//
//  Copyright (C) 26-01-2014 Jasper den Ouden.
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

module cover2d()
{
    hull()
    {   circle(r+t);
        translate([0,-r-t]) circle(t);
    }
}
module pump()
{
    difference()
    {   union()
        {   cylinder(r=R+t,h=H);
            translate([0,1.5*l+R,br+t]) rotate([90,0,0]) linear_extrude(height=3*l+2*R) 
                cover2d(r=br,t=t);
            linear_extrude(height=t) difference()
            {   hull()
                {   circle(R+2*t);
                    for(x=(R+3*t)*[1,-1]) translate([x,0]) circle(3*t);
                }
                for(x=(R+3*t)*[1,-1]) translate([x,0]) circle(2*t);
            }
            for(x=(R+3*t)*[1,-1]) translate([x,0]) cylinder(r=3*t,h=2*br);
        }
        translate([0,0,t]) cylinder(r=R,h=H);
        for(x=(R+3*t)*[1,-1]) translate([x,0,-t]) cylinder(r=2*t,h=8*br);
        translate([0,0,-4*H]) cube(H*[8,8,8],center=true);
        for(y=[R,-l-R]) translate([0,y,br+t]) rotate([-90,0,0]) //The oneway thingies.
        {   rotate(180) oneway_cut();
            difference() //Space to flap rubber band onto.
            {   translate([0,br-bw,l/2+bw/4]) cube(bw*[1,2,0.5],center=true);
                cylinder(r=br+t-bt,h=l);
            }
        }
    }
    for(y=(1.5*l+R-ds)*[1,-1]) translate([0,y,br+t]) rotate([90,0,0]) rotate_extrude()
        translate([r,0]) circle(ds);
            
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

module cover(s=0.4)
{
    rotate(180) linear_extrude(height=l) difference()
    {   intersection(){ cover2d(r=br,t=1.5*t); square((br+1.5*t)*[2,2],center=true); }
        intersection(){ cover2d(r=br,t=t+s); square((br+t+s)*[2,2],center=true); }
    }
}


module show()
{   pump();
    translate([0,0,4*t+H*$t/2]) color("blue") plunger();
    translate([0,2*R+2*R*$t,br+t]) rotate([-90,0,0]) color("red") cover();
    translate([4*R,0]) rubber_oneway_lone();
}
show();
