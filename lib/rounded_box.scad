//
//  Copyright (C) 01-04-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

module sph_cyl(r,h, x,y)
{ sphere(r);
  cylinder(r=r,h= h-2*r);
  translate([0,0,h-2*r]) sphere(r);
  if(x > 0)
  { rotate(v=[0,1,0],a=90) cylinder(r=r,h=x);
    translate([0,0,h-2*r]) rotate(v=[0,1,0],a=90) cylinder(r=r,h=x);
  } else {
    rotate(v=[0,1,0],a=-90) cylinder(r=r,h=-x);
    translate([0,0,h-2*r]) rotate(v=[0,1,0],a=-90) cylinder(r=r,h=-x);
  }
  if(y > 0)
  { rotate(v=[1,0,0],a=90) cylinder(r=r,h=y);
    translate([0,0,h-2*r]) rotate(v=[1,0,0],a=90) cylinder(r=r,h=y);
  } else {
    rotate(v=[1,0,0],a=-90) cylinder(r=r,h=-y);
    translate([0,0,h-2*r]) rotate(v=[1,0,0],a=-90) cylinder(r=r,h=-y);
  }
}

module rounded_square(w,l,r)
{
    r = (2*r> w ? w/2 : r);
    translate([r,0]) square([w-2*r, l]);
    translate([0,r]) square([w, l-2*r]);
    
    translate([r,   r])   circle(r);
    translate([w-r, r])   circle(r);
    translate([r,   l-r]) circle(r);
    translate([w-r, l-r]) circle(r);
}


//If only minkowski was fast.
module rounded_cube(w,l,h,r)
{
    translate([r,r]) cube([w-2*r,l-2*r,h]);
    translate([0,r,r]) cube([w,l-2*r,h-2*r]);
    translate([r,0,r]) cube([w-2*r,l,h-2*r]);

    translate([r,r,r]) sph_cyl(r,h, w-2*r,0);
    translate([r,l-r,r]) sph_cyl(r,h, w-2*r,l-2*r);
    translate([w-r,r,r]) sph_cyl(r,h, 0,-l+2*r);
    translate([w-r,l-r,r]) sph_cyl(r,h, 0,0);
}

//rounded_box(40,40,80,10);

