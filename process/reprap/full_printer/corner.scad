//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Stuff connecting plates.

include<params.scad>
use<pulley.scad>

ut=2*t;

hh=fh-bt;
sr=2;

module planks_space()
{   linear_extrude(height=8*hh) //Space for planks.
    {   square([pt,8*hl]);
        square([8*hl,pt]);
    }
}

ch=bt+min(hl/4,sh);

module base_corner(reinforce=true)
{
    r=pt/2+t;
    d=hl-r;
    f=0.2;
    translate([pt/2,pt/2,-bt]) union()
    {   intersection() 
        {   union() for(pos=[[0,d],[d,0]]) hull()
            {   cylinder(r=r,h=bt);
                translate(-f*[r,r]) cylinder(r=(1-f)*r,h=bt); 
                translate([0,0,ch-r/2]) 
                {   sphere(r);
                    translate(-f*[r,r]) sphere((1-f)*r);
                }
                translate(pos) 
                {   cylinder(r=r,h=bt);
                    translate([0,0,h-r/2]) sphere(r);
                }
            }
            cube([8*hl,8*hl,2*ch],center=true);
        }
        for(pos=[[0,d],[d,0]]) translate(pos) intersection()
        {   scale([1,2]) cylinder(r=r,h=ch+r);
            cube(2*[r,r,8*ch],center=true);
        }
        if(reinforce) hull() for(a=[0,90]) rotate(a) translate([hl-r,0]) cylinder(r=r,h=bt+t);
    }
}

module base_corner_sub()
{
    r=pt/2+t;
    d2= hl-t;
    union()
    {   planks_space();
        difference()
        {   translate([d2,d2,ch-r/2]) 
                for(a=[[0,-90,0],[90,0,0]]) rotate(a) cylinder(r=sr,h=2*d2);
            translate((pt+2*t)*[1,1]) cube(hl*[8,8,8]);
        }
    }
}

module bottom_drill_sub()
{
    d=pt+t+sr;
    for(pos=[[d+t/2,hl-d,-t-bt],[hl-d,d+t/2,-t-bt]]) translate(pos) cylinder(r=sr,h=hl);
}

//TODO add feet, bottom plate ability.
module bottom_bare_corner() 
{
    difference()
    {   base_corner();
        base_corner_sub();
        bottom_drill_sub();
    }
}

module bottom_motor_corner(bottom_hole=false)
{
    difference()
    {   union()
        {   bottom_bare_corner();
            translate([0,0,-bt]) hull() //Rest of the plate under the motor.
            {   translate([pt+t/2+sw,pt+t/2+sw]) cylinder(r=t/2,h=bt+t);
                cube([pt+t/2+sw,pt+t/2+sw,bt+t]);
            }
        }
        translate((pt+t/2)*[1,1]) difference()
        {   cube([sw,sw,2*sh]);
            translate([0,0,sh+t]) rotate(45) cube(2*[sqrt(2)*ssd+sr+t,sw,t],center=true);
        }
        translate((pt+t/2+0.3*sw)*[1,1,0]+[0,0,0.3*t]) cube(2*[sw,sw,sh]);        
        translate([pt+t/2+ssd,pt+t/2+ssd,bt+t]) cylinder(r=sr,h=sw);
        if(bottom_hole) translate([zrd,zrd,-bt-t]) cylinder(r=sw/2-t,h=8*t);
    }
}

module x_rod_add()
{   translate([zrd,zrd]) hull()
    {   translate([-3*t,0,xrh]) 
            rotate([0,90,0]) cylinder(r=bbr+t/2,h=6*t); //x rod.
        cylinder(r=t,h=t);
    }
}
module x_rod_sub()
{
    translate([pt+t,zrd,xrh]) rotate([0,90,0]) cylinder(r=bbr,h=hl); //x rod.
}

//Top corners are all the same, a thingie is put on that allows it to be wiggled
//into the correct place.
//TODO .. two of them need pulleys.

module belt_corner_holes()
{    translate([zrd,zrd,-bt]) for(a=[0:90:270]) rotate(a) translate((bbr+2*t)*[1,1]) child();
}

