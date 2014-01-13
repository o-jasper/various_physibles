//
//  Copyright (C) 24-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

bw = 15; //Blade width.
bt = 2.5; //Thickness.
bl =75;  //..length

mr = 16/2; //Magnet radius.
mh = 11; //Magnet height.

rr = 9.1/2; //Rod radius.

//tw = 8; //tweezers width.

sr = 3.8/2;
sh=4.9;

t = 2.5; //Thicknesses

module tweezersnknife()
{
    rs = (mr+t)/2;
    difference()
    {   union()
        {   cylinder(r=rr+t,h=bw + 2*t);
            translate([0,0,bw/2+t]) sphere(mr+t);
            translate([rr+t/2,-rr]) linear_extrude(height=bw+2*t) minkowski()
            {   square([bt,bl]);
                circle(t);
            }
            translate([0,0,rr+2*t]) rotate([0,-90,0]) cylinder(r=mr+t, h=rr+t+mh);
            translate([-rr-mh-t,-rs]) cube([mh+2*rr+2*t,2*rs,bw+t]);
        }
        translate([-rr/2,0]) cube([rr,mr+t,2*(bw+t)]);
        
        translate([rr+t/2,-bl-rr,t]) cube([bt,2*bl,bw]);
        cylinder(r=rr,h=2*(bw+t));
        translate([-rr,0,rr+2*t]) rotate([0,-90,0]) linear_extrude(height=mh)
        {   circle(mr);
            translate([mr,0]) square(2*[mr,mr],center=true); 
            //cylinder(r=mr, h=2*(mh+t));
        }
        translate([0,0,-bl]) cube(bl*[2,2,2], center=true);
        translate([-rr-t-mh,0,bw/2+t]) scale([t/mr,1.5,0.9]) rotate([90,0,0])
            rotate(45) cube([2*mr+t/2,2*mr+t/2,2*bw], center=true);
//            cylinder(r= mr, h = 2*bw);
    }
}

tweezersnknife();
