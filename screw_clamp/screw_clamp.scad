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

t=5;
ti = t;
to = max(fil/6, nw+t);

pa = 7; //Angle to print it at. //TODO calculate it.

$fs=0.4;

fh = 0.97;

inf = 10*fil;

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
    r2=ur+t;
    difference()
    {   intersection()
        {   cylinder(r=r2, h=el);
            sphere(sqrt(r2*r2 + el*el)-to/8);
        }
        cylinder(r=br, h= ehl);
    }
}

f=0.65;
module nutend()
{
    translate([-el/2,0]) rotate([0,90,0]) difference()
    {   cylinder(r=to/2, h= 5*to);
        //   translate([0,0,5*to]) sphere(0.9*to/2);
    }
}

module frame()
{
    difference()
    {   union()
        {   
            translate([el/2,0]) rotate([90,0,0]) scale([1,f]) cylinder(r=to,h=w);
            translate([fil-px-el/2,0]) rotate([90,0,0]) scale([1,f]) cylinder(r=to,h=w);
            translate([el/2,-w]) scale([1,f,f]) 
            {   rotate([0,90,0]) cylinder(r=to,h=fil-px-el);
                sphere(to);
                translate([fil-px-el,0]) sphere(to);
            }
            translate([fil-px,0]) scale([-1,1]) nutend();
            nutend();
        }
        translate([5*to-el/2,0]) sphere(0.9*to/2);
        translate([fil-5*to,0]) sphere(0.9*to/2);
        
        translate([0,0,-inf-to/2]) cube(inf*[2,2,2],center=true);
        translate([0,0,inf+to/2]) cube(inf*[2,2,2],center=true);
        
        //Cuts for moving bits and space for it.
        translate([el/4,-w,-inf]) linear_extrude(height=2*inf)
        {   translate([0,t]) square([fil-px-el/2,inf]);
            translate([t,0]) square([fil-px-el/2-2*t,inf]);
            translate([t,t]) circle(t);
            translate([fil-px-el/2-t,t]) circle(t);
//            translate([t,t]) square([fil-px-el+t,inf+t]);
        }

        rotate([0,90,0]) 
        {   translate([0,0,px-nh-hcl/2]) linear_extrude(height= nh) hex_hole(nw);
            translate([0,0,px-nh-hcl/2]) linear_extrude(height= to+nh) hex_hole(fh*nw);
            
            translate([0,0,-w]) cylinder(r=br,h=2*w);
        }
        
    }
}

//Thumb wheel for it.
module thumb_wheel()
 {
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
        linear_extrude(height=nh) hex_hole(fh*nw);
    }
}

module as_print()
{
//    translate([w/2,0]) rodend();
    frame();
//    translate([1.4*w,0]) thumb_wheel();
}

as_print();

//frame();
