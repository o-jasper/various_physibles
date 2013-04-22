//
//  Copyright (C) 22-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Hmm just bending one way might be nicer..

r =10; t=2;

module spring_and_button()
{
    difference()
    {   scale([2,1]) circle(r); 
        scale([(2*r-sqrt(2)*t)/(r-t),1]) circle(r-t); 
        translate([0,2*r]) square(4*r*[1,1],center=true); 
    }

    difference()
    {   union()
        {   rotate(45) difference() 
            {   square(sqrt(8)*r*[1,1], center=true); 
                square((sqrt(8)*r-2*t)*[1,1], center=true);
            }
            translate([0,2*r]) scale([2,1]) circle(2*t); 
            translate([0,2*r-t]) square([4*t,2*t], center=true);
        }
        translate([0,-2*r]) square(4*r*[1,1],center=true); 
        translate([0,2*r-2*t]) square([2*t,4*t], center=true);
        translate([0,2*r]) scale([2,1]) circle(t); 
    }
}

spring_and_button();
