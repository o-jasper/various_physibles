//
//  Copyright (C) 20-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<rounded_box.scad>

wd = 6; //minimum distance to wall.

pl  = 250; //Plank length.(unimportant here, must be bigger than grab length; `gl`)
pt  = 20.2; //..thickness,

t = 8; //Thicknesses.
r= 2*t/3; //Rounding of stuff.

dl = 70; //length down from the plank //(short one is 20)
gl = 40; //'Grabbing length'.

rr = 6; //Radius of rod.

dx = (wd+gl)/2; //Position at which it 'decends.

w  = t+2*rr; //Width of clamp.
cut_more = false; //(w>3*t); //Wether to cut some stuff off if it is thick.
reinforce = true;

sr=1.4; //Screw/whatever holes.

echo(dx);

module spool_plank_profile()
{   
    difference()
    {   translate([-wd,-t])
        {   rounded_square(wd+gl,2*t+pt, r);
            translate([dx,t-dl]) square([t,dl+rr+t/2]);
        }
        square([pl,pt]);
    }
}

module reinforcements()
{//Dont think these are good..
    rl = min(dl-rr, dx-r, gl+wd-dx, 4*t);
    linear_extrude(height= t) polygon([[dx-rl-t,0], [dx,-rl], [dx+rl,0]]);
}

module spool_plank()
{   difference()
    {   union()
        {   linear_extrude(height= w) spool_plank_profile();
            translate([dx-wd,-dl,w/2]) rotate([0,90,0]) linear_extrude(height=t)
                intersection()
            {   scale([1.4,1]) circle(rr+t/2);
                square([w,w], center=true);
            }
            if( reinforce )
            {   reinforcements();
                translate([0,0,w-t]) reinforcements();
            }
        }
        translate([0,-dl,w/2]) rotate([0,90]) cylinder(r=rr, h=pl);
        translate([dx-wd+t/2,-rr+dl,w/2]) rotate([90,0]) cylinder(r=sr, h=pl);
        translate([dx-wd+t/2,-dl,0]) cylinder(r=sr, h=pl);
        if( cut_more )
        {   translate([0,pl,w/2]) rotate([90,0]) 
            {
                scale([dx-t,w/2-t]/w) cylinder(r=w, h=3*pl);
                translate([wd+gl,0]) scale([(w-t+gl-dx)/2,w/2-t]/w) cylinder(r=w, h=3*pl);
            }
            translate([0,rr-dl+t,t]) cube([pl,dl-rr-2*t,w-2*t]);
        }
    }
}

module splitter() //off one intersect other.
{
    translate([-pl,-4*t]) cube([3*pl,pl,w]);
    translate([-pl,-7*t,w/3]) cube([3*pl,pl,w/3]);
}
module splitter_sub() //This goes off both.
{
    translate([dx-wd+t/2,-4.5*t,-pl])
    {   cylinder(r=sr, h=3*pl);
        translate([0,-t]) cylinder(r=sr, h=3*pl);
        translate([0,-2*t]) cylinder(r=sr, h=3*pl);
    }
}

module split_spool_plankpart()
{
    intersection()
    {   spool_plank();
        difference()
        {   splitter();
            splitter_sub();
        }
    }
}
module split_spool_hangpart()
{   translate([0,0,wd-dx]) rotate([0,-90,0]) difference() 
    {   spool_plank();
        splitter();
        splitter_sub();
    }
}

//For reaching a little further.(if you messed up)
module little_extra_reach(h)
{
    difference()
    {   union()
        {   cylinder(r=rr+t/2,h=h+t/2);
            cylinder(r=rr-0.1,h=h+2*t);
        }
        cylinder(r=rr,h=h);
        for( z=[t/2:t/2:h+3*t/2] )
            translate([0,5*rr,z]) rotate([90,0,0]) cylinder(r=sr,h=10*rr);
        rotate(90) for( z=[t/2:t/2:h+3*t/2] )
            translate([0,5*rr,z]) rotate([90,0,0]) cylinder(r=sr,h=10*rr);
    }
}

//little_extra_reach(10);
//reinforcements();
gl=20;dl=20;
split_spool_plankpart();
//split_spool_hangpart();

//spool_plank();
