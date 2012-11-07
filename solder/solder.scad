//
//  Copyright (C) 07-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

plate_w = 5;

holder_l = 70; //Also width of sheet.
holder_h = 40;
sheet_w = 2;

room_w = 40;
room_l = 80;

holder_w = room_w+2*(sheet_w + plate_w);

solder_hold_w = holder_w; //Radius at the point at which it is held.
solder_hold_l = 30;

holding_bar_r = 2;

//Block with two slits in which the sheets are clamped.
module sheet_holder()
{
    w = holder_w;
    h = holder_h;
    l = holder_l;
    difference() //TODO round the center.
    { cube([w,l,h]);
      translate([plate_w,-l,plate_w]) cube([sheet_w,3*l,h]);
      translate([w-plate_w-sheet_w,-l,plate_w]) cube([sheet_w,3*l,h]);
      //TODO pins that screw in and really clamp?
    }
}

module holder_bar_extract()
{
    w = solder_hold_w-4*plate_w;
    l = solder_hold_l;
    r = holding_bar_r;
    //Horizontal holding bars.
    translate([-w/2,-w/4,-w])cylinder(r=r, h=3*w);
    translate([-w/2, w/4,-w])cylinder(r=r, h=3*w);
    translate([w/2, -w/4,-w])cylinder(r=r, h=3*w);
    translate([w/2,  w/4,-w])cylinder(r=r, h=3*w);
    //Vertical holding bars.
    rotate(a=90, v=[0,1,0])
    {   translate([-w/2,-w/2,-w])cylinder(r=r, h=3*w);
        translate([-w/2, 0,  -w])cylinder(r=r, h=3*w);
        translate([-w/2, w/2,-w])cylinder(r=r, h=3*w);
        translate([w/2, -w/2,-w])cylinder(r=r, h=3*w);
        translate([w/2,  0,  -w])cylinder(r=r, h=3*w);
        translate([w/2,  w/2,-w])cylinder(r=r, h=3*w);
    }
}

module solder_holder()
{ w = solder_hold_w - 4*plate_w;
  l = solder_hold_l;
  f = 2;
  difference()
    { intersection()
        { scale([1,f]) sphere(w/2 + 2*plate_w);
          translate([-w,-l/2,-w]) cube([3*w,l,3*w]);
        }
      translate([0,-l]) rotate(a=-90, v=[1,0,0]) 
          cylinder(r=w/2+plate_w, h=3*l);
      //Guiding cone. //TODO sloppy, where does the edge turn up?
      translate([0,-l/2-plate_w]) rotate(a=-90, v=[1,0,0]) union()
      { cylinder(r1=w/2+2*plate_w, r2=0, h=l);
          scale([-1,-1]) cylinder(r1=w/2+2*plate_w, r2=0, h=l);
      }
      holder_bar_extract();
    }
}

module gravestone(d,w,h)
{   cube([w,d,h]);
    rotate(a=90, v=[1,0,0]) 
        translate([w/2,h,-d]) cylinder(r=w/2, h=d);
}

module sheet_flange()
{
    w = holder_w;
    h = holder_h + room_w;
    d = plate_w;
    translate([plate_w,-plate_w,plate_w])
    { difference()
        { translate([-d,-d,-d]) gravestone(2*d,w,h);
          gravestone(2*d, w-2*d,h-d);
        }
        translate([sheet_w,0]) gravestone(d, w-2*(d+sheet_w),h-d);
    }
}

module complete_holder()
{
    w = solder_hold_w;
    l = room_l;
    difference()
    {   union()
        { sheet_flange();
          translate([0,l-2*plate_w]) scale([1,-1]) sheet_flange();
          sheet_holder();
          translate([holder_w/2,-solder_hold_l/2,holder_h + room_w]) 
              solder_holder();
        }
        translate([holder_w/2, -2*holder_l ,holder_h + room_w]) 
            rotate(a=-90, v=[1,0,0]) 
            cylinder(r=w/2-plate_w, h=3*holder_l + l);
    }
}

complete_holder();
//solder_holder();
