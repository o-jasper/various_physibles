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

nh=4; nr =3*$rt;
sR=1.8;

save=false; //Doesnt really save.

module pusher_bottom(rf1=$r,rf2=2*$r, is_bottom=true)
{
    h = t+nh/2;
    r=$r; rt=$rt;
    difference()
    {   hull()
        {   union() for( x=pusher_d*[1,-1] ) translate([x,0]) cylinder(r=sR+t/2, h= h);
            cylinder(r=$rt+t/2, h=h);
            translate([0,0,h-nh/2]) rotate(30) cylinder(r=nr+t/4,h=nh/2, $fn=6);
        }
        translate([0,0,-0.1*nh]) cylinder(r1=rf1,r2=rf2,h=2*nh+t); //Filament hole.
        if(is_bottom) translate([0,0,-t/2]) cylinder(r1=1.5*$rt,r2=$rt,h=t); //Filament hole.
        translate([0,0,t]) linear_extrude(height=8*nh) union()
        {   rotate(30) circle(nr,$fn=6); //M5 nut hole n slide.
            translate([0,2*nr]) square([sqrt(3),4]*nr,center=true);
        }
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
    translate([0,nr+2*t]) pusher_bottom();
}

module pusher_bottom_3mm()
{   pusher_bottom($r=3/2,$rt=6/2); }

module pusher_top_3mm()
{   pusher_top($r=3/2,$rt=6/2); }


module show(tube=true, screws=true,move_top=true)
{
    pusher_bottom();
    translate([0,move_top ? -nr*(1-$t) : 0,2*t+nh+t*(1-$t)]) 
        rotate(180)rotate([180,0,0]) pusher_top();
    if(tube) color("red") 
    {   translate([0,2*nr*(1-$t), nh+t*(1-$t)/2]) 
        {   rotate(30) cylinder(r=nr-0.2,h=nh-0.2,$fn=6);
            cylinder(r=$rt,h=8*nh);
        }
        translate([0,0,-3*nh+nh*$t]) cylinder(r=$rt,h=2*nh+t/2-0.2);
    }
    if(screws) color("blue") for( x=pusher_d*[1,-1] ) translate([x,0,t*(1-$t)-2*nh]) 
    {   cylinder(r=sR-0.2,h=2*nh+4*t);
        translate([0,0,4*nh+t+0.2]) cylinder(r=1.7*sR,h=t-0.2);
    }
}

show();
