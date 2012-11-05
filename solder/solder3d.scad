//
//  Copyright (C) 05-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

include<solder.scad>

module back3d()
{ color([1,0,0]) rotate(a=90, v=[0,0,1]) rotate(a=90,v=[1,0,0]) 
        back();
}

module whole()
{ translate([0,0,plate_w]) back3d();
  translate([0,w]) rotate(a=90, v=[1,0,0]) side();
  scale([1,-1]) rotate(a=90, v=[1,0,0]) side();
  color([0,0,1]) bottom();
  
  rotate(a=-90, v=[1,0,0]) union()
  { translate([plate_w/2,-h+s_h - plate_w/2]) cylinder(r=3,h=w-plate_w);
      // translate([w,-plate_w - plate_w]) cylinder(r=2,h=w-plate_w);
  }
}

whole();
