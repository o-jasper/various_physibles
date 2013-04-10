//
//  Copyright (C) 11-04-2013 Jasper den Ouden.
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

lr =10;

t = 20;
pr= 50;

ir=pr-t;

cl= 2*(ir+t);
hl = 5*ir;
bl= cl + hl;

fl = 160;
pl = 600;

ff=0.15;

inf=2*(pl+bl);

module holding_profile()
{
    for( y = [ 2*ir-bl: ir : hl-bl-ir ] )
    {   translate([0,y]) square([ir,ir/2], center=true);
    }
}

_rs = (ir - 3*lr/2 + t/2)/2;
module _clicker()
{
    translate([pr-_rs-t/2,   bl]) circle(_rs);
    translate([-(pr-_rs-t/2),bl]) circle(_rs);

    translate([0,ir+bl/2]) square([2*ir,bl-2*ir], center=true);
    translate([0,2*ir]) circle(ir);
}

module clicker()
{    
    difference()
    {   linear_extrude(height=ir) difference()
        { 
            _clicker();
            translate([0,bl]) holding_profile();        
            translate([0,bl]) square([3*lr-2*ir,2*cl], center=true);
        }
        translate([0,pr+ir/2,ir/2]) rotate([-90,0]) cylinder(r=lr,h=3*inf);
    }
}



module base_shape(r,h)
{
    linear_extrude(height=h) difference()
    {   circle(r);
        translate([0,+inf + r*(1-ff)]) square(2*inf*[1,1], center=true);
        translate([0,-inf - r*(1-ff)]) square(2*inf*[1,1], center=true);
    }
}

module pen_back()
{   difference()
    {   translate([0,ir-bl+ir]) union() 
        {   sphere(pr);
            rotate([-90,0]) cylinder(r=pr,h=bl-cl-pr);
        }
        translate([0,0,+inf + pr*(1-ff)]) cube(2*inf*[1,1,1], center=true);
        translate([0,0,-inf - pr*(1-ff)]) cube(2*inf*[1,1,1], center=true);
        
        translate([0,-bl,-ir/2]) linear_extrude(height=ir) _clicker();
        translate([0,0,-inf]) linear_extrude(height=3*inf) holding_profile();
    }
}

module pen_front()
{
    difference()
    { 
        translate([0,-cl+lr]) union()
        {   rotate([-90,0]) cylinder(r=pr,h=pl-bl-fl);
            translate([0,pl-bl-fl]) scale([1,fl/pr,1]) sphere(pr);
        }
        translate([0,-bl,-ir/2]) linear_extrude(height=ir) _clicker();
        translate([0,-bl-2*_rs,-ir/2]) linear_extrude(height=ir) _clicker();

        translate([0,0,+inf + pr*(1-ff)]) cube(2*inf*[1,1,1], center=true);
        translate([0,0,-inf - pr*(1-ff)]) cube(2*inf*[1,1,1], center=true);

        //Pen lead hole.
        translate([0,inf]) rotate([90,0]) cylinder(r=lr,h=3*inf);
    }
}

module holder()
{
    difference()
    {   union()
        {   translate([-2*lr/3,lr/2-lr*ff]) cylinder(r=lr/2, h=2*pr);
            translate([2*lr/3,lr/2-lr*ff]) cylinder(r=lr/2, h=2*pr);
            translate([-pr/2,0]) cube([pr,pr/2,pr/2]);
            translate([-pr/2,0,3*pr/2]) cube([pr,pr/2,pr/2]);
        }
        translate([0,-inf]) cube(inf*[2,2,2],center=true);
    }
}

translate([-2*pr,0])holder();

translate([2*pr,0]) color([0,0,1]) pen_front();

pen_back();
translate([0,-bl,2*pr]) clicker();
