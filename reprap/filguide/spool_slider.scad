//
//  Copyright (C) 26-09-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//A filament guide that slides along the spool edge.

$fs=0.1;

r=2.5;
R=5;
l=40;

al=65;
at = 4;
aid=10;

ll=40;

t=3;

sr=1.5;

oval_hole=true;
stilts=false;

module tongue(r,l)
{
    intersection(){ scale([1.3,1]) circle(r); square(2*[r,r],center=true); }
    translate([0,l/2]) square([2*r,l],center=true);
}

module slide_cut(holes)
{
    union()
    {   difference()
        {   linear_extrude(height=3*t) difference()
            {   tongue(r,al/2);
                if(holes) for(y=[t: 2*t : al/2-t]) translate([0,y]) circle(sr);
            }
            translate([0,0,1.5*t]) cube([al,al,t],center=true);
        }
        for( z=[t,2*t] ) translate([0,0,z]) intersection()
                         {   scale([1.3,1,0.2]) sphere(r);
                             cube(r*[2,2,4],center=true);
                         }        
    }
}

module hang_part()
{
    difference()
    {   union()
        {   linear_extrude(height=2.5*t) difference()
            {   tongue(R,al);    
                if( oval_hole ) //Oval hole, for fun.
                    translate([0,al/4-t/2]) scale([min(r,R-t/2),al/5]/al) circle(al);
                //Extra holes that may (or may not) be used for attachment.
                for(y=[al/2+t: 2*t : al]) translate([0,y]) circle(sr);
            }
            intersection()
            {   translate([0,0,l-R/sqrt(2)]) sphere(R);
                cylinder(r=R,h=l);
            }
            cylinder(r=r, h=l-R);
        }
        translate([0,al/2,-t/2]) slide_cut(false);
//        translate([0,al/2,1.5*t]) linear_extrude(height=2*t) tongue(r,al);
//        translate([0,al/2,-t/2]) linear_extrude(height=t) tongue(r,al);
        translate([0,al+t]) scale([1.3,1,1]) cylinder(r=R, h=l);
    }
}

module slide_part()
{
    rotate([0,-90,0]) union()
    {
        slide_cut(true);
        translate([0,al/2-aid,3*t+at]) linear_extrude(height=t) tongue(r,aid);
        
        translate([0,al/2]) linear_extrude(height=at+4*t) intersection()
        {   scale([1.3,1,1]) circle(r);
            square(2*[r,r],center=true);
        }
        translate([0,al/2,r]) rotate([0,90,0]) difference() 
        {   union()
            {   if(stilts) 
                    translate([-at-2.5*t,t/2,t/2]) rotate([0,15,0]) cylinder(r=t/2,h=ll);
                if(stilts) translate([t,-at-2.5*t,t/2]) 
                {   sphere(t/2);
                    rotate([-15,0,0]) cylinder(r=t/2,h=ll);
                }
                cylinder(r1=r,r2=R,h=ll);
                translate([0,0,l]) sphere(R);
            }
            hull()
            {   translate([0,-R]) cylinder(r=r,h=1);
                translate([0,R,2*l]) cylinder(r=r,h=1);
            }
        }
    }
}

module show()
{
    hang_part();
    translate([0,t+al/2+0.2*t+al*$t/2,-0.5*t]) color([1,0,0]) rotate([0,90,0]) slide_part();
}

module as_print()
{
    hang_part();
    translate([R+5*t+at,0,r]) color([1,0,0]) slide_part();
}

as_print();
//show();
//slide_cut();
