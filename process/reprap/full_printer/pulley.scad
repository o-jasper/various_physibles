//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module pulley_pos() //At the position of the pulley.
{   d=hl-zrd;//tbr+3*t+2*sr/3;
    for(s=[1,-1]) rotate(45) scale([1,s,1]) translate([d,d]/sqrt(2)) child();
}

module pulley_add_1(){ translate([pr,2*t]) rotate([90,0,0]) cylinder(r=pr-t/2,h=4*t); }
module pulley_add()
{   pulley_pos() pulley_add_1(); }

module pulley_sub(bottom=true)
{
    pulley_pos() union()
    {   cylinder(r=2*sr,h=l);
        translate([pr,t]) rotate([90,0,0]) cylinder(r=pr+2*sr,h=2*t);
        translate([pr,fh]) rotate([90,0,0]) cylinder(r=sr,h=8*fh);
        translate([pr,6*t]) rotate([90,0,0]) cylinder(r=pr-t/2,h=4*t); 
        translate([pr,-2*t]) rotate([90,0,0]) cylinder(r=pr-t/2,h=4*t); 
    }    
}
