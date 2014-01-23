//
//  Copyright (C) 07-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fn=60;

ball_r = 3;
ball_e = 0.05;

eh=1;

sh=0.6;
r = ball_r + ball_e;
s=0.7*r;
n=12;

ss=0.5;

t=s;

R = n*(r+0.5)/3.14;
Ro = R+r+2*t;
h=2*(r+t); //NOTE not actual height. (+eh)

sr=1;

with_guide=true; //Guiding plate.

anti_sag_a=50;

module path(anti_sag=false)
{   rotate_extrude() translate([R,r+t]) 
    {   circle(r); 
        if(anti_sag) rotate(anti_sag_a) translate([r,0]) square(2*[r,r],center=true);
    }
}

module inner()
{
    difference()
    {   linear_extrude(height=h) difference()
        {   circle(R-s/2);
            square((R-r)*[1,1],center=true);
        }
        path(true);
    }
}
module outer()
{
    difference()
    {   linear_extrude(height=h+eh) difference()
        {   circle(Ro);
            circle(R);
        }
        if(with_guide)
            translate([0,0,r+t-sh]) cylinder(r=R+r+s+ss, h=2*sh);
        path();
    }
}
module guide()
{
    linear_extrude(height=sh) difference()
    {   circle(R+r+s);
        circle(R);
        for(a= [0:360/n:360]) rotate(a) translate([R,0]) circle(r+2*ss);
    }
}
module outer_half_vertslide(with_guide=with_guide)
{   intersection()
    {   outer(with_guide=with_guide);
        difference()
        {   union()
            {   cube([8*Ro,8*Ro,h+eh],center=true);
                for(a=[90,270]) rotate(a) translate([Ro,s]) cube(2*[s,Ro,h+eh/2],center=true);
            }
            for(a=[0,180]) rotate(a) translate([Ro,s]) cube(2*[s,Ro,h+eh/2],center=true);
        }
    }
}

//Note showing currently the 'vertslide' approach.
module as_show(a=0,as_assembled=false)
{
    outer_half_vertslide(with_guide=with_guide);
    if(as_assembled) translate([0,0,h+eh/2]) rotate(90) rotate([0,180,0]) 
                         outer_half_vertslide(with_guide=with_guide);
    inner();
    rotate(a)
    {   if(with_guide) translate([0,0,r+t-sh/2+eh/2]) guide();
        for(a=[0:360/n:360]) rotate(a) 
            translate([R,0,r+t+eh/2]) color("red") sphere(ball_r);
    }
}

module as_assembled(a=0)
{   as_show(a,true, with_guide=with_guide); }

module vertslide_show()
{
    difference()
    {   as_assembled();
        for(a=[180,210-180/n]) rotate(a) cube(R*[8,8,8]);
    }
}

module vertslide_as_print()
{
    translate([2*Ro,0]) outer_half_vertslide(with_guide=with_guide);
    translate([0,2*Ro]) outer_half_vertslide(with_guide=with_guide);
    inner();
    if(with_guide) translate([-2*Ro,0]) guide();
}

//vertslide_show();
//outer_half();

//Different ways of using this below:
//
//* Slide bearing together vertically, with guide: 
//  => outer_half_vertslide + inner (guide disabled below)

//* Slide vertically togeter, no guide: (untested)
//  => inner +
module vert_slide_no_guide()
{   outer_half_vert_slide(with_guide=false); }

//* Inserting balls half way. (No guide possible) (untested)
module insert_halfway()
{   union()
    {   inner();
        outer(with_guide=false); //Cannot have a guide at this point.
    }
}

//* Pair of half ring that clips around and onto each other: (untested)
//  => inner + guide + (can also be done without guide but not provided)
module _ring_sub(f=0.3)
{
    r1=Ro-f*(h+eh);
    r2= Ro-t/2;
    union()
    {   cylinder(r1=r1,r2=r2, h=(h+eh)/2);
        translate([0,0,(h+eh)/2]) cylinder(r1=r2,r2=r1, h=(h+eh)/2);
        translate([0,0,-h]) cylinder(r=r1,h=8*(h+eh));
    }
}

module outer_half_ringclip()
{   intersection()
    {   outer();
        cube([8*Ro,8*Ro,h+eh],center=true);
        _ring_sub();
    }
}

module ringclip()
{
    dx= Ro/8;
    d= sqrt(2)*((h+eh)/2 +dx);
    intersection()
    {   difference()
        {   cylinder(r=Ro,h=h+eh);
            _ring_sub();
        }
        rotate([90,0,0]) translate([0,0,-2*Ro]) linear_extrude(height= 8*Ro) difference()
        {   union()
            {   square([Ro,h+eh]);
                translate([-dx,0]) rotate(45) square([d,d],center=true);
            }
            translate([dx,h+eh]) rotate(45) square([d,d],center=true);
        }
    }
}

module ringclip_show()
{   ringclip();
    translate([-0.1,0.1,h+eh+1]) rotate(180) rotate([180,0,0]) color("blue") ringclip();
    translate([0,0,2*h]) outer_half_ringclip();
}
//ringclip_show();

//* Single ring that clips around: (untested)
//  => inner + guide + (can also be done without guide but not provided)
module ringclip_one_cut()
{   difference()
    {   cylinder(r=Ro,h=h+eh);
        _ring_sub();
        translate([-t/2,0]) cube([t,8*Ro,8*h]);
    }
}

//* Complete outer ring but cut in center. (link to example)
