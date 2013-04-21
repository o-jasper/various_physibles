//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use <rounded_box.scad>

//These three variables are supposed to be somewhat standard.
hw = 20; //Holding size.
hl = 5; //Holding bar length.
r  = 2.5;

t=5;
hw = 20; //Holding size.
hl = 5; //Holding bar length.(standard)
r=2.5;

module acceptor(h,sh)
{   difference()
    {   linear_extrude(height=h) difference()
        {   translate([-hw/2-hl,-hw/2-hl]) rounded_square(hw+2*hl,hw+2*hl, r);
            translate([-hw/2,-hw/2]) rounded_square(hw,hw, r);
        }
        translate([0,0,h])
        {   cube([hl,4*hw,2*sh], center=true);
            cube([4*hw,hl,2*sh], center=true);
        }
    }
}

module acceptor_component_extra(sr, nscrew,nplate) //The stuff extra on the component.
{
    for( i=[1:nplate] )
    {   rotate(i*360/nplate) 
            translate([hw/4+3*hl/2,0]) square([hw/2+3*hl,2*hl], center=true); 
    }
    for( j=[1:nscrew] )
    {   rotate(180+j*360/nplate) difference()
        {   union()
            {   translate([hw/4+hl,0]) square([hw/2+2*hl,2*hl], center=true); 
                translate([hw/2+2*hl,0]) circle(hl);
            }
            translate([hw/2+2*hl,0]) circle(sr);
        }
    }
}

module acceptor_component(sr, nscrew,nplate)
{
    translate([0,0,2*hl]) scale([1,1,-1]) acceptor(2*hl,hl/2);
    linear_extrude(height=hl) difference()
    {   acceptor_component_extra(sr, nscrew,nplate);
        translate([-hw/2-hl,-hw/2-hl]) rounded_square(hw+2*hl,hw+2*hl, r);
    }
}

acceptor_component(1.2,0,1);
//acceptor(2*hl,hl);
