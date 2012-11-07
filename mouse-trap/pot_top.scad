//
//  Copyright (C) 05-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

plate_w = 4;
thread_d = 2;
thread_w = 5;

pot_r = 50/2;
top_w = 2*(pot_r + plate_w + thread_d);
Rf = 1.7;
top_R = top_w/Rf;
top_h  = 50;

hinge_d = 1.5*plate_w;
hinge_w = 1.5*hinge_d;

hinge_r = hinge_d/3;

space_d = plate_w/4;

module meh(r,w,h)
{ intersection()
    {   cube([w,w,h]);
        translate([w/2,w/2]) cylinder(r=r,h=h);
    }
}

module pot_top()
{ w = top_w;
  R = top_R;
  h = top_h;
  wi = w-2*plate_w;
  Ri = wi/Rf;
  difference()
  { union()
      { meh(R,w,h);
        translate([w/2,w/2,h]) 
            cylinder(r= pot_r + plate_w + thread_d, h=thread_w);
      }
    translate([plate_w,plate_w,-h]) meh(Ri,wi,2*h-thread_w);
    translate([w/2,w/2]) cylinder(r=pot_r, h=3*h);
        //TODO take out thread.
  }
}

module rcut(r,h)
{ difference()
    { cube([h,2*r,2*r]);
      rotate(a=90,v=[0,1,0]) cylinder(r=r, h = h);
    }
}

hinge_x = 4*plate_w;

module hinged_pot_hinge()
{ w = top_w;
  h = w-2*hinge_x;
  d = hinge_d;
  difference()
  { union()
      { cylinder(r=d,h=h);
        linear_extrude(height=h) 
            polygon([[0,-d], [0,d], [top_h/2,d], [top_h/2,d-plate_w]]);
      }
    translate([0,0,-top_h]) cylinder(r= hinge_r, h = 3*top_h);
    translate([-h,-h,hinge_w]) cube([3*h,3*h,h-2*hinge_w]);
  }  
}

module hinged_pot_top()
{ w = top_w;
  R = top_R;
  d= plate_w;
  difference()
  { pot_top();
//    translate([-w, w-4*d,-d]) cube([3*w, w,3*d]);
    
  }
  translate([w-2*hinge_x/2,w-hinge_d,-d]) rotate(v=[0,1,0], a=-90)
      hinged_pot_hinge();
}

rotate(v=[1,0,0],a=90) hinged_pot_top();

s=0.1;

module hinged_pot_lid()
{ w = top_w-plate_w;
    d = hinge_d;
    x = hinge_x-plate_w/2;
    translate([plate_w/2,0]) difference()
    { union()
        { translate([0,plate_w-w]) difference() 
            { meh(w/Rf, w, plate_w);
              translate([-w,w-d+plate_w/2,-plate_w]) 
                  cube([3*w, 2*d, 3*plate_w]);
            }
            translate([x-d,0]) 
                rotate(a=90, v=[0,1,0])
            { cylinder(r=plate_w, h=w-2*x+2*d);
              linear_extrude(height=w-2*x+2*d) 
                  polygon([[-plate_w,0], [plate_w,-plate_w]/sqrt(2),
                           [0,-2*plate_w]]);
            }
        }
        translate([x-s,0]) 
            rotate(a=90, v=[0,1,0]) cylinder(r=hinge_d+space_d, 
                                             h=hinge_w+2*s);
        translate([w-x-hinge_w+s,0]) 
            rotate(a=90, v=[0,1,0]) cylinder(r=hinge_d+space_d, 
                                             h=hinge_w+2*s);
        translate([plate_w/2+x-d-w,0]) 
            rotate(a=90, v=[0,1,0]) cylinder(r=hinge_r, h=4*w);
    }
}

module hinged_pot_axis()
{ w = top_w-plate_w;
  d = hinge_d;
  x = hinge_x-plate_w/2;
  translate([x-d+plate_w/2,0]) rotate(a=90,v=[0,1,0]) 
      cylinder(r=hinge_r, h=w-2*x+2*d); 
}

color([0,0,1]) translate([0,plate_w-s,top_w-hinge_d]) 
rotate(v=[1,0,0],a=90+90*$t) union()
{ hinged_pot_lid();
  color([1,0,0])hinged_pot_axis();
}

