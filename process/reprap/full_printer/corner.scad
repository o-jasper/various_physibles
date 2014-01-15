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

ut=2*t;

hl=80;
hh=fh-bt;
sr=2;

module planks_space()
{   linear_extrude(height=8*hh) //Space for planks.
    {   square([pt,8*hl]);
        square([8*hl,pt]);
    }
}

module _corner(thicken_diag=t,thicken_diag_t=t)
{   translate([0,0,-bt]) difference()
    {   union()
        {   linear_extrude(height=bt+hh) minkowski()
            {   difference()
                {   square([hl-t,hl-t]);
                    translate([hl-t,hl-t]) circle(hl-pt-t,$fn=4);
                }
                circle(t);
            }
            linear_extrude(height=3*bt) minkowski()
            {   union(){ square([hl-ut,pt]); square([pt,hl-ut]); }
                circle(ut);
            }
        }
        difference() //Hollow it out.
        {   translate([pt+t,pt+t,bt]) cube([hl,hl,2*hh]);
            //Thicken diagonal.
            if(thicken_diag>0) translate([hl,hl]) 
                                   cylinder(r=hl-pt+thicken_diag_t,h=bt+thicken_diag, $fn=4);
        }
        //Drill holes.
        for( x= hl*[1,2]/3 ) translate([pt+x,pt+x,(hh+bt)/2]) 
                                 for(a=[[90,0,0],[0,-90,0]]) 
            rotate(a) cylinder(r=sr,h=8*hl);
    }
}

module corner(thicken_diag=t,bt=bt)
{   difference()
    {   _corner(thicken_diag=thicken_diag,bt=bt);
        planks_space();
    }    
}
//Corner with additional holder for z-rods.
module zrod_bcorner()
{
    difference()
    {   union()
        {   _corner();
            translate([zrd,zrd,-bt]) linear_extrude(height=fh) difference()
            {   circle(bbr+1.5*t); circle(bbr); }
            translate([adx,adx,ah/2-t]) rotate(45) 
                translate([0,2.5*(aw+t)]) rotate([90,0,0]) cylinder(r=aw+2*t,h=5*(aw+t));
        }
        //Space for arm.
        translate([adx,adx,ah/2-t]) rotate(45) 
        {   translate([0,1.5*aw+1.7*t])
                rotate([90,0,0]) linear_extrude(height=3*aw+3.4*t) hull()
            {   circle(aw+t);
                rotate(min_a) translate([fh,0]) circle(aw+2*t);
                translate([t,fh]) circle(aw);
            }
            //And hinge cylinder
            translate([0,2.6*(aw+t)]) rotate([90,0,0]) cylinder(r=ah/4,h=5.2*(aw+t));
        }
        planks_space();
        translate([0,0,-bt-4*fh]) cube([8,8,8]*fh,center=true);
    }
}

relpos=[[zrd+2*(bbr+sr),zrd+2*(bbr+sr)],[zrd-bbr,hl/2],[hl/2,zrd-bbr]];

module _holder(r=2*t)
{   linear_extrude(height=2*bt) hull()
    {   translate([zrd,zrd]) circle(3*bbr+r-2*t);
        for( pos=relpos ) translate(pos) circle(r);
    }
}

module zrod_holder()
{
    difference()
    {   _holder(r=t);
        for(pos=relpos) translate(pos) translate([0,0,-bt]) cylinder(r=sr,h=4*bt);
        translate([zrd,zrd,-bt]) cylinder(r=bbr,h=8*bt);
    }
}

module x_rod_add(a=0)
{
    translate([zrd,0,bbr+bt+t]) rotate(a) rotate([-90,0,0])  //x rod.
        linear_extrude(height=hl-zrd) difference()
    {   circle(bbr+1.5*t);
        circle(bbr);
    }
}
module zrod_tcorner()
{
    difference()
    {   union()
        {   if(rod_adjustable) _corner(bt=2*bt,thicken_diag_t=2*t);
            else _corner(thicken_diag_t=2*t);
            x_rod_add();
            translate([zrd,zrd,-bt]) cylinder(r=bbr+1.5*t,h=fh);
        }
        //Hole for z rod, and holder.
        if(rod_adjustable)
        {   translate([zrd,zrd,-fh]) cylinder(r=bbr+0.5*t,h=8*fh);
            translate([0,0,-3*bt]) _holder();
            for( pos=relpos ) translate(pos) 
               translate([0,0,-fh]) cylinder(r=2*sr,h=fh+3*bt);
        }
        else
        {   translate([zrd,zrd,-fh]) cylinder(r=bbr,h=8*fh);
        }
        planks_space();
    }
}
module xrod_corner()
{
    difference()
    {   union()
        {   if(rod_adjustable) _corner(bt=2*bt,thicken_diag_t=2*t);
            else _corner(thicken_diag_t=2*t);
            translate([0,zrd,bbr+bt+t]) rotate([0,90,0]) cylinder(r=bbr+1.5*t,h=6*t); //x rod.
        }
        planks_space();
        translate([0,zrd,bbr+bt+t]) rotate([0,90,0]) cylinder(r=bbr,h=hl); //x rod.
    }
}

//All plates are the same.
module side_plate()
{
    fz= (min_z+bh+fh)/2;
    translate([pt,0]) rotate([0,-90,0]) linear_extrude(height=pt) difference()
    {   square([h,l-pt]);
        translate([fz,l/4]) square([h-fz-fh,2*l]);
    }
}

zrod_bcorner();
//translate([hl,hl]) zrod_holder();
