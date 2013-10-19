//
//  Copyright (C) 19-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

top_screwable = true;

$r = 2/2; // radius of filament(accounted, actually made a bit bigger than needed)
$rt = 1.75; //Tube radius
ph = (top_screwable ? 4 : 3)*t; //Pusher height.

//-----

//Screws go into the smaller hole to push down the top of the pfte tube that 
// enters the j-head.
module pusher_whole(srr=sr+t/2)
{
    r=$r; rt=$rt;
    ar= 2*rt+t/2;
    difference()
    {   union()
        {   linear_extrude(height=ph) difference()
            {   union()
                {   for( x=pusher_d*[1,-1] ) translate([x,0]) circle(srr);
                    intersection()
                    {   scale([(r+d+t/2+2*sr)/(5*r),(rt+t/2)/(5*r)]) circle(5*r);
                        scale([1,1/2]) circle(rt+d+t+2*sr);
                    }
                } //Screw holes.
                for( x=pusher_d*[1,-1] ) translate([x,0]) circle(sR);
            }
            hull() //Around insert area.
            {   cylinder(r=ar-ph/2+3*t/4,h=1);
                translate([0,0,2*t-3*t/4]) cylinder(r=ar,h=1);
                translate([0,0,2*t+3*t/4-1]) cylinder(r=ar,h=1);
                translate([0,0,2*t]) scale([1,(r+t/2)/d]) cylinder(r=d,h=1);
                translate([0,0,ph-1]) cylinder(r=r+t/2,h=1);
                
            }
        }
        if(top_screwable) translate([0,0,ph-t]) cylinder(r=rt < 2.5 ? 2.5 : rt+t/3,h=ph);
//The side hole inspired by Erik de Bruijns http://www.thingiverse.com/thing:1899/
        translate([0,0,-l]) cylinder(r=rt,h=l+t); 
        translate([0,4*rt,2*t]) cube([4*rt,8*rt,t],center=true); //Side hole for nut/plug.
        translate([0,0,2*t-t/2]) cylinder(r=2*rt, h=t+1);        // .. end location.

        translate([0,4*rt,ph]) cube([2*rt,8*rt,ph],center=true); //Side hole for tube
        translate([0,0,2*t-t/2]) cylinder(r=rt, h=l);            //..main hole.
        translate([0,0,0.7*t]) cylinder(r1=0,r2=2*rt,h=1.3*t);   // guide for filament.
        
        //Hole for filament.
        translate([0,0,-ph]) cylinder(r=$r,h=3*ph);
        //Keep bottom flat.
        translate([0,0,-ph]) cube(ph*[2,2,2],center=true);
    }

}

//Cut for two-part printing with less overhang.
module pusher_cut()
{
    cube([2*l,2*l,ph-t],center=true);
    translate([0,0,ph/2-t/2]) rotate([45,0,0]) cube([1.25*pusher_d,t,t],center=true);
    for(a=[0,180]) rotate(a) translate([1.25*pusher_d/2,0,ph/2-t/2]) 
                       rotate([0,45,0]) cube([t,l,t],center=true);
}

module pusher_bottom() //Bottom part of two.
{
    intersection()
    {   pusher_whole();
        pusher_cut();
    }
}
module pusher_top() //Top part of two.
{
    rotate([180,0,0]) difference()
    {   pusher_whole();
        pusher_cut();
    }
}

module pusher_pincher() //Pincher, potential alternative to holding the filament?
{
    s=0; ts=0.4;
    linear_extrude(height=t-ts) union()
    {   difference()
        {   circle(2*rt-ts);
            for(a=[0:60:300]) rotate(a) translate([rt-s,0]) circle(0.5);
            circle(rt-s);
        }        
        for(a=[0:60:300]) rotate(30+a) translate([rt-s/2,0]) circle(0.5);
    }
}

// --- 3mm filament-associated tube(untested!)
module pusher_bottom_3mm() { pusher_bottom($r=1.7, $rt=2.8); }
module pusher_top_3mm()    { pusher_top($r=1.7, $rt=2.8); }
module pusher_whole_3mm()  { pusher_whole($r=1.7, $rt=2.8); }
module pusher_pincher_3mm(){ pusher_pincher(rt=2.8); }

pusher_whole_3mm();
