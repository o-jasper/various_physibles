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
sr=0.77;
inf = 100*t;
sf = 0.9; //Factor to make it smaller so it fits.

$fs =0.1;

r=t/2;

hat_h=t/2; //If it gets all the way in it might get too stuck.

sleek = true; //Sleeken it
bottom_cut = false; //So small otherwise

module rounded_square(w,l,r)
{
    r = (2*r> w ? w/2 : r);
    translate([r,0]) square([w-2*r, l]);
    translate([0,r]) square([w, l-2*r]);
    
    translate([r,   r])   circle(r);
    translate([w-r, r])   circle(r);
    translate([r,   l-r]) circle(r);
    translate([w-r, l-r]) circle(r);
}

//s makes it more fittable, he and hi make room for wires at different places.
module h_profile(s,he,hi)
{
    difference()
    {   union()
        {   scale(s) square([3*t,t+he],center=true);
            for(x=[-t-hi,t+hi]) translate([x,0]) scale(s) square([t-2*hi,3*t],center=true);
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
    sa = -6;
    l =  sqrt(t*t/4+sr*sr);
    h=4.2*t;
    el = 5*t*sin(-sa);
    difference()
    {   union()
        {   linear_extrude(height=t) translate(-1.5*[t,t]) 
                rounded_square(3*t,3*t, r);
            linear_extrude(height=h) h_profile(sf,0,sr);
        }
        //Vertical wire tubes.
        for( y=[-t/2,t/2] ) translate([0,y]) cylinder(r=sr, h=inf);

        for( a = [0,180] ) rotate(a)
            {   translate([t/2,0]) rotate(45)
                {   translate([0,0,h-t/2]) rotate([sa,0,0]) //Angled wire tubes.
                        translate([0,0,-2*inf]) cylinder(r=sr,h=6*inf);
                    //Resp. top and bottom channels.
                    translate([-sr,0,h-t/2]) cube([2*sr,sqrt(t*t/2+sr*sr),t]);
                    translate([-sr,sr-el]) cube([2*sr,l + el,t/2]);
                }
            }
        if(bottom_cut){ _h_male_bottom_cut(); }
        if(sleek) translate([0,0,h-2*t]) difference()
        {   cylinder(r=h,h=h);
            intersection()
            {   cylinder(r2=t,r1=8*t,h=2*t);
                union()
                {   translate([t,0]) cylinder(r2=1*t,r1=2*t,h=2*t);
                    translate([-t,0]) cylinder(r2=1*t,r1=2*t,h=2*t);
                }
            }
        }
    }
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
    {   linear_extrude(height=4*t) translate(-t*[2,2]) rounded_square(4*t,4*t, r);
        translate([0,0,t]) linear_extrude(height=4*t) h_profile(1,2*sr,0);

        for( s=[1,-1] )
        {   scale([s,1]) for( z = [3*t/2:t:5*t] ) //Horizontal wire touching tubes.
                rotate([90,0,0]) translate([0.51*t,z,-inf]) cylinder(r=sr, h=3*inf);
            //Vertical wire channel.
            scale([1,s]) translate(t*[-0.5,1.6]) cube([t,t/2,3.5*t]);
        }
        //Wire tube on the bottom.
        rotate([90,0,0]) translate([0,t/2,-inf]) cylinder(r=min(2*sr,0.45*t), h=3*inf);
        cylinder(r=t,h=t/2); //Hole the tubes collect.
        if(bottom_cut){ _h_female_bottom_cut(); }
    }
    //Angled thingy that helps separate the wires in the bottom and 
    // helps bringing them up.
    difference() 
    {   translate([2*t,0]) rotate([0,-90,0]) linear_extrude(height=4*t) 
            polygon([[t,-3*sr],[0,-sr],[0,sr],[t,3*sr]]);
        if(bottom_cut){ _h_female_bottom_cut(); }
    }
}

//Sets of multiple of the above.
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
