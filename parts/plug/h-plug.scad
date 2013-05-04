//
//  Copyright (C) 28-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Idea: try separate the two sides of the male.

t= 4;
sr=0.75;
inf = 100*t;
sf = 1.15; //Factor to make it smaller so it fits.

$fs =0.1;

hat_h=t/2; //If it gets all the way in it might get too stuck.

bottom_cut = false; //So small otherwise

module h_profile(s,he)
{
    difference()
    {   union()
        {   scale(s) square([3*t,t+he],center=true);
            for(x=[-t,t]) translate([x,0]) scale(s) square([t,3*t],center=true);
        }
        translate([1.5*t,0]) scale(1/s)circle(t/2);
    }
}

module _h_male_bottom_cut() // wah it no workies.
{   for( a = [0,90,180,270] )
    {   echo(a);
        rotate(a) translate([t,t]) cylinder(r=t/4,h=2*t); 
    }
}
module h_male()
{
    l =  sqrt(t*t/4+sr*sr);
    el = 5*t*sin(10);
    difference()
    {   union()
        {   linear_extrude(height=t) difference()
            {   square(3*[t,t],center=true);
                for( y=[-t/2,t/2] ) translate([0,y]) circle(sr);
            }
            linear_extrude(height=4*t) difference()
            {   h_profile(1,0);
                for( y=[-t/2,t/2] ) translate([0,y]) circle(sr);
            }
        }
        for( a = [0,180] ) rotate(a)
            {   translate([t/2,0]) rotate(45)
                {   translate([0,0,3.5*t]) rotate([-10,0,0]) 
                        translate([0,0,-2*inf])  cylinder(r=sr,h=6*inf);
                    translate([-sr,0,3.5*t]) cube([2*sr,sqrt(t*t/4+sr*sr),t]);
                    translate([-sr,sr-el]) cube([2*sr,l + el,t/2]);
                }
            }
        if(bottom_cut){ _h_male_bottom_cut(); }
    }
    if( hat_h>0 )
        for( a = [0,90,180,270] ) rotate(a) translate([t,t,4*t]) 
                                      cylinder(r1=t/2,r2=t/4,h=hat_h);
}

module _h_female_bottom_cut()
{   for( a = [0,90,180,270] ) rotate(a) translate([t,t]) cylinder(r=t/4,h=2*t/3); 
    translate([1.5*t,0]) cylinder(r=t/4, h=2*t);
    for( s= [[1,1],[1,-1],[-1,1],[-1,-1]] )
        scale(s) translate(t*[2,2.5]) 
        {   scale([1,4]) cylinder(r=t/4,h=inf);
            scale([4,1]) cylinder(r=t/4,h=inf);
        }
}

module h_female()
{
    
    difference()
    {   union()
        {   linear_extrude(height=t) square(t*[4,5],center=true);
            linear_extrude(height=4*t) 
            {   difference()
                {   //Basically this is minus t/2 the size of the thing in the racks
                    square(t*[4,5],center=true); 
                    h_profile(sf,2*sr);
                }
            }
        }
        for( s=[1,-1] )
        {   scale([s,1]) for( z = [3*t/2:t:5*t] )
                rotate([90,0,0]) translate([0.51*t,z,-inf]) cylinder(r=sr, h=3*inf);
            scale([1,s]) translate(t*[-0.5,2]) cube([t,t/2,3.5*t]);
        }
        rotate([90,0,0]) translate([0,t/2,-inf]) cylinder(r=min(2*sr,0.45*t), h=3*inf);
        cylinder(r=t,h=t/2);
        if(bottom_cut){ _h_female_bottom_cut(); }
    }
    difference()
    {   translate([2*t,0]) rotate([0,-90,0]) linear_extrude(height=4*t) 
            polygon([[t,-3*sr],[0,-sr],[0,sr],[t,3*sr]]);
        if(bottom_cut){ _h_female_bottom_cut(); }
    }
}

//h_female();
//translate([5*t,0]) h_male();

//TODO male and female as sets mxn

module h_male_rack(n,m)
{
    for( i = [0:n-1] ) 
    {   for( j = [0:m-1] ) translate(t*[3.75*i,4.75*j]) h_male();
        if( m>1 )
            for( j = [0:m-2] ) translate(t*[3.75*i-1,4.75*j+1.5]) cube(t*[2,2,1]);
    }
    if( n>1 )
        for( i = [0:n-2] ) for( j = [0:m-1] ) 
            translate(t*[3.75*i+1.5,4.75*j-1]) cube(t*[1,2,1]);
}

module h_male_bottom_cut(n,m)
{   for( i = [0:n-1] ) for( j = [0:m-1] ) translate(t*[3.75*i,4.75*j]) 
                                              _h_male_bottom_cut();
}

module h_female_rack(n,m)
{
    for( i = [0:n-1] ) for( j = [0:m-1] ) translate(t*[3.75*i,4.75*j]) 
                                              h_female();
}
module h_female_bottom_cut(n,m)
{   for( i = [0:n-1] ) for( j = [0:m-1] ) translate(t*[3.75*i,4.75*j]) 
                                              h_female_bottom_cut();
}

h_male_rack(2,1);

translate([0,-10*t]) h_female_rack(2,1);
