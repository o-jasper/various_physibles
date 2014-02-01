//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>
use<pulley.scad>
use<corner.scad>

module bed_holder() //TODO also raising method.
{   d=bzd;
    th=fh+bh;

    dl=l/3;
    dist = sqrt(dl*dl+dc*dc);

    pz=fh-pr-t-2*sr;

    difference()
    {   union() 
        {   for(pos=[[dl,dc,0],[dc,dl,0]])
            {   hull() //Main shape.
                {   cylinder(r1=0,r2=t,h=th);
                    translate(pos+[0,0,fh-t]) cylinder(r=bbr+t,h=t);
                    translate(pos*(dist-fh/1.5)/dist) cylinder(r=t/2,h=fh);
                }
                hull()
                {   cylinder(r=bbr+t,h=t);
                    translate(pos*(dist-fh/1.5)/dist) cylinder(r=t/2,h=t);
                }
            }
            translate([dc+bsd,dc+bsd,fh-t]) cylinder(r=sr+2*t,h=t);

            //Screw 'platform'
            translate([dc,dc,fh-t]) rotate(45) cube(2*[sr+t,sqrt(2)*dc,t],center=true);
            cylinder(r=bbr+t,h=th);

            pulley_pos() hull()
            {   translate([0,0,pz]) pulley_add_1(); 
                translate([t,t]) cylinder(r=t/2,h=t);
            }
        }
        translate([dc-t/4,dc-t/4,fh]) cube([l,l,l]); //Space for bed.
        translate([0,0,-fh]) cylinder(r=bbr,h=4*fh);
        translate([dc+bsd,dc+bsd,t]) //Screw hole and space.
        {   cylinder(r1=(dc+bsd)*sqrt(2)-bbr-t,r=sr+t,h=fh-3*t);
            cylinder(r=sr,h=h+t);
        }
        translate([0,0,pz]) pulley_sub();
    }
}

module show_bed()
{
    color("red") translate([zrd,zrd]) bed_holder();
//    planks_space();
    color("green") translate([zrd,zrd,fh+bh]) cylinder(r=tbr,h=10);
    //Illustrates space the pulley may not violate.
}
show_bed();
