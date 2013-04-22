//
//  Copyright (C) 22-04-2013 Jasper den Ouden.(ojasper.nl)
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

//TODO 
//* make the pinch bits less steep; easier for the printer.
//* an additional clicking system with a thing with a 'hat'
//* images on the sides.

pr=75; 
er = 10;

lr = 20;   //radius of lead.
ll = 1050; //length of lead.
//slr = 15;  //small radius of lead(not used)

pl= ll; //length of pen.

rc = 4*pr/3-0.8*lr; //Cut radius of lead holder.

bl = pr + 2.2*rc; //Length of bottom of pen.
tl = pl/2; //..top

scr = 2*lr/3; //Cut radius of screw.
scd = lr/16; //Extra room for screw.
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
        translate([-2.2*pr,rc/2]) scale([1,2,1]) cylinder(r=2.9*pr, h= 4*pr);
    }
}

module screws(R)
{
    color([0,0,1]) for( i=[1:scn] )
        rotate(360*i/(scn-0.5)) 
        {   linear_extrude(height=sch, twist=sca) 
                translate([R,0]) circle(scr);
            rotate(sca) translate([R,0,sch-1]) cylinder(r1=scr,h=2*scr);
        }
}

module bottom()
{
//    sz = bl+ 2*(pr-scR)+ sch;
    difference()
    {   union()
        {   cylinder(r=pr,h=bl);
            translate([0,0,bl]) cylinder(r1=pr,r2=scR, h= 2*(pr-scR));
            cylinder(r=scR, h= bl+sch);
            translate([0,0,bl]) 
            {   screws(scR);
                translate([0,0,sch]) cylinder(r=scR, h= 2*scr);
                translate([0,0,sch+2*scr]) 
                {   cylinder(r1=scR, h= 2*scR);
                    cylinder(r1=0, r2=scR, h= 2*scR);
                    cylinder(r=3*scR/5, h=2*scR);
                }
                translate([0,0,sch+2*(scr+scR)]) cylinder(r1=scR,r2=scR/2, h= scR);
            }
        }
        translate([0,0,0.2*rc])
        {   bottom_cut();
            rotate(180) bottom_cut();
        }
    } 
}

module top_cut()
{
    pz = 2*scr + scR;
    rh = (pr+scR)/2;
    difference()
    {   union()
        {   cylinder(r=pr, h=sch);
            translate([0,0,sch]) 
            {   cylinder(r1=pr,r2=rh, h=pz-pr/2);
                translate([0,0,pz-pr/2]) cylinder(r1=rh,r2=0.8*scR, h=pr/2);
                translate([0,0,pz]) cylinder(r1=0.8*scR,r2=rh, h=pr/2);
                translate([0,0,pz+pr/2]) cylinder(r=rh, h=pr/2);
            }
        }
        screws(pr);
    }
}

module top()
{
    tr = pr+er; //Total radius.
    difference()
    {   
        union()
        {   cylinder(r=tr, h=pl-bl-tl);
            translate([0,0,pl-bl-tl]) 
                scale([1,1,(tl+tr/3)/tr]) sphere(tr);
        }
        inficube([0,0,pl-bl+inf]);
        inficube([0,0,-inf]);
        
        top_cut();
    }
}

module as_print()
{
    rotate(90) bottom();
    translate([3*pr,0]) top();
}

translate([400,300])as_print();

module cut_bottom()
{
    translate([0,0,4*pr/3]) rotate([-90,0]) difference()
    {   cylinder(r=pr,h=bl);
        bottom_cut();
        rotate(180) bottom_cut();
    }
}

module pen_plank_clamp(pt,d,ct)
{
    difference()
    {   linear_extrude(height=1.5*pr) difference()
        {   union()
            {   minkowski()
                {   circle(ct);
                    translate([ct,ct]) square([pt,d]);
                }
                translate([pt+2*ct,0]) circle(ct);
                translate([ct,0]) circle(ct);
            }
            translate([ct,ct]) square([pt,2*d]);
        }
        translate([0,ct]) rotate(225) cut_bottom();
        translate([pt+ct,ct/2]) rotate(247.5) cut_bottom();
        translate([pt+ct,d]) rotate(-90)  
        {   cut_bottom();
            translate([-pr,0]) cut_bottom();
        }
    }
}

//pen_plank_clamp(165,160,80);
