//
//  Copyright (C) 22-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Hmm just bending one way might be nicer..

r =10; t=2;
dev=1;
h=3*t;

module spring_profile()
{
    difference()
    {   circle(r); 
        circle(r-t); 
        translate([-2*r,0]) square(4*r*[1,1],center=true); 
        rotate(-45) translate([-2*r,0]) square(4*r*[1,1],center=true); 
    }
    translate([-t/2,-r]) square([t,r]);//, center=true);
}

module finger_tip()
{   polygon([[0,0], [0,-2*t],[t/2,-3*t/2], [t/2,0]]); }

module from_spring_finger()
{
    translate([r/sqrt(2),0]) 
    {   scale([1/3,1/sqrt(2)]) intersection()
        {   difference(){   circle(r); circle(r-3*t/2); }
            scale([-1,1]) square([r,r]);
        }
        translate([-r/3,0]) finger_tip();
    }
}

module from_wall_finger()
{
    translate([-t/2,-r]) square([t,r+t]);//, center=true);
    translate([r/6+t/2,0]) difference()
    {   
        circle(r/3-t/4);
        circle(r/3-3*t/4); 
        translate(-2*[0,r]) square(4*[r,r],center=true);
    }
    translate([r/2+t/4,0]) scale([-1,1]) finger_tip();
}

module spring_finger()
{
    linear_extrude(height=h/3) spring_profile();
    linear_extrude(height=h) from_spring_finger();
}

spring_finger();

color([0,0,1]) translate([0,0,7*t]) from_wall_finger();
