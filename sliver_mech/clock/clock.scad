//
//  Copyright (C) 22-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<MCAD/involute_gears.scad>

$fs=0.5;
$fn=40;

//No idea if this shit works.

rh=2.5;
t=2;

sr=1;

th=1;

module _escapement_gear(r,R,n,f)
{
    t= 6.14*r/n;
    circle(r);
    for(a=[0:360/n:360*(1-1/n)]) rotate(a) polygon([[r-t/2,-t/2],[R,f*t],[r-t/2,t/2]]);
}

module _escapement(R,d,r)
{
    difference()
    {   union()
        {   difference()
            {
                union()
                {   translate([0,-R]) circle(R);
                    scale([1/2,1]) circle(0.7*R);
                }
                translate([0,-1.2*R]) difference()
                {   circle(R);
                    for(x=[R,-R]) translate([x,d]) 
                                      rotate(45) square([d,d],center=true);
                }
            }
            circle(0.3*R);
        }
        for(y=[0:4*rh:R-2*rh]) translate([0,y]) circle(rh);
    }
}

r=20;
R=40;
f=0.2;
///escapement_gear(r,R,n,f);
//translate([0,1.4*R]) escapement(R,(R-r)/2);

pitch = 180;
mf= 49*pitch/(500*36);

br=2*sr;

module g(n)
{   gear(flat=true,number_of_teeth=n, circular_pitch=pitch, bore_diameter=2*br); }

//NOTE the clock kindah has a 'sum number' which is the constant sum of tooth
// given some tooth size and a distance between two rotating points.
//It has to be dividable by all >1 (gear ratio)+1
sum_number= 36;

module gp(factor, m = sum_number)
{   k1= m/(factor+1);
    k2= m-k1;
    echo("found k values (",factor,")", k1,k2);
    if( k1+k2 != m )
    { echo("Error: incorrect number of teeth for distance!", [k1,k2,m]); }
    if( k1%1 !=0 ){ echo("Error: fractional tooth! ",k1); }
    g(k1);
    translate([0,mf*m]) rotate(180/k2) g(k2);
}


module show_sequence(hor=false)
{
    v = hor ? [0,70*mf] : [0,0,10*th];

    translate(v*-2) //10s
    {   escapement_gear(r,R,10,f);
        translate([0,1.4*R]) escapement(R,(R-r)/2);
    }
    //Note: tabelling these values would be better.
    translate(v*0) gp(3);   //x3 (30s)     9  + 25
    translate(v*1) gp(1/2); //x2 (1 min)  24 + 12  //*
    translate(v*1) sphere(4);
    
    translate(v*2) gp(2);   //x2 (2 min)  12 + 24
    translate(v*3) gp(1/5); //x5 (10 min) 30 + 6
    translate(v*4) gp(3);   //x3 (30 min) 9  + 25
    translate(v*5) gp(1/2); //x2 (1h) //* 24 + 12
    translate(v*5) sphere(4);
    
    translate(v*6) gp(3);   //x3  (3h)    9  + 25
    translate(v*7) gp(1/2); //x2  (6h)    24 + 12
    translate(v*8) gp(1);   //x1  (6h)    18 + 18
    translate(v*9) gp(1/2); //x2 (12h)    24 + 12 //*
    translate(v*9) sphere(4);

    translate([0,-4*mf*sum_number/3]) 
    {
        translate(v*1) g(2*sum_number/3);
        translate(v*5) g(2*sum_number/3);
        translate(v*9) g(2*sum_number/3);
    }
}

//show_sequence();

gh=1.5;
sh=0.3;
sr=0.5;

module stack_gear(n,m) //Implements the many sets of connected gears.
{ 
    rb= mf*min(m+2,n-3);
    if( n >= m )
    {
        difference()
        {   translate([0,0,sh]) union()
            {   linear_extrude(height=gh) g(n);
                linear_extrude(height=3*gh+2*sh) g(m);
                cylinder(r=rb,h=1.5*gh-sh);//1=mf*(n-3),r2=mf*(m-3),h=2*gh);
                translate([0,0,1.5*gh-sh]) cylinder(r1=rb,r2=mf*(m-3),h=gh/2);
            }
            cylinder(r=sr,h=8*gh);
            cylinder(r=br,h=8*gh);
        }
    }
    else
    {   translate([0,0,3*gh]) rotate([0,180,0]) stack_gear(m,n); }
}

