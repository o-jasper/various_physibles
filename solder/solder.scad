//
//  Copyright (C) 07-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<../lib/rounded_box.scad>

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

front_bottom_r = sqrt(3)*plate_w-sheet_w;

holder_angle = 45;

pi = 3.14;
echo("length plate est ", holder_h+room_w+ pi*(solder_hold_w/2-plate_w));

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
  f = 3;
  difference()
    { intersection()
        { translate([0,l/2]) scale([1,f]) sphere(w/2 + 2*plate_w);
          translate([-w,-l/2,-w]) cube([3*w,l,3*w]);
        }
//      translate([0,-l]) rotate(a=-90, v=[1,0,0]) //Other guy does it.
//          cylinder(r=w/2+plate_w, h=3*l);
      //Guiding cone. //TODO sloppy, where does the edge turn up?
      translate([0,-l/2-plate_w]) rotate(a=-90, v=[1,0,0]) union()
      { cylinder(r1=w/2+2*plate_w, r2=0, h=l);
          scale([-1,-1]) cylinder(r1=w/2+2*plate_w, r2=0, h=l);
      }
    }
}

module gravestone(d,w,h)
{   cube([w,d,h]);
    rotate(a=90, v=[1,0,0]) 
        translate([w/2,h,-d]) cylinder(r=w/2, h=d);
}

module rcut(r,h)
{ difference()
    { cube([h,2*r,2*r]);
      rotate(a=90,v=[0,1,0]) cylinder(r=r, h = h);
    }
}

module holder_part()
{
    d = plate_w;
    s = sheet_w;

    f_room = 1/2;
    w = solder_hold_w;
    l = room_l+2*d;
    h = holder_h+room_w;

    translate([0,-room_l-4*plate_w]) difference()
    {   union()
        { gravestone(l, w,h);
          translate([0,l]) gravestone(2*d, w,h);
          translate([holder_w/2,-solder_hold_l/2,holder_h + room_w]) 
              solder_holder();
        }
        translate([holder_w/2,-solder_hold_l/2,holder_h + room_w]) 
            holder_bar_extract();
        translate([holder_w/2, -2*holder_l, holder_h + room_w]) 
            rotate(a=-90, v=[1,0,0]) 
            cylinder(r=w/2-d, h=3*holder_l + l);
        translate([-w,2*d,holder_h]) cube([3*w,room_l,2*room_w]);

        translate([d,2*d,holder_h-room_w*f_room])
            cube([w-2*d,room_l, room_w]);
        translate([d,d,d]) difference()
        { gravestone(l, w-2*d, h-2*d);
          translate([s,-l]) gravestone(3*l, w-2*(d+s), h-2*d-s);
        }
        translate([-w,front_bottom_r,front_bottom_r])
            rotate(a=-180, v=[1,0,0]) rcut(front_bottom_r,3*w);
    }

    translate([0,-room_l-4*plate_w])
        translate([d+s+room_w/2,d,holder_h-f_room*room_w]) 
        rotate(a=-90, v=[1,0,0]) 
        scale([1,f_room]) cylinder(r=room_w/2, h=l+d);
}

holder_base_h = plate_w;
holder_base_l = 60;
holder_base_r = 2*plate_w;

holder_bin_h = holder_base_l/4;

module rounded_cube(w,l,h,r)
{   translate([r,0]) cube([w-2*r, l, h]);
    translate([0,r]) cube([w, l-2*r, h]);
    
    translate([r,r]) cylinder(r=r, h=h);
    translate([w-r,r]) cylinder(r=r, h=h);
    translate([r,l-r]) cylinder(r=r, h=h);
    translate([w-r,l-r]) cylinder(r=r, h=h);
}

module holder_base()
{  l = room_l+4*plate_w;
   h = room_w + holder_h + 5*plate_w;
   w  = holder_w;
   a = holder_angle;
   
   hole_r = holder_w/2-plate_w;

   holder_base_lh = holder_base_l*max(tan(a),1/tan(a));
   
   l_tot= l*cos(a) + h*sin(a);
   y = l*cos(a);
   difference()
   {
       union(){ difference()
       {   union()
           { translate([0,-y]) 
                   rounded_cube(w,l_tot,holder_base_h, holder_base_r);
             translate([0,-holder_base_l])
                 cube([w, 2*holder_base_l,holder_base_h + holder_base_lh]);
           }
           rotate(a=90, v=[1,0,0]) 
               translate([holder_w/2, holder_base_h + hole_r, -l])
               cylinder(r=hole_r, h=l+h);
           translate([-w,-holder_base_l,holder_base_h+holder_base_lh/2])
               rotate(a=90, v=[0,1,0]) cylinder(r=holder_base_lh/2, h=3*w);
           translate([-w,holder_base_l,holder_base_h+holder_base_lh/2])
               rotate(a=90, v=[0,1,0]) cylinder(r=holder_base_lh/2, h=3*w);
       }
       translate([0,-4*d]) cube([w, 8*d,8*d]);
       }
       translate([-w,0,plate_w])
           rotate(a=holder_angle, v=[1,0,0]) cube([3*w,l,h]);
   }
   d = plate_w/2;
   translate([0,-y]) difference() //Bin.
   {   rounded_cube(w,l_tot,holder_base_h+holder_bin_h, holder_base_r);
       translate([d,d,d])
           rounded_cube(w-2*d,l_tot-2*d,2*holder_bin_h, holder_base_r);
   }

}

//Basically the most plain version.(May need extra support/weighing down.
module whole_holder()
{
    translate([0,0,plate_w-0.1])
        rotate(a=-holder_angle,v=[1,0,0]) holder_part();
    color([0,0,1]) holder_base();
}

whole_holder(); 

//holder_part();

//holder_base();
