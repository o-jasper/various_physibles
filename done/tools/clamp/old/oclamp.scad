//
//  Copyright (C) 15-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

// Clamp profile and application with 5mm pole system.

$quality=30;
$fs=0.4;

t=4; //Thicknesses.
l= 50; //Length of clamp.
h = 1.5*t;

zl = t; //Single zigzag length.
zw = zl/1.3;

tab=true;
logo=true;

hl = 20; //Handle length.
ha = 45; //.. angle
ht = t;  //.. thickness

module teeth_profile(oz,l=l)
{   difference()
    {   union()
        {   square([1.5*t,l-1.5*t]);
            intersection() 
            {   translate([0,l-1.5*t]) circle(1.5*t);
                square([1.5*t,l]);
            }
        }
        //Zigzag motion.
        for( y = [oz : zl : l] ) 
            translate([0,y]) scale([zw/zl,1]) rotate(45) square([zl,zl]/sqrt(2), center=true);
        //Entry at top.
        translate([0,l]) rotate(45) square(t*[2,2], center=true);
    }
}

module clamp_profile(oz)
{   union()
    {   difference()
        {   union()
            {   scale([1/2,2]/4) circle(l); //Arc.
                if( hl > 0 ) translate([0,-l/4]) rotate(180+ha) union()//Handle
                {   intersection() 
                    {   square([ht,hl]);
                        translate([ht,0]) scale([ht,hl]) circle(1);
                    }
                    translate([2*ht/3,hl-ht/4]) circle(ht/3);
                }
            }
            difference()
            {   scale([1/2-2*t/l,2-2*t/l]/4) circle(l); //Hole and reinforcement.
                translate([5*l,l/2]) square([10*l,l/2],center=true);
            }
            translate([-l,-l]) square([l,2*l]); //Half it.
        }
        //Pad.
        translate([-t,t+l/6]) 
            rotate(10) intersection(){ teeth_profile(oz,l/3); square([l,l/3-t],r=t/3); }
    }
}

peg_connect = false; //Old way of connecting the two parts.
module peg_profile()
{   polygon([[+1,-1],[-1,+1],[+1,+1]]*t/2); }

module half_clamp(oz)
{
    union()
    {   intersection()
        {   linear_extrude(height=h) difference()
            {   clamp_profile(oz);
                if(peg_connect) union()
                {   for( y=[0,1.6*t] ) translate([0,y-l/2+t]) rotate(45) 
                                           square(sqrt(2)*t,r=t/4,center=true);
                    translate([0,-l/2]) square([2*t,2*t],center=true);
                }
            }
            rotate([0,90]) translate([0,0,-l]) linear_extrude(height=3*l) 
                translate([-h/2,l/2-h/1.5]) union()
            {   circle(h/1.5);
                translate([0,-l]) square([2*h/1.5, 2*l],center=true);
             }
        }
        //Old peg system to connect them.(pretty poor, at least at the scale i tried)
        if(peg_connect) for( y = [0,1.6*t] ) translate([0,y-l/2+t]) union()
        {   linear_extrude(height=h/2) 
                rotate(45) difference()
            {   square(sqrt(2)*t,r=t/4,center=true);
                rotate(-90) peg_profile();
            }
            rotate(135) linear_extrude(height=h) peg_profile();
        }
        translate([0,t/4-l/2]) cube([t/4,h+5*t/4,h]); //Thing to hold the backside together.
    }
}

module wedge()
{
    linear_extrude(height=h) difference()
    {   translate([0,1.5*h+t/2]/2) square([t,1.5*h+t/2], center=true);
        polygon([[+t/4,1.5*h], [-t/4,1.5*h], [-t/6,0], [+t/6,0]]);
    }
}

module clamp_pair()
{   union()
    {   half_clamp(0);
        translate([l/3,0]) half_clamp(zl/2);
        translate([l/3,0]) wedge();
    }
}
clamp_pair();