dz=2*gh+2*sh;

module stack_space(n,m) //Space for said gears.
{
    cylinder(r=mf*(n+2)+2*sr,h=gh+2*sh); //Bigger gear
    cylinder(r=mf*(m+2)+2*sr,h=dz+gh+2*sh); //Smaller top gear
}

$which = 1;
module sw(n,m)
{
    if( $which == 1 ){ stack_gear(n,m); }
    if( $which == 2 ){ stack_space(n,m); } 
}

//Gear at the bottom and pillar to the arm.
module arm_gear(h,ro,ri)
{
    n = sum_number*2/3;
    if( $which == 1 ) difference()
    {   union()
        {   rotate(180/n) linear_extrude(height=gh) rotate(180/9) g(n);
            cylinder(r=ro,h=h);
        }
        translate([0,0,-h]) cylinder(r=ri,h=3*h);
        translate([0,0,h]) cube([8*ro,0.8*ro,2*dz],center=true);
        translate([0,4*ro,h-dz/2]) rotate([90,0,0]) cylinder(r=2*sr,h=8*ro);
    }
    if( $which == 2 )
    {
        cylinder(r=mf*(3+n)+2*sr,h=gh+2*sh);
        cylinder(r=ro+sr,h=h);
    }
}
module seconds()
{   ex = ($which==2 ? sr : 0);
    difference()
    {   union()
        {   arm_gear(13.5*dz,10*mf-sr,3*mf);
            translate([0,0,ex/2]) cylinder(r1=20*mf-sr+ex,r2=ex,h=4*dz); 
        }
        if($which==1) translate([0,0,gh/2]) cylinder(r1=15*mf-sr+ex,r2=3*mf,h=2.5*dz-gh); 
    }
}
module minutes()
{   ex = ($which==2 ? sr : 0);
    arm_gear(8*dz, 14*mf-sr,10*mf);
    difference()
    {   translate([0,0,gh]) cylinder(r1=11*mf+dz+ex,r2=14*mf-sr+ex,h=dz+gh+ex);
        rotate_extrude() translate([14*mf-sr,dz+gh/2]) 
            if( $which==1 ) translate([dz/sqrt(8),0]) circle(gh/2);
        for(s=[1,-1]) translate([-44*mf,s*(12*mf-sr/2),dz+gh/2]) 
                          rotate([0,90,0]) cylinder(r=sr,h=88*mf);
        if($which==1) translate([0,0,-10*mf]) cylinder(r=10*mf,h=88*mf);
    }
}
module hours()
{   arm_gear(2.5*dz, 20*mf-sr,14*mf); }

module escapement_gear()
{
    translate([0,0,-4*gh-t]) 
    {   linear_extrude(height=2*gh+t)  _escapement_gear(r,R,10,f);
        linear_extrude(height=5*gh+t) rotate(180/9) g(9);
        cylinder(r=12*mf,h=3.5*gh+t);
        translate([0,0,3.5*gh+t]) cylinder(r1=12*mf,r2=6*mf, h=gh/2);
    }
}

module escapement()
{
    translate([0,1.4*R,-4*gh-t]) linear_extrude(height=2*gh+t) _escapement(R,(R-r)/2);
}

module top_gear()
{   if( $which==1 )
    {   linear_extrude(height=gh) g(24); } //x2 (12h)    24 + 12 //*
    else
    {   cylinder(r=27*mf,h=gh+2*sh); }
}

extra_sum=0.2;

