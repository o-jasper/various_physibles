//
//  Copyright (C) 08-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<../lib/rounded_box.scad>
include<../expanding_base/expanding_base.scad>

plate_w = 5;

holder_l = 70; //Also width of sheet.
holder_h = 40;
sheet_w = 1;

room_w = 20;
room_l = 80;

holder_w = room_w+2*(sheet_w + plate_w);

solder_hold_w = 0.75*holder_w; //Radius at the point at which it is held.
solder_hold_l = 20;

holding_bar_r = 2;

front_bottom_r = sqrt(3)*plate_w-sheet_w;

holder_angle = 45;

holder_base_h = plate_w;
holder_base_l = 6*holder_l/7;
holder_base_r = 2*plate_w;

holder_bin_h = holder_base_l/4;

//Optional stuff
expanding_base_p = true;

screwable_p = true;
screw_w = 20;
screw_r = 3;

holder_bar_p = false;

//Some calculated totals.
tot_holder_l = room_l + 4*plate_w;
tot_holder_h = holder_h + 3*room_w/2 +plate_w;
tot_l = tot_holder_l*cos(holder_angle) + tot_holder_h*sin(holder_angle);

pi = 3.14; //Huh no pi?
echo("length plate est ", holder_h+room_w+ pi*(solder_hold_w/2-plate_w));

module holder_bar_extract()
{
    w = holder_w;
    b = solder_hold_w/3;
    l = solder_hold_l;
    r = holding_bar_r;
    //Horizontal holding bars.
    translate([-b,-b/2,-w])cylinder(r=r, h=3*w);
    translate([-b, b/2,-w])cylinder(r=r, h=3*w);
    translate([b, -b/2,-w])cylinder(r=r, h=3*w);
    translate([b,  b/2,-w])cylinder(r=r, h=3*w);
    //Vertical holding bars.
    rotate(a=90, v=[0,1,0])
    {   translate([-b,-b,-w])cylinder(r=r, h=3*w);
        translate([-b, 0,  -w])cylinder(r=r, h=3*w);
        translate([-b, b,-w])cylinder(r=r, h=3*w);
        translate([b, -b,-w])cylinder(r=r, h=3*w);
        translate([b,  0,  -w])cylinder(r=r, h=3*w);
        translate([b,  b,-w])cylinder(r=r, h=3*w);
    }
}

