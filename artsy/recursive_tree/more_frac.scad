//
//  Copyright (C) 06-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Some experimentation, now also 'tubie' trees, and more randomized trees.

t=2;
div=1.6;
sub=0;
a=45;
sa=5;

ar=70;
module frac3d(n,r,a=a)
{
    if( n>0 && r>0 ) union()
    {
        cylinder(r=t/2, h=r);
        translate([0,0,r]) rotate(ar)
        {   sphere(t/2);
            rotate([a,0,0]) frac3d(n-1,(r-sub)/div,a+sa, t=t,div=div,sub=sub,a=a,sa=sa);
            rotate([-a,0])  frac3d(n-1,(r-sub)/div,a+sa, t=t,div=div,sub=sub,a=a,sa=sa);
        }
    }
}

frac3d(10,5,div=1.2,a=40,sa=20,ar=30,t=2);

rma = 10;
rml = 5;
rmml = -5;

module rfrac(n,r,a=a)
{
    a1 = rands(0,rma,1)[0];
    a2 = rands(0,rma,1)[0];
    l = r + rands(rmml,rml,1)[0];
    echo(l);
    if( n>0 && l>0 ) union()
    {
        translate([l/2,0]) square([l,t],center=true);
        translate([l,0]) 
        {   circle(t/2);
            rotate(a+a1) rfrac(n-1,(l-sub)/div,a+sa,  t=t,div=div,sub=sub,a=a,sa=sa);
            rotate(-a-a1) rfrac(n-1,(l-sub)/div,a+sa, t=t,div=div,sub=sub,a=a,sa=sa);
        }
    }
}

w=50;

module rfrac_linex()
{   rotate([0,-90,0]) translate([0,0,-w/2]) linear_extrude(height=w) rfrac(7,10,30,div=1.2); }

* intersection()
{   union()
    {   rfrac_linex();
        rotate(90) rfrac_linex();
    }
    difference()
    {   sphere(40);
        sphere(35);
    }    
}
