//
//  Copyright (C) 03-06-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//The size difference between the male and female.
t=0;
//Length.
l = 40;
//Length of the top bit.
lt = 5;
//Radius.
R = 10;
//Dip.
d = 1;
//Number of petals.
n = 2;

module pill_sub()
{
    translate([0,0,lt]) difference()
    {   union()
        {   cylinder(r=R-t, h=l-2*lt);
            scale([1,1,1.5*lt/R]) sphere(R-t);
            translate([0,0,l-2*lt]) scale([1,1,1.5*lt/R]) sphere(R-t);
        }
        rotate_extrude() translate([R+d,l/2-lt]) circle(2*d+t, $fn=12);
        translate([0,0,-l-lt]) cube(l*[2,2,2], center=true);
        translate([0,0,2*l-lt]) cube(l*[2,2,2], center=true);
    }
}

module pill_flower()
{   
    difference()
    {   circle(R);
        for( a=[0:360/n:360] ) rotate(a) difference()
        {
            union()
            {   
                translate([R,0]) difference()
                {   square(R*[1,1/2], center=true);
                    for( y=R*[1,-1]/4 ) translate([-R/4,y]) 
                        scale([1,2/3]) circle(R/4, $fn=12);
                }
                translate([R/3,0]) square(R*[1/3,1], center=true);
                for( y=R*[1,-1]/2 ) translate([R/3,y]) circle(R/5, $fn=12);
            }
            scale([2/3,1]) circle(R/2, $fn=12);
            scale([7/8,1/3]) circle(R/2, $fn=12);
        }
    }
}

module pill()
{
    intersection()
    {   pill_sub(R=R,l=l,t=t,lt=lt,d=d);
        linear_extrude(height=l) pill_flower(n=n,R=R);
    }
}

pill(); 
//pill_flower();
translate([3*R,0]) pill_sub(t=0.5);
