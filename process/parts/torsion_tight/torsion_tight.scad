//
//  Copyright (C) 05-03-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//The whole thing rotates, just the inner part of it rotates if against pressure.
//Useful for instance to allow power springs to be tightened without releasing
// first.

h= 20;

d=5; //Distance pushed in.

ro = 60;
ri = 40;
rd = d;

ra = ri/2;

n = 5;

module cut_base()
{
    for( a= [ 0 : 360/n :360 ] )
    {
        rotate(a=a) translate([0,d]) difference()
        {
            circle(ri-d);
            translate([-ro,0]) square(2*[ro,ro], center=true);
        }
    }
}

module rot_base()
{
    r = (ri+ra)/2;
    circle(ra);
    for( a= [ 0 : 360/n :360 ] )
    {
        rotate(a=a) translate([0,ri-r]) difference()
        {
            circle(r);
            translate([-ro,0]) square(2*[ro,ro], center=true);
            scale([0.7,1]) circle(r-rd);
        }
    }
}
color([1,0,0]) linear_extrude(height=h) rot_base();

linear_extrude(height=h)
difference()
{ 
    circle(ro);
    cut_base();
}
