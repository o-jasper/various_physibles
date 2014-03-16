//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>
use<pulley.scad>
use<corner.scad>

module pulley_add_1()
{ translate([pr,2*t]) rotate([90,0,0]) cylinder(r=pr-t/2,h=4*t); }
module pulley_add()
{   pulley_pos() pulley_add_1(); }

module pulley_sub(bottom=true)
{
    pulley_pos() union()
    {   cylinder(r=2*sr,h=l); //Wire hole.
        translate([pr,0,-pr]) rotate([0,90,0]) cylinder(r=2*sr,h=l);
        translate([pr,t]) rotate([90,0,0]) cylinder(r=pr+2*sr,h=2*t);
        translate([pr,fh]) rotate([90,0,0]) cylinder(r=sr,h=8*fh);
        translate([pr,6*t]) rotate([90,0,0]) cylinder(r=pr-t/2,h=4*t); 
        translate([pr,-2*t]) rotate([90,0,0]) cylinder(r=pr-t/2,h=4*t); 
    }    
}

include</home/jasper/oproj/physical/reprap/i3ext/inc/nema17.scad>

dl=l/3;

module bed_holder(save=true) //TODO also raising method.
{   d=bzd;
    fh=lh;
    th=fh+bh;

    dist = sqrt(dl*dl+dc*dc);

    color("red") difference()
    {   union() 
        {   for(pos=[[dl,dc,0],[dc,dl,0]])
            {   hull() //Main shape.
                {   cylinder(r1=0,r2=t,h=th);
                    translate(pos+[0,0,fh-t]) cylinder(r=bbr+t,h=t);
                    translate(pos*(dist-fh/1.5)/dist) cylinder(r=t/2,h=fh);
                }
                hull() //Floor plate.
                {   cylinder(r=bbr+t,h=t);
                    translate(pos*(dist-fh/1.5)/dist) cylinder(r=t,h=t);
                }
            }
            hull() //Little platform
            {   translate([0,0,fh/4]) cylinder(r=bbr+t,h=3*fh/4+t/2);
                translate([dc+bsd,dc+bsd,fh-t]) cylinder(r=sr+2*t,h=t);
            }
            translate([dc+bsd,dc+bsd,fh-t]) linear_extrude(height=t) hull()
            {   circle(sr+2*t);
                for(a=[180,0]) rotate(a) translate([-3*t,3*t]) circle(t);
            }

            cylinder(r=bbr+t,h=th); //Around smooth rod.

            pulley_pos() hull()
            {   translate([0,0,pz]) pulley_add_1(); 
                translate([t,t]) cylinder(r=t/2,h=t);
            }
        }
        translate([dc-t/4,dc-t/4,fh]) cube([l,l,l]); //Space for bed.
        translate([0,0,-fh]) cylinder(r=bbr,h=4*fh);
        translate([dc+bsd,dc+bsd,t]) //Screw hole and space.
        {   cylinder(r1=(dc+bsd)*sqrt(2)-bbr-t,r=sr+t,h=fh-3*t);
            cylinder(r=sr,h=h+t);
        }
        translate([0,0,pz]) pulley_sub();
        if(save) translate((lh/2+bbr)*[1,1,0]+[0,0,hl/4+t]) for(a=[0,-90]) rotate(a)
            rotate([90,0,0]) scale([0.8,1,1]) cylinder(r=lh/2-2*t,8*hl,$fn=4);

    }
    if($show) color("purple") pulley_pos() translate([pr,3*t/4,pz]) rotate([90,0,0]) pulley();
}

wr=pz/2;
mz=pz+pr-wr;

module motor_pos()
{   rotate(45) translate([sqrt(2)*dl,-sh/2]) rotate([90,0,0]){ child(0); }}

module motor_hold_walls2d(x=0)
{
    r=dl-sw/sqrt(8)-x;
    hull() //Walls that connect motor thing.
    {   translate([dl-x,zrd+t+x]) circle(t+x);
        translate(r*[1,1]+(sw+2*t)*[1,-1]/sqrt(8)) circle(t+x);
    }
    hull()
    {   translate([zrd+t+x,dl-x]) circle(t+x);
        translate(r*[1,1]+(sw+2*t)*[-1,1]/sqrt(8)) circle(t+x);
    }
    if(x>0) hull()
    {   translate(r*[1,1]+(sw+2*t)*[-1,1]/sqrt(8)) circle(t+x);
        translate(r*[1,1]+(sw+2*t)*[1,-1]/sqrt(8)) circle(t+x);
    }
}

module bed_holder_w_motor(save=true)
{
    msd=6;
    bed_holder(save=save);
    color("red") translate([-zrd,-zrd]) difference()
    {   union()
        {   translate([0,0,mz]) motor_pos() union()
                translate([-sw/2-t,-mz,-sh-t]) 
            {   cube([sw+2*t,sw/2,sh+2*t]);
                cube([sw/2-t,sw+t,sh+2*t]);
            }
            linear_extrude(height=sw/2) motor_hold_walls2d();
            linear_extrude(height=t) motor_hold_walls2d(x=t);
        }
        translate([0,0,mz]) motor_pos() union()
        {   translate([0,0,-sh/2]) cube([sw+t,sw+t,sh+t/2],center=true);
            for(x=(sw/2-msd)*[1,-1]) for(y=(sw/2-msd)*[1,-1]) 
                translate([x,y,-4*sh]) cylinder(r=sr,h=8*sh);
            translate([0,0,-4*sh]) cylinder(r=wr+t/3,h=8*sh);
            //Holes of saving
            translate([0,0,-sh/2]) rotate([90,0,0]) cylinder(r=sw/2-t,h=8*sh,$fn=4);
            translate([0,-t,-sh/2]) rotate([0,-90,0]) cylinder(r=sw/2-2*t,h=8*sh,$fn=4);
        }
       translate([0,0,pz]) pulley_sub();
    }
}

module winder() //TODO hole should not be circular!
{   pulley(pr=wr,pt=10,sr=2.5,f=1/6);
}

include<fits/nema17.scad>

module show_bed(ps=true)
{
    $show=true;
    translate([zrd,zrd]) bed_holder_w_motor();
    if(ps) planks_space();
    translate([0,0,mz]) motor_pos() union()
    {   nema();
        translate([0,0,t]) winder();
    }
}
show_bed();
//bed_holder_w_motor();
