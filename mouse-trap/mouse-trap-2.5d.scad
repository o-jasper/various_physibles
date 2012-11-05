//
//  Copyright (C) 05-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

// TODO main concern with this is that the trap hinge cant get out of the
// way..(put it below
// TODO sliding top.

plate_w = 2; //Plate width.
d = plate_w/2; //Take space for stuff.
hinge_d = 2*plate_w; //wall round hinge.
hinge_r = 0.5*plate_w;

//_Door_ height (see totals.)
h = 50; 
w = h;
l=2*w;

//width of the door.
side_w = max(2*hinge_d, 3*plate_w);

//Size of pull pins
pull_pin_l = 20;
pull_pin_r = 2;
//Pad positions.
pad_fy = 1.5*side_w + 2*pull_pin_l/3;
pad_ry = pad_fy + 2*pull_pin_l/3+plate_w/2;
pad_y = 4*l/5;

pad_z = plate_w+ 2*pull_pin_r + pull_pin_l/3;

pad_ly = max((pad_y + pad_ry)/2, pay_ry + 5*plate_w);

//Guide slot for pad sliding back.
side_slot_l = 6*plate_w;

total_h = h + 2*(plate_w+2);

door_s = side_w/2;

module door()
{  linear_extrude(height=plate_w)
    {   square([w-2*plate_w, h-2*door_s]); }
}

module _door_side(h,s)
{ translate([s,s])
  { square([h-2*s,h-s]);
    square([h-s,h-2*s]);
    translate([h-2*s,h-2*s]) circle(s);
    translate([h-2*s,0]) circle(s);
    translate([0,h-2*s]) circle(s);
  }
}

module door_left_side()
{ hs = h-side_w/2;
  translate([-hs,-hs]) linear_extrude(height=plate_w) difference()
  {   union()
      { _door_side(h,side_w/2);
        translate([0,h])
            polygon([[0,-side_w/2],[side_w,0],
                     [side_w/2,side_w/2],[0,side_w/2]]);
      }
      translate(-[side_w,side_w]) _door_side(h,side_w/2);
      translate([h-side_w/2,h-side_w/2]) circle(hinge_r);
  }
}

module rounded_pin2d(r,l)
{ translate([r,r]) circle(r);
  translate([r,l-r]) circle(r);
  translate([0,r]) square([2*r,l-2*r]);
}

module door_right_side()
{ linear_extrude(height=plate_w) translate(-[side_w/2,h-side_w/2]) 
      difference()
  { rounded_pin2d(side_w/2,h);
    translate([side_w/2,h-side_w/2]) circle(hinge_r);
  }
}

module pull_pin()
{ linear_extrude(height=plate_w) union()
    { rounded_pin2d(pull_pin_r, pull_pin_l); }
}

module pad()
{
    l = pad_y-w/2 - 2*side_w;
    linear_extrude(height=plate_w) 
    {
        translate([0,pad_fy]) square([plate_w, pad_ly - pad_fy + side_w]);
        translate([-plate_w, pad_ry-plate_w/2]) square([3*plate_w,plate_w]);
        polygon([[0,pad_ly], [0,pad_ly+side_w], 
                 [w/2, pad_y+side_w/2],[w/2, pad_y-side_w/2]]);
    }
}

module right_side()
{ linear_extrude(height=plate_w) { square([total_h,l]); } }

module left_side2d()
{
    slot_l = side_slot_l;
    { difference()
        { square([total_h,l]);
          translate([pad_z + 2*plate_w, pad_ry])
          { circle(plate_w);
            translate([-plate_w/sqrt(2), plate_w/sqrt(2)])
                rotate(a=-45) square([2*plate_w,slot_l]);
            translate([slot_l/sqrt(2), slot_l/sqrt(2)]) circle(plate_w);
          }
        }
    }
}
module left_side()
{ linear_extrude(height=plate_w) left_side2d(); }

module left_inner()
{
    ty = pad_ry+ hinge_d;
    slot_l = side_slot_l;
    r = hinge_d+plate_w;
    linear_extrude(height=plate_w) intersection()
    { left_side2d();
        union()
        { translate([0,2*plate_w]) square([pad_z, ty-2*plate_w]);
          translate([pad_z + 2*plate_w, pad_ry])
          { circle(r);
              translate([slot_l/sqrt(2), slot_l/sqrt(2)]) circle(r);
              polygon([[-r,-2*r],[r/sqrt(2),-r/sqrt(2)], 
                       [(slot_l+r)/sqrt(2), (slot_l-r)/sqrt(2)],
                       [slot_l/sqrt(2), slot_l/sqrt(2)+r],
                       [-pad_z-2*plate_w,ty- pad_ry]]);
          }
        }
    }
}
module left_inside()
{ y = 1.5*side_w + pull_pin_l; 
  linear_extrude(height=plate_w) 
    { difference()
        { union()
            { square([plate_w+2*pull_pin_r,l-plate_w]);
              translate([0,y]) square([plate_w+4*pull_pin_r, l-y-plate_w]);
            }
          translate([h-hinge_d,hinge_d]) 
              circle(sqrt(pow(h-side_w,2) + pow(side_w,2))+plate_w);
        } 
    }
}

module left_module()
{
    translate([0,0,-plate_w]) rotate(a=-90, v=[0,1,0]) 
    { left_side(); 
      color([0,1,0]) translate([0,0,-plate_w]) left_inside();
      color([1,1,0]) translate([0,0,-2*plate_w]) left_inner();
    }
}

module back()
{ cube([w,plate_w,h]); }
module bottom()
{ translate([plate_w,0,-plate_w]) difference()
    { cube([w-plate_w,l-plate_w,plate_w]); 
      translate([0,-plate_w,-plate_w]) 
          cube([plate_w,pad_ry+plate_w,3*plate_w]); 
    }
}

translate([0,l-plate_w,-plate_w]) back();
//translate([plate_w,0,-2*plate_w]) 
color([0,0,1]) bottom();

module door_module()
{
    color([1,0,0])
    { rotate(a=-90, v=[0,1,0]) 
        { door_left_side();
          translate([0,0,plate_w-w]) door_right_side();
        }
        color([1,0.5,0]) translate([0,side_w/2-h+door_s,plate_w]) door();
    }
}
translate([plate_w,hinge_d, h-d]) rotate(a=90*$t, v=[1,0,0]) door_module();
sphere(3);

rotate(a=90, v=[0,1,0]) translate([-4*pull_pin_r,1.5*side_w])
  pull_pin();

translate([0,0, pad_z]) pad();

translate([w+plate_w,0,-plate_w]) rotate(a=-90, v=[0,1,0]) right_side();

left_module();
