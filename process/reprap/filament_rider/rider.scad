//
//  Copyright (C) 06-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.2;

t=3;  //Thicknesses.
R=20; //Radius of wheel.
n=6;  
m=30; //Number of indicators going round.
Ri=t; //Extra hole size.

sr=1.6;

fr=2; //Radius of filament.(over-estimated)

decorate1=true;
decorate2=true;
teeth=false; //Hmm ugly.
hole_thingy=true;

module wheel()
{   
    difference()
    {   intersection()
        {   union() //Main shape.
            {   cylinder(r1=R,r2=R-2*t,h=2*t);
                cylinder(r1=R-2*t,r2=R,h=2*t);
            }
            cylinder(r=R-t/2,h=2*t);
        }
        //Ticks.
        for(a=[0:360/m:360*(1-1/m)]) rotate(a) if(teeth)
        {
            translate([0,R,-t]) cylinder(r=2*R/m,h=8*t,$fn=4);
        }
        else
        {   for(z=[0,2*t]) 
               translate([0,R-6*R/m,z]) sphere(2*R/m,$fn=4);
        }
        translate([0,0,-t])
        {
            cylinder(r=sr,h=8*t); //Center hole.
            for(a=[0:360/n:360*(1-1/n)]) rotate(a) translate([R/2,0]) //Extra holes.
            {   cylinder(r1=Ri+t,r2=Ri-t,h=4*t);
                cylinder(r2=Ri+t,r1=Ri-t,h=4*t);
            }
        }
    }
}

module _hanger()
{
    translate([0,R+t,-t]) cylinder(r1=t,h=t/2,$fn=4); //Pointers.
    translate([0,R+t,2.5*t]) cylinder(r2=t,h=t/2,$fn=4);
    difference()
    {   translate([0,0,t]) union()
        {   //Entrance 'pipe'
            translate([R,R-t]) rotate([0,90,0]) cylinder(r1=2*t,r2=3*t,h=R/2);
            translate([0,R-t]) rotate([0,90,0]) cylinder(r=2*t,h=R);
            translate([0,0,-2*t]) intersection()
            {   union() //Main shape
                {   cylinder(r=R+4*t,h=4*t,$fn=80);
                    //Hole thingy.
                    if(hole_thingy) translate([0,0,t]) 
                        linear_extrude(height=2*t) difference()
                    {   hull()
                        {   translate([0,R+2*t]) circle(2*t);
                            rotate(-15) translate([0,R+5*t]) circle(2*t);
                        }
                        rotate(-15) translate([0,R+5*t]) circle(t);
                    }
                }
                //(helps with main shape)
                translate([0,4.5*R]) cube([2*(R+t),8*R,8*R],center=true);
            }
        }
        translate([0,0,-t]) cylinder(r=R+t,h=6*t); //Hole for wheel.
        translate([R,R-t,t]) rotate([0,90,0]) cylinder(r1=t,r2=3*t,h=R);
        //Decoration on the side.
        if(decorate1) for(a=[-40:12:50]) rotate(a) 
            for(z=[-1.2*t,3.2*t]) translate([0,R+2.5*t,z]) sphere(t,$fn=4);
    }
    
    //To hinge.
    difference()
    {   for(z=[-t,2.1*t]) translate([0,0,z]) linear_extrude(height=0.9*t) hull()
            {   circle(1.5*t);
                translate([-R-t,R-4*t]) square([t,2*t]);
                rotate(-45) translate([-R-t,0]) circle(t);
            }
        translate([0,0,-t]) cylinder(r=sr,h=8*t);
        if(decorate2)
            for(z=[-1.6*t,2.6*t]) translate([0,0,z]) linear_extrude(height=0.9*t) difference()
        {   hull()
            {   circle(t);
                translate([-R,R-3.5*t]) square([t/2,t/4]);
                rotate(-45) translate([-R-t,0]) circle(t/8);
            }
            rotate(57) square(t*[2.5,2.5],center=true);
            difference(){ circle(R/2+1.3*t); circle(R/2+t/2); }
        }
    }
}
module hanger()
{
    difference()
    {   _hanger(R=R,t=t,
            decorate1=decorate1,decorate2=decorate2,teeth=teeth,hole_thingy=hole_thingy);
        translate([-4*R,R-t,t]) rotate([0,90,0]) cylinder(r=fr,h=8*R);
    }
    
}

module show()
{
    hanger();
    color("green") rotate($t*360/n) wheel();
}

show();

module hanger_plain()
{   hanger(decorate1=false,decorate2=false); }
