//
//  Copyright (C) 16-03-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Stuff connecting plates, and  holding steppers, and rods.
//All the corners excepting two that hold pulleys aswel are the same.

include<params.scad>
//include<fits/nema17.scad>

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

module base_corner(reinforce=false,plate=true)
{
    r=pt/2+t;
    d=hl-r;
    f=0.2;
    phw=d/4;
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
        if(plate) for(a=[0,-90]) rotate(a) scale([a<0 ? -1 : 1,1,1]) 
           linear_extrude(height=t) difference()
        {   hull()
            {   circle(r);
                translate([phw,0]) circle(r);
                translate([0,hl-r]) circle(r);
                translate([phw,hl-r]) circle(r);
            }
            for(x=(phw-pt)*[1,3]/4) for(y=(phw-pt-t)*[0,1]) 
               translate([pt+t+x,hl-r-y]) circle(sr);
        }
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

module around_nema2d(sub=0)
{
    da = zrd+sw/2+t-sub; //zrd+bbr+2*sr+3*t-sub;
    db= da+t;//hl+t-sub;
    hull()
    {   square([db,t]);
        square([t,db]);
        translate([da,da]) circle(t);
    }
}

module rod_mounting_hole_pos() //Positions the blocks holding the sliders.
{    translate([zrd,zrd,-bt]) for(a=[0:60:120]) rotate(-60+a) 
          translate((a==60 ? sw/2-2*(t+sr) : bbr+2*t)*[1,1]) child();
}

module corner()
{
    difference()
    {   union()
        {   base_corner();
            translate([0,0,-bt]) linear_extrude(height=bt+3*t) around_nema2d();
        }
        translate((pt+t/2)*[1,1]) difference()
        {   cube([sw,sw,2*sh]);
            translate([0,0,sh+t]) rotate(45) cube(2*[sqrt(2)*ssd+sr+t,sw,t],center=true);
        }
        translate([pt+t/2+ssd,pt+t/2+ssd,bt+t]) cylinder(r=sr,h=sw);
        base_corner_sub();
        rod_mounting_hole_pos() translate([0,0,-t]) cylinder(r=sr+t/2,h=8*t);
        translate([zrd,zrd,-bt-t]) cylinder(r=bbr+t,h=8*t);
    }
}

module x_rod_add()
{   translate([zrd,zrd]) hull()
    {   translate([-3*t,0,xrh]) 
            rotate([0,90,0]) cylinder(r=bbr+t,h=6*t); //x rod.
        cylinder(r=t,h=t);
    }
}
module x_rod_sub()
{   translate([pt+t,zrd,xrh]) rotate([0,90,0]) cylinder(r=bbr,h=hl); //x rod.
}

//That the block x-rod, z-rod go into.
module rod_block(a=0)
{
    translate([zrd,zrd]) rotate(a) translate([-zrd,-zrd]) difference()
    {   union()
        {   x_rod_add();
            translate([zrd,zrd]) cylinder(r=bbr+t,h=xrh+2*(bbr+t));
            linear_extrude(height=2.5*t) difference()
            {   hull() 
                {   rod_mounting_hole_pos() circle(sr+t);
                    translate([zrd,zrd]) circle(bbr+t);
                }
            }
        }
        x_rod_sub();
        translate([zrd,zrd,-fh]) cylinder(r=bbr,h=8*fh);
        rod_mounting_hole_pos() translate([0,0,-t]) cylinder(r=sr,h=8*t);
    }
}

module pulley_head_base()
{
    d = hl/2-zrd/2-pr-t;
    difference() 
    {   union()
        {   
            hull() pulley_pos() //Top bit.
                translate([-2*t,-pr]) rotate([0,90,0]) linear_extrude(height=4*t)
                intersection()
            { scale([1.2,1]) circle(sr+t); square((sr+t)*[2,2],center=true); }
            for(s= [1,0,-1]) rotate(45) hull()
            {               
                translate([(hl-zrd)/sqrt(2)-2*t,-0.8*d*s,-2*t]) 
                    cylinder(r=t,h=4*t);
                rotate(-s*45) translate([bbr,0,-2*t]) cylinder(r=t,h=xrh+t);
            }
            //Main thing around.
            translate([0,0,-2*t]) cylinder(r=bbr+t,h=xrh+t);
            //Clamping thing.
            rotate(-45) translate([0,bbr-t/4,xrh/2-1.5*t]) 
                cube([4*bbr+5*t,3*t,xrh+t],center=true);
        }
        //Screw holes for clamping.
        for(z=[0:4*t:xrh-2*t]) for(x=(2*bbr+t)*[1,-1])
            rotate(-45) translate([x,2*bbr,z])
                rotate([90,0,0]) cylinder(r=sr,h=8*t);
        pulley_head_screw_holes();
        pulley_pos() union() //Hole for pulley.
        {   translate([-t,-pr]) rotate([0,90,0]) cylinder(r=pr+t/4,h=2*t);
            translate([-4*t,-pr]) rotate([0,90,0]) cylinder(r=sr,h=8*t);
        }
        translate([0,0,-phz]) cylinder(r=bbr,h=8*phz);
    }
}

module pulley_head()
{   difference()
    {   pulley_head_base(); 
        rotate(45) translate([-phz,0]) cube(2*[phz+bbr-t/4,8*phz,8*phz],center=true);
    }
}
module pulley_clamp()
{   intersection()
    {   pulley_head_base(); 
        rotate(45) translate([-phz,0]) cube(2*[phz+bbr-t/4,8*phz,8*phz],center=true);
    }    
}

module top_bare_corner(){ corner(); }
module top_motor_corner()
{   corner(); }

module bottom_bare_corner(){ corner(); }
module bottom_motor_corner(){ corner(); }

module top_motor_corner_show()
{
    top_motor_corner();
    color("blue") translate([0,0,bt]) rod_block(a=90);
    translate([zrd,zrd,phz]) 
        rotate(-90) rotate([0,180,0]) 
    {   color("purple") pulley_head();
        color("green") translate([0.1,-0.1,0.1]) pulley_clamp();
    }
}

//TODO feh make space for belt path..
module corner_show(place_block=true)
{
    d=hl+pt+t;
    
    corner();
    translate([zrd,zrd,sh]) 
    {   translate([0,0,sh/2]) color("green") cylinder(r=bbr,h=4*sh);
    }

    translate([0,d]) top_bare_corner();
    if(place_block) color("blue") translate([0,d]) rod_block();
    translate([d,d]) top_motor_corner_show();

    if(place_block) color("blue") translate([d,d]) rod_block();
    translate([d+zrd,d+zrd,-bt-t/2-10]) color("purple") cylinder(r=20,h=10); 
    translate([d,0]) rod_block();

}

$show=true;
corner_show();

