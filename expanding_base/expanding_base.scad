//
//  Copyright (C) 08-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<../lib/rounded_box.scad>

module expanding_base()
{
    difference()
    { rounded_cube($w,$l,$h,$r);
      translate([$w/4,$w/4,-$h]) 
      { cylinder(r= $hinge_y-$w/4, h= $h+$hinge_h);
        cylinder(r= $w/16, h= 1.75*$h); //TODO add screw
      }
      translate([3*$w/4, $w/4,-$h])
      { cylinder(r= $hinge_y-$w/4, h= $h+$hinge_h);
        cylinder(r = $w/16, h= 1.75*$h); //TODO add screw.
      }
    }
}

module hinge()
{
    color([0,0,1]) difference()
    { translate([-$w/4,-$w/4]) rounded_cube($w/2,$hinge_y,$hinge_h, $r);
      translate([0,0,-$hinge_h/2])
      {
          cylinder(r= $w/8, h= $hinge_h);
          cylinder(r= $w/16, h= 2*$h);
      }
    }
}

module nut()
{  
    color([1,0,0])
    {   cylinder(r= $w/8, h= $hinge_h/2);
        translate([0,0,0]) cylinder(r= $w/16, h=$h);
    }
}

module expanding_base_module()
{ 
    s=0.01;
    translate([$w/4+s,$w/4+ s,s])
    { rotate(a= $a) hinge();
      nut();
    }
    translate([3*$w/4+ s,$w/4+ s,s])
    { rotate(a=-$a) hinge();
      nut();
    }
    expanding_base();
}
