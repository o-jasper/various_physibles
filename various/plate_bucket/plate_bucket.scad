//
//  Copyright (C) 19-06-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.5;
t = 4;
w = 80;

pt=1;
wr=1;

h=100;

module base_bottom()
{   union()
    {   square([w,w-2*t],center=true);
        square([w-2*t,w],center=true);
        for( a=[0,90,180,270] ) rotate(a) translate([w/2-t,w/2-t]) circle(t);
    }
}

bh=t;
module bottom()
{   difference()
    {   linear_extrude(height=h/2) base_bottom();
        translate([0,0,bh]) linear_extrude(height=h) base_bottom(w=w-2*t);
        translate([0,0,t]) linear_extrude(height=h) difference()
        {   square([w-t+pt,w-t+pt],center=true); 
            square([w-pt-t,w-pt-t],center=true);
            for( a = [45,-45] ) rotate(a) square([pt,4*w], center=true);
        }
        
        for( a=[0,90] ) rotate(a) for( x = [2*t-w/2 : 2*t  : w/2-2*t] )
                            translate([x,0,1.5*t]) cube([pt,w-2*pt,pt],center=true);
        translate([0,0,h/2+2*t]) cube([2*w,w-3*t,h],center=true);
        translate([0,0,h/2+2*t]) cube([w-3*t,2*w,h],center=true);
    }
}
module top(){ bottom(bh=0); }
//bottom();
top();
