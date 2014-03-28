//Author: Jasper den Ouden 20-02-2014
//Placed in public domain.

// Thingy to use wire to sew onto broken pants-belts.

use<logos/openhw.escad>

d=32; sr=2; f=3;
$fs=d/100;

sf=1.5;

module belt_patch()
{   
    intersection()
    {   union()
        {   translate([0,0,-d]) scale([f,1.5,1.1]) sphere(d);
            child(0);
        }
        translate([0,0,-d]) difference()
        {   scale([f/sf,1.5/sf,1]) cylinder(r=d/2,h=8*d);
            for(x=0.2*f*[-d,d]) for(y=0.2*[-d,d]) translate([x,y]) cylinder(r=sr,h=8*d);
            for(x=0.25*f*[-d,d]) translate([x,0]) cylinder(r=sr,h=8*d);
        }
        translate([0,0,4*d]) cube(d*[8,8,8],center=true);
    }
}

module belt_patch_oshw()
{   belt_patch() linear_extrude(height=d/8) oshw_logo_2d(d); }

module belt_patch_nothing()
{    belt_patch() union(); }

belt_patch_oshw();
