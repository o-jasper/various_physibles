//
//  Copyright (C) 05-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;

t=5;

rr = 8.8/2; //Z-rod radius.
rb = 10; //Horizontal rod radius.
nw = 13.1; // Nut width

dx = 20; //11.1 //Horizonal rod distance
d = 11.1;//rr+rb+2*t;//Distance between rods. TODO
dz=15; //Vertical distance.

feature = false; //NOTE kindah broken for true.
al=5; 
sr=1.4;    //Screw radius.
snw = 6.2; //Screw hex head width.
snh= 4;    //Actually bunch more than the hex head height.

pair_enough=false; //Wether to just have two or as many as wanted half-feature holes.

zt = 1.5*t; //Height of z-rod assocated
xl = 4*al; //Length of nut profile.

hex_from_top=true;
with_slide=true;

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
            {   translate([xl/2+dx/2,d]) square([xl+dx,2*(al+t)],center=true);
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

bw=2*(al+t);//3*(rb+t)/2;
//Slide-on and clamp.
module _bottom()
{
    w=bw;
    tz = dz+3*t;
    translate([dx,d]) rotate([0,90,0]) linear_extrude(height=xl) difference()
    {   union()
        {   circle(nw/2+t);
            translate([-dz/2,0]) square([dz,w], center=true);
        }
        if( hex_from_top ) translate([nw/2+inf,0]) square(inf*[2,2],center=true);
    }
    hx = dx+2.5*t; 
    if(feature)translate([dx+2*al,d,tz-zt-t]) linear_extrude(height=t) screws_plate();
    
    translate([0,0,dz]) linear_extrude(height=zt) z_rod_associated();
}

module hex_hole(w)
{
    difference()//Where it goes on the big nuts.
    {   circle(w); //Hex thing
        for( a= [0:60:360] ) rotate(a) translate([w,0]) square([w,w],center=true);
    }
}

module bottom()
{
    bh = dz+zt+nw/2;
    difference()
    {   union()
        {   _bottom();
            translate([0,bw]) scale([1,-1]) if( with_slide ) //Block it slides in.
            {   translate([dx+xl/2,-0.2*al,-nw/2]) linear_extrude(height=bh)
                {   square([xl-al,2*al],center=true);
                    square([xl,al],center=true);
                    for( s=[1,-1] ) translate([s*(xl-al)/2,-al/2]) circle(al/2);
                }
                //More where the screw to clamp it down goes.
                translate([dx+xl/2,-al,dz]) cylinder(r=1.5*al,h=3*al/2);
            }
                        
        }        
        //hex nut space and screw space.
        translate([0,bw]) scale([1,-1]) 
            if( with_slide ) translate([dx+xl/2,0,dz+3*al/4]) rotate([90,0]) 
        {   cylinder(r=sr,h=inf);
            linear_extrude(height=al+snh) hex_hole(snw); //Small hex nut.
        }

        translate([0,bw]) scale([1,-1]) if( with_slide ) //Slide hole.
            translate([dx+xl/2,-al/2,-nw/2]) linear_extrude(height=3*bh)
                translate([0,-al/2]) slide_profile();
        
        translate([dx,d]) rotate([0,90,0]) linear_extrude(height=inf) 
        {   hex_hole(nw); //Where it goes on the big nuts.
            if( pair_enough ) //Half feature holes.
            {   for( y=[-al,al] ) translate([al-dz,y])  circle(al/2); }
            else
            {   for( z=[al:2*al:dz-nw/2] )
                    for( y=[-al,al] ) translate([z-dz,y])  circle(al/2);
            }
        }
    }
}

module bottom_as_print()
{   rotate([0,180,0]) bottom(); }

//Slider with small endstop.
//I had ZMA00A080P00PC's 
//http://nl.mouser.com/ProductDetail/CK-Components/ZMA00A080P00PC/?qs=sGAEpiMZZMumBvQ1hY%2ffBUTjWSsepfwlGeSSynpM5b4%3d
sd = 6.51;//Distance between screws. 
sdy = 4; //Height of microswitch from screws.(button has to stick out)

sl = 120; //Slider length.

module _slider_with_endstop()
{
    f= 0.91;
    bh = dz+zt+nw/2;
    rotate([90,0]) translate([0,-f*al]) linear_extrude(height=sl+t) scale(f) slide_profile();
    
    w= 2*(sr+t);
    translate([0,sr,-t]) linear_extrude(height=t) difference()
    {   union()
        {   square([sd, w],center=true);
            for(s = [1,-1] ) scale([s,1]) translate([sd/2,0]) circle(sr+t);
        }
        for(s = [1,-1] ) scale([s,1]) translate([sd/2,0]) circle(sr);
        translate([0,sdy+2*inf]) square(inf*[4,4],center=true);
    }
}
module slider_with_endstop()
{   scale([1,1,-1]) _slider_with_endstop(); 
}

fr = 1.75/2; //Filament radius.
tt=3;

//Thumb wheel for it.
module thumb_wheel()
{
    t=tt;
    h=2.4*snh+2*t;
    difference()
    {   union()
        {   cylinder(r=snw/2+t, h=h);
            for( a=[0:60:360] ) rotate(a) translate([snw/2+t/2,0]) 
                                {   cylinder(r=t, h=h-t);
                                    translate([0,0,h-t]) sphere(t);
                                }
        }
        translate([0,0,t]) 
        {   linear_extrude(height=snh) hex_hole(snw);
            cylinder(r=snw/2, h=2.4*snh);
        }
        cylinder(r=sr,h=2.4*snh);
        //Hole to slide it in.
        translate([0,inf/2])
        {   cube([2*sr,inf,2*(2.4*snh+t)],center=true);
            translate([0,0,t+1.2*snh]) cube([snw,inf,2.4*snh],center=true);
        }
        translate([-inf,snw/2,1.2*snh+t]) rotate([0,90,0]) cylinder(r=fr,h=3*inf);
    }
}

//bottom_as_print();
slider_with_endstop();
//thumb_wheel();
