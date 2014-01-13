//
//  Copyright (C) 16-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.2;

t=3;
r=6;
pr= 2;

l= r+3*t;

f=1;

cover_attach_holes=true;
pole_attacher=true;

module pole()
{   
    difference()
    {   union()
        {   scale([f,f,1]) cylinder(r=pr, h=l);
            if(pole_attacher) translate([0,0,t/2]) cube([2*t,2*pr,t],center=true);
        }
        if(pole_attacher) for( y= [-t/2,t/2] )
            translate([y,2*t,t/2]) rotate([90,0]) cylinder(r=t/4,h=4*t);
    }
}

module joint_ball()
{   scale(f) sphere(r);
    translate([0,0,-l]) pole();
}

module _joint_petal()
{
    union()
    {   translate([0,0,-r]) cylinder(r=max(pr+t,r/2), h=r);
        translate([0,0,-r-2*t]) cylinder(r1=pt, r2=max(pr+t,r/2), h=2*t);
        translate([0,0,-l]) pole();
    }
}

module joint_petal()
{
    difference()
    {   _joint_petal();
        sphere(r);
        rotate([-90,0]) cylinder(r=r-t/4,h=l);
    }
}

module flower_entry()
{
    rotate([-90,0]) cylinder(r=r,h=l);
    translate([0,r,-r]) cube([2*pr,2*r,2*r], center=true);
}

module _joint_flower()
{
    difference()
    {   union()
        {   sphere(r+t);
            translate([0,0,-r-1.5*t]) cylinder(r=max(pr+t,r/2)+t, h=r+1.5*t);
        }
//        translate([0,0,-r-t]) cylinder(r=max(pr+t,r/2), h=r+t);
//        translate([0,0,-l]) cylinder(r=pr, h=l);
        _joint_petal();
        sphere(r);
        translate([0,0,r+t]) cube([2*pr,2*(r+t),3*(r+t)],center=true);
    }    
}

module flower_cover_attach()
{
    if( cover_attach_holes ) union()
    {   translate([-2*r,r,-r-t/2]) rotate([0,90]) cylinder(r=t/4,h=4*r);
        for( a = [-60,60] ) 
            rotate(a) translate([-2*r,r+t/2,0]) rotate([0,90]) cylinder(r=t/4,h=4*r);
    }
}

module joint_flower()
{   difference()
    {   _joint_flower();
        flower_entry();
        flower_cover_attach();
    }
}

module flower_cover() //TODO something to mount the cover?
{
    intersection()
    {   _joint_flower();
        difference()
        {   flower_entry();
            cube([2*r,r,2*r],center=true);
            flower_cover_attach();
        }
    }
}

module assembled()
{   joint_petal();
    joint_flower();
    rotate([135,0]) joint_ball();
    
    flower_cover();
}

module display()
{
    translate([0,0,l-r-1.5*t]) joint_petal();
    translate([3*r,0]) joint_flower();
    translate([0,3*r, l-r-1.5*t]) joint_ball();
    translate([3*r,3*r]) flower_cover();
}
display();
//assembled();
