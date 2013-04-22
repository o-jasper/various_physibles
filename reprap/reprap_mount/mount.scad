//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//include <attachable.scad>

al = 5;

h = 24.5; 
pt = 5.8; //Note the top one seems a littl less.

st =4; //Structural thicknesses.

td = 20; //Length grabbed..
mtd = 14;
mbd = 14;
bd = 20;

t=2; //Thickness of springy bits.

w = al; //Width.
dev = 0.5; //Deviation for beding.


module springy(l,gy,dir)
{
    y = gy + dir*dev;
    translate([bd-l,y]) 
    {   polygon([[-t/2,0], [-t,t/2],[-t,t], [3*(l+t)/4,dir>0 ? t : t/2], 
                 [3*(l+t)/4,dir>0 ? t/2 : 0]]);
        translate([l/2,t/2]) scale([1,dir]) difference()
        {   scale([1,1/2]) circle(l/2+t);
            scale([(l/2)/l,(l/4)/l]) circle(l);
            translate([0,l]) square(2*[l,l],center=true);
        }
    }
}

module clamp_profile()
{   springy(td,-t,+1);
    springy(mtd,pt,-1);
    springy(mbd,h-pt-t,+1);
    springy(bd,h,-1);

    translate([bd,-t]) square([st,h+2*t]);
}

module clamp()
{   linear_extrude(height=w) clamp_profile(); }

module clamp_component()
{   linear_extrude(height = 3*al) clamp_profile();
    for( y = [0 : 2*al :h] ) 
        translate([bd-t+al,y,al]) 
            linear_extrude(height=al) difference()
        {  square([al,al]); translate(al*[1,1]/2) circle(al/4); }
}

clamp_component();

module clamp_to_visualization()
{   color([0,0,1]) 
    {   translate([bd-td-t,0]) square([td,pt]);
        translate([-t,h-pt])  square([bd,pt]);
    }
}
clamp_to_visualization();
