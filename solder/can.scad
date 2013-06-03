
can_tx = 10; //Can taper.
can_ty = 10; //..

can_tty=15; //Top can taper height.


can_r = 33; //Radius of can.
can_h = 167; //Height of can.

module can() //Shape of a can.
{   union()
    {   translate([0,0,can_ty]) cylinder(r=can_r, h = can_h-can_ty-can_tty);
        cylinder(r1=can_r-can_tx,r2=can_r, h=can_ty);
        translate([0,0,can_h-can_tty]) cylinder(r1=can_r,r2=can_r-can_tx, h=can_tty);
    }
}
