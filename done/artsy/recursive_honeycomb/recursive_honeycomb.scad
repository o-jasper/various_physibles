//Created by Jasper den Ouden 11-10-2013, public domain or CC0 whichever you
//prefer

$fn=6;
hdiv=2;
rdiv=2;
Rdiv=2.01;
t=2;

ri=30;
Ri=30;
hi=30;

module recursive_honeycomb(n,R=Ri,r=ri,h=hi)
{   
    rotate(30) difference()
    {   sphere(r*2/sqrt(3));
        sphere(0.95*r*2/sqrt(3));
        translate([0,0,-1.1*r]) cylinder(r=r/1.75,h=2.2*r);
    }
    if(n>0) translate([0,0,-h]) 
    {   recursive_honeycomb(n-1,R/Rdiv,r/rdiv,h/hdiv);
        for(a=[0:60:300]) rotate(a) translate([R,0]) 
                              recursive_honeycomb(n-1,R/Rdiv,r/rdiv,h/hdiv);
    }
}
//(for the makefile)
module recursive_honeycomb_1()
{   recursive_honeycomb(1); }
module recursive_honeycomb_2()
{   recursive_honeycomb(2); }
module recursive_honeycomb_3()
{   recursive_honeycomb(3); }

recursive_honeycomb_2();

