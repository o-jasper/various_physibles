//
//  Copyright (C) 13-02-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

//NOTE incomplete

plate_w = 3.3;
hinge_r = 3;
hinge_d = hinge_r + 5;

allow_phi = 45;

swivel_h = 100;
swivel_w = 4*plate_w;

swivel_y = max(0.3*swivel_h, hinge_d);

module swivel_phi_plate2d()
{ difference()
    { square([swivel_w,swivel_h]);
      translate([swivel_w/2, swivel_y]) circle(hinge_r);
    }
}

module swivel_phi_plate()
{ rotate(a=90,v=[1,0,0]) linear_extrude(height=plate_w) swivel_phi_plate2d();}
module swivel_phi_plate_side()
{ rotate(a=90,v=[1,0,0]) linear_extrude(height=plate_w)intersection()
    { swivel_phi_plate2d()
      union(){ square([swivel_w, swivel_y]);
               translate([swivel_w/2, swivel_y]) circle(swivel_w/2);
        }
    }
}

/*module swivel_theta()
{ square([3*plate_w, 
}*/
