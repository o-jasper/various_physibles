//
//  Copyright (C) 05-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

// 5mm pole system between wall and plank.

$fs=0.4;

pt  = 20.2; //Plank thickness.
wd = 6; //minimum distance to wall.

dz = 40; //Distance the clamp is lower that the plank.

gl = 20; //Wall grab length.

t=5; //Thicknesses.

al = 5;

wrl = 4*al; //Length of wall receiver profile. (holes are added as fits.)

module wall_receiver_profile()
{
    tx = wd+gl;
    bw = 2*t+2.5*al;
    difference()
    {   union()
        {   square([tx-t/2, pt+2*t]); //Main around plank.
            translate([0,t/2]) square([tx, pt+t]);
            translate([tx-t/2,t/2]) circle(t/2);
            translate([tx-t/2,pt+3*t/2]) circle(t/2);
            
            square([2*t, pt+dz]); //Reaches to clamp section.
            translate([0,pt+dz]) square([bw,5*al-bw/2]);
            translate([bw/2,pt+dz+5*al-bw/2]) circle(bw/2);
        }
        translate([wd,t]) square([2*gl,pt]);
    }
}

module wall_receiver()
{
    tx = wd+gl;
    bw = 2*t+2.5*al;
    difference()
    {   linear_extrude(height=wrl) wall_receiver_profile();
        for( y=[al:2*al:wrl-al] )
            translate([bw-al,2*(pt+dz),y]) rotate([90,0]) cylinder(r=al/2,h=1.2*(pt+dz));
    }
}

//Bar receiver with two bars. For instance to go onto the wall receiver.
brl = 16*al;

module bar_receiver()
{
    sf1 = 1.05; sf2=1.02;
    difference()
    {   union()
        {   linear_extrude(height=t)
            {   circle(al);
                translate([brl/2-al,0]) square([brl-2*al,2*al],center=true);
                translate([brl-2*al,0]) circle(al);
            }
            cylinder(r=al/(2*sf1), h=5*al);
            translate([brl-2*al,0]) cylinder(r=al/(2*sf1), h=5*al);
            translate([sf2*al,-al]) cube([brl-(2+2*sf2)*al,al,5*al]);
        }
        for( x=[2*al:2*al:brl-4*al] ) translate([x,0]) cylinder(r=al/2, h=6*al);
    }
}

bar_receiver();
//wall_receiver();
