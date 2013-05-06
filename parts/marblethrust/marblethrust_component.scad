//
//  Copyright (C) 18-04-2013 Jasper den Ouden. (ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include <marblethrust.scad>

male_n = 2; //Connecting holes on plate ontop.

female_b_n = 0; //Connecting holes on bottom.(choose 4 if you use it.)
female_t_n = 4; //Connecting holes on top.
female_t_hole = true;

inf= 100*mr;

module inficube(pos)
{   translate(pos) cube(2*[inf,inf,inf], center=true); }
module infisquare(pos)
{   translate(pos) square(2*[inf,inf], center=true); }

//TODO make 'component' pieces that can be fit into other things.
module marble_male_c()
{
    h= uz+2*mr+3*et;
    tz= 2*et + 2*ri*male_n; //Height thing.(overridden here)
    intersection()
    {   marble_male(ri,mr, uz,ur,tz,et);
        union()
        {   inficube([0,0,h -inf]);
            difference() 
            {   cube([ri,2*ri,inf], center=true);
                for( i=[0:male_n-1] )
                    translate([-2*ri,0,h+2*ri*(male_n-i)+ri/2]) 
                        rotate([0,90]) cylinder(r=ri/2,h=4*ri);
            }
        }
    }
}

module marble_female_c()
{
    ro = et+ri+2*mr;
    echo(ro);
    ur = max(ur,1.2*(ro-uz));
    marble_female(ri, mr,uz,ur,et);
    if( female_b_n>0 )linear_extrude(height=uz) for( i = [1:female_b_n] ) 
    {   rotate(45+360*i/female_b_n) translate([0,ur + ri/2])
            difference(){ circle(ri); circle(ri/2); }
    }
    R = ri+2.5*mr;
    h = uz+ 7*mr/6;
    if( female_t_n >0 ) for( i = [1:female_t_n] )
    {
        rotate(360*i/female_t_n) union()
        {   difference()
            {   
                translate([0,0,R/2]) rotate([0,90]) rotate_extrude() translate([R,0]) 
                {   circle(mr/2); 
                    translate([-mr/4,0]) square([mr/2,mr],center=true);
                }
                inficube([0,0,-inf]);
                inficube([0,-inf,0]);
                inficube([0,0,h + inf]);
            }
            if( female_t_hole ) translate([0,0,h]) difference()
            {   linear_extrude(height=1.5*mr+uz+3*et) translate([0,R]) 
                {   difference()
                    {   circle(mr/2);
                        infisquare([0,et-mr/2-inf]);
                    }
                }
                translate([0,R,mr+uz+3*et]) rotate(45-360*i/female_t_n) rotate([90,0])
                    translate([0,0,-inf]) cylinder(r=mr/4,h=3*inf);
            }
        }
    }
}

marble_male_c();
translate([2*(ri+3*mr+2*et),0]) marble_female_c();