module solder_holder()
{ w = holder_w - 4*plate_w;
  l = solder_hold_l;
  f = 3;
  difference()
    { intersection()
        { translate([0,l/2]) scale([1,f]) sphere(w/2 + 2*plate_w);
          translate([-2*w,-l/2,-2*w]) cube([4*w,l,4*w]);
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
    w = holder_w;
    l = room_l+2*d;
    h = holder_h+room_w;

    translate([0,-room_l-4*plate_w]) difference()
    {   union()
        { gravestone(l, w,h);
          translate([0,l]) gravestone(2*d, w,h);
          translate([holder_w/2,-solder_hold_l/2,holder_h + room_w]) 
              solder_holder();
        }
        if( holder_bar_p )
        { translate([holder_w/2,-solder_hold_l/2,holder_h + room_w]) 
                holder_bar_extract();
        }
        translate([holder_w/2, -2*holder_l, holder_h + room_w]) 
            rotate(a=-90, v=[1,0,0]) 
            cylinder(r=solder_hold_w/2-d, h=3*holder_l + l);
        translate([-w,2*d,holder_h]) cube([3*w,room_l,2*room_w]);

        translate([d,2*d,holder_h-room_w*f_room])
            cube([w-2*d,room_l, room_w]);
        translate([d,d,d]) difference()
        { gravestone(l, w-2*d, h-d);
          translate([s,-l]) gravestone(3*l, w-2*(d+s), h-d-s);
        }
        translate([-w,front_bottom_r,front_bottom_r])
            rotate(a=-180, v=[1,0,0]) rcut(front_bottom_r,3*w);
    }

    translate([0,-room_l-4*plate_w])
        translate([d+s+room_w/2,d,holder_h-f_room*room_w]) 
        rotate(a=-90, v=[1,0,0]) 
        scale([1,f_room]) cylinder(r=room_w/2, h=l+d);
}


module screw_pad(w, li,hi, lo,ho,r)
{
    f = 2*(hi-ho)/(lo-li);
    difference()
    {   translate([0,w/2]) union()
        { cube([w,lo-w, hi]);
          translate([w/2,0]) cylinder(r=w/2,h=hi);
          translate([w/2,lo-w]) cylinder(r=w/2,h=hi);
        }
        translate([-w,0,hi]) rotate(a=90, v=[0,1,0]) 
            scale([f,1]) cylinder(r=(lo-li)/2, h=3*w);
        translate([-w,lo,hi]) rotate(a=90, v=[0,1,0]) 
            scale([f,1]) cylinder(r=(lo-li)/2, h=3*w);
        translate([w/2,w/2,-ho])
        { cylinder(r=r, h=3*hi);
          translate([0,0,2*ho]) cylinder(r=2*w/7, h=ho);
          translate([0,lo-w]) cylinder(r=r, h=3*hi);
          translate([0,lo-w,2*ho]) cylinder(r=2*w/7, h=3*hi);
        }
        translate([-w,(lo-li)/2,-hi]) cube([3*w,li,3*hi]);
    }   
    
}
module holder_screw_pad()
{ translate([holder_w+screw_w,0]) rotate(a=90) 
        screw_pad(screw_w, holder_w-plate_w,holder_base_h+holder_bin_h, 
                  holder_w+2*screw_w, holder_base_h, screw_r);
}

module holder_base()
{  l = tot_holder_l;
   h = tot_holder_h;

   w  = holder_w;
   a = holder_angle;
   
   hole_r = holder_w/2-plate_w;

   holder_base_lh = holder_base_l*max(tan(a),1/tan(a));

   y = l*cos(a);
   hby = min(holder_base_l,y) - holder_base_r;
   difference()
   {   union()
       { difference()
           {   translate([0,-y]) 
                   rounded_cube(w,tot_l,holder_base_lh, holder_base_r);
           
               rotate(a=90, v=[1,0,0]) 
                   translate([holder_w/2, holder_base_h + hole_r, -l])
                   cylinder(r=hole_r, h=l+h);
               translate([-w,-holder_base_l,holder_base_h+holder_base_lh/2])
                   rotate(a=90, v=[0,1,0]) 
                   cylinder(r=holder_base_lh/2, h=3*w);
               translate([-w,holder_base_l,holder_base_h+holder_base_lh/2])
                   rotate(a=90, v=[0,1,0]) 
                   cylinder(r=holder_base_lh/2, h=3*w);
           }
           translate([0,-4*d]) cube([w, 8*d,8*d]);
           if(screwable_p)
           {   translate([0,holder_base_r-y]) holder_screw_pad();
               translate([0,h*sin(a)-holder_base_r-screw_w])
                   holder_screw_pad();
           }
       }
       translate([-w,0,plate_w])
           rotate(a=holder_angle, v=[1,0,0]) cube([3*w,l,h]);
   }
   d = plate_w/2;
   if( holder_bin_h>0 )
   { translate([0,-y]) difference() //Bin.
       {   rounded_cube(w,tot_l,holder_base_h+holder_bin_h, holder_base_r);
           translate([d,d,d])
               rounded_cube(w-2*d,tot_l-2*d,2*holder_bin_h, holder_base_r);
       }
   }
}

//Basically the most plain version.(May need extra support/weighing down.
module whole_holder()
{
    translate([0,0.1,plate_w-0.1])
        rotate(a=-holder_angle,v=[1,0,0]) holder_part();
    color([0,0,1]) holder_base();

    $w = holder_w; $l = tot_l; $h= 2*plate_w;
    $r = holder_base_r; $a=30;
    $hinge_y = 0.75*$l; $hinge_h = 2*plate_w;
    $hinge_r = 5;
    if( expanding_base_p )
    {    translate([0,-tot_holder_l*cos(holder_angle),-2*holder_base_h]) 
            expanding_base_module();
    }
}

whole_holder(); 




//holder_part();

//holder_base();
