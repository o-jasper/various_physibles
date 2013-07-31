//
//  Copyright (C) 19-07-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//NOTE bit thick imo.

servo_sx = 23; servo_sy = 12.5; servo_sz = 27;//22 
servo_s = [servo_sx,servo_sy,servo_sz];
t=2;

h= servo_sz;

echo(servo_s);

hh = 3;

w=32;

module side_servo()
{
    h=14;
    difference()
    {   intersection()
        {
            translate([0,-4,3]) cube([w+t,servo_sy+t+3.9,h], center=true);
            rotate([90,0,0]) translate([0,0,-w]) cylinder(r= w/2+t/2,h=3*w);
            translate([0,0,-w]) scale([1,1.5]) cylinder(r= w/2+t/2,h=3*w);
        }
        cube(servo_s, center=true);
        translate([0,6,5]) cube([40,24,2.5], center=true);
        for( x=[14,-14] ) translate([x,0,-h]) cylinder(r=1,h=2*h);
        for( x = [-servo_sx/2 : 20/7 : servo_sx/2] ) //
            translate([x,0]) rotate([90,0]) 
            {   cylinder(r=1,h=2*h);
                cylinder(r=3,h=servo_sy/2+hh);
            }
    }
}

//NOTE: going to make an alternative.
module side_camera()
{
    gh=44; gw=37; gt=15;
    difference()
    {   translate([hh,0]) union()
        {   translate([0,0,-1]) cube([gw+t+hh,gt+t,gh+2], center=true);
            translate([gw/2+t/2+hh/2,0,gh/2]) 
                rotate([0,-90]) cylinder(r=gt/2+t/2,h=gw+t+hh);
        }
        translate([-gw,0]) cube([3*gw,gt,gh], center=true);
        translate([gw/2,0,gh/2]) rotate([0,-90]) cylinder(r=gt/2,h=3*gw);
        translate([-gw/2,0,-gh/2]) cube([2*gw,7.5,gh], center=true);
        
        for( z = [2*t-gh/2 : 20/7 : gh/2-t] ) //
            translate([0,0,z]) rotate([0,90,0]) 
            {   cylinder(r=1,h=2*h);
                cylinder(r=3,h=gw/2+hh);
            }
    }
}

module side_servo_assembly()
{
    color([0,0,1]) include<9G_Servo_in_OpenSCAD/9g_servo.scad>

    side_servo();
}

//TODO slidable beam that holds it in place and escape for wire.
module servo_holder()
{
    difference()
    {   
        intersection()
        {   cube([w+t,servo_sy+t,h+2*t], center=true);
            translate([0,0,-w]) scale([1,0.7]) cylinder(r= w/2+t/2,h=3*w);
        }
        translate([0,t,h]) cube(servo_s+[0,t,2*h], center=true);
        translate([0,w/2-t,-6]) cube([2*w,w,2*t], center=true);
        translate([0,6,5]) cube([40,24,2.5], center=true);
        for( x=[14,-14] ) translate([x,0,-h]) cylinder(r=1,h=2*h);

        translate([w/2+1.6,0,-6]) cylinder(r=t,h=w);
        translate([5.5,0,-h]) cylinder(r=5, h=2*h, center=true);
    }
}

module base_floor_2d(R)
{
    difference()
    {   circle(1.6*R);
        for(a=[0:60:360]) rotate(30+a) translate([2*R,0]) circle(0.7*R);
    }
}

module base()
{
    R=30;
    difference()
    {
        intersection()
        {   translate([0,0,-R/2]) scale([2,2,4/3]) sphere(R);
            linear_extrude(height=w) base_floor_2d(R);
        }
        
        intersection()
        {   cube([w+1.5*t,servo_sy+1.5*t,2*R], center=true);
            translate([0,0,-R]) scale([1,1.5]) cylinder(r= w/2+t,h=3*R);
        }
        translate([0,0,-2*R]) cube(R*[4,4,4],center=true);
        for(a=[0:60:360]) rotate(a) 
            {   translate([w/2+R/2,0]) cylinder(r=R/2-t,h=w);
                rotate(30) translate([1.17*R,0]) cylinder(r=0.07*R,h=w);
            }
        for(a=[90,270]) rotate(a) translate([servo_sx/2+0.07*R,0]) cylinder(r=0.13*R,h=w);
    }
    linear_extrude(height=1) base_floor_2d(R);
}

//rotate([90,0]) translate([2*servo_sx,0]) side_servo();

//translate([4*servo_sx,0]) 
//rotate([0,0,90]) rotate([0,90]) side_camera();
//base();
//color([0,0,1]) servo_holder();
//include<9G_Servo_in_OpenSCAD/9g_servo.scad>
//translate([10,10,-3]) cube([2,2,18],center=true);
