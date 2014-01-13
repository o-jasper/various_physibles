//
//  Copyright (C) 12-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;$fn=40;

$ww=10;
$wh=15;
$wt=2;
$wth=0.8;

module window(w=$ww,h=$wh,t=$wt)
{
    scale([1,h/w,1]) rotate_extrude() translate([w/2,0]) intersection() circle(t/2); 
}

module pod_base(R,l)
{
    rotate_extrude() intersection()
    {   scale([R/l,1]) circle(l);
        translate([0,-l]) square(8*[R,l]);
    }
}

module pod(R=$pR,l=$pl,n=$pn)
{   difference()
    {   pod_base(R,l);
        for( a=[0:360/n:360*(1-1/n)]) rotate(a) translate([2*R-$wt/2,0]) 
                                          cube(2*[R,R,R],center=true);
    }
    intersection()
    {   union() for( a=[0:360/n:360*(1-1/n)]) rotate(a) translate([R-$wt/2,0]) 
           rotate([0,90,0]) rotate(90) window();
        pod_base(R+$wth,l+$wth);
    }
}

module frill_base(dx,h,ty=-1,angle=0)
{
    r_ty = (ty == -1) ? dx*sqrt(2)-dx*sin(angle) : ty;
    rotate_extrude() translate([dx,0]) scale([-1,h/(dx*sqrt(2))]) intersection()
    {   union()
        {   translate([dx,0]) circle(dx);
            translate([dx/sqrt(8),0]) square(dx*[2,2]);
        }
        difference()
        {   square([dx,r_ty]);
            translate(dx*[1-sqrt(2),sqrt(2)]) circle(dx);
        }
    }    
}

$fdx=$ww/sqrt(2); $fdh= 20; $f_n=10;$ft=2;$fd=2; $fth=8;

module frill(dx=$fdx,h=$fdh, n=$f_n,t=$ft,d=$fd,m=$f_m,th=$fth)
{
    frill_base(dx,h);
    intersection()
    {   union()
        {   frill_base(dx+d,h);
            if(th>0) translate([0,0,h]) scale([0.5,0.5,th/dx]) sphere(dx);
        }
        union() for( a=[0:360/n:360*(1-1/n)] ) rotate(a) 
           translate([-t/2,0]) cube([t,8*dx,8*h]);
    }
}

module rocket_bottom(r=$pR,l=$pl,n=4)
{
    intersection()
    {   union()
        {   scale([r,r,l]/l) sphere(l);
            for(a=[0:360/n:360*(1-1/n)]) rotate(a)
                translate([0.6*r,0,-l/2]) scale([1.6*r,r,l]/l) sphere(l/2);
        }
        translate([0,0,0.2*l]) cube(2*[l,l,l],center=true);
    }
}

//translate([0,0,40]) frill();

//pod(10,20,4);
//window(10,20,2,0.6);

module rocket()
{
    translate([0,0,$wh/1.7]) frill();
    pod(10,20,4);
    translate([0,0,$wh+2*$fth+4]) scale([1,1,2]) sphere(3);
}

rocket();
translate([0,0,-30]) rocket_bottom(r=10,l=20);

