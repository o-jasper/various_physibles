//
//  Copyright (C) 10-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Adds a new handle to conical cups.
//Note that it doesnt have anything not to fall down, just the clamping force of
// you make the radii slightly smaller. (and when you're holding it the conical shape)
// (could also just a use little bit of double sided tape)

//TODO find some prevalent cups and apply to them.

$fn=120;

ctr = 42; //Top radius.
cbr = 31; //Bottom radius.
ch  = 107;      //Cup height.

t = 3; //Thicknesses.

cw= 15; //Cut width.(In my case a broken ear in the way) negative to not have one.

h = 20; //Round height.
hdz = 3; //Round distance from top.

hh = ch*50/107; //Handle height. (Note: the match is to
hd = ch*20/107; //... distances from end(roughly)
hw= (ctr+cbr)*15/73;  //Width.
hea = 20; //Extra angle for looks.
ht = 1.2*t; //Thickness to give 

module handle(a)
{
    inf=8*(ch+ctr+cw+hh+hd);
    intersection()
    {   rotate([0,a+hea,0]) difference() //Handle
        {   scale([hd/hh,hw/(2*hh),0.6]) sphere(hh);
            intersection()  //Takes out for fingers.
            {   color("red") scale([hd-t,(hw-t)/2,(0.6*hh-t)]/hh) 
                    rotate([90,0,0]) translate([0,0,-inf]) cylinder(r=hh-t,h=2*inf);
                //Add back a cylinder following the side of the cup.
                rotate([0,-hea,0]) color("cyan") rotate([0,-a,0]) difference()
                {   rotate([0,-a,0]) translate([ch,0]) 
                        cube([inf,ch/2,hh-2*ht],center=true);
                    translate([-t,0,-hh/2]) rotate([0,a,0]) 
                        scale([t/hw,1/4]) cylinder(r=hw,h=inf);
                }
            }
        }
        cube([inf,ch,hh],center=true);
    }
}

module cup_handler()
{
    inf=8*(ch+ctr+cw+hh+hd);
    z = ch-h/2-hdz;
    f = z/ch;
    r = f*cbr + ctr*(1-f)+2.5*t;
    a = atan((ctr-cbr)/ch);
    rotate([180,0,0]) difference()
    {   translate([0,0,z]) union()
        {   rotate_extrude() translate([r,-h/2]) intersection()
            {   rotate(-a) scale([t/h,0.55]) circle(h);
                square([inf,h],center=true);
            }
            translate([r,0,-hh/2]) handle(a, hh=hh,hw=hw,hd=hd,t=t,ch=ch,hea=hea);
        }
        cylinder(r1=cbr,r2=ctr,h=ch);
        if(cw>0) translate([-cw/2,0]) cube([cw,2*ctr,5*ch]);
    }
}

module cup_handler_42_31_107(){ cup_handler(); }

//TODO ctr=35, cbr=25, cbh=79 for one of joris 
// http://www.thingiverse.com/joris/ weekly cups 
// (NOTE: do NOT assume food/drink compatibility)

//TOD those plastic cups.

module just_show()
{   color("blue") cylinder(r1=cbr,r2=ctr,h=ch);
    rotate([180,0,0]) cup_handler();
}

just_show();
