//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>;
use<corner.scad>;
use<bed.scad>;
use<arm.scad>

module show(a=min_a+(max_a-min_a)*$t)
{    
    bed_z = bed_z(a);//
   //Bottom corners.
//    translate([0,0,-bt]) for(a=[0:90:270]) rotate(a) translate([-w/2,-l/2]) corner();
    for(z=bbr*[0,-2]) translate([0,w/2-zrd+bbr,h-(bbr+bt+t)+z]) rotate([90,0,0]) 
        color("green") cylinder(r=sbr,h=w-2*zrd); //x rod
    
    for(a=[0,180]) rotate(a)
        {   
            rotate(90) translate([-l/2+0.2,-w/2+0.2])
            {   corner();
                translate([0,0,h]) rotate(90) rotate([180,0,0]) xrod_corner();
            }
            translate([-l/2+0.3,-w/2+0.3]) 
            {   zrod_bcorner();
                translate([zrd+bbr+t/2,zrd,h-(bbr+bt+t)]) rotate([0,90,0]) 
                    color("green") cylinder(r=bbr,h=l-bbr-zrd); //y rods
                translate([0,0,h]) rotate(90) rotate([180,0,0]) zrod_tcorner();
                translate([pt+t,zrd+bbr+t,h-45-t-10]) color("grey") cube(45*[1,1,1]);

            }
            
            rotate(90)
            {   translate([l/2-pt,-w/2,0]) color("blue") side_plate();
                translate([l/2-pt,-w/2,0]) rotate(90) color([0.4,0.4,0.9]) side_plate();
            }
            translate([zrd-w/2,zrd-l/2]) 
            {   color("red") translate([0,0,bed_z]) bed_holder();
                if(rod_adjustable) color("red") translate([-zrd,-zrd,h]) zrod_holder();
                color("green") cylinder(r=bbr,h=h+2*bt);//h+fh); //z rods
            }
            translate([-bw/2,-bw/2,bed_z+fh]) cube([bw,bw,bh]); //Bed itself.
        }
    translate([w/2-adx,w/2-adx,ah/2-t]) 
        rotate(225) rotate([0,-a,0]) translate([0,aw/2]) rotate([90,0,0]) color("purple")
    {   translate([ad,0]) rotate(180-2*a) top_arm();
        translate([0,ah/2]) color("red") bottom_arm();
    }
}

show((min_a+max_a)/2);

echo(h);
