//
//  Copyright (C) 14-05-2013 Jasper den Ouden.
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
h = 4*t;

zl = 2*t; //Single zigzag length.
zw = t/1.3;

bend_help=false;

module teeth_profile(l=l)
{   difference()
    {   union()
        {   square([1.5*t,l-1.5*t]);
            intersection() 
            {   translate([0,l-1.5*t]) circle(1.5*t);
                square([1.5*t,l]);
            }
        }
        //Zigzag motion.
        for( y = [zl/2 : zl : l] ) 
            translate([0,y]) scale([zw/zl,1]) rotate(45) square([zl,zl]/sqrt(2), center=true);
        //Entry at top.
        translate([0,l]) rotate(45) square(t*[2,2], center=true);
    }
}

    
module clamp_base_profile(n,ta,l=l)
{
    union()
    {   for( a = [0:ta/n:ta] ) rotate(a) teeth_profile(l);
    }
}

function mrf(l)=  min(l/12,l/6-t);

module clamp_base(n,ta,l=l)
{
    mr = mrf(l);
    union()
    {   translate([0,0,t]) linear_extrude(height=t) intersection()
        {   difference()
            {   circle(l/6); 
                square(mr*[2,2],center=true); 
            }
        }
        linear_extrude(height=t) difference()
        {   union()
            {   circle(l/6);
                clamp_base_profile(n,ta,l); 
            }
            square([2*mr,2*mr+t],center=true); 
            square([2*mr+t,2*mr],center=true); 
        }
    }
}

module attach_finger(l)
{
    y = l/3-t;
    union() 
    {   linear_extrude(height=t) //Tooth.
            translate([0,l/3]) scale([-1,1]) teeth_profile(2*l/3);
        //Bend upwards.
        translate([-1.5*t,0]) rotate([0,90]) linear_extrude(height=t) union()
        {   polygon([[0,l/3], [-t,l/3+t], [-3*t,y],[-2*t,y-t]]);
            translate([-3*t,0]) square([t,y]);
        }
    }
}

use<openhw.escad>;

with_logo=true;
module clamp_attach(n,ta,l=l,ca=3)
{
    mr = mrf(l);
    sa=ta/n;
    difference()
    {   union()
        {   for( a = [0:sa:ta] )  //Ziplock hold fingers.
                rotate(a-ca) attach_finger(l);
            //Takes off corners.
            linear_extrude(height=3*t) difference() 
            {   square([2*mr,2*mr], center=true);
                for(a=[0,90,180,270]) 
                    rotate(a) translate(mr*[1,1]) rotate(45) 
                    square(sqrt(2)*[t,t],center=true);
            }
            //Bottom.
            linear_extrude(height=t) 
            {   square([2*mr,2*mr+t],center=true); 
                square([2*mr+t,2*mr],center=true); 
            }
            translate([0,0,3*t]) cylinder(r1=mr, r2=mr/2, h=l/2);

            if( with_logo) intersection()
            {   rotate(ta/2+a) rotate([90,0]) 
                    translate([0,3*t+7,-l]) linear_extrude(height=2*l) oshw_logo_2d(7);
                translate([0,0,3*t]) cylinder(r1=mr+t/4, r2=mr/2+t/4, h=l/2);
            }
        }
        //Substract inside of pillar for more bendiness of pillar.
        cube([2*mr-t/2,2*mr-t/2,4*t], center=true);
        //Divide into section. (also for bendiness)
        for( a= [45,-45] ) rotate(a) cube([10*mr,t/2,4*t], center=true);
        //Hole 
        cylinder(r=mr-t/4, h=3*t);
        translate([0,0,3*t]) cylinder(r1=mr-t/4, r2=mr/2-t/4, h=l/2);
        //Holes for holding on to it.
        for( z = [4*t:2*t:l/2+3*t] ) 
            rotate(ta/2) rotate([90,0]) translate([0,z,-l]) cylinder(r=t/2,h=2*l);
    }
}

//clamp_base(5,120);
clamp_attach(5,120);
