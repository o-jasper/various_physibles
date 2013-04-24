//
//  Copyright (C) 16-04-2013 Jasper den Ouden. (ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

ri = 31/2; //Inner diameter.
ro = 1.7*ri; //Outer .. idem.

t= ri/4; //Thicknesses.

inf=3*ro;

n_attach = 4;  //Number of attachment points.

mr= 15/2; //Radius of marbles.
md = mr/2; //Depth marble track into thing.


rl = mr/sqrt(2)+2*t;
mz = t+rl/2 + (mr-md)/sqrt(2);

mR = ri+rl/2 + (mr-md)/sqrt(2); //Radius the marbles run at.

nh = 8; //hole count(zero for none)
bridge = true; //Bride to tie stuff to.

module holes()
{   if( nh>0 ) translate([0,0,t]) for( i = [1:nh] )
    {   rotate(i*360/nh) rotate([90,0]) cylinder(r=t/2,h=inf); }
}

//On other side of spool.
module bottom()
{
    h = 3*t;
    difference()
    {   union()
        {   cylinder(r1=ri, r2=ro, h=h-t/2);
            translate([0,0,h-t/2]) cylinder(r=ro, h=t/2);
            cylinder(r=ri,h=h+2*t);
        }
        cylinder(r1=ri-t/2,r2=ri-t, h=h);
        cylinder(r=ri-t, h=inf);
        translate([0,0,h]) holes();
    }
    if(bridge) translate([0,0,(h+t)/2])  difference()
    {   cube([t,ri+3*t,h+t],center=true); }
}

module marble_torus()
{   rotate_extrude() translate([mR,mz]) circle(mr); }

module top()
{
    t=2*t;
    h = 2*t;
    difference()
    {   union()
        {   cylinder(r1=ri+rl-t/2,r2=ri+rl,h=t);
            translate([0,0,t]) cylinder(r1=ri+rl,r2=ri+t,h=rl);
            translate([0,0,t]) cylinder(r=ri+t,h=rl+t/4);
            translate([0,0,1.25*t+rl]) cylinder(r=ri, h=t);
        }
        cylinder(r2=ri-2*t,r1=ri+t/2, h=2*t+rl-h);
        cylinder(r=ri-t/2, h=inf);
        marble_torus();
        translate([0,0,1.25*t+rl]) holes();
    }
    if(bridge) translate([0,0,rl+2*t-(h+t)/2])  difference()
    {   cube([t,ri+t,h+t],center=true);
        translate([0,0,-(h+t)/2]) translate([inf,0]) rotate([0,-90]) 
            cylinder(r=ri, h=3*inf);
    }
}

module end()
{
    h = 2*mr + 3*t;
    difference()
    {   union()
        {   cylinder(r1=mR+mr, r2= mR+mr+t, h= h/2);
            translate([0,0,h/2]) cylinder(r2=mR+mr, r1= mR+mr+t, h= h/2);
            for( i = [1:n_attach]) 
            {   rotate(90*i) translate([mR+mr+t,0,h/2]) cylinder(r=mr,h=h/2); }
        }
        marble_torus();
        cylinder(r=ri+t,h=2*h);
        translate([0,0,h/2]) cylinder(r=ro+t,h=2*h);
        for( i = [1:n_attach]) 
        {   rotate(90*i) translate([mR+mr+t,0]) cylinder(r=t,h=3*h); }
    }
}

translate((4*ro+t)*[1,0]) 
{   top();
}

translate((4*ro+t)*[0,1]) bottom();

end();
