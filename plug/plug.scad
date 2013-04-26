//
//  Copyright (C) 26-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

t = 10;
w= 40; h= w; l =60;
f=1.05;

sr= 4;
inf = 3*(l+w+h);

module slide_hole_profile()
{
    difference()
    {   union()
        {   square([w,2*h/3]);
            translate([w/2,h/2]) square([w/3,h],center=true);
        }
        translate([w/2,0]) square([w/3,h/3],center=true);
    }
}

module body_profile()
{   minkowski()
    {   square([w,h]);
        circle(t);
    }
}
module body()
{
    difference()
    {   linear_extrude( height=l ) difference()
        {   body_profile();
            slide_hole_profile();
            translate([w/2,2*h/3]) scale([1,1/3]) circle(w/2);
            translate([w/8,h-sr/2]) circle(sr);
            translate([7*w/8,h-sr/2]) circle(sr);
        }
        translate([0,h-w/3,l-w/2]) rotate([45,0,0]) cube([w,w,w]);
    }
}


module slide_cut()
{   translate([w/2,h/6]) 
    {   rotate(135) rotate([90,0,0]) cylinder(r=sr,h=inf);
        rotate(225) rotate([90,0,0]) cylinder(r=sr,h=inf);
    }
    translate([0,2*h/3+sr]) rotate([0,90,0]) cylinder(r=sr,h=inf);
}
module slide()
{   
    difference()
    {   linear_extrude(height=l) difference()
        {   slide_hole_profile();
            translate([w/2,h/6]) circle(w/6);
        }
        translate([0,0,l/4]) slide_cut();
        translate([0,0,l/2]) slide_cut();
        translate([0,0,3*l/4]) slide_cut();
    }
}
translate([2*w+t,0]) slide();

body();
