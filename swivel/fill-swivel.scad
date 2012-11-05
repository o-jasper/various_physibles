//
//  Copyright (C) 13-02-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

r = 10;
node_r = 2*r;

hinge_r = 2;
hinge_d = 3*hinge_r;

space_d = 1;

phi_limit = 45;
theta_limit = 45;

up_l = 120;
down_l = 40;

theta_h = 30;
theta_d = 6;

//theta_w = 2*(theta_h*tan(phi_limit) + space_d + theta_d);
theta_w = 2*max(hinge_d*tan(phi_limit) + 
                (r + theta_d + space_d)/cos(phi_limit) +
                space_d,
              node_r + space_d + hinge_d);
max_l = max(up_l,down_l);

plate_w = 3.3;

bottom_r = 10;

theta_reinforce_d = 0;
phi_reinforce_d = r/2;

module swivel_theta_mount_1(){}
module swivel_theta_mount_2(){ sphere(4); }

module swivel_phi()
{ difference()
    { union()
        { cylinder(h=up_l , r=r);
          rotate(a=90,v=[1,0,0]) translate([0,0,-r])
              cylinder(h=2*r, r=node_r);
          translate([-plate_w/2,-r,-down_l]) cube([plate_w, 2*r,down_l]);
          translate([0,0,phi_reinforce_d-down_l]) union()
          { cylinder(h=down_l,r=phi_reinforce_d);
            sphere(phi_reinforce_d);
          }
        }
      rotate(a=90,v=[1,0,0]) translate([0,0,-2*r]) cylinder(h=4*r, r=hinge_r);
    }
}

module swivel_center_cutter()
{ cylinder(h=up_l+space_d, r= r+space_d);
  translate([-plate_w/2-space_d,-r-space_d,-down_l]) 
      cube([plate_w+2*space_d, 2*(r+space_d),down_l+2*space_d]);
  translate([0,0,-down_l]) cylinder(r=phi_reinforce_d, h=down_l);
}

module swivel_center_cut()
{
  rotate(a=90,v=[1,0,0]) translate([0,0,-r-space_d]) 
      linear_extrude(height = 2*(r+space_d)) union()
  { intersection()
      { polygon([[space_d,0], 
                 [space_d+2*up_l*sin(phi_limit), 2*up_l*cos(phi_limit)],
                 [0,2*up_l],
                 [-space_d-2*up_l*sin(phi_limit), 2*up_l*cos(phi_limit)], 
                 [-space_d,0]]);
        circle(sqrt(pow(up_l,2)+pow(plate_w/2,2))+space_d);
      }
    intersection()
    { polygon([[space_d,0], 
               [space_d+2*down_l*sin(phi_limit), -2*down_l*cos(phi_limit)],
               [0,-2*down_l],
               [-space_d-2*down_l*sin(phi_limit), -2*down_l*cos(phi_limit)], 
               [-space_d,0]]);
      circle(sqrt(pow(down_l,2)+pow(plate_w/2,2))+space_d);
    }
  }
  translate([space_d,0]) rotate(a= phi_limit,v=[0,1,0]) 
      swivel_center_cutter();
  translate([space_d,0]) rotate(a=-phi_limit,v=[0,1,0]) 
        swivel_center_cutter();

  translate([-space_d,0]) rotate(a= phi_limit,v=[0,1,0]) 
      swivel_center_cutter();
  translate([-space_d,0]) rotate(a=-phi_limit,v=[0,1,0]) 
      swivel_center_cutter();
  
  rotate(a=90,v=[1,0,0]) translate([0,0,-r-space_d]) 
      cylinder(h=2*(r+space_d), r= r+space_d);
}

module swivel_theta_base_sub()
{ /*union()
    { rotate(a=90,v=[1,0,0]) translate([0,0,-theta_w]) 
            linear_extrude(height = 2*theta_w) union()
        { polygon([[0,0], [theta_w*tan(phi_limit),theta_w],
        [-theta_w*tan(phi_limit),theta_w]]); } */
        
    rotate(a=90,v=[1,0,0]) rotate(a=-90,v=[0,1,0]) 
        translate([0,0,-theta_w]) 
        linear_extrude(height = 2*theta_w) union()
    { polygon([[0,0], [theta_w*tan(theta_limit),theta_w],
               [-theta_w*tan(theta_limit),theta_w]]); }
}

module swivel_theta_base()
{
    difference()
    { sphere(theta_w/2);
      
      difference()
      { union()
          { swivel_theta_base_sub();
              //rotate(a=180, v=[1,0,0]) swivel_theta_base_sub();
          }
        translate([-theta_w,-theta_w,-hinge_d])
            cube([2*theta_w,2*theta_w,2*hinge_d]);
      }
    }
}

module theta_tube_reinforcement()
{
    translate([0,r+plate_w+space_d]) union()
    { sphere(theta_reinforce_d);
      translate([0, 0,-down_l+theta_reinforce_d]) union() 
      { cylinder(r= theta_reinforce_d, h= down_l - theta_reinforce_d);
        sphere(theta_reinforce_d);
      }
    }
}

module theta_reinforcement()
{ } //theta_tube_reinforcement(); }

module swivel_theta()
{ difference()
    { union()
        { swivel_theta_base();
          
//          rotate(a=-90,v=[1,0,0]) 
//              cylinder(r=hinge_d, h= r+plate_w+space_d+theta_reinforce_d);
          theta_reinforcement();
            
/*          rotate(a=90,v=[1,0,0]) translate([0,0,-r-plate_w-space_d]) 
              linear_extrude(height = 2*(r+plate_w+space_d)) union()
          { polygon([[r+hinge_d+space_d,0], [-r-hinge_d-space_d,0],
                     [-bottom_r, bottom_r-down_l,], 
                     [bottom_r,  bottom_r-down_l]]);
            translate([0,bottom_r-down_l]) circle(bottom_r);
            } */
        }
      translate([-node_r-space_d, -r-space_d]) 
          cube([2*node_r, 2*(r+space_d), node_r+2*space_d]);
      translate([0,r+space_d])
          rotate(a=90,v=[1,0,0]) cylinder(h=2*(r+space_d), r=node_r+space_d);
      
      swivel_center_cut();
      rotate(a=90,v=[1,0,0]) translate([0,0,-2*theta_w]) 
          cylinder(h=4*theta_w, r=hinge_r);
      rotate(a=90,v=[0,1,0]) translate([0,0,-2*theta_w]) 
          cylinder(h=4*theta_w, r=hinge_r);
    }
}

holder_h = 2*hinge_d;
holder_rp = 2*hinge_d;

module swivel_holder()
{ translate([0,0,-holder_h/2]) difference()
    { cylinder(r= theta_w/2+holder_rp, h= holder_h);
      translate([0,0,-hinge_d]) cylinder(r= theta_w/2, 
                                         h= holder_h+2*hinge_d);
      translate([0,0,holder_h/2])
          rotate(a=90,v=[0,1,0]) translate([0,0,-2*theta_w]) 
          cylinder(h=4*theta_w, r=hinge_r);
    }
}
//swivel_center_cut();

theta = 45*sin(360*$t);
phi = 45*cos(360*$t+44);

rotate(v=[1,0,0], a=theta) rotate(v=[0,1,0], a=phi) color([0,0,1]) 
  swivel_phi();
rotate(v=[1,0,0], a=theta) swivel_theta();
swivel_holder();
