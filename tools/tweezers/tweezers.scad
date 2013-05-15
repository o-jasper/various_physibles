//Author: Jasper den Ouden
//This one is public domain

l=70;
t=10;

scale([1,1/7,1/7]) intersection()
{   sphere(l/2);
    difference()
    {   cube([l,l,l/2], center=true);
        translate([0,0,-l]) cylinder(r=l/2-t,h=3*l);
        translate([-l,0]) cube([2*l,l/4,l], center=true);
    }
}
