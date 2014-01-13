//
//  Copyright (C) 15-2-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//down_d,up_d, how far down/up to substract.
//hole_r size of hole downward
//head_r size of hole upward
//head_d depth of hole.
/*
module substract_hole(down_d,up_d, hole_r,head_r,head_d, head_dr)
{   translate([0,0,-head_d])
    { cylinder(r= hole_r, h = down_d);
      cylinder(r1= head_r + head_dr*2*head_dz/head_dz, r2=head_r, 
               h= up_d);
      cylinder(r= head_r, h= up_d);
    }
}
*/
module plain_screw_hole(screw_r,recess_r, recess_d, low,high)
{
    translate([0,0,-recess_d])
    {   cylinder(h=high, r=recess_r);
        translate([0,0,-low]) cylinder(h=low+high, r=screw_r);
    }
}
