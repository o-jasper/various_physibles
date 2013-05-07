//
//  Copyright (C) 05-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//M6 x 60
l = 60; //Length of bolt
br = 6/2; //Radius of bolt

nw = 10.8; // Nut width
nh = 6; //Nut height.
hh = 5; //Head height.

hl = 30; //Handle length.(minimum of 1.1*hh+ti)

//('advanced') params.
d = 1; //Extra.

hcl = 4; //'Head capture' room.

px = 3;

el = 10;
ehl = 6; //Space for end to hang on to.
fil = l + el - ehl - hcl + 2*px;

echo(fil+2*to);

w = fil/2;

hi = fil/5;
to = fil/6;
ho = hi/3;
ti = to/2;

pa = 7; //Angle to print it at. //TODO calculate it.

$fs=0.4;

f = 0.97;

module _screw_frame(t,h)
{
    difference()
    {   union()
        {   translate([-t,0]) cube([fil+2*t,w,h]);
            cube([fil,w+t,h]);
            translate([0,w]) cylinder(r=t,h=h);
            translate([fil,w]) cylinder(r=t,h=h);
        }
        translate([0,-w,-hi]) cube([fil,2*w,3*hi]);
    }
}

module hex_hole(w)
{
    difference()//Where it goes on the big nuts.
    {   circle(w); //Hex thing
        for( a= [30:60:390] ) rotate(a) translate([w,0]) square([w,w],center=true);
    }
}

ur = nw/2; //Radius near nut.

module rodend()
{
    r2=ur+ti; //br+to;
    difference()
    {   intersection()
        {   cylinder(r=r2, h=el);
            sphere(sqrt(r2*r2 + el*el)-to/8);
        }
        cylinder(r=br, h= ehl);
    }
}

//Gah openscad fucking up again.
module frame()
{
    r_a = sqrt(hi*hi + (px+ti)*(px+ti));
    difference()
    {   union()
        {   
            _screw_frame(ti,hi);
            translate([0,0,(hi-ho)/2]) _screw_frame(to,ho);
            
            translate([fil-px,0,hi/2]) rotate([0,90,0]) scale([1,2])
            {   intersection()
                {   cylinder(r=hi,h=px+ti);
                    translate([0,0,px+ti]) sphere(r_a-to/8);
                }
                translate([0,0,px+ti]) scale([2,2,(to-ti)/ho]) sphere(ho);
                cylinder(r=ho/2, h=px+to);
            }

            translate([0,0,hi/2]) rotate([0,90,0])  //Nut end.
            {   translate([0,0,-ti]) cylinder(r=ur + ti, h= ti+px);
                translate([0,0,-to]) cylinder(r1 = ur+ho, r2 = ur+ti, h= to-ti);
                translate([0,0,-to]) scale([1,1,1/2]) sphere(ur+ho/2);
            }
        }
        
        translate([fil-px-to,0,0]) cube(to*[2,2,2],center=true);
        translate([0,0,hi/2]) rotate([0,90,0]) 
        {   translate([0,0,px-nh-hcl/2]) linear_extrude(height= nh) hex_hole(nw);
            translate([0,0,px-nh-hcl/2]) linear_extrude(height= to+nh) hex_hole(f*nw);
            
            translate([0,0,-w]) cylinder(r=br,h=2*w);
        }
        
    }
}

//Thumb wheel for it.
module thumb_wheel()
 {
    t=ti;
    h=max(hl, t+1.1*hh);
    mr = nw/2+t;
    difference()
    {   union()
        {   cylinder(r=mr, h=h-t/2);
            cylinder(r=mr/2, h=h-t/4);
            translate([0,0,h-t/2]) rotate_extrude() 
                translate([mr-t,0]) scale([1,1/2]) circle(t);
            for( a=[0:60:360] ) rotate(a) translate([nw/2+t/2,0]) 
                                {   cylinder(r=t, h=h-2*t);
                                    translate([0,0,h-2*t]) sphere(t);
                                }
        }
        translate([0,0,0.1*hh]) linear_extrude(height=nh) hex_hole(nw);
        linear_extrude(height=nh) hex_hole(f*nw);
    }
}

module as_print()
{
    translate([w/2,0]) rodend();
    translate([0,0,ur+ti-hi/2]) frame();
    translate([1.5*w,0]) thumb_wheel();
}

as_print();

//frame();
