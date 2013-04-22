//
//  Copyright (C) 20-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

pr=75; 

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

use<twist_pen.scad>

bottom();
/*
pt = 16;
ct = 4;

minkowski()
{
    circle(ct);
    translate([ct,ct]) square([pt,ct]);
}
*/
