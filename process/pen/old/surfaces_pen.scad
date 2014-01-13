//
//  Copyright (C) 17-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Pen for surface-style printing;
// zero top and bottom levels (not a few bottom levels like for cups)
// zero infill  
// low number of perimeters

//(slic3r: --top-solid-layers 0 --bottom-solid-layers 0 --fill-density 0
//         --perimeters 1)

t=3;

pr=75; 

lr = 20;   //radius of lead.
ll = 1050; //length of lead.
//slr = 15;  //small radius of lead(not used)

pl= ll; //length of pen.

rc = 4*pr/3-0.8*lr; //Cut radius of lead holder.

bl = pr + 2*rc; //Length of bottom of pen.
tl = pl/2; //..top

inf = 4*pl;

module inficube(pos)
{   translate(pos) cube(2*[inf,inf,inf], center=true); }

module default_base_shape()
{  
    intersection()
    {   translate([0,0,pl/2]) scale([1,1,pl/pr]) sphere(pr);
        translate([0,0,(pl-tl)/2]) cube([inf,inf,pl-tl], center=true);
    }
    eff_z = (pl-tl)*pr/pl;
    r = sqrt(pr*pr - eff_z);
    intersection()
    {   translate([0,0,pl-tl]) scale([1,1,1.06*tl/r]) sphere(r);
        translate([0,0,pl/2]) cube(2*[inf,inf,pl/2], center=true);
    }
}

module img() //Note values regarding this rather botched, tbh!
{   rotate([0,90]) scale([4,-6,16]) 
        translate([-54,-7]) surface(file = "surface.dat", center = false, convexity = 5); 
}
module base_shape()
{   
    intersection()
    {   translate([0,0,bl+6.5*pr]) img();
        scale(1.1) default_base_shape();
    }
    default_base_shape();
}

module bottom_cut()
{
    translate([-4*pr/3,pr,pr]) rotate([90,0])
    {   cylinder(r= rc, h=4*pr);
        translate([0, pr]) cylinder(r=rc, h=4*pr);
    }
}
d = pr/4;
module bottom()
{
    br = pr-3*d/4-t; //'Bulbous' areas for clicking.
    rotate(90) intersection() //Rotation avoids damage due to travelling away a bit.
    {   union()
        {
            difference()
            {   base_shape();
                bottom_cut();
                scale(-1) bottom_cut();
                inficube([0,0,bl+inf]);
            }
            translate([0,0,bl])
            {
                cylinder(r1=pr, h=pr);
                cylinder(r=pr/2, h = 3.5*pr);
                translate([0,0,pr]) scale([1,1,(pr-t)/br]) sphere(br);
                translate([0,0,2.5*pr]) scale([1,1,(pr-t)/br]) sphere(br);
                translate([0,0,4*pr]) scale([1,1,(pr-t)/br]) sphere(br);
            }
        }
        cylinder(r1=pr,r2=0.8*pr, h =bl+4*pr+br);
    }
}

module cut_torus()
{   rotate_extrude() translate([pr,0]) rotate(45) square([d,d]);
}

module top()
{
    difference()
    {   translate([0,0,-bl]) base_shape();
        translate([0,0,pr/4]) cut_torus();
        translate([0,0,1.5*pr + pr/4]) cut_torus();
        translate([0,0,3*pr + pr/4]) cut_torus();
        translate([0,0,4.5*pr + pr/4]) cut_torus();
        inficube([0,0,-inf]);
    }    
}

module as_assembled()
{
    bottom();
    translate([0,0,bl+1.5*pr+5*pr*$t]) top();
}

module as_print()
{   top();
    translate([4*pr,0]) bottom();
}
as_print();
//as_assembled();
bottom();
