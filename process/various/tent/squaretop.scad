//
//  Copyright (C) 08-03-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Stick-and-corner based tent.

d=100;
w=200;
h=150;

$r=9;

t=2;

module stick(l)
{
    translate([0,0,$r]) linear_extrude(height=l-2*$r) child();
}

module stick_rect()
{
    for(a=[0:90:270]) rotate(a) 
        translate([d/2,d/2]) rotate([90,0,0]) stick(d) child();
}

module stick_pattern()
{   
    vl= sqrt(d*d/4 + (w/sqrt(2)-d/2)*(w/sqrt(2)-d/2) + h*h);
    
    translate([0,0,h]) stick_rect(d=d) child();
    rotate(45) stick_rect(d=w) child();
    for(a=[0:90:270]) rotate(a) translate([0,w/sqrt(2)]) 
        rotate([-atan2(d/2-w/sqrt(2),h),0,0]) 
            for(b=[1,-1]*asin(d/(2*vl))) rotate([0,b,0]) stick(vl) child();
}

module bottom_corner(pr=$r/2,outward_pitch=true,inward_pitch=true,R=4*$r+t)
{
    r=$r; y=w/sqrt(2);
    translate($show ? [0,0,0] : -[0,w/sqrt(2)+r,0]) 
    {   intersection()
        {   union()
            {   stick_pattern($r=0) circle(r+t);
                translate([0,y,-1.2*r]) hull()
                {   cylinder(r=r+t,h=2*r);
                    if(outward_pitch) translate([0,r+pr,-d]) cylinder(r=pr+2*t,h=d+2*r); 
                }
            }
            difference()
            {   translate([0,w/sqrt(2)+r]) sphere(R);
                stick_pattern() child();
                translate([0,0,-4*d-r-t/2]) cube(d*[8,8,8],center=true);
                if(outward_pitch) translate([0,y+r+pr,-2*d]) cylinder(r=pr,h=8*d);
            }
        }
        if(inward_pitch) translate([0,y-2*r,-r-t/2]) linear_extrude(height=3*t) 
                             difference(){ circle(r); circle(pr); }
    }
}

module top_corner(t=2,R=2*$r+t)
{
    r=$r;
    rotate([0,180,0]) translate($show ? [0,0,0] : -[d/2,d/2,h]) intersection()
    {   union()
        {   stick_pattern($r=0) circle(r+1.4*t);
            translate([d/2,d/2,h]) sphere(r+1.4*t);
        }
        difference()
        {   translate([d/2,d/2,h]) sphere(R);
            stick_pattern() child();
            translate([0,0,h+4*d+r+t]) cube(d*[8,8,8],center=true);
        }
    }
}

module show()
{
    $show=true;
    rotate([0,180,0]) top_corner() child();
    bottom_corner() child();
    color("blue") stick_pattern() child();
}
//show() square([8,8],center=true); //circle(4);
//show() circle(4,$fn=3);

//NOTE: doesnt co-operate at all!
module tiny_top_corner()
{
    $fs=0.1;
    $r=0.7;
    t=$r;
    top_corner(t=$r/2,R=2*$r+t) circle($r);
}
module tiny_bottom_corner()
{
    $fs=0.1;
    $r=1.3;
    t=$r;
    bottom_corner(t=t,R=2*$r+t) circle($r);
}

//top_corner() circle($r);
show() circle($r);
