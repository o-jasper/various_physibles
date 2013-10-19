//
//  Copyright (C) 19-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

//Screws go into the smaller hole to push down the top of the pfte tube that 
// enters the j-head.
module pusher_whole(srr=sr+t/2)
{
    difference()
    {   linear_extrude(height=3*t) difference()
        {   union()
            {   for( x=(r+d+sr)*[1,-1] ) translate([x,0]) circle(srr);
                intersection()
                {   scale([(r+d+t/2+2*sr)/(5*r),(rt+t/2)/(5*r)]) circle(5*r);
                    difference()
                    {   scale([1,1/2]) circle(rt+d+t+2*sr);
                        circle(r);
                    }
                }
            } //Screw holes.
            for( s=[1,-1] ) translate([s*(r+d+sr),0]) circle(sR);
        }
        translate([0,0,2*t]) cylinder(r=rt,h=l);
        translate([0,0,-l]) cylinder(r=rt,h=l+t);
    }
}
//Splits the j-head in two, for quicker removal of top part.
module pusher_cut()
{
    z=1.5*t;
    d=sqrt(2)*rt;
    intersection()
    {   union()
        {   translate([0,0,z]) rotate([45,0,0]) cube([8*w,d,d],center=true);
            cube([8*w,8*w,2*z],center=true);
        }
        cube([8*w,8*w,2*z+0.9*t],center=true);
    }
}

module pusher_bottom()
{   intersection()
    {   pusher_whole();
        pusher_cut();
    }
}
module pusher_top()
{   rotate([180,0,0]) difference()
    {   pusher_whole(srr=wr+t/2);
        pusher_cut();
        for( x=(r+d+sr)*[1,-1] ) translate([x,0])  //Side entry of screws.
        {   translate([0,0,2.5*t]) cylinder(r=wr,h=8*t);
            translate([0,4*t]) cube([2*sR,8*t,8*t],center=true);
        }
    }
}
pusher_whole();

