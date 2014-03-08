//
//  Copyright (C) 22-09-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//TODO terribly missing: holders for the thingy.

//$fs=0.1; Bleh 

$fn=60;

//For reprappro mendel(~prusa 2), Tiny carriage with one quick fit.

include<o-jasper/nut.scad>

t=4; //Thicknesses

s=0.6; //Extra space around.

srr = 4.5+s; //Smooth rod radius.

lbr = 7.5+s;  //Linear bearing radius. (15mm diam bearing)
lbl = 25; //.. length
lbd = 70; //.. distance between smooth rods.

sw = 40 +2*s; //Slot width.
sl = 80 +2*s;//lbd+2*lbr; //Slot length.
sh = 5 +2*s; //Slot height.

l = max(sw+2*t, 1.5*lbl); //(resulting)length(along smooth rods, actually w>l)
w = lbd+2*(lbr+t);      //(...)width
h = 2*lbr+sh + 2*t;   //(...)height

lock_handle=4;

csh=2*sh+t+s; //Height at which to split the carriage.

///Reiterate all the sizes.
hold_block_size = [sl-s, sw-s, sh-s];       //Profile used for holding on to it.
free_block_size = [w-4*(lbr+t), sw-s, h-t]; //Volume and area above this free for use.

echo("hold_block size ", hold_block_size);
echo("free size ", free_block_size);  //TODO increased slightly.
module hold_block()
{   color([1,0,0]) translate([0,0,2*lbr+t+sh/2]) cube(hold_block_size, center=true); }
module free_block()
{   color([0,0,1]) translate([0,0,t/2+h/2]) cube(free_block_size, center=true); }

//free_block();
//hold_block();

with_tierib = false;
//extra_attach

bx = 15;  //Timing belt distance
bt = 1.7;   //Accounted thickness.
bz = 15;
bw = 5+0.5;   //... width.
bp = 2.5; //.... pitch
bhl= 20;  //length to hold it
bhz = lbr -3*t/4 + bz+bt;

module main()
{   linear_extrude(height = h) difference()
    {   square([w,l],center=true);
        intersection()
        {   square([w-4*(lbr+t),sw],center=true);
            translate([0,-sw/2]) circle(sw);
            translate([0,+sw/2]) circle(sw);
        }
    }
}

//Stuff for holding in the linear bearing with tie ribs. (defaultly disabled)
module tierib_cut()
{
    ww=3;
    wh = 1.5;
    rotate([90,0]) translate([0,0,-ww/2]) linear_extrude(height = ww) union()
    {   difference()
        {   union()
            {   circle(lbr+wh);
                translate([0,-2*lbr]) square((lbr+wh)*[2,3],center=true);
            }
            circle(lbr);
            translate([0,-2*lbr]) square([2*lbr,3*(lbr+wh)],center=true);
        }
        intersection()
        {   circle(lbr+wh);
            rotate(45) square(lbr*[4,4]);
        }
    }
}

//NOTE the belt holder does not tighten the be belt just holds it.
// Use separate item.
module belt_holder_profile()
{
    x= bhl-t/2; y= bw+t;
    translate(-[x,t+bw]/2) difference()
    {   union()
        {   minkowski()
            {   translate([-t/2,t/2]) square([bhl+t/2,bw]);
                circle(t/2);
            }
            for(rx= [0,x]) translate([rx,0]) circle(t);
                translate([x/2-t,y-t]) square([2*t,t/2+bx - lbr]);
        }
        for(rx= [0,x]) translate([rx,0]) circle(sr);
    }
}
module belt_holder_top()
{
    x= bhl-t/2; y= bw+t;
    rotate([90,0,0]) difference()
    {   rotate([90,0,0]) linear_extrude(height=t) belt_holder_profile();
        translate([0,0,-bw/2.5]) //linear_extrude(height=bw) 
            for(x=[-bhl/2-t:bp:bhl/2+t]) translate([x,0]) cylinder(r=0.45*bp, h=bw);
    }
}

module main_cut()
{
    translate([0,0,2*lbr+t]) //Hole matching block held on to.
        linear_extrude(height = sh) square([sl,sw],center=true);
    translate([0,0,t]) //Makes hole bigger above the bottom plate.
        linear_extrude(height = h) square([w-4*(lbr+t),sw],center=true);
    translate([w/2,0,2*lbr+t+sh/2]) //Side you put it in, with the rotating latch.
        linear_extrude(height = h) square([w,sw],center=true);
    
    for(s=[1,-1]) translate([s*lbd/2,-l]) //Hole for linear bearings.
    {   translate([0,0,lbr+t/4]) 
        {   rotate([-90,0]) cylinder(r=lbr,h=3*l);
            if(with_tierib) for( y = [-l/2+lbl/4: (l-lbl/2)/6 : l/2-lbl/4] ) 
                                translate([0,l+y]) rotate([0,-s*100,0]) tierib_cut();
        }
        cube([2*srr,4*l,2*srr],center=true); //Slot smooth rod fits through.
    }
    //Wedge for the timing belt goes in here.
    translate([-w/2,0,bhz]) linear_extrude(height = t+bt+s) 
        square([2*t+4*s,2*t+2*s],center=true);
    
