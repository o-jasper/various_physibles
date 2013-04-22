//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include <rounded_box.scad> 
include <acceptor.scad> 

h = 24.5; 
pt = 5.8; //Note the top one seems a littl less.

td = 10; //Length grabbed..
bd = 20;

t=1; //Thickness of springy bits.

w = 30; //Width.
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

module mount()
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

sr= 1.2;

include<attachable.scad>

module mount_component()
{
    difference()
    {   union()
        {   mount();
            translate([bd+pt + hw/2+t,h/2, w/2]) 
                rotate([90,0,0]) rotate(180) difference()
            {   
                linear_extrude(height=hl) difference()
                {   scale([1,1.2]) circle(w/2);
                    translate([-hw/2-hl,0]) 
                    {   circle(sr);
                        translate([hl/2,+hl+sr]) circle(sr);
                        translate([hl/2,-hl-sr]) circle(sr);
                    }
                    translate([0,+w]) square([w,w],center=true);
                    translate([0,-w]) square([w,w],center=true);
                }
                cube([hw,hw, 10*hl], center=true);
            }
        }
        translate([bd+pt + hw/2+t,h/2-hl, w/2]) 
            rotate([90,0,0]) rotate(180) attach_methods(1.2,1,1);
        
        translate([bd+pt + hw/2+t,h/2+hl, w/2])
            rotate([90,0,0]) rotate(180) attach_methods(1.2,1,1);
    }
}
  
mount_component();
  
//color([0,0,1])
//{   square([pt,pt]);
//    translate([0,h-pt]) square([pt,pt]);
//}
