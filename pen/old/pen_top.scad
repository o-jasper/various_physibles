//
//  Copyright (C) 05-03-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Idea is that the top of the pen clicks into the two holes.

//TODO bottom needs to grab the 'lead'.
//NOTE: probably make the back end 'free'.

plate_w = 4;
pen_r = 20;
top_r=pen_r - plate_w;

pen_h = 8*top_r+2*plate_w;

pen_round_r = 4*plate_w;

top_d= plate_w;
top_h=50;

top_cut_h= top_h/1.5;

lead_r = 4;

dimple_h = 0.9*plate_w;

module _hold_sphere(f)
{   intersection()
    {   scale([1,(top_r+dimple_h)/top_r,1]) sphere(top_r);
        cube(2*[f*top_d,top_h,top_h], center=true);
    }
}

module pen_top()
{
    h=top_h; d=top_d; r=top_r;
    difference()
    {   
        union()
        {   scale([1,1,h/r]) sphere(r);
            translate([0,0,-h]) cylinder(h=h,r=r);
            translate([0,0,-h]) _hold_sphere(1);
        }
        scale([1,1,h/r]) sphere(r-d);
        translate([0,0,-2*h]) cylinder(h=4*h,r=lead_r);
        translate([0,0,-2*h]) cylinder(h=2*h,r=r-d);

        rotate(a=90, v=[1,0,0]) translate([-r,-h,-h]) 
            scale([1,top_cut_h/(r-d)]) cylinder(h=2*h,r=r-d);

        rotate(a=90, v=[1,0,0]) translate([+r,-h,-h]) 
            scale([1,top_cut_h/(r-d)]) cylinder(h=2*h,r=r-d);

        translate([0,0,h]) cube(2*[top_r,top_r,top_d], center=true);
        translate([0,0,d-h-r]) cube(4*[top_r,top_r,top_d/2], center=true);
    }
}

module pen_bottom()
{
    difference()
    {   union()
        {   _hold_sphere(1);
            translate([0,0,2*top_r]) _hold_sphere(1);
            cube([2*plate_w,3*top_d,5*top_r], center=true);
        }
        translate([0,0,3*top_r]) 
        {   cube([4*plate_w,top_d,8.5*top_r], center=true);
            rotate([0,90]) cylinder(r = 1.2*top_r, h=4*plate_w, center=true);
        }
    }
}


translate([0,100]) pen_bottom();

module pen_case()
{
    difference()
    { 
        union()
        {   cylinder(r= pen_r, h=pen_h-pen_round_r);
            translate([0,0,pen_h-pen_round_r]) scale([1,1,pen_round_r/pen_r]) sphere(pen_r);
        }
        
        translate([0,0,pen_h-top_h-top_r]) cylinder(r= pen_r-plate_w, h=3*pen_h);

        translate([0,0,-pen_h]) cylinder(r= lead_r, h=3*pen_h);
        //The cuts in clicks into.
        translate([0,0,pen_h - top_h]) _hold_sphere(1.1);
        translate([0,0,pen_h - top_h/2]) _hold_sphere(1.1);

        translate([0,0,top_h]) _hold_sphere(1.1);
        translate([0,0,top_h/2]) _hold_sphere(1.1);
       
    }
}

module pen_assembly()
{
    pen_case();
    color([1,0,0]) translate([0,0,pen_h]) pen_top();
}

inf = 3*pen_h;
intersection() //Openscad went nuts on `difference`
{   translate([0,-inf]) cube(2*inf*[1,1,1]);
    pen_assembly();
}
