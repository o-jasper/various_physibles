//
//  Copyright (C) 09-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;

t=5;

rr = 8.9; //9.6/2; //Z-rod radius.
rb = 10; //Horizontal rod radius.
nw = 13.2; // Nut width

dx = 20; //11.1 //Horizonal rod distance
d = 11.1;//rr+rb+2*t;//Distance between rods. TODO
dz=15; //Vertical distance.

feature = false;
al=5; 
sr=1.4;
snw = 6.5/2;
snh= 3.1;

pair_enough=false; //Wether to just have two or as many as wanted half-feature holes.

zt = 1.5*t; //Height of z-rod assocated
xl = 4*al; //Length of nut profile.

hex_from_top=true;
with_slide_profile=true;

inf = 3*(rr+rb+nw);

module z_rod_associated()
{
    hx = dx+2.5*t; 
    x = rr+t+al+t;
    difference()
    {   union()
        {   circle(rr+t); //Round smooth rod.
            translate([0,x]) circle(rr/2+t); //Springy circle
            translate([0,x/2]) square([2*t,x],center=true); //And slot leading to it.

            translate([dx-al,d]) circle(al+t); //Feature hold plate.
            if(feature) translate([dx+x,d]) circle(al+t);
            if(feature)
            {   translate([dx+x/2-al,d]) square([2*(x-al),2*(al+t)],center=true); }
            else
            {   translate([dx+x/2-2*al,d]) square([2*(x-al),2*(al+t)],center=true);
            }
        }
        translate([0,x]) circle(rr/2); //hole in springy

        for( x = [dx-t : 3*al : dx+al+5*t] ) translate([x,d]) circle(al);  //Feature holes.
        circle(rr); //Hole for smooth rod.
        square([rr/2,2*x], center=true); //Slot for clicking on.
        translate([0,-rr-t]) scale([1/2,1]) rotate(45) //Easier opening.
            square(2*[t,t],center=true); 
    }
}

module screws_plate()
{   hl= 2*rb+t+3*sr; //Plate for screws.
    difference()
    {   union()
        {   translate([0,hl/4]) square([3*sr+t,hl/2],center=true);
            translate([0,+hl/2]) circle(3*sr/2+t/2);
        }
        square(2*[al,al],center=true);
        translate([0,+hl/2]) circle(sr);
    }
}

module slide_profile()
{
    translate([0,al/2]) square(al*[2,1],center=true);
    translate([0,3*al/4]) square(al*[3,1/2],center=true);
}


//Slide-on and clamp.
module _bottom()
{
    tz = dz+3*t;
    w=2*(al+t);//3*(rb+t)/2;
    translate([dx,d]) rotate([0,90,0]) linear_extrude(height=xl) difference()
    {   union()
        {   circle(nw/2+t);
            translate([-dz/2,0]) square([dz,w], center=true);
        }
        if( hex_from_top ) translate([nw/2+inf,0]) square(inf*[2,2],center=true);
        if( pair_enough )
        {   for( y=[-al,al] ) translate([al-dz,y])  circle(al/2); }
        else
        {   for( z=[al:2*al:dz-nw/2] )
                for( y=[-al,al] ) translate([z-dz,y])  circle(al/2);
        }
    }
    hx = dx+2.5*t; 
    if(feature)translate([dx+2*al,d,tz-zt-t]) linear_extrude(height=t) screws_plate();
    
    translate([0,0,dz]) linear_extrude(height=zt) z_rod_associated();
}

module bottom()
{
    bh = dz+zt+nw/2;
    difference()
    {   union()
        {   if( with_slide_profile ) //Block it slides in.
                translate([dx+xl/2,-0.2*al,-nw/2]) linear_extrude(height=bh)
                {   square([xl-al,2*al],center=true);
                    square([xl,al],center=true);
                    for( s=[1,-1] ) translate([s*(xl-al)/2,-al/2]) circle(al/2);
                }
            _bottom();
            //Screw to clamp down slider.
            translate([dx+xl/2,-al,dz]) scale([1.5,1]) cylinder(r=al,h=3*al/2);
        }        
        //hex nut space and screw space.
        translate([dx+xl/2,0,dz+3*al/4]) rotate([90,0]) 
        {   cylinder(r=sr,h=inf);
            linear_extrude(height=al+snh) difference()
            {   circle(snw); //Hex thing
                for( a= [0:60:360] ) 
                    rotate(a) translate([snw,0]) square([snw,snw],center=true);
            }
        }

        if( with_slide_profile ) //Slide hole.
            translate([dx+xl/2,-al/2,-nw/2]) linear_extrude(height=3*bh)
                translate([0,-al/2]) slide_profile();
        translate([dx,d]) rotate([0,90,0]) linear_extrude(height=inf) difference()
        {   circle(nw); //Hex thing
            for( a= [0:60:360] ) rotate(a) translate([nw,0]) square([nw,nw],center=true);
        }
    }
}

module as_print()
{   rotate([0,180,0]) bottom(); }
as_print();
