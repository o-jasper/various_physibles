//
//  Copyright (C) 21-06-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

R=35;
t=3;

sr = 4;
sR = 200;

module _petal()
{   intersection()
    {   difference()
        {   translate([0,0,t]) sphere(R);
            sphere(R);
        }
        translate([+R/2,0,-2*R]) cylinder(r=R,h=4*R);
        translate([-R/2,0,-2*R]) cylinder(r=R,h=4*R);
    }
}

module petal()
{   rotate([180,0]) translate([0,-R*0.8,-R*0.6]) _petal(R=R); }

module petal_3()
{   difference()
    {   for( a = [0:120:360] ) rotate(a) rotate([45,0]) petal(R=R);
        translate([0,0,-R]) cylinder(r=sr,h=9*R);
    }
}

module outer()
{   translate([0,0,-2*t]) petal_3(); }

module inner1()
{   rotate(60) color([0,0,1]) petal_3(); }

module inners1()
{   rotate(30) petal_3(R=0.8*R); }

module inners2()
{   translate([0,0,2*t]) rotate(90) color([0,0,1]) petal_3(R=0.8*R);}

module center()
{   rotate(30) translate([0,0,3*t]) 
        for( a = [0:45:360] ) rotate(a) rotate([20,0]) scale(0.3) petal();
    rotate([180,0]) difference()
    {   cylinder(r=sr,h=4.5*t);
        translate([0,4*t,3.5*t]) rotate([90,0]) cylinder(r=sr/4,h=8*t);
    }
}

module flower()
{
    outer();
    inner1();
    inners1();
    inners2();
    center();
}

flower();
//outer();

//rotate_extrude() translate([sR,0]) circle(t);
//translate([60,60]) cube([10,10,10]);
