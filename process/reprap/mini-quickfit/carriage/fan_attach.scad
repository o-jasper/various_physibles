//
//  Copyright (C) 08-03-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Fan attacher, currently intended to glue 

fw=52;fh=12.5; //Width, height of fan.
fsw=41; sr=1.8; //Screw location,radius.

t=3;
ch=20; //Clearance height.
fh=28; //Height of face it clings too.

gz=1.5;gt=5.1; //'Grabbing height'

module fan_sub(big=true)
{
    translate([0,0,ch]) rotate([0,asin(ch/fw),0]) 
    {   if(big) 
        {   translate([-fw,-fw]) cube([4*fw,4*fw,8*fh]); }
        else
        {   cube([fw,fw,fh]); }
        translate([fw/2,fw/2,-4*fh]) for(a=[0:90:270]) rotate(a) 
            translate([fsw,fsw]/2) cylinder(r=sr,h=8*fh);
    }    
}

module duct()
{   difference()
    {   translate([-2*t,0]) cube([fw,fw,ch]);
        fan_sub();
        translate([0,t,t]) cube([2*fw,fw-2*t,ch-2.5*t]);
        translate([0,t,ch-t]) rotate([0,135,0]) 
        {   cube([2*fw,fw-2*t,ch-2*t]);
            translate([2.5*t,-4*fw,-3*fw]) cube([2*fw,8*fw,8*fw]);
        }
    }
}

module reach_up()
{   
    difference()
    {   translate([-2*t,0,ch]) cube([2*t,fw,fh+2*t]); 
        translate([-t,fw/2,ch+fh/2]) rotate([0,90,0]) 
            scale([0.6,1,1]) cylinder(r=fw/2-t,h=8*fw,$fn=4);
    }
}
module top_grab()
{   difference()
    {   translate([-gt-4*t,0,fh+ch-gz]) cube([4*t+gt,fw,gz+2*t]);
        translate([-2*t-gt,0]) cube([gt,2*fw,ch+fh+gz]);
    }
}

module eyes()
{   
    for(y=[0.2,0.8]*fw) translate([-t,y,ch+fh+2*t]) rotate([0,90,0]) 
    linear_extrude(height=t) difference() 
    {   scale([0.13,0.2]) circle(fw,$fn=4); translate([-sr,0]) circle(sr); } 
}

module fan_attach(top_grab=false,eyes=true)
{
    rotate($show ? [0,0,0] : [90,0,0])
    {
        duct();
        reach_up();
        if(top_grab) top_grab();
        if(eyes) eyes();
    }
}

fan_attach();
