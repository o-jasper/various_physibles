//
//  Copyright (C) 04-12-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

top_screwable = true;

$r = 2/2; // radius of filament(accounted, actually made a bit bigger than needed)
$rt = 1.8; //1.75; //Tube radius

nh=4; nr =2*$rt;
sR=1.2;

save=false; //Doesnt really save.

module pusher_bottom(rf1=$r,rf2=2*$r, is_bottom=true)
{
    h = t+nh/2;
    r=$r; rt=$rt;
    difference()
    {   hull()
        {   union() for( x=pusher_d*[1,-1] ) translate([x,0]) cylinder(r=sR+t/2, h= h);
            cylinder(r=$rt+t/2, h=h);
            translate([0,0,h-nh/2]) cylinder(r=nr+t/4,h=nh/2, $fn=6);
        }
        translate([0,0,-0.1*nh]) cylinder(r1=rf1,r2=rf2,h=2*nh+t); //Filament hole.
        if(is_bottom) translate([0,0,-nh]) cylinder(r=1.1*$rt,h=nh+t/2); //Filament hole.
        translate([0,0,t]) cylinder(r=nr,h=8*nh,$fn=6); //M5 nut hole
        for( x=pusher_d*[1,-1] )  translate([x,0,-nh]) cylinder(r=sR,h=8*nh); //Screw holes.
        if(save)
            for( x=(pusher_d-sR + nr)*[1,-1]/2 ) translate([x,0,-nh]) cylinder(r=sR,h=8*nh); 
    }
}
module pusher_top()
{
    difference()
    {   pusher_bottom(rf1=$rt,rf2=$rt, is_bottom=false);
        //Top slides in sideward.
        translate([0,$rt+t]) cube(2*[0.9*$rt,$rt+t,8*nh],center=true);
        for( x=pusher_d*[1,-1] ) translate([x,$rt+t]) cube(2*[sR,$rt+t,8*nh],center=true);
    }
}

module as_print()
{   pusher_top();
    translate([0,$rt+2*t]) pusher_bottom();
}

as_print();

module pusher_bottom_3mm()
{   pusher_bottom($r=3/2,$rt=6/2); }

module pusher_top_3mm()
{   pusher_top($r=3/2,$rt=6/2); }
