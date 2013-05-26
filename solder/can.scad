
can_tx = 10; //Can taper.
can_ty = 10; //..

can_r = 33; //Radius of can.
can_h = 167; //Height of can.

module can() //Shape of a can.
{ translate([0,0,can_ty]) cylinder(r=can_r, h = 3*can_h);
  cylinder(r1=can_r-can_tx,r2=can_r, h=can_ty);
}
