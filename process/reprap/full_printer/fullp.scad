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
use<plates.scad>;

//TODO fix this link...
use<pulley.scad>

module show(bed_z=h/2,$realnema=false)
{    
    $show=true;
   //Bottom corners.
    for(z=bbr*[0,-2]) translate([0,w/2-zrd+bbr,h-(bbr+bt+t)+z]) rotate([90,0,0]) 
        color("green") cylinder(r=sbr,h=w-2*zrd); //x rod
    
    for(a=[0,180]) rotate(a)
        {   
            rotate(90) translate([-l/2+0.2,-w/2+0.2])
            {   bottom_motor_corner(); //NOTE: bottom corners the same for simplicity
                translate([0,0,h]) rotate(90) rotate([180,0,0]) 
                {   top_bare_corner();
                    color("blue") translate([0,0,bt]) belt_corner_block();
                }
            }
            translate([-l/2+0.3,-w/2+0.3]) 
            {   bottom_motor_corner();
                translate((pt+t/2+sw/2)*[1,1,0]+[0,0,sh]) nema();
                
                translate([zrd+bbr+t/2,zrd,h-(bbr+bt+t)]) rotate([0,90,0]) 
                    color("green") cylinder(r=bbr,h=l-bbr-zrd); //y rods
                translate([0,0,h]) rotate(90) rotate([180,0,0]) 
                {   top_motor_corner();
                    color("blue") translate([0,0,bt]) belt_corner_block(a=90);
                }
            }
            
            rotate(90)
            {   translate([l/2-pt,-w/2,0]) color("blue") side_plate();
                translate([l/2-pt,-w/2,0]) rotate(90) color([0.4,0.4,0.9]) side_plate();
            }
            translate([zrd-w/2,zrd-l/2]) 
            {   translate([0,0,bed_z]) if(a==0)
                {   bed_holder(); } else{ bed_holder_w_motor(); }
                color("purple") translate([0,0,bed_z+pz]) pulley_pos() 
                    cylinder(r=1,h=h-bed_z-phz-pz);
                
//                if(rod_adjustable) color("red") translate([-zrd,-zrd,h]) zrod_holder();
                color("green") cylinder(r=bbr,h=h+2*bt);//h+fh); //z rods
            }
            translate([-bw/2,-bw/2,bed_z+fh]) cube([bw,bw,bh]); //Bed itself.
        }
}


show();

module bed_n_corner_show(bed_z=-3*fh)
{
    translate([zrd,zrd]) 
    {   color("red") translate([0,0,bed_z]) bed_holder();
    }
    translate([0.3,0.3]) rotate(90) rotate([180,0,0]) 
    {   top_motor_corner();
        color("blue") translate([0,0,bt]) belt_corner_block(a=90);
    }
    translate([zrd,zrd,-100]) pulley_pos() cylinder(r=1,h=200);

}

//bed_n_corner_show();
