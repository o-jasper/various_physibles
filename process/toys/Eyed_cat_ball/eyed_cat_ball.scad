//
//  Copyright (C) 03-08-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.2;

R=30;
r=14;
t=5;

bc = 5;

n=8;

module eye(y=1.5*t) {
    rotate([90,0,0]) translate([0,0,-4*R]) linear_extrude(height=8*R) intersection(){
        translate([R-y,0]) circle(R); 
        translate([-R+y,0]) circle(R); 
    }
}

module toy_outer() {
    intersection() {   
        difference() {
            translate([0,0,-R + bc]) cylinder(r=2*R,h=2*R);
            translate([0,0,-R]) cylinder(r=r,h=8*R);
            sphere(R-t);
            for(a=[0:360/n:360*(1-1/n)]) rotate(a) eye(1.7*t, R=R-t);
        }
        sphere(R);
    }
}

module toy_inner(r=r+t*0.6, z = -1) {
    z = (z<0 ? r - R +t : -z);
    intersection() {   
        hull() {
            translate([0,0,z]) sphere(r);
            translate([0,0,-R+t]) sphere(r-1.6*t);
        }
        difference()
        {   translate([0,0,-R+bc]) cylinder(r=2*R,h=2*(R-t));
            hull() {
                sphere(r-2*t);
                translate([0,0,-R+t]) sphere(t/2);
            }
            translate([0,0,-R]) cylinder(r=r-2*t,h=8*R);
            translate([0,0,z]) for(a=[0:360/n:360*(1-1/n)]) rotate(a) eye(t*0.8,R=r);
        }
    }
}

module eyed_cat_ball() {
    toy_inner();
    toy_outer();
}
