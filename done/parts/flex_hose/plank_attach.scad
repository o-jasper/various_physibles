//
//  Copyright (C) 30-05-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Makes an attacher for the plank.

include<on_plank.scad>

rc=9;
w=25;

t=5;
gl=2*w;
sz=(max_pt+3*t)/2;

module plank_attach()
{   difference()
    {
        union()
        {   on_plank(w=w);
            translate([gl,sz,w/2]) intersection()
            {   rotate([0,90]) scale([0.9,1,1]) cylinder(r=sz,h= (1+1/sqrt(2))*rc);
                cube([2*sz,2*sz,w],center=true);
            }
        }
        for( y = [rc+t/2 : 2*rc+t/2 : 2*sz-rc-t/2] ) 
            translate([gl+rc,y,w/2]) sphere(rc);
    }
}