//Block x-rod, z-rod and belt controller go into.
module belt_corner_block(a=0)
{
    translate([zrd,zrd]) rotate(a) translate([-zrd,-zrd]) difference()
    {   union()
        {   x_rod_add();
            translate([zrd,zrd]) cylinder(r=bbr+t,h=xrh+bbr+t);
            linear_extrude(height=t) difference()
            {   hull() belt_corner_holes() circle(sr+t);
                translate([zrd,zrd]) for(a=[0:90:270]) rotate(a) 
                    translate([bbr+2*t,0]) circle(t);
            }
        }
        x_rod_sub();
        translate([zrd,zrd,-fh]) cylinder(r=bbr,h=8*fh);
        belt_corner_holes() translate([0,0,-t]) cylinder(r=sr,h=8*t);
    }
}

module top_corner_floor2d(sub=0)
{
    da = zrd+bbr+2*sr+3*t-sub;
    db= da+t;//hl+t-sub;
    hull()
    {   square([db,t]);
        square([t,db]);
        translate([da,da]) circle(t);
    }
}

module top_corner_floor_n_wall()
{
    translate([0,0,-bt]) linear_extrude(height=bt) top_corner_floor2d();
    translate([0,0,-bt]) linear_extrude(height=bt+t) difference()
    {   top_corner_floor2d(); top_corner_floor2d(sub=t); }
}

module top_bare_corner()
{
    difference()
    {   union()
        {   base_corner(reinforce=false);
            top_corner_floor_n_wall();
        }
        base_corner_sub();
            
        belt_corner_holes() translate([0,0,-t]) cylinder(r=sr+t/2,h=8*t);
        translate([zrd,zrd,-bt-t]) cylinder(r=bbr+t,h=8*t);
    }
}

module pulley_holder()
{
    translate([zrd,zrd]) difference()
    {   union()
        {   hull() pulley_pos() translate([0,-pr]) //Top bit.
            {   translate([-2*t,0,phz]) rotate([0,90,0]) cylinder(r=sr+t,h=4*t);
            }
            //Pole it is on.
            rotate(45) translate([(hl-zrd)/sqrt(2),0,-bt])  intersection()
            {   union()
                {   linear_extrude(height=phz+bt) difference()
                    {   circle(3*t); scale([0.5,0.7]) circle(3*t); }
                    cylinder(r=3*t,h=2*t);
                }
                cube([4*t,8*t,8*phz],center=true);
            }
        }
        rotate(45) translate([(hl-zrd)/sqrt(2),4*hl,phz-pr])  //Hole for wire.
            rotate([90,0,0]) cylinder(r=0.7*t,h=8*hl,$fn=4);
        translate([0,0,phz]) pulley_pos() union() //Hole for pulley.
        {   translate([-t,-pr]) rotate([0,90,0]) cylinder(r=pr+t/4,h=2*t);
            translate([-4*t,-pr]) rotate([0,90,0]) cylinder(r=sr,h=8*t);
        }
    }
    if($show) color("purple") translate([zrd,zrd,phz]) pulley_pos() 
                  translate([-0.75*t,-pr]) rotate([0,90,0]) pulley();

}
module top_motor_corner(with_pulley=true)
{                
    difference()
    {   union()
        {   base_corner(reinforce=false);
            top_corner_floor_n_wall();
            if(with_pulley) pulley_holder();
        }
        base_corner_sub();
            
        belt_corner_holes() translate([0,0,-t]) cylinder(r=sr+t/2,h=8*t);
        translate([zrd,zrd,-bt-t]) cylinder(r=bbr+t,h=8*t);
    }
}

//TODO feh make space for belt path..
module corner_show(place_block=true)
{
    d=hl+pt+t;
    
    bottom_motor_corner();
//    color("gray") translate((pt+t/2)*[1,1]) cube([sw,sw,sh]);
    color("green") translate([zrd,zrd]) cylinder(r=bbr,h=4*sh);

    translate([d,0]) bottom_bare_corner();

    translate([0,d]) top_bare_corner();
    if(place_block) color("blue") translate([0,d]) belt_corner_block();
    translate([d,d]) top_motor_corner();
    if(place_block) color("blue") translate([d,d]) belt_corner_block();
    translate([d+zrd,d+zrd,-bt-t/2-10]) color("purple") cylinder(r=20,h=10); 
    translate([2*d,0]) belt_corner_block();
}

$show=true;
corner_show();

