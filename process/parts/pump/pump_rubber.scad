//
//  Copyright (C) 05-03-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<oneway_rubber.scad>

br=r;
t=1.6;
ri=-1;

R=10; H=60;

s=0.1;

fhr=2;
fhd=2.5*ceil((R+2.5*t)/2.5);
module fhpos()
{   for(x=fhd*[1,-1]) translate([x,0]) child(0); }

vd=R+r+t;
module valve_pos()
{   for(a=[0,180]) rotate(a) translate([0,vd]) child(0); }

module pump()
{
    difference()
    {   union()
        {   cylinder(r=R+t,h=H);
            linear_extrude(height=t) difference()
            {   hull()
                {   circle(R+2*t);
                    fhpos() circle(fhr);
                }
                fhpos() circle(fhr);
            }
            hull() fhpos() cylinder(r=fhr,h=2*br);
            fhpos() cylinder(r=fhr+t,h=2*br);
            
            hull() valve_pos() cylinder(r=r+t,h=2*l+2*t);
        }
        translate([0,0,t]) cylinder(r=R,h=H);
        
        translate([0,0,-4*H])
        {   cube(H*[8,8,8],center=true);
            fhpos() cylinder(r=fhr,h=8*H); //Feature hole.
        }

        difference()
        {   union()
            {   translate([0,vd,t+r]) oneway_cut();
                translate([0,-vd,l+t+r]) rotate([180,0,0]) oneway_cut();
            }
            translate([0,0,t-4*H]) cube(H*[8,8,8],center=true);
        }
        translate([0,0,2*l]) valve_pos() cylinder(r1=r,r2=r/2,h=l);
        translate([0,0,t]) hull()
        {   valve_pos() cylinder(r1=r-t,r2=0,h=l/2);
            cylinder(r1=r,h=l);
        }
      //Too close..
        //translate([0,0,-t]) valve_pos() 
        //    for(a=[-30,-150]) rotate(a) translate([r+t/2,0]) cylinder(r=t/4,h=8*H);
    }
}

module plunger(fancy_center=false,fr=1)
{
    difference()
    {   cylinder(r=R-s,h=H);
        translate([0,0,t]) cylinder(r=R-t,h=H);
    }
    difference()
    {   linear_extrude(height=H) intersection()
        {   for(a=[0,90]) rotate(a) square([t,4*R],center=true);
            circle(R);
        }
        if(fancy_center)
        {   for(z=[R:R:H-R]) rotate_extrude() translate([(R+t)/2,z]) circle(R/2-t,$fn=4);
            for(z=[0:R:H-R]) translate([0,0,z+R/2])
            {   cylinder(r1=R/2,r2=0,h=R/2);
                translate([0,0,-R/2]) cylinder(r2=R/2,r1=0,h=R/2);
            }
        }
    }
    for(y=[4*t,-2*t]) translate([0,y,H]) rotate([90,0,0]) 
       linear_extrude(height=2*t) difference()
    {   hull()
        {   for(x=R*[1,-1]) translate([x,R]) circle(fr+2*t);
            circle(R);
        }
        translate([0,R/3]) circle(R/2);
        for(x=R*[1,-1]) translate([x,R]) circle(fr);
    }
}
module plunger_fancy(fr=1){ plunger(fancy_center=true,fr=fr, H=H,R=R,t=t); }

module cover2d(s)
{   union()
    {   circle(R+t+s);
        hull() valve_pos() circle(r+t+s);
    }
}

module cover(s=0.4)
{
    difference()
    {   union()
        {   linear_extrude(height=l) 
            {   cover2d(s+t);
                fhpos() circle(fhr+t);
            }
            linear_extrude(height=t) hull(){ cover2d(s+t); fhpos() circle(fhr+t); }
        }
        translate([0,0,-l]) linear_extrude(height=8*l) 
        {   cover2d(s);
            fhpos() circle(fhr);
        }
    }
}

module show()
{   pump();
    translate([0,0,4*t+H*$t/2]) color("blue") plunger();
    translate([0,0,l]) color("red") cover();
    translate([4*R,0]) rubber_oneway_lone();
}
show();
