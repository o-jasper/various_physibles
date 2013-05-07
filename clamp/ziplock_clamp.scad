//
//  Copyright (C) 06-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

// Clamp profile and application with 5mm pole system.

$fs=0.4;

t=2; //Thicknesses.
l= 50; //Length of clamp.
a=22; //Angle of zigzag.
h = 4*t;

zl = 4*t*cos(a); //Single zigzag length.

bend_help=false;


module clamp_profile()
{   difference()
    {   union()
        {   translate([0,l/2-0.75*t]) square([3*t,l-1.5*t],center=true);
            translate([0,l-1.5*t]) circle(1.5*t);
            if(bend_help) translate([1.5*t, 1.5*t]) circle(1.5*t);
        }
        if(bend_help) translate([1.5*t, 1.5*t]) 
        {   circle(t/2);
            translate([-0.75*t,0]) square([1.5*t,t], center=true);
            translate([-1.5*t,0]) circle(t/2);
        }
        translate([0,2*t])
        {   circle(t/4);
            rotate(a) 
            {   translate([0,t/2]) square([t/2,t], center=true);
                
            }
        }
        for( y= [2*t+zl/2 : zl : l] )
        {   translate([0,y]) rotate(-a) 
            {   square([t/2,2*t],center=true);
                for( y=[-t,t] )  translate([0,y]) circle(t/4);
            }
            translate([0,y+zl/2]) rotate(a) square([t/2,2*t],center=true);
        }
        //Entry at top.
        translate([0,l]) rotate(45) square(t*[2,2], center=true);
    }
}

module clamp()
{
    sf1=1.05;
    linear_extrude(height=h) scale([-1,1]) clamp_profile(); 
//    for( x=[-1.5*t:2*al:t]) translate([x,t/2]) cylinder(r=al/(2*sf1), h= 2*t+4*al);
}

//clamp();

module clamp_fan(ta,n)
{
    sa=2*ta/n;
    for( a= [0:sa:ta] ) rotate(a) translate([0,5*t]) clamp(bend_help=false);
    for( a= [sa/2:sa:ta-sa/2] ) rotate(a) translate([t/2,5*t]) clamp(bend_help=false);
}

al=5;

module hanging_clamp_fan(ta,n,h)
{
    clamp_fan(ta,n);
    difference()
    {   intersection()
        {   linear_extrude(h=h) 
            {   intersection()
                {   difference()
                    {   circle(5*t);
                        circle(4*t);
                    }
                    polygon([[-t,0],[t,0], [1.5*t,h], [-h*sin(ta),h*cos(ta+2*ta/n)]]);
                }
                rotate(ta/2) translate([0,5*t]) circle(2*t);
            }
            rotate(ta/2) translate([0,5*t]) cylinder(r1=8*t,r2=2*t,h=h);
        }
        for( z = [4*t+al:2*al:h-al] )
            rotate(ta/2) rotate([90,0]) translate([0,z,-h]) cylinder(r=al/2,h=h);
    }
    
}
hanging_clamp_fan(40,4,50);
    
