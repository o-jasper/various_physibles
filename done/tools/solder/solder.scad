//
//  Copyright (C) 03-06-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<can.scad> //NOTE preview doesnt show can() well.

$fs=0.1;
//$fa=3;

sa = 40; //Angle of soldering iron.

//Bottom thickness.
bt= 14; 
//Radial thickness.
rt=3;
//Number of times round.
n= 6;
//Sizeof pips.
pr=7;
//Size of guides.
sr=1;

sol = 10;

pt=bt/2; //Plate thickness.

module can_substract()
{   union()
    {   can();
        cylinder(r=can_r-3*can_tx/4,h=can_r);
    }
}

module can_end(wire_end=false)
{
    intersection()
    {   union()
        {   cylinder(r=can_r+rt, h=bt); //Main shape.
            for(a=[0:360/n:360]) rotate(a) //Pips on the wires.
               translate([can_r,0,bt]) sphere(pr);
        }
        difference()
        {   translate([0,0,bt]) scale([1,1,2*bt/(can_r+rt)]) sphere(can_r+rt); //Round it.
            can_substract(); //Hole for can.
            for(a=[0:360/n:360]) rotate(a) union() //Holes for wires.
            {   for( y=sr*[-2,2] ) translate([can_r,y,bt-pr]) 
                {   cylinder(r=sr,h=bt);
                    sphere(sr);
                    rotate([0,140]) cylinder(r=sr,h=bt);
                }
                if( wire_end )//Place to put wire end.(NOTE hole too big
                {   translate([can_r+rt,0]) scale([4,2]) cylinder(r=sr, h=bt);
                    translate([can_r+rt,0,bt]) scale([4,2,2]) sphere(sr);
                }
            }
            
        }
    }
}

attachment_plate_rounded = false;
module attachment_plate()
{
    if( attachment_plate_rounded ) 
    {   translate([0,0,pt/2]) intersection()
        {   
            union() for( a = [-60,60] ) rotate(a) 
                {   rotate([-90,0]) scale([1,pt/sol]) cylinder(r=sol, h=can_r+rt+sol);
                    translate([0,can_r+rt+sol]) scale([1,1,pt/sol]) sphere(sol);
                }
            difference()
            {   cube([4*can_r,4*can_r,pt],center=true);
                can_substract(); //Hole for can.
                for( a = [-60,60] ) rotate(a) translate([0,can_r+rt+sol,-can_r]) 
                                        cylinder(r=sol/2,h=3*can_r);
            }
        }
    }
    else
    {   difference()
        {   linear_extrude(height=pt) union() for( a = [-60,60] ) rotate(a) difference()
            {   union()
                {   translate([-sol,0]) square([2*sol,can_r+rt+sol]);
                    translate([0,can_r+rt+sol]) circle(sol);
                }
                translate([0,can_r+rt+sol]) circle(sol/2);
            }
            can_substract(); //Hole for can.
        }
    }
}

module bottom_end()
{
    union()
    {   can_end();
        attachment_plate();
    }
}

//bottom_end();

sbh = 3; //Stang bottom height.

module stand_profile(s)
{
    R=sol+rt;
    bw= 2*(can_r+rt+sol)*sin(60)+2*R;
    bl= can_h*cos(sa)*0.35;
    union()
    {   translate([-bw/2+s,s]) square([bw-2*s,bl-2*s]);
        translate([R-bw/2+s,-R+s]) square([bw-2*R-2*s,bl-2*s]);
        translate([0,bl]) circle(bw/2-s);
        for(pos= [[R-bw/2,0], [bw/2-R,0]]) translate(pos) circle(R-s);
    }
}

//Optional holes in bottom to use screws to hold it down.(negative to disable.)
bottom_sr = -2;

