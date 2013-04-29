//
//  Copyright (C) 28-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Idea: try separate the two sides of the male.

t= 4;
sr=1;
inf = 100*t;

$fs =0.1;

module h_profile(s,he)
{
    scale(s) square([3*t,t+he],center=true);
    for(x=[-t,t]) translate([x,0]) scale(s) square([t,3*t],center=true);
}

module h_male()
{
    difference()
    {   union()
        {   linear_extrude(height=t) difference()
            {   square(3*[t,t],center=true);
                for( y=[-t/2,t/2] ) translate([0,y]) circle(sr);
            }
            linear_extrude(height=4*t) difference()
            {   h_profile(1,0);
                for( y=[-t/2,t/2] ) translate([0,y]) circle(sr);
            }
        }
        for( a = [0,180] ) rotate(a)
            {   translate([0,t/2,3.5*t]) rotate(45)
                    rotate([135,0,0]) cylinder(r=sr,h=inf);
                translate([t,-t,0]) rotate([0,22,0]) 
                    translate([0,0,-inf]) cylinder(r=sr,h=3*inf); 
/*                translate([t,-t/2,3.6*t])
                {   translate([0,0,-inf]) cylinder(r=sr,h=3*inf); 
                    rotate(45) translate([0,-inf/2,t/2]) cube([t/2,inf,t],center=true);
                    }*/
            }
    }
}
module h_female()
{
    
    difference()
    {   union()
        {   linear_extrude(height=t) square(4*[t,t],center=true);
            linear_extrude(height=4*t) 
            {   difference()
                {   square(4*[t,t],center=true);
                    h_profile(1.05,2*sr);
                }
            }
        }
        for( s=[[1,1],[-1,1]] ) scale(s) for( z = [3*t/2:t:5*t] )
            rotate([90,0,0]) translate([t/2,z,-inf]) cylinder(r=sr, h=3*inf);
    }        
}

h_female();
translate([5*t,0]) h_male();
