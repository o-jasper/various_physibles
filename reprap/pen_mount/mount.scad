//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include <acceptor.scad> 

h = 24.5; //TODO get these!
pt = 5.8; 

td = 10;
bd = 20;

t=3;

w = 40;
dev = 2; //Deviation for beding.

module circle_spring(r,d,t)
{
    translate([r-d,0]) difference()
    {   union()
        {   difference(){ circle(r); circle(r-t); }
            translate([t-r,-t]) square([d,t]);
        }
        translate([-2*r,0]) square(r*[4,4]);
        translate([-r,0]) rotate(45) square(r*[1,1]/6,center=true);
    }

}

module clamp()
{
    linear_extrude(height=w)
    {   translate([0,h-dev]) scale([1,-1]) circle_spring(bd,td,t); //top
        translate([0,pt-dev]) scale([1,-1]) circle_spring(h-2*pt, td,t); //Middle
        translate([0,dev]) circle_spring(bd,bd,t); //bottom.
        
        //Body
        polygon([[h-pt,0], [h-2*pt,t],[bd+td-t,h-dev],[bd+td,h-dev],
                 [bd+td,0]]);

    }
}

clamp();

color([0,0,1])
{   square([pt,pt]);
    translate([0,h-pt]) square([pt,pt]);
}
