//Author: Jasper den Ouden
//This one is public domain

l=70;
t=10;

scale([1,1/7,1/7]) intersection()
{   union()
    {   sphere(l/2);
        rotate([0,-90,0]) cylinder(r=l/2,h=l/4);
        translate([-l/4,0]) scale([1/2,1,1]) sphere(l/2);
    }
    difference()
    {   cube([l,l,l/2], center=true);
        translate([0,0,-l]) cylinder(r=l/2-t,h=3*l);
        translate([-l,0]) cube([2*l,l-2*t,l], center=true);
    }
}
