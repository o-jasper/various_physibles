//
//  Copyright (C) 31-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;
w=210/2+5; 
h=297/2+5;
bt=10;
t=2;

sr=0.8;

n=10;m=15;
dx=w/n;dy=h/n;

module base()
{   difference()
    {   hull()
        {   cube([w,h,0.7*t]);
            translate([t,t,0.8*t]) cube([w-2*t,h-2*t,0.2*t]);
        }
        for(y=[dy,h-dy]) for(x=[dx:dx:w-dx]) translate([x,y,1.5*t]) 
            scale([2,2.5,1]) sphere(t);
        for(x=[dx,w-dx]) for(y=[dy:dy:h-dy]) translate([x,y,1.5*t]) 
            scale([2.5,2.5,1]) sphere(t);
        hull()
        {   translate([w/2,h/2,t]) cube([w-2*dx,h-2*dy,t],center=true);
            translate([w/2,h/2,t+dx]) cube([w+dx,h,t],center=true);
        }
    }
}

module side()
{   difference()
    {   base();
        rotate([-90,0,0]) scale([0.7,1,1]) cylinder(r=t,h=8*h,$fn=4);
        translate([2*t,0]) 
        {   rotate([-90,0,0]) scale([0.7,1,2*(t+sr)/t]) cylinder(r=t/2,h=8*h,$fn=4);
            for(y=[2*t:2*t:h-2*t]) translate([0,y,t/2])
                                       rotate([0,-90,0]) cylinder(r=sr,h=h,$fn=4);
        }
    }
}
module book_spine()
{
    difference()
    {   union()
        {   hull()
            {   translate([t/2,0]) cube([bt-t,h,t]);
                translate([0,0,0.8*t]) cube([bt,h,0.2*t]);
            }
            for(y=[dy:dy:h-dy]) translate([bt/2,y,0.8*t]) scale([2,2,0.5]) sphere(t);
        }
        for(y=[2*t:2*t:h-2*t]) translate([h/2,y,t/2])
                                   rotate([0,-90,0]) cylinder(r=sr,h=h,$fn=4);
    }
}

module book_front(front_file="output/front.dat")
{   translate([dx,h-dy,t/2]) 
        rotate(270) scale([(w-2*dx)/149,(h-2*dy)/210,t/2000]) 
        surface(file = front_file, convexity = 0);
    side();
}

module book_back(back_file="output/front.dat")
{   translate([w-dx,dy,t/2]) 
        rotate(90) scale([(w-2*dx)/149,(h-2*dy)/210,t/2000]) 
        surface(file = back_file, convexity = 0);
    side();
}

module show()
{   translate([t,0]) rotate([0,-90,0]) book_spine();
    translate([0,0,bt]) book_front();
    translate([0,h]) rotate([180,0,0]) book_back();
}

//show();
book_front();
