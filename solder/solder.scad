
plate_w = 10;
// Can-based soldering iron holder. 

solder_r = plate_w;

can_r = 30; //Radius of can.
can_h = 100; //Height of can.

can_inner_r = 25;
can_inner_h = plate_w/2;;

hole_f = 0.75;

can_a = 37;

duct_n = 2;
duct_r = plate_w/2;
duct_d = 4*duct_r;

min_w = -2;

cut_fx = -(can_r-plate_w)/2;
cut_x= 0;

module rounded_cylinder(r,h,d)
{ rotate_extrude(convexity = 10)
    { square([r-d,h]);
      translate([0,d]) square([r,h-2*d]);
      translate([r-d,d]) circle(d);
      translate([r-d,h-d]) circle(d);
    }
}

module duct()
{ translate([0,0,can_r/sin(can_a)])
        rotate(v=[0,1,0], a=can_a-90) scale([-1/sin(can_a),1]) 
        difference()
    {   rotate_extrude(convexity = 10)
          { translate([can_r,0]) circle(duct_r); }
    }
}

//duct();

module holder_part()
{
    sub_cone = cylinder(r1=0, r2= 4*hole_f*can_r, h=4*can_r);
    difference()
    {   rounded_cylinder(can_r+plate_w, can_h+2*plate_w, plate_w); //Body.
        translate([0,0,plate_w]) cylinder(r=can_r, h=3*can_h); //Can hole.
        rotate(v=[1,0,0], a=90) translate([0,plate_w+can_h/2]) //Side holes.
            scale([1,can_h/(2*can_r)]) 
        {   cylinder(r1=0, r2= 4*hole_f*can_r, h=4*can_r);
            scale([1,1,-1]) cylinder(r1=0, r2= 4*hole_f*can_r, h=4*can_r);
        }
        //air ducts
        difference()
        {   for(i=[1:duct_n])
            {   translate([0,0,duct_r+duct_d*(i-1)]) duct();
            }
            translate([0,-2*can_r]) cube(4*can_r*[1,1,can_h]);
        }
    }
}

module holder_front()
{
    difference()
    {   union()
        {   cylinder(r= can_r, h =plate_w);
            translate([0,0,-can_inner_h]) 
                cylinder(r= can_inner_r, h = can_inner_h + plate_w/2);
        }
        translate([0,0,-can_inner_h-plate_w])
            cylinder(r1= 2*can_inner_r*0.75, r2=0, h= can_inner_h +2*plate_w);
        cylinder(r=solder_r, h=8*plate_w);
    }
}

translate([0,0,2*can_h]) holder_front();

holder_part();