module stand()
{
    R=sol+rt;
    bw= 2*(can_r+rt+sol)*sin(60)+2*R;
    bl= can_h*cos(sa)*0.35;
    union()
    {   translate([0,0,sol*cos(sa)])
            rotate([-sa,0,0]) translate([0,-(can_r+rt+sol)*cos(60)]) 
            for( a = [30,150] ) rotate(a) translate([can_r+rt+sol,0])
                                {   cylinder(r=sol/2, h= 2*pt);
                                    sphere(sol/2);
                                    translate([0,0,2*pt]) sphere(sol/2);
                                }
        intersection() //Beam up to can.
        {   rotate([0,90]) rotate_extrude() translate([bl+bw/2-sol/2,0]) 
                scale([1/2,2]) circle(sol);
            translate([-bw,0]) cube((bl+bw)*[4,4,4]);
            difference() 
            {   rotate([-sa,0]) translate([-bw,0]) cube((bl+bw)*[4,4,4]);
                translate([0,0,sol*cos(sa)]) rotate([-sa,0]) 
                    translate([0,-(can_r+rt+sol)*cos(60)]) 
                {   cylinder(r=can_r+sol,h=can_h); //Minus holding ring.
                    translate([0,0,can_h/2]) cube([sol,2*can_r+4*sol,can_h],center=true);
                    for(x=[-sol,-1.5*sol,sol,1.5*sol]) //Wire holes.
                        translate([x,can_r+sol+sr]) cylinder(r=sr,h=can_h);
                }
            }
        }
        difference()
        {   linear_extrude(height=1.5*sol) difference()
            {   stand_profile(0);
                if( bottom_sr>0 )
                {   for(x= (bw/2-2*R-2*bottom_sr)*[1,0,-1]) 
                        translate([x,0]) circle(bottom_sr);
                    for(x= bw*[1/4,-1/4]) translate([x,(bl+sqrt(bl*bl-x*x))])
                                            circle(bottom_sr);
                }
            }
            //Hollow for putting stuff in.
            translate([0,0,sbh]) linear_extrude(height=2*sol) difference() 
            {   stand_profile(rt);
                for(pos= [[R-bw/2,0], [bw/2-R,0]]) translate(pos) scale([1,2]) circle(R);
            }
            translate([0,0,sol*cos(sa)]) //Space for bottom_end
                rotate([-sa,0,0]) translate([0,-(can_r+rt+sol)*cos(60)]) 
                for( a = [30,150] ) rotate(a)  
                    linear_extrude(height=can_r)
                    {   translate([can_r+rt+sol,0]) circle(sol);
                        square(2*[can_r+rt+sol,sol], center=true);
                    }
        }
    }
}
module holding_ring()
{
    h=1.2*sol;
    difference()
    {   union()
        {   linear_extrude(height=h) difference()
            {   union()
                {   intersection()
                    {   circle(can_r+sol);
                        translate([0,can_r]) square([4*sol,2*can_r],center=true);
                    }
                    intersection() //Clamping bit.
                    {   circle(can_r+2*sol);
                        translate([0,2*can_r]) square([sol,4*can_r],center=true);
                    }
                }
                
            }
            linear_extrude(height=h-sol) intersection() //Tab underneath
            {   circle(can_r+2*sol);
                difference()
                {   translate([0,2*can_r]) square([4*sol,4*can_r],center=true);
                    for(x=[-sol,-1.5*sol,sol,1.5*sol]) //Wire holes.
                        translate([x,can_r+sol+sr]) circle(sr);
                }
            }
                
            intersection()
            {   cylinder(r=can_r+sol/2,h=h);
                translate([0,0,sol/2]) scale([1,1,1.5*h/(can_r+sol/2)]) sphere(can_r+sol/2);
            }
            translate([0,can_r-sol/2]) intersection()
            {   scale([2,1.2,6]) sphere(sol);
                translate([0,0,can_h]) cube(can_h*[2,2,2],center=true);
            }
        }
        translate([0,0,-can_r]) cylinder(r=can_r,h=3*can_r);
        translate([0,can_r]) cube([sol/2,2*can_r,4*can_r],center=true);
        for( a=[0:30:360] ) rotate(a) //All the holes for wires.
           translate([-4*can_r,can_r/3,h/2]) rotate([0,90,0]) cylinder(r=sr,h=8*can_r);
    }

}

can_t_ir = 24;
can_t_iir = can_t_ir-3;
can_t_h=4;
mid_hole_r=2*can_t_ir/3;
mid_hole_t=3;
module can_top()
{
    t = can_t_h/4;
    difference()
    {   union()
        {   difference()
            {   cylinder(r=can_t_ir, h=can_t_h);
                translate([0,0,can_t_h/2]) cylinder(r1=can_t_iir, r2=can_t_ir, h=can_t_h/2);
            }
            difference()
            {   union()
                {   cylinder(r1=mid_hole_r+mid_hole_t,r2= can_t_ir,h=3*can_t_h);
                    translate([0,0,3*can_t_h]) cylinder(r2=mid_hole_r+mid_hole_t,r1= can_t_ir,h=can_t_h);
                }
                translate([0,0,2*can_t_h]) cylinder(r1=mid_hole_r,r2=mid_hole_r+mid_hole_t/2, h=2*can_t_h);
            }
        }
        cylinder(r=mid_hole_r,h=10*can_t_h);
        cylinder(r1=mid_hole_r+2*t,r2=mid_hole_r,h=can_t_h/2);
    }
}

module as_assembled()
{
    stand();
    translate([0,0,sol*cos(sa)]) rotate([-sa,0]) translate([0,-(can_r+rt+sol)*cos(60)]) 
    {   color([0,0,1]) bottom_end();
        color([1,0,0]) can();
        translate([0,0,can_h+can_t_h]) color([0,0,1]) rotate([180,0]) can_top();
        color([0,0,1]) translate([0,0,can_h/2-sol/2]) holding_ring();
    }
}
//can_top();

as_assembled();

//stand();

//holding_ring();
