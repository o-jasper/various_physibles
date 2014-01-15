//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>
module bed_holder() //TODO also raising method.
{   d=bzd;
    ht=fh;
    th=fh+bh;

    dl=l/3;
    dist = sqrt(dl*dl+dc*dc);
    difference()
    {   union() 
        {   for(pos=[[dl,dc,0],[dc,dl,0]]) hull() //Main shape.
            {   cylinder(r=bbr+t,h=th);
                translate(pos+[0,0,fh-t]) cylinder(r=bbr+t,h=t);
                translate(pos*(dist-fh)/dist) cylinder(r=t/2,h=fh);
            }
            //Screw 'platform'
            translate([dc,dc,fh-t]) rotate(45) cube([dc,1.5*dc,2*t],center=true);
        //Hinge cylinder addition.
            translate([adx-zrd,adx-zrd]) rotate(45) 
                translate([0,2*aw,fh-aw-3*t]) rotate([90,0,0]) cylinder(r=ah/2,h=4*aw);
        }
        translate([dc-2*t,dc-2*t,fh]) cube([l,l,l]); //Space for bed.
        translate([0,0,-fh]) cylinder(r=bbr,h=4*fh);
        translate([dc,dc,-h]) //Screw hole and space.
        {   //cylinder(r=2*t,h=h+fh-2*t);
            cylinder(r=sr,h=2*h);
        }
        //Space for arm.
        translate([adx-zrd,adx-zrd]) rotate(45) 
        {   translate([0,aw+t]/2)
                rotate([90,0,0]) linear_extrude(height=aw+t) hull()
            {   translate([0,fh-aw-3*t]) circle(aw+t);
                translate([fh,fh-aw-3*t]) circle(aw+t);                
                square(aw*[1,2],center=true);
            }
        //And hinge cylinder
            translate([0,fh,fh-aw-3*t]) rotate([90,0,0]) cylinder(r=ah/4,h=3*fh);
        }
    }

}

bed_holder();
