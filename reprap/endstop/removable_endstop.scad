//
//  Copyright (C) 09-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

t=5;

rr = 9.6/2; //Z-rod radius.
rb = 10; //Horizontal rod radius.
nw = 13.2; // Nut width

dx = 11.1; //Horizonal rod distance
d = 11.1;//rr+rb+2*t;//Distance between rods. TODO
dz=30; //Vertical distance.

al=5;
sr=1.2;

pair_enough=false; //Wether to just have two or as many as wanted half-feature holes.

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
            translate([dx+al+5*t,d]) circle(al+t);
            translate([hx,d]) square([2*al+5*t,2*(al+t)],center=true);
        }
        translate([0,x]) circle(rr/2); //hole in springy

        translate([dx-al,d]) circle(al);  //Feature holes.
        translate([dx+2.5*t,d]) circle(al);  //Feature holes.
        translate([dx+al+5*t,d]) circle(al);
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
        {   square([3*sr+t,hl],center=true);
            translate([0,+hl/2]) circle(3*sr/2+t/2);
            translate([0,-hl/2]) circle(3*sr/2+t/2);
        }
        square(2*[al,al],center=true);
        translate([0,+hl/2]) circle(sr);
        translate([0,-hl/2]) circle(sr);
    }
}

//Slide-on and clamp.
module bottom()
{
    tz = dz+3*t;
    w=2*(rr+t);//3*(rb+t)/2;
    translate([dx,d]) rotate([0,90,0]) linear_extrude(height=5*t) difference()
    {   union()
        {   circle(nw/2+t);
            translate([-dz/2,0]) square([dz,w], center=true);
        }
        difference()
        {   circle(nw);
            for( a= [0:60:360] ) rotate(a) translate([nw,0]) square([nw,nw],center=true);
        }
        if( pair_enough )
        {   for( y=[-al,al] ) translate([al-dz,y])  circle(al/2); }
        else
        {   for( z=[al:2*al:dz-nw/2] )
                for( y=[-al,al] ) translate([z-dz,y])  circle(al/2);
        }        
    }
    hx = dx+2.5*t; 
    translate([hx,d,tz-t]) linear_extrude(height=t) screws_plate();

    translate([0,0,dz]) linear_extrude(height=3*t) z_rod_associated();
}

module as_print()
{   rotate([0,180,0]) bottom(); }
as_print();
