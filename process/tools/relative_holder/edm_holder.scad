//
//  Copyright (C) 14-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module screwthing()
{   linear_extrude(height=t) difference()
    {   hull() for(x=(bcr+2*t+sr)*[1,-1]) translate([x,0]) circle(sr+t);
        for(x=(bcr+2*t+sr)*[1,-1]) translate([x,0]) circle(sr);
    }
}
module edm_bottom() //Bottom where thing slides.
{   q=d+sr+2.5*t;
    rotate([180,0,0]) difference()
    {   union()
        {   hull()
            {   cylinder(r=mrr+t,h=mrh);
                translate([0,0,mrh-t]) cylinder(r=bcr+t,h=t);
            }
            translate([0,0,mrh-t]) screwthing();
            translate([0,bcr+sr,mrh-sr-t]) cube([t,2*(bcr+sr),2*(t+sr)],center=true);
            //Block to connect to other bit with.
            translate([0,-d,mrh-2*t]) cylinder(r=sr+t,h=2*t);
            translate([-t,-q,mrh-zh-t])  cube([2*t,q,zh+t]);
        }
        translate([0,-d,-t]) cylinder(r=sr,h=8*mrh);
        translate([0,-d,mrh-zh]) cube([8*t,2*(sr+t+s),2*zh-5*t],center=true);
        translate([0,0,-mrh]) cylinder(r=mrr,h=8*mrh); //Hole for the slider itself.

        translate([-4*t,bcr+t+1.2*sr,mrh-sr-t]) rotate([0,90,0]) cylinder(r=sr,h=8*t);
    }
}

module edm_top() //Cap with coil in it.
{   hole_r=max(mrr+t/2,bcr-2*t);
    difference()
    {   union()
        {   hull()
            {   cylinder(r=bcr+t,h=bch);
                cylinder(r=hole_r+t/2,h=bch+1.2*bcr);
            }
            screwthing();
        }
        hull()
        {   translate([0,0,-bch]) cylinder(r=bcr,h=2*bch);
            cylinder(r=t,h=bch+1.2*bcr-t);
        }
        cylinder(r=hole_r,h=8*bch);
    }
}

module show_edm()
{   edm_top();
    translate([0,0,-mrh]) color("blue") rotate([180,0,0]) edm_bottom();
}
show_edm();
