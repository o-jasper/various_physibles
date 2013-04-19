//
//  Copyright (C) 19-04-2013 Jasper den Ouden.(ojasper.nl)
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

pr=75; 

lr = 20;   //radius of lead.
ll = 1050; //length of lead.
//slr = 15;  //small radius of lead(not used)

pl= ll; //length of pen.

rc = 4*pr/3-0.8*lr; //Cut radius of lead holder.

bl = pr + 2.2*rc; //Length of bottom of pen.
tl = pl/2; //..top

scr = 2*lr/3; //Cut radius of screw.
scd = lr/3; //Extra room for screw.
scR = pr-lr -scd;
sch = 300;

sca = 360; //Screw total angle.
scn = 1*pr/scr; //Number of them.(3 is lower than pi to give it some room.)

inf = 2*pl;

module inficube(pos)
{   translate(pos) cube(2*[inf,inf,inf], center=true); }


module bottom_cut()
{
    translate([-4*pr/3,pr,pr]) rotate([90,0])
    {   cylinder(r= rc, h=4*pr);
        translate([0, pr]) cylinder(r=rc, h=4*pr);
    }
}

module screws(R)
{
    color([0,0,1]) for( i=[1:scn] )
        rotate(360*i/(scn-0.5)) linear_extrude(height=sch, twist=sca) 
            translate([R,0]) circle(scr);
}

module bottom()
{
    sz = bl+ 2*(pr-scR)+ sch;
    difference()
    {   union()
        {   cylinder(r=pr,h=bl);
            translate([0,0,bl]) cylinder(r1=pr,r2=scR, h= 2*(pr-scR));
            cylinder(r=scR, h= bl+sch);
            translate([0,0,bl]) screws(scR);
        }
        translate([0,0,0.2*rc])
        {   bottom_cut();
            scale(-1) bottom_cut();
        }
    } 
}

module top()
{
    difference()
    {   union()
        {   cylinder(r=pr, h=pl-bl-tl);
            translate([0,0,pl-bl-tl]) 
                scale([1,1,(tl+pr/3)/pr]) sphere(pr);
        }
        inficube([0,0,pl-bl+inf]);
        inficube([0,0,-inf]);
        screws(pr);
    
        for( i=[1:scn] )
            rotate(sca + 360*i/(scn-0.5)) translate([pr,0,sch-1]) cylinder(r1=scr,h=2*scr);
    }
}

module as_print()
{
    rotate(90) bottom();
    translate([3*pr,0]) top();
}

as_print();
