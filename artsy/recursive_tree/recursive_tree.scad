//
//  Copyright (C) 06-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Inspired from http://www.thingiverse.com/thing:4787
// which was by thingiverse user tc_fea; Tony Cervantes
//
//Intention it is vase-printable.(expect it to be)

t=2;
div=1.6;
sub=0;
a=45;
sa=5;
adiv = 1;

module frac(n,r,a=a)
{
    if( n>0 && r>0 ) union()
    {
        translate([r/2,0]) square([r,t],center=true);
        translate([r,0]) 
        {   circle(t/2);
            rotate(a) frac(n-1,(r-sub)/div,(a+sa)/adiv,  
                           t=t,div=div,sub=sub,a=a,sa=sa, adiv=adiv);
            rotate(-a) frac(n-1,(r-sub)/div,(a+sa)/adiv, 
                            t=t,div=div,sub=sub,a=a,sa=sa,adiv=adiv);
        }
    }
}

module treeform()
{
    R=35;
    translate([0,0,70-R]) intersection()
    {   scale([1,1,1.2]) sphere(R);
        translate([0,0,-R]) cylinder(r1=R/3,r2=1.5*R,h=2*R);
    }
    translate([0,0,-R/2]) sphere(R);
}

module dbl_recursive()
{   for(a=[0:90:270]) rotate(a) frac(5,15);
    for(a=[0:90:270]) rotate(a+45) frac(3,7);
}

module recursive_tree()
{
    intersection()
    {
        linear_extrude(height=70) dbl_recursive();
        union()
        {   difference()
            {   treeform();
                for(a=[0:90:270]) rotate(a+45) //Makes sure it doesnt have to hover
                   translate([0,15,18]) rotate([-90,0,0]) cylinder(r=10,h=100,$fn=4);
            }
            intersection()
            {   cylinder(r=35,h=3);
                scale([1,1,0.3]) sphere(35);
            }
        }
    }
}

module recursive_cupoid()
{
    intersection()
    {
        linear_extrude(height=70) dbl_recursive();
        union()
        {   sphere(35);
            intersection()
            {   translate([0,0,60]) scale([1,1,1.2]) sphere(35);
                cylinder(r=40,h=50);
            }
        }
    }
    translate([0,0,10]) cylinder(r1=0, r2=30,h=40);
    intersection()
    {   translate([0,0,60]) scale([1,1,1.2]) sphere(30);
        cylinder(r=40,h=50);
    }
}

module recursive_spheroid()
{
    rc = 23; s = 27/23;
    intersection()
    {   union()
        {   linear_extrude(height=70,twist=90) dbl_recursive();
            translate([0,0,25]) scale([s,s,1]) hull()
            {   sphere(rc);
                translate([0,0,10]) sphere(rc);
            }
        }
        difference()
        {   translate([0,0,25]) scale([1,1,0.8]) sphere(35);
            translate([0,0,25]) scale([s,s,1])
            {   sphere(rc-t);
                cylinder(r=rc-t,h=70);
            }
            translate([0,0,40]) cylinder(r=100,h=100);
        }
    }
}

recursive_tree();
//recursive_spheroid();
//recursive_cupoid();

