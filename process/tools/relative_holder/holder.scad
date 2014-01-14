//
//  Copyright (C) 14-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module _bottom()
{
    linear_extrude(height=bt) difference()
    {   hull()
        {   for(x=[w,-w]/2) translate([x,0]) circle(r);
            translate([0,w]) circle(t);
        }
        hull() for(y=[0,w-r]) translate([0,y]) circle(sr);
    }
}

module bottom()
{
    difference()
    {   _bottom();
        translate([0,0,-sbh]) linear_extrude(height=2*sbh) hull() 
            for(y=[0,w-r]) translate([0,y]) circle(sbr);
    }
}

//Movable platform.
module holder_platform()
{
    linear_extrude(height=t) difference()
    {   hull()
        {   //for(x=[w,-w]/2) translate([x,w/1.5]) circle(r);
            translate([0,w/2]) scale([(w/2)+r,0.5*w]/w) circle(w);
            circle(r);
        }
        for(x=[w,-w]/2) translate([x,0]) circle(w/2-r);
        circle(sr); //Hole for
    }
}

module holder_body(ps=0)
{
    bottom();
    intersection()
    {   union()
        {   translate([w/2,0]) linear_extrude(height=h, twist=twist_a) 
            {   for(a=[0:60:300]) rotate(a) translate([r-t,0]) circle(t+ps,$fn=4);
                circle(r-t+ps);
            }
            translate([-w/2,0]) intersection()
            {   cylinder(r=r+ps,h=h);
                translate([0,0,h/2]) cube([2*r+ps,r,h],center=true);
            }
        }
        for(x=[w,-w]/2) translate([x,0]) cylinder(r1=h+t,r2=t,h=h);
    }
}

module holder_z_slider()
{
    difference()
    {   union()
        {   linear_extrude(height=t) difference()
            {   hull()
                {   translate([w/2,0]) circle(r+t);
                    translate([-w/2-t,0]) circle(r);
                }
                translate([w/2,0]) circle(r+s);
            }
            linear_extrude(height=zh) difference()
            {   union()
                {   translate([w/2,0]) circle(r+t);
                    hull() for(x=[t,-t]) translate([-w/2+x,0]) circle(r);
                    square([w,2*(sr+t)],center=true);
                }
                translate([w/2,0]) circle(r+s);
            }
        }
        translate([0,0,-h/2]) 
        {   holder_body(ps=s);
            hull() for(x=[1,-1]*(w/2-r-t-sr)) translate([x,0]) cylinder(r=sr,h=3*h);
        }
    }
}
module holder_knob()
{
    difference()
    {   intersection()
        {   cylinder(r=r+1.5*t,h=2*t);
            translate([0,0,t]) sphere(r+1.5*t);
        }
        translate([-w/2,0,-h/2]) holder_body(ps=s);
        for(a=[0:30:330]) rotate(a) translate([r+2*t,0]) cylinder(r=t,h=20);
    }
}

module show(z=t+h/2*$t)
{   
    holder_body();
    translate([0,(w-r-sr)*(1+sin(720*$t))/2,bt]) rotate(30*sin(360*$t)) 
        color("red") holder_platform();
    translate([w/2,0,bt+z]) color("green") rotate(z*twist_a/h) holder_knob();
    translate([0,0,bt+z+2*t]) holder_z_slider();
}
show();
