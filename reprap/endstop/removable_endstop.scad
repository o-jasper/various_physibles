//
//  Copyright (C) 09-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

t=5;

rr = 8.9; //9.6/2; //Z-rod radius.
rb = 10; //Horizontal rod radius.
nw = 13.2; // Nut width

dx = 20; //11.1 //Horizonal rod distance
d = 11.1;//rr+rb+2*t;//Distance between rods. TODO
dz=15; //Vertical distance.

al=5;
sr=1.2;

pair_enough=false; //Wether to just have two or as many as wanted half-feature holes.

zt = 1.5*t; //Height of z-rod assocated
xl = 4*al; //Length of nut profile.

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
            translate([dx+x,d]) circle(al+t);
            translate([dx+x/2-al,d]) square([2*(x-al),2*(al+t)],center=true);
//            translate([hx,d]) square([2*al+5*t,2*(al+t)],center=true);
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
        {   square([3*sr+t,hl],center=true);
            for(s=[1,-1]) scale(s) translate([0,+hl/2]) circle(3*sr/2+t/2);
        }
        square(2*[al,al],center=true);
        for(s=[1,-1]) scale(s) translate([0,+hl/2]) circle(sr);
    }
}

//Slide-on and clamp.
module bottom()
{
    tz = dz+3*t;
    w=2*(al+t);//3*(rb+t)/2;
    translate([dx,d]) rotate([0,90,0]) linear_extrude(height=xl) difference()
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
    translate([dx+2*al,d,tz-zt-t]) linear_extrude(height=t) screws_plate();

    translate([0,0,dz]) linear_extrude(height=zt) z_rod_associated();
}

module as_print()
{   rotate([0,180,0]) bottom(); }
as_print();

//Endstop portion.

module _slide_part()
{
    polygon([[-3*al,0],[-1.5*al,2*al+t],[1.5*al,2*al+t],
             [3*al,0], [1.5*al,-2*al-t],[-1.5*al,-2*al-t]]);
}

module slide_bottom()
{  
    bt= t;
    hl= 2*rb+t+3*sr; //Plate for screws.
    st = 3*t;
    
    difference()
    {   union()
        {   for( x=[-3*al,0,3*al] ) translate([x,0]) cylinder(r=0.95*al, h=st+zt);
            linear_extrude(height=bt) difference()
            {   union()
                {   square([6*al,2*al], center=true);
                    _slide_part();
                    for(s=[[1,1],[1,-1],[-1,-1],[-1,1]]) 
                        scale(s) translate([al+t/2,2*al+t]) circle(al+t/2);
                }
                for(s=[1,-1]) scale(s) translate([0,+hl/2]) circle(sr);
            }
            linear_extrude(height=st) difference()
            {   _slide_part();
                scale([0.9,0.6]) 
                    polygon([[-3*al,0],[-1.5*al,2*al+t],[1.5*al,2*al+t],
                             [3*al,0], [1.5*al,-2*al-t],[-1.5*al,-2*al-t]]);
                for(s=[1,-1]) scale(s) translate([0,+hl/2]) circle(3*sr);
            }
            for(a=[0,60,120]) rotate(a) translate([0,0,st/2]) cube([6*al,t/2,st],center=true);
        }
        for(s=[[1,1],[1,-1],[-1,-1],[-1,1]]) 
            scale(s) translate([al+t/2,2*al+t]) cylinder(r=al, h=10*bt);
//        cylinder(r=2*al,h=st-t);
    }
}

translate([10,0]) slide_bottom();    
   
