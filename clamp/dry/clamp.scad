//
//  Copyright (C) 15-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Idea is to be inspired from http://www.thingiverse.com/thing:89457

$quality=80;
$fs=0.4;

h=5; //Height.(thickness)

t= 5; //Thicknesses generally.

l=60; //Total length.
hx=l/2; //Hinge position.

gl= 0; //Gap length.

zl = 2; //Tooth zigzag length.
zd = 2; //... depth

fw=20; bw=30; //Front and back width/
fr=15;  br=4;  //Rounded lengths front and back.

f = hx/l; //Fraction of the way.
r = (1-f)*bw/2 + f*fw/2 - 1.5*t;

sw = max(20,hx-r-t); //Spring width.

fb = (hx-r-t/8-sw)/l;
yb = (1-fb)*bw/2 + fb*fw/2 - t;

sl = 4*yb;

//`which` makes sure the teeth mesh.
module clamp_base_profile(which)
{
    fd = (hx-r-t/8)/l;
    yd = (1-fd)*bw/2 + fd*fw/2 - t;
    difference()
    {   union()
        {   translate([l-fr,0]) scale([fr/fw,1/2]) circle(fw); //Front curve.
            translate([br,0]) scale([br/bw,1/2]) circle(bw);   //Back curve.
            polygon([[l-fr,0],[l-fr,fw/2],[br,bw/2],[br,0]]); //Main shape.
        }
        difference()
        {   polygon([[l,0],[l,fw/2-t],[0,bw/2-t],[0,0]]); //Get top piece.
            translate([hx,0]) square([l,l]); //Mouth.
        }
        if( gl>0 ) translate([hx+r+gl/2,0]) scale([1/2,r/gl]) circle(gl); //Gap to the teeth
        translate(2*[-l,-l]) square(l*[4,2]); //Cut off y<0
    
        translate([fd*l,yd]) circle(t/4); //Dip for holding (printed) spring.
        for( x= [hx+r+gl - (which ? -zl/2 : zl) : zl : l] )
            translate([x,0]) rotate(45) scale([1,zd/zl]) square([zl,zl]/sqrt(2), center=true);
    }
    translate([fb*l,yb]) circle(t/4); //Bump for for holding (printed) spring.
}

module clamp_male_profile()
{
    difference()
    {   union()
        {   clamp_base_profile(false);
            translate([hx,0]) difference()
            {   circle(r); 
                polygon([[-t/4,0], [t/2,0], [0,r], [-2*r,r]]);
            }
        }
        translate([hx,0]) 
        {   circle(t/5);
            translate([0,t/2]) square([t/3,t],center=true);
            translate([0,t]) circle(t/6);
        }
    }
}

module clamp_female_profile()
{
    translate([hx,0]) rotate(125) 
    {   translate([-t/6,t/6]) circle(t/6);
        translate([-t/6,r]) scale([1,2]) circle(t/6);
        translate([-t/3,t/6]) square([t/3,r-t/6]);
    }
    difference()
    {   union()
        {   clamp_base_profile(true);
            translate([hx,0]) circle(r+t/3);
        }
        translate([hx,0]) union()
        {   circle(r);
            rotate(215) translate([-r-t/3,t/6]) square([4*(r+t),r+t]);
        }
    }
}

module clamp_female()
{
    linear_extrude(height=h) clamp_female_profile();
}

module clamp_male()
{
    linear_extrude(height=h) clamp_male_profile();
}
//rotate([-90,0]) rotate(-atan((fw-bw)/(2*(l-t)))) clamp_female();

//clamp_female();
//translate([0,-bw/2]) scale([1,-1]) clamp_male();

clamp_base_profile(true);
