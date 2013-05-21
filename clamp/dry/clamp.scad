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

h=10; //Height.(thickness)

t= 5; //Thicknesses generally.

fil_r = 1;

l=60; //Total length.
hx=l/2; //Hinge position.

gl= 20; //Gap length.

zl = 2; //Tooth zigzag length.
zd = 2; //... depth

fw=20; bw=30; //Front and back width/
fr=15;  br=10;  //Rounded lengths front and back.

f = hx/l; //Fraction of the way.
r = (1-f)*bw/2 + f*fw/2 - 1.5*t;

sw = max(20,hx-r-t); //Spring width.

fd = (hx-r-t/8)/l;
yd = (1-fd)*bw/2 + fd*fw/2 - t;

fb = (hx-r-t/8-sw)/l;
yb = (1-fb)*bw/2 + fb*fw/2 - t;

sl = 4*yb;

//Adds a tube for the spring guide to go through. Probably a bad idea.
//Incompatible with using the provided plastic spring.
spring_guide=false;

//`which` makes sure the teeth mesh.
module clamp_base_profile(which)
{
    difference() //TODO the polygon approach sucks a bit.
    {   union()
        {   translate([l-fr,0]) scale([fr/fw,1/2]) circle(fw); //Front curve.
            translate([br,bw/2-br]) circle(br);   //Back curve.
            square([br,bw/2-br]);
            polygon([[l-fr,0],[l-fr,fw/2],[br,bw/2],[br,0]]); //Main shape.
        }
        difference()
        {   polygon([[l,0],[l,fw/2-t],[0,bw/2-t],[0,0]]); //Get top piece.
            translate([hx,0]) square([l,l]); //Mouth.
        }
        if( gl>0 ) 
            translate([hx+0.6*r+gl/2,0]) scale([1/2,r/gl]) circle(gl); //Gap to the teeth
        translate(2*[-l,-l]) square(l*[4,2]); //Cut off y<0
    //Dip for holding (printed) spring.
        translate([fd*l,yd]) square([t/1.5,t/1.8],center=true); 
        if( zd>0 ) for( x= [hx+r+0.6*gl - (which ? -zl/2 : zl) : zl : l] )
            translate([x,0]) rotate(45) scale([1,zd/zl]) square([zl,zl]/sqrt(2), center=true);
        translate([(fb-1)*l-t/2,0]) square([l,l]);
    }
    translate([fb*l,yb]) circle(t/2); //Bump for for holding (printed) spring.
}

module clamp_male_profile()
{
    scale([1,-1]) difference()
    {   union()
        {   clamp_base_profile(false);
            translate([hx,0]) difference()
            {   circle(r); 
                polygon([[-t/4,0], [t/2,0], [t,r], [-2*r,r]]);
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

module hring(a)
{
    translate([hx,0]) rotate(a) difference()
    {   rotate_extrude() translate([r,h/2]) circle(r/4);
        translate([-2*r,0,-h]) cube([4*r,2*r,3*h]);
    }
}

module clamp_female()
{
    f=(fb+fd)/2;
    y= bw*f + fw*(1-f);
    difference()
    {   union()
        {   linear_extrude(height=h) clamp_female_profile();
            hring(220);
            if( spring_guide )
                translate([f*l,y/8,h/2]) rotate([-90,0]) cylinder(r=2*fil_r, h=3*y/8+t/2);
        }
        translate([(fb+fd)*l/2,0,h/2]) rotate([-90,0]) cylinder(r=fil_r, h=l);
    }
}

module clamp_male()
{
    scale([1,-1]) difference()
    {   linear_extrude(height=h) scale([1,-1]) clamp_male_profile();
        translate([(fb+fd)*l/2,0,h/2]) rotate([-90,0]) cylinder(r=fil_r, h=l);
        hring(0);
        hring(-40);
    }
}
//rotate([-90,0]) rotate(-atan((fw-bw)/(2*(l-t)))) clamp_female();
//clamp_base_profile(true);
module plastic_spring_profile(sw=sw, sl=sl, step=sw/4,t=-1)
{   d= step;
    t = (t<0 ? d/2 : t);
    s1 = [sw,  d+t]/(2*d);
    s2 = [sw-2*t,d-t]/(2*d);
    for( y= [d:2*d:sl+d] ) translate([0,y]) difference()
    {   scale(s1) circle(d);
        scale(s2) circle(d);
        translate([-sw,-sw]) square(sw*[1,2]);
    }
    for( y= [2*d:2*d:sl] ) translate([0,y]) difference()
    {   scale(s1) circle(d);
        scale(s2) circle(d);
        translate([0,-sw]) square(sw*[1,2]);
    }
    translate([-sw/2,d/2-t/2])
    {   square([sw/2,t]);
        translate([0,-t]) square([t,2*t]);
    }
    translate([-sw/2,sl-t]) 
    {   square([sw/2,t]);
        square(t*[1,2]);
    }
}
module plastic_spring(sw=sw, sl=sl, step=sw/4,t=-1, h=h)
{
    difference()
    {   linear_extrude(height=h) plastic_spring_profile(sw,sl,step,t,h);
//TODO crab clamp better. (postponed)
//        for(y=[0,sl]) translate([-sw/2,y,h/2]) cube([sw/4,sw/2,h/8],center=true);
    }
}

module as_print(with_spring=true)
{   w = max(fw,bw);
    if(with_spring) translate([l,w]) rotate(90) plastic_spring();
    clamp_female();
    translate([0,-w/2]) color([0,0.6,0]) clamp_male();
}

module as_show()
{
    color([0,0,1]) translate([hx- r - sw/2 +t/8,-yb]) scale([-1,1.8*yb/sl]) plastic_spring();
    clamp_female();
    translate([0,-w/2]) color([0,0.6,0]) clamp_male();    
}

//zas_show();
as_print();
