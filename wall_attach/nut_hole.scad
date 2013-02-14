//
//  Copyright (C) 15-2-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

module substract_hole(d,hole_r, head_r,head_d,head_dr,head_dz)
{   translate([0,0,-head_d])
    { cylinder(r= hole_r, h = 4*d);
      cylinder(r= head_r, h= head_d);
      cylinder(r1= head_r + head_dr*2*head_dz/head_dz, r2=head_r, 
               h= 2*head_dz);
    }
}

hole_r = 10;
head_r = 20; //Radius of screw(or whatever) head.
head_d = 5; //Depth of embedding.
head_dr = 5;
head_dz = 5;
substract_hole(100,hole_r, head_r,head_d,head_dr,head_dz);
