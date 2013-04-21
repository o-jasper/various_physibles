//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use <rounded_box.scad>

t=5;
hw = 20; //Holding size.
hl = 5; //Holding bar length.(standard)

ph = 20;

ft= 5;
pr= 10/2;  //Pen radius.
pf = 0.9; //Factor less space to take so it clamps. 
h= 19.4; //Height.
spcl = 10; //Spring (sufficiently!)compressed length.
spir  = 0.5; //.. inside radius.

have_w = 45.2; //Width we have.

t = 6;
bt = 4;//Bottom height.. Cant be larger than heatsheat height, bummer.
r = min(t,pr)/2;


w= min(4*pr, have_w);
td = 10; //Depth of grab.
ud = 20;

sr = 0.6; //Screw radius

a=40;

module grabber(h)
{
    h = h<0 ? 2*pr/sin(a) : h;
    linear_extrude(height=h) difference()
    {   circle(r);
        translate([2*r,0]) circle(2*r);
    }
}

n = 4; m =4;
hw = 4*pr-2*r;//Hole width
ph = (m-0.5)*t-r*cos(a);//Pillars height.
th = h + 2*pr/sin(a); //total height

module pen_grab()
{    
    
    intersection()
    {   union()
        {   linear_extrude(height=ph) difference()
            {   translate([-hw/2 - r,-hw/2 - r]) rounded_square(hw + 2*r,hw + 2*r, r);
                translate([-hw,-hw]/2) rounded_square(hw,hw, r);
            }
            for( i = [0:n-1] )
                rotate(45+i*360/n) translate([2*pr,0]) 
                {   grabber(ph);
                    for( j =[0:m-1] )
                        translate([0,0,j*t]) rotate([0,-a]) grabber(-1);
                }
        }
        difference()
        {   translate([0,0,th/2]) cube([hw+2*r,hw+2*r,th], center=true);
            cylinder(r= pf*pr, h=10*h);
        }
    }
}

pen_grab();

module ride_grab_profile()
{
    difference()
    {   union()
        {   square([t+ud+t,bt]);
            //translate([ud-td, bt+h]) square([td+t/2,t]);
            translate([ud,0]) 
            {   square([2*t,t]);
                translate([0,ph-t]) square([2*t,t]);
                square([t,bt+t/2 + h]);
                translate([t/2,bt+t/2+h]) circle(t/2);
            }
        }
        translate([ud+t/2,bt+0.6*t]) circle(sr);
        translate([ud+t/2,bt+h-0.6*t]) circle(sr);
        translate([ud+t/2,bt+h+t/2]) circle(sr);
    }
}

module ride_grab_finger(fb)
{
    translate([0,(w-1.1*t)/2,-t/4]) rotate([90,0]) 
        linear_extrude(height= w-1.1*t) intersection()
    {   union()
        {   translate([-fb*t,0]) square([ud+fb*t,t/2]);
            translate([-fb*t,t/2]) scale([1,1.4]) circle(t/2);
            translate([ud,t/2]) scale([1,1.4]) circle(t/2);
        }
        difference()
        {   translate([-ud-t,0]) square([3*(ud+t),t/2]);
            translate([0,t/4]) circle(sr);
        }
    }
}

module ride_grab_middle_finger() //One of the two middle fingers.
{   ride_grab_finger(0.3);
    translate([ud,0,-t/4]) cylinder(r=spir, h=h/2-0.5*t);
    translate([ud,0,0]) scale([1/2,(w-1.1*t)/(2*t)]) 
        cylinder(r=t, h= ((h-1.2*t)-spcl)/2);
}

module ride_grab_top_finger() //Top finger.
{   ride_grab_finger(0.8);
    translate([-t,0,-t/4]) cylinder(r=spir, h=0.8*t);
}

module ride_grab()
{
    translate([0,-w/2]) rotate(180) rotate([90,0]) difference()
    {   linear_extrude(height=w) ride_grab_profile();
        translate([0,bt,t/2]) cube([ud+2*t,2*(bt+h), w-t]);
        translate([ud+t/2,-t,t/2]) cube([1.5*t,3*t,w-t]);
    }
}

module main_body()
{   pen_grab();
    translate([ud+2*t+1.55*pr,0]) ride_grab();
    translate([2*pr-spir,0]) cylinder(r=spir, h=bt+h-t/2+0.2*t);
}

module as_print() //..could look
{   main_body();
    translate([ud-t,6*pr,t/2]) ride_grab_middle_finger();
    translate([ud-t,6*pr + w/2+t,t/2]) ride_grab_middle_finger();
    translate([ud-t,6*pr + w+2*t,t/2]) ride_grab_top_finger();
}

module as_assembled()
{
    main_body();
    translate([2*pr+t,0,bt+h-0.6*t]) rotate([180,0]) ride_grab_middle_finger();
    translate([2*pr+t,0,bt+0.6*t]) ride_grab_middle_finger();
    translate([2*pr+t,0,bt+h+t/2]) rotate([180,0]) ride_grab_top_finger();
}

//as_assembled();
//as_print();

//main_body();