module cut_sequence()
{
    v=[0,0,dz];
    off = [0,mf*(sum_number+extra_sum),0];

//    linear_extrude(height=gh) rotate(180/9) g(9);
    if( $which==1 ) escapement_gear();
    if( $which==2 ) translate([0,0,-4*gh]) cylinder(r=12*mf,h=5*gh+2*sh);
    translate(off+v*0) sw(25,12); //x3 (30s)       9  + 25
    translate(v*1)     sw(24,12); //x2 (1 min)     24 + 12 ->minute, second hand
    translate(off+v*2) sw(24,6);  //x2 (2 min)     12 + 24     
    translate(v*3)     sw(30,9);  //x5 (10 min)    30 + 6
    translate(off+v*4) sw(25,12); //x3 (30 min)    9  + 25
    translate(v*5)     sw(24,9);  //x2 (1h)        24 + 12 ->hour, minute hand
    translate(off+v*6) sw(25,12); //x3 (3h)        9  + 25
    translate(v*7)     sw(24,12); //x2 (6h)        24 + 12
    translate(off+v*8) sw(18,12); //x1 (6h)        18 + 18
    translate(v*9) top_gear();    //x2 (12h = .5d) 24 + 12 ->half-day, hour hand//*
    
    translate([0,-4*mf*sum_number/3]) 
    {
        translate(v*1) seconds();
        translate(v*5) minutes();
        translate(v*9) hours();
        if( $which==2 ) translate(5*v)
        {   translate([0,0,dz]) cylinder(r=(sum_number-2)*mf,h=dz-gh);
//            translate([0,0,dz/2]) sphere((sum_number-5)*mf);
        }
    }
}

module _base_profile(neg=true)
{
    hull()
    {   circle(mf*sum_number+2*t);
        translate([0,mf*sum_number]) circle(mf*sum_number*4/5+2*t);
        if(neg) translate([0,-mf*sum_number*4/3]) circle(mf*sum_number*2/3+2*t);
    }
}

module body()
{   dy=1.4*R;
    difference()
    {   union()
        {   translate([0,0,-gh]) linear_extrude(height=10*(2*gh+2*sh)+gh)
                _base_profile(false);
            for(z=dz*[1,5,9]) translate([0,0,z-gh]) 
                                  linear_extrude(height=3*gh+2*sh) _base_profile(true);
            translate([0,0,-gh]) linear_extrude(height=4*dz) difference()
            {   hull()
                {   circle((sum_number+2)*mf);
                    translate([0,-dy]) circle(sum_number*mf/2);
                }
                translate([0,-dy]) circle(sum_number*mf/4);
            }
        }
        cut_sequence($which=2);
        translate([0,0,-mf*100]) cylinder(r=br,h=mf*300);
        translate([0,mf*sum_number,-mf*100]) cylinder(r=br,h=mf*300);
        for(s=[1,-1]) 
            translate([s*(sum_number+extra_sum)*mf,
                       0.7*(sum_number+extra_sum)*mf,-4*sum_number*mf])
                cylinder(r=2*sr,h=8*sum_number*mf);
    }
}

//cut_sequence($which=2);;
module sliver_cutter(neg=true)
{   //translate([0,0,-800*mf]) cube(1600*[mf,mf,mf],center=true);
    translate([0,0,-800*mf]) union()
    {   cylinder(r=mf*sum_number+t, h=800*mf);
        translate([0,mf*sum_number]) cylinder(r=mf*sum_number*4/5+t, h=800*mf);
        if(neg) translate([0,-mf*sum_number*4/3]) 
                    cylinder(r=mf*sum_number*2/3+t, h=800*mf);
    }
}
module sliver(n)
{
    if(n==0) //First one has a whole body.
    {    difference()
        {   body();
            translate([0,0,400*mf]) sliver_cutter();
        }
    }
    intersection() 
    {   body();
        translate([0,0,dz-gh+n*dz-0.01]) difference()
        {   sliver_cutter();
            translate([0,0,-dz]) sliver_cutter();
        }
    }
}

module sliver_show(gears=false, inc=-dz, grid=true)
{
    for( i=[0:12] )
    {   if( grid) translate([2.6*mf*sum_number*(i%4),floor(i/4)*4.5*mf*sum_number,inc*i]) 
                      sliver(i);
        else translate([2.5*mf*sum_number*i,0,inc*i]) sliver(i);
    }
}
//sliver_show();

module clock_show()
{
    color([1,1,0]) intersection()
    {   body();
        translate([-100,0]) cube(100*[2,2,2],center=true);
    }
    cut_sequence($which=1);
    rotate(180) escapement();
}
clock_show();
//sliver(0);

//translate([0,0,-10]) color("blue") square([100,100],center=true);
