//
//  Copyright (C) 20-05-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Damper for the feet of a reprappro more specifically. 
//Inspired by feet out there.

$fs=0.2;

//This bit was gleaned from github.com/reprappro/Mendel,
// version 3ac59579a49410dc2204ccb1006dfabf0deeadf6
xfeet = 288;
yfeet = 320;

m8_diameter = 9;
m8_horizontal=m8_diameter+0.5;
vfvertex_height=m8_horizontal+4;

diagonal=atan2(xfeet,yfeet);
diag_y = 7;

module foot_substract()
{   w= m8_diameter;
    difference()
    {   translate ([0.1,8,0]) cube([15,20,vfvertex_height],center=true);
        translate ([-15,diag_y,6])  //Cuts off corners.
            rotate([0,diagonal,0])
            cube([20,20,20],center=true);
        translate ([15,diag_y,-6]) 
            rotate([0,diagonal,0])
            cube([20,20,20],center=true);
    }
    //Holes for tieing it to the reprap.
    rotate([0,diagonal,0])
        for( x= [1,-1]*w/1.2 ) translate([x,w]) rotate([90,0,0]) cylinder(r=3/2, h=2*w);
}

//(end gleaned bit)
w=m8_diameter;
l= 1.1*w;
t=3;
r= 1.7*w;

tw= 5;th=2; //Tie rib width and height

module damper_profile()
{
    h=2*(w+2*t);
    difference()
    {   union()
        {   square([l+2*r,h],center=true);
            for( x= [1,-1]*(l/2+r) ) translate([x,r-h/2]) circle(r);
        }
        for( x= [1,-1]*(l/2+r) ) translate([x,r-h/2]) circle(r-t);
        translate([0,t]) square([l+2*r,w+t],center=true);
    }
}

module damper()
{
    difference()
    {   linear_extrude(height=2*w) damper_profile(); //Main profile.
        translate([0,w+2*t,w]) scale(1.05) foot_substract(); //Foot hole.
        translate([0,t/2+th/2-w,w]) cube([2*w,th,tw],center=true); //Hole for tie rib.
        for( z=[w/2,3*w/2] ) translate([0,0,z])
        { //Path for elastic on ground.
            translate([-w,-w-t]) rotate([0,90]) scale([1,1/2]) cylinder(r=t/2, h=2*w);
           //And holes for elastic.
            for( x= [w,-w] ) translate([x,0]) rotate([90,0]) cylinder(r=t/2, h=2*w);
        }
        for( z=[0,2*w] ) //Grooves for tie rib clamp.
            translate([0,-t,z]) cube([2*l,th,w],center=true);
    }
}
//Tie rib
module tie_rib_clamp() //Just a block with a hole in it.
{
    linear_extrude(height=2*t) difference()
    {   intersection() //Block with some rounding.
        {   square([2*w, th+t]);
            translate([w,0]) scale([1,1.3*(th+t)/w]) circle(w);
        }
        translate([w,0]) square([1.02*w,t], center=true); //Slot for damper part.
        translate([w,th+t]) square([tw,2*th], center=true); //Slot for tie rib.
    }

}

damper();
tie_rib_clamp();
