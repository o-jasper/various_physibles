//
//  Copyright (C) 18-04-2012 Jasper den Ouden. (ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Variables throughout:
mr= 15/2; //Radius of marbles.
ri = 5; //Radius of pole.
et = 1;  //Thickness of edge.
uz = 5; //Height of bottom plate.
ur = 0; //Radius at bottom
tz= 3*et; //Height thing.
s=1.1;

module marble_torus(mR,mr)
{   rotate_extrude() translate([mR,0]) circle(mr); }

//'Rod radius'
module marble_male(ri,mr, uz,ur,tz, et)
{
    ro = et+ri+2*mr;
    difference()
    {   union()
        {   cylinder(r1=max(ur,1.2*(ro-uz)), r2=ro, h=uz+2*mr/3);
            cylinder(r=ri, h=uz + tz + 2*mr);
        }
        translate([0,0,uz+mr]) marble_torus(ri+mr,mr);
    }
    
}

module marble_female(ri, mr,uz,ur,et)
{
    ro = ri+2*mr+et;
    difference()
    {   cylinder(r1=max(ur,1.2*(ro-uz)), r2=ro, h= uz+7*mr/6);
        translate([0,0,uz+mr]) marble_torus(ri+mr,mr);
        translate([0,0,-uz]) cylinder(r=ri+s,h=3*(uz+mr));
        translate([0,0,uz+2*mr/3]) cylinder(r=ri+mr,h=3*(uz+mr));
    }
}

//Just examples! For standalones use marblethrust_component.
marble_male(ri, mr,uz,ur,tz,et);
translate([50,50]) marble_female(ri, mr,uz,ur,et);
