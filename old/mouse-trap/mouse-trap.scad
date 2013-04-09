//
//  Copyright (C) 05-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

module meh(r,w,h)
{ intersection()
    {
        cube([w,w,h]);
        translate([w/2,w/2]) cylinder(r=r,h=h);
    }
}

w = 50;
Rf = 1.7;
R = w/Rf;
h = 80;

plate_w = 4;

drop = w/3;
hinge_y = h/2;

module body()
{ wi = w-2*plate_w;
  Ri = wi/Rf;
  difference()
  { meh(R,w,h);
    translate([plate_w,plate_w,-h]) meh(Ri,wi,3*h);
    /*  translate([plate_w,plate_w,-h]) intersection()
      { meh(Ri,wi,3*h);
          union()
          { cube([w,w,h+hinge_y]);
            cube([w,w-drop,3*h]);
//            translate([0,w-drop-plate_w,h+hinge_y])
//                  rotate(v=[0,1,0], a=90) cylinder(r=drop-plate_w, h=w);
          }
          }*/
  }
}
//rotate(v=[1,0,0],a=90) body();

rotate(v=[1,0,0],a=90)
difference() 
{ body();
  translate([-w,w-drop,-h+drop]) 
  difference()
  { cube([3*w,3*w,h+hinge_y]);
    translate([0,0,h+hinge_y]) 
        rotate(a=90,v=[0,1,0]) 
        cylinder(r=drop, h=3*w);
  }
}
