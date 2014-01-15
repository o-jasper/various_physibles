//
//  Copyright (C) 20-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<rounded_box.scad>

wd = 10; //used distance to wall.

psl = 211; //Power supply length
pshf = 54; //..height front
pshb = 53; //..height back
psh = max(pshf,pshb); //TODO `back_holder_profile` doesnt use this.

pl  = 250; //Plank length.
pt  = 20.2; //..thickness,

dx = 20; //Desired distance from wall, forced larger than `wd`!
dz = 20; // .. from plank.

sfd = 21.8; //Front distance to screw.
sbd = 9.8; //back ..
sl  = 2; //Screw leeway.
sr  = 0.7; //Screw radius.

ct = 8; //Use thickness.

gl = 50; //Minimum grab length.

w = ct; //Thickness the other way.

module plank_n_power()
{
    scale(-1) square([pl,pt]);
    translate([dx-pl,-dz-pt-pshb]) square([psl,pshf]);
}

module cut_screw()
{
    rotate([90,0]) 
    {   cylinder(r=sr, h=10*pshb);
        translate([sl/2,sr]) cube([sl,2*sr,10*pshb],center=true);
        translate([sl,0]) cylinder(r=sr, h=10*pshb);
    }
}

module back_holder_profile()
{   l = pl - psl-dx;
    h1= ct+dz+pshb/2;
    r= 2*ct/3;
    difference()
    {   union()
        {   translate([-gl,-pt-ct]) rounded_square(gl+ct,2*ct+pt, r);
            translate([-l/2,-pt-ct]) rounded_square(l/2+ct,2*ct+pt, r);
            translate([-l,-pt-h1]) rounded_square(l/2+ct,h1, r);
            translate([-l-sbd-sl-ct, -pt-pshb-ct-dz]) 
                rounded_square(sbd+sl+2*ct,pshb+2*ct, r);
        }
        translate([ct-l,-ct-pt-h1]) rounded_square(l/2+ct,h1, r);
        plank_n_power();
    }
}

module back_holder()
{
    difference()
    {   linear_extrude(height=w) back_holder_profile();
        translate([dx-pl+psl-sbd,pshb,w/2]) cut_screw();
    }    

}

module front_holder_profile()
{
    dx = min(wd,dx);
    r= 2*ct/3;
    z = -(ct+pt+dz+psh);
    psx = dx + sbd + sl + ct; //Distance of power supply to wall.
    translate([pl+dx,0]) intersection()
    {   difference()
        {   union() translate([-pl-dx,z])
            {   translate([-r,0]) rounded_square(2*dx+r,-z+ct, r);
                translate([0,0]) scale([1,(-z-pt+ct)/(psx+ct)]) circle(psx+ct);
                rounded_square(dx+sfd+sl + pl-psl,2*ct, r);
                translate([pl-psl-ct,ct+psh]) circle(ct);
            }
            translate([-pl-dx,z]) scale([1,(-z-pt-ct)/(psx-ct)]) circle(psx-ct);
            plank_n_power();
        }
        translate([-pl-dx,z]) square([pl,pl]);
    }
}

module front_holder()
{
    dx = max(wd,dx);
    psx = dx + sbd + sl + ct; //Distance of power supply to wall.
    difference()
    {   linear_extrude(height=w) front_holder_profile();
        translate([psx+sfd,pshb,w/2]) cut_screw();
        translate([dx+ct,pshb,w/2]) rotate([90,0]) cylinder(r=sr, h=10*pshb);
    }
}

module show_use()
{   color([0,0,1]) plank_n_power();
    
    translate([-pl-wd,0])front_holder();
    back_holder();
}

//show_use();
front_holder();
//back_holder();
