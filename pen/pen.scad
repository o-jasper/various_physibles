//
//  Copyright (C) 12-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//TODO 
//* real values
//* Print layout `module` bridging, and possibly half-cuts.
//* Assembly `module`

//All are times ~10.(not yet exact)
pr=100;
pl=1000;

lr = 10;

t=50;
cr=1.1*t; //Clicker radius.
cl=max(pl/8, 4*cr+t);  //.. length

bl = pl/4; //Length of bottom of pen.
tl = pl/2;

inf = pl;

module default_base_shape()
{  
    intersection()
    {   translate([0,0,pl/2]) scale([1,1,pl/pr]) sphere(pr);
        translate([0,0,(pl-tl)/2]) cube([inf,inf,pl-tl], center=true);
    }
    eff_z = (pl-tl)*pr/pl;
    r = sqrt(pr*pr - eff_z);
    intersection()
    {   translate([0,0,pl-tl]) scale([1,1,1.06*tl/r]) sphere(r);
        translate([0,0,pl/2]) cube(2*[inf,inf,pl/2], center=true);
    }
}

module base_clicker(d)
{
    translate([pr-t,cl]) circle(t/2);
    translate([-pr+t,cl]) circle(t/2);
    translate([-pr+t,0]) square([2*(pr-t),cl+d]);
}

s=max(4*lr,t+lr);
module clicker()
{
    translate([0,0,-cr/2]) linear_extrude(height= cr) difference()
    {   base_clicker(0);
        translate([0,cl]) square([s,2*cl], center=true);
    }
}

module sub_clicker()
{   translate([0,0,-cr/2]) linear_extrude(height= cr) 
    {   base_clicker(cr);
        translate([0,cl]) scale([1,3]) circle(pr-t);
        translate([0,-2*cr]) base_clicker(cr);
    }
}

module pushthing() 
{   rotate([0,180+45]) cylinder(r=lr,h=inf);
    rotate([0,135]) cylinder(r=lr,h=inf);
    sphere(lr);
}
module lead_space()
{
    difference()
    {   union()
        {   translate([0,0,-inf]) cylinder(r=lr, h=3*inf);
            translate([0,0,bl/2]) scale([1,1,4]) sphere(4*lr);
        }
        for( z= [bl/2-10*lr : 6*lr : bl/2+10*lr] )
        {   translate([0,1.5*lr,z]) pushthing();
            translate([0,-1.5*lr,z]) pushthing();
        }
    }
}

module base_shape()
{   default_base_shape(); }

module default_pen_bottom()
{
    intersection()
    {   base_shape();
        union()
        {   difference()
            {   union()
                {   color([0,0,1]) translate([0,0,bl-inf]) cube(2*[inf,inf,inf], center=true);
                    translate([0,0,bl]) rotate([90,0]) clicker();
                }
                translate([0,0,t]) cylinder(r=s/2,h=inf);
            }
            rotate(90) for( z= [t : 6*lr : bl+t] )
            {   translate([0,1.5*lr,z]) pushthing();
                translate([0,-1.5*lr,z]) pushthing();
            }
        }
    }
}
module default_pen_top()
{
    difference()
    {   base_shape();
        translate([0,0,bl-inf]) cube(2*[inf,inf,inf], center=true);
        translate([0,0,bl]) rotate([90,0]) sub_clicker();
        translate([0,0,-inf]) cylinder(r=lr,h=3*inf);
    }
}

module as_print()
{   translate(2*pr*[1,1]) default_pen_bottom();
    translate([0,0,-bl]) default_pen_top();
}

as_print();
