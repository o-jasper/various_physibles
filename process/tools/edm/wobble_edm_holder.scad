//
//  Copyright (C) 24-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

$fs=0.1;
bl=170;

module screwthing_add(d=(bcr+1.5*t+sr))
{   hull() for(x=d*[1,-1]) translate([x,0]) circle(sr+t);
}
module wobble_edm_bottom() //Bottom where thing slides.
{   q=d+sr+2.5*t;
    rotate([180,0,0]) difference()
    {   union()
        {   translate([0,0,mrh-2*t]) cylinder(r=bcr+t,h=2*t); //Main around coil.
            translate([-1.5*t,-q,mrh-zh-t])  cube([3*t,q,zh+t]);//Main body.
            translate([0,-d,mrh-2*t]) cylinder(r=sr+t,h=2*t); //Strengthen around screw hole.
            //Attachment of top.
            translate([0,0,mrh-2*t]) linear_extrude(height=2*t) screwthing_add();
            //Attachment of wobbler.
            translate([0,sd+t+sr-d,mrh-2*t]) 
                linear_extrude(height=2*t) screwthing_add(d=sr+t);
        }
        //Cuts it a bit from the top for more space for the electromagnet.
        translate([0,0,mrh-1.5*t]) cylinder(r=bcr+t/2,h=2*t);
        cube(2*[d-t-bcr,d-t-bcr,mrh-2*t],center=true); //Space for wobbly thing.

        //Holding it to some other bit.
        translate([0,-d,-t]) cylinder(r=sr,h=8*mrh); 
        translate([0,-d,mrh-zh]) cube([8*t,sd+s,2*zh-5*t],center=true); 
        
        translate([0,0,-mrh]) cylinder(r=mrr,h=8*mrh); //Hole for metal bit to stick through.
        //Mounting the wobble thing that reaches for the anode.
        for(x=(sr+t)*[1,-1]) translate([x,sd+t+sr-d]) cylinder(r=sr,h=8*mrh);
        //Holes for mounting the electromagnet.
        for(x=(bcr+1.5*t+sr)*[1,-1]) translate([x,0]) cylinder(r=sr,h=8*mrh);
    }
}

module reacher(is_spacer=false) //Plate that reaches to the anode, intended to bend.
{
    bl=bl/2;
    rd=d-sd-2*(sr+t);
    difference() //Overreach.
    {   hull()
        {   translate([0,-rd]) circle(2*(sr+t));
            translate([0,bl-rd])  circle(sr+2*t);
        }
        hull()
        {   translate([0,-rd]) circle(2*sr+t);
            translate([0,bl-rd])  circle(sr+t);
        }
    }
    difference() //And then back to the anode bit.
    {   hull()
        {   square((sr+t/2)*[2,2],center=true); 
            translate([0,bl-rd+sr+t]) square([2*(t+sr),t],center=true);
        }
        //With slot to decrease cross section.
        translate([0,(bl-rd)/2+sr+t]) square([t,bl-rd+t],center=true);
    }
    translate([0,-rd]) square([3*(t+sr),t],center=true);
}

wt=1; //The entire thing with the reacher.
module wobble(h= (zh-t)/2, is_spacer=false)
{    
    difference()
    {   union()
        {   //Attach
            translate([0,sd+t+sr-d]) linear_extrude(height=h) screwthing_add(d=sr+t);
            //Reach to it.
            if(!is_spacer) linear_extrude(height=wt) 
                               reacher(is_spacer=is_spacer,bl=bl,d=d,t=t,sr=sr);
            //Holds the 
            if(!is_spacer) translate(-[sr+t/2,sr+t/2]) cube([2*sr+t,2*sr+t,h]);
        }
      //attach-holes.
        if(!is_spacer) translate([0,0,-t]) cylinder(r=sr,h=8*mrh);
        for(x=(sr+t)*[1,-1]) translate([x,sd+t+sr-d,-t]) cylinder(r=sr,h=8*mrh);
    }
}

module wobble_spacer(h=t)
{   wobble(h=h, is_spacer=true); }

module wobble_edm_top() //Cap with coil in it.
{   hole_r=max(mrr+t/2,bcr-2*t);
    difference()
    {   union()
        {   hull() //Cap
            {   cylinder(r=bcr+t,h=bch);
                cylinder(r=hole_r+t/2,h=bch+1.2*bcr);
            }
            linear_extrude(height=t) screwthing_add(); //Attachment
        }
        hull() //cap cavity/
        {   translate([0,0,-bch]) cylinder(r=bcr,h=2*bch);
            cylinder(r=t,h=bch+1.2*bcr-t);
        }
        for(x=(bcr+1.5*t+sr)*[1,-1]) translate([x,0]) cylinder(r=sr,h=8*mrh); //Attach holes.
        cylinder(r=hole_r,h=8*bch); //Hole at top.
    }
}

module show_wobble_edm()
{   wobble_edm_top();
    translate([0,0,-mrh]) color("blue") rotate([180,0,0]) wobble_edm_bottom();
    translate([0,0,-zh-2*t]) color("green") wobble();
    translate([0,0,2*t-zh]) rotate([0,180,0]) wobble();
    translate([0,0,-3*t]) color("green") wobble_spacer();
}
show_wobble_edm();

