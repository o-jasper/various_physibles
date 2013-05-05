//
//  Copyright (C) 28-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

pr=75; 
er = 10;

lr = 20;   //radius of lead.
ll = 1050; //length of lead.
//slr = 15;  //small radius of lead(not used)

tl = ll/2; //..top

scr = 2*lr/3; //Cut radius of screw.
scd = lr/18; //Extra room for screw.
scR = pr - lr -scd;
sch = 300;

sca = 360; //Screw total angle.
scn = 1*pr/scr; //Number of them.(3 is lower than pi to give it some room.)

inf = 2*ll;

module screws(R)
{
    color([0,0,1]) 
        {   linear_extrude(height=sch, twist=sca) 
                for( a=[0:360/scn:360] )
                    rotate(a) translate([R,0]) circle(scr);
            for( a=[0:360/scn:360] )
                    rotate(a+sca) translate([R,0,sch-1]) cylinder(r1=scr,h=2*scr);
        }
    cylinder(r=R, h=sch+2*scr);
}

module _bottom(R,z,mr)
{   difference()
    {   union()
        {   screws(R);
            translate([0,0,sch+2*scr])
            {   cylinder(r1=R,r2=mr, h=z);
                translate([0,0,z]) cylinder(r2=R,r1=mr, h=scR);
                translate([0,0,z+scR]) cylinder(r1=R,r2=mr, h=scR);
            }
        }
        rotate_extrude()
        {    polygon([[0,0],[scR,-sch],[scR,0],[lr,sch/2],
                      [1.5*lr,sch/2+lr],[lr,sch/2+2*lr], [2*lr,8*sch], [0,8*sch]]);
        }
    }
}

ir= 0.95*pr;

module _top()
{   rotate_extrude() difference()
    {   union()
        {   intersection()
            {   square([pr,ll-tl]);
                translate([0,ll/2]) scale([1,6*ll/pr]) circle(pr);
            }
            translate([0,ll-tl]) scale([pr/tl,(tl+pr/3)/tl]) circle(tl);
            }
        translate([0,2*ll]) square(ll*[2,2],center=true);
        translate([0,-ll]) square(ll*[2,2],center=true);
        translate([0,ll/4]) scale([1,ll/(ir*2)]) circle(ir);
    }
}
module top()
{   
    z=scR + sch/2;
    tz = sch+2*scr+z+2*scR;
    screws(scR+scd);
    translate([0,0,tz]) difference()
    {   scale([1,1,(ll-tz+pr/4)/pr]) sphere(pr);
        translate([0,0,2*ll-tz]) cube(ll*[2,2,2],center=true);
        rotate_extrude() 
            translate([pr,1.3*sch+2*scR-tz]) 
            scale([1,3]) rotate(45) square((pr-scR+scd)*[1,1]/sqrt(2),center=true);

    }
}
//translate([scR,1.3*sch+2*scR]) rotate(45) square(scR*[1,1],center=true);

module bottom()
{   _bottom(scR,scR,scR/2); }

top();
//translate([-2*pr,0]) _bottaom(scR, scR + sch/2 ,scR/2+scd);

translate([2*pr,0]) bottom();
