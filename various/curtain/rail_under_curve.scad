//
//  Copyright (C) 09-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;

$R=15;
$t=3;
$s=0.4;

//NOTE the curve thing seems potentially overkill!
//TODO cut that out.
module rail2d()
{   intersection()
    {   circle($R);
        difference()
        {   square($R*[2,2]);
            circle($R-$t);
        }
    }
    translate([$R-$t,-2*$t]) square($t*[1,2]);
    translate([$R-1.5*$t,-1.5*$t]) hull()
    {   circle($t/2); translate([2*$t,0]) circle($t/2); }
}

module slider2d()
{   difference()
    {   union()
        {
            for(x=$t*[1.5,-1.5]) hull()
            {   translate([x,0]) circle($s+$t);
                translate([x,$t/4]) circle($t);
                translate([0,-$s]) circle(1.25*$t);
            }
        }
        translate([$t/2-$R,1.5*($t+$s)]) rail2d($t=$t+$s);
    }
}
module rail(l=100,n=5)
{
    difference()
    {   linear_extrude(height=l) rail2d();
        //Pokes holes.
        if(n>0) rotate(-145) rotate([0,-90,0]) linear_extrude(height=l) 
            for(x=[l/(2*n):(l-$t)/n:l]) translate([x,0])
                                            circle(l/(2*n)-$t,$fn=4);
    }
}
module rail_corner(a=90)
{
    intersection()
    {   rotate_extrude() rail2d();
        translate([-4,0,-4]*$R) cube($R*[8,8,8]);
        rotate(180+a) translate([-4,0,-4]*$R) cube($R*[8,8,8]);
    }
}

rail_corner();
rotate([90,0,0]) rail();