    //Decided it needed more space.
    translate([-lbd/2+t,0,h]) cube([2*t,sw,2*t+sh],center=true);
    
    translate([w/2,0,h]) rotate([0,45,0]) cube([h-bhz,2*w,h-bhz],center=true);
}


rx= w/2+t; ry= 0; //(-l/2+sr+t)*0.5;

//Rotating lock radius.
rlr = rx-w/2 + 2*t+2*lbr-t;

module carriage_belt_holder()
{
    x= bhl-t/2; y= bw; //Belt holder positions.
    
    _r= nt/2+t/2;
    _d= (l + bhl)/4;

    translate([-lbd/2-bx,0,bhz-t]) difference()
    {   union()
        {   linear_extrude(height = t) hull()
            {   translate([y/2+t,0]) square([t,bhl+1.5*t],center=true);
                for(rx= [-x,x]/2) translate([-y,rx]) circle(t);
            }
            for(rx= [-x,x]/4) translate([-y,rx]) 
                              {   sphere(t/3);
                                  rotate([0,90,0]) cylinder(r1=t/3,r2=t,h=y+t);
                              }
        }
        for(rx= [-x,x]/2) translate([-y,rx,-t]) cylinder(r=sr, h=2*h);
    }
}

rlz = 2*lbr+t+sh/2;
module carriage()
{   
    difference()
    {   union()
        {   main();
            translate([rx,ry,rlz-t-nh]) linear_extrude(height = t+nh) //Hinge part.
            {   circle(sr + t);
                translate([-sr-t,0]) square((sr + t)*[2,2],center=true);
            }
            carriage_belt_holder();
        }
        main_cut();
        translate([rx,ry,-t]) //Space for hinge rotation. 
        {   translate([0,0,t+rlz]) cylinder(r=rlr+s, h=h);
            cylinder(r=sr, h=2*h);
            linear_extrude(height=rlz+nh-t/2) nut2d(nt);
        }
        //Dont need overhang over the whole thing.
        translate([0,0,h]) cube([lbd-2*(sr+t),sw,2*(h-bhz)],center=true);
        //Cutting corners
        for(a=[0,180]) rotate(a)
            translate([lbd/2-lbr-t,0,rlz-sh/2]) rotate([0,45,0]) 
                           cube([1.5*t,sw,4*t],center=true);

        //location for screws that hold the split carriage together.
        for(s=[1,-1]) for( y=(bhl/2+2*t)*[1,-1]) 
                          translate([s*w/2,y,h-csh/2])  //TODO better height
                              rotate([0,s*45+180,0]) 
                              translate([0,0,-lbr]) 
                          {   cylinder(r=sr,h=3*lbr+t);
                              cylinder(r=2*sr,h=lbr+sr*sqrt(2));
                          }
    }
}

module _rotate_lock_wall(r,h)
{
    linear_extrude(height=h) translate([-t/2,t]) hull()
    {   circle(r);
        translate([0,rlr-2*t]) circle(r);
    }
}

use<logos/openhw.escad>

module rotate_lock()
{   difference()
    {   union()
        {   linear_extrude(height = t) difference()
            {   minkowski()
                {   intersection()
                    {   circle(rlr - sR-t);
                        square(rlr*[1,1]);
                    }
                    circle(sR+t);
                }
                circle(sR);
            }
            if( lock_handle==2 || lock_handle==3) _rotate_lock_wall(t/2,2*t);
            if( lock_handle==2 ) _rotate_lock_wall(t/3,2.2*t);
            if( lock_handle==4 ) linear_extrude(height=1.2*t) 
                                     rotate(-45) translate([0,0.4*rlr]) oshw_logo_2d(rlr);
        }
    }
    if( lock_handle==1 ) translate([0,rlr-t,0])  //(ugly imo)
    {   cylinder(r=t*0.6,h=3*t);
        translate([0,0,3*t]) sphere(0.6*t);
    }
}

module assembled()
{   carriage();
    translate([rx,ry,2*lbr+t+sh/2]) rotate(-225) color([0.8,0.6,0.2]) rotate_lock();
    translate([-lbd/2-bx,0, bhz]) 
       rotate(-90)rotate([180,0]) color([1,0,0]) belt_holder_top();
}

module carriage_split()
{
    translate([0,0,h]) cube([2*w,2*w,csh],center=true);
    translate([0,0,h]) cube([2*t,2*w,csh+2*t],center=true);
    difference()
    {   for(x=[w,-w]/2) translate([x,0,h-csh/2]) 
                            rotate([0,45,0]) cube([2*t,2*w,2*t],center=true);
        translate([0,0,h]) cube([2*w,bhl+2*t,l],center=true);
    }
}

//assembled();
module split_carriage_bottom()
{   difference()
    {   carriage();
        carriage_split();
    }
}
module split_carriage_top()
{   intersection()
    {   carriage();
        carriage_split();
    }
}
//rotate([0,180,0]) split_carriage_top();
rotate([0,180,0]) split_carriage_bottom();

//belt_holder_top();
