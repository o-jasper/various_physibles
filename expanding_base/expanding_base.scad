
module rounded_cube(w,l,h,r)
{   translate([r,0]) cube([w-2*r, l, h]);
    translate([0,r]) cube([w, l-2*r, h]);
    
    translate([r,r]) cylinder(r=r, h=h);
    translate([w-r,r]) cylinder(r=r, h=h);
    translate([r,l-r]) cylinder(r=r, h=h);
    translate([w-r,l-r]) cylinder(r=r, h=h);
}

w = 40;
l = 80;
h = 20;
r =10;

hinge_y = 0.75*l;
hinge_h = 0.5*h;
hinge_r = 5;

s=0.1;

module expanding_base()
{
    difference()
    { rounded_cube(w,l,h,r);
      translate([w/4,w/4,-h]) 
      { cylinder(r=hinge_y-w/4, h=h+hinge_h);
        cylinder(r=w/16, h=1.75*h); //TODO add screw
      }
      translate([3*w/4,w/4,-h]) 
      { cylinder(r=hinge_y-w/4, h= h+hinge_h);
        cylinder(r=w/16, h=1.75*h); //TODO add screw.
      }
    }
}

module hinge()
{
    color([0,0,1]) difference()
    { translate([-w/4,-w/4]) rounded_cube(w/2,hinge_y,hinge_h, r);
      translate([0,0,-hinge_h/2]) {
          cylinder(r=w/8, h=hinge_h);
          cylinder(r=w/16, h=2*h);
      }
    }
}

module nut()
{  
    color([1,0,0]){
        cylinder(r=w/8, h=hinge_h/2);
        translate([0,0,0]) cylinder(r=w/16, h=h);
    }
}

a= 45*(1+sin(360*$t));

translate([w/4+s,w/4+s,s]) 
{ rotate(a=a) hinge();
  nut();
}
translate([3*w/4+s,w/4+s,s])
{ rotate(a=-a) hinge();
  translate([0,0,-h*(1+sin(360*$t))/2]) nut();
}

expanding_base();

