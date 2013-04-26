//
//  Copyright (C) 26-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

br = 20; //Ball radius.

pw = 500; //Playing area width, length, depth.
pl = 1000;
pd = 1.5*br;
ed = 20; //Edge depth.
bd = 3*ed;

h = 200;

pr = br;

module _top_cut_profile(w,l)
{
    minkowski()
    {   difference()
        {   polygon([[-w/2,0],[w/2,0], [w/2-ed,pd],[-ed+w/2,pl],
                     [ed-w/2,pl],[ed-w/2,pd]]);
//            translate([+w/2-ed,pd+br]) circle(br);
            translate([-w/2+ed,pd+br]) circle(br);
        }
        circle(br/2);
    }
}
module _top_cut(w,l)
{   translate([0,0,-l/2]) linear_extrude(height=l) _top_cut_profile(w,l); }

module ball_drop()
{   r=1.5*br;
    rotate_extrude()
    {   _top_cut_profile(4*pd,r); }
}

module top_cut()
{
    intersection()
    {   rotate([90,0]) _top_cut(pw,pl);
        rotate(90) rotate([90,0]) _top_cut(pl,pw);
    }
}

module _lead_tube(d)
{
    a = 80;
    r = 1.5*br;
    translate([0,-2*r,-r])
    {   intersection()
        {   rotate_extrude() translate([2*r,r]) circle(r);
            linear_extrude(height = 8*br) polygon([[0,0], [0,8*br], [8*br,8*br*cos(a)]]);
        }
        rotate(-a) translate([0,2*r,r]) rotate([0,90,0]) cylinder(r=r, h=d);
    }
}
module lead_tube(d)
{   rotate([0,90]) _lead_tube(d); }

module ball_cut(a,dx,dy,d)
{
    translate([+dx,+dy]) 
    {   //ball_drop();
        cylinder(r=1.5*br, h=pl);
        rotate(a) lead_tube(d);
    }
}

module most_cut()
{   top_cut();
    dx= (pw-br)/2; dy= (pl-br)/2;
    
    ball_cut(-45,+dx,+dy, pw/2);
    ball_cut(45, -dx,+dy, pw/2);
    
    ball_cut(-90,  +dx,-dy, pw/2);
    ball_cut(90,   -dx,-dy, pw/2);

    ball_cut(-45,  +dx,0, pw/2);
    ball_cut(45,   -dx,0, pw/2);
    
    
    difference()
    {   translate([0,-pl/3,-7.7*br]) rotate([2,0,0]) linear_extrude(height=4*br)
        {   square([pw/2,4*pl/3-pw/4], center=true);
            translate([0,2*pl/3-pw/8]) circle(pw/4);
        }
        translate([0,-3*pl/2-5*br,0]) cube(pl*[2,2,2],center=true);
    }
}

module table_paw()
{
    w= pw+2*bd; l= pl+2*bd; 
    hh = h+br; z= -h/2-5*br;
    translate([-w/4,-l/2+l/8,-h]) rotate(22*[-1,1,0]/sqrt(2)) rotate(-45) difference()
    {   union()
        {   cube([3*br,6*br,2*h],center=true);
            translate([0,0,-1*h]) rotate([22,0,0]) 
            {   linear_extrude(height=2*br) 
                {   square([4*br,6*br],center=true);
                    translate([0,3*br]) circle(2*br);
                    translate([0,-3*br]) circle(2*br);
                }
                
            }
        }
        translate([0,0,-1*h]) rotate([22,0,0]) 
            translate([0,0,-pl]) cube([pl,pl,pl]*2, center=true);
    }
}

module base_table()
{
    w= pw+2*bd; l= pl+2*bd; 
    hh = h+br; z= -h/2-5*br;
    intersection()
    {   rotate([90,0,0]) translate([0,0,-l]) linear_extrude(height=3*l) minkowski()
        {   square([w,br], center=true);
            circle(br);
        }
        rotate([0,90,0]) translate([0,0,-w]) linear_extrude(height=3*w) minkowski()
        {   square([br,l], center=true);
            circle(br);
        }
    }
    intersection()
    {   rotate([90,0,0]) translate([-w/2,z,-l]) linear_extrude(height=4*l)
            polygon([[w/8,0],[7*w/8,0],[w,hh],[0,hh]]);
        
        rotate(90) rotate([90,0,0]) translate([-l/2,z,-l]) linear_extrude(height=4*l)
            polygon([[l/16,0],[15*l/16,0],[l,hh],[0,hh]]);
    }
    table_paw();
    scale([1,-1]) table_paw();
    scale([-1,1]) table_paw();
    scale([-1,-1]) table_paw();
    
    translate([0,-pl/2-2*br,-h/2+2*br]) 
    {   cube(br*[16,2,4],center=true);
        translate([0,0,-5*br]) linear_extrude(height=3*br)
        {   square(br*[16,8],center=true);
            translate(br*[-7,-4]) circle(br);
            translate(br*[7,-4]) circle(br);
            square(br*[14,10],center=true);
        }
    }
}

module pool_table()
{
    color([0,0,1]) translate([0,-pl/2-2*br,-h/2-2.5*br]) cube(br*[16,8,1],center=true);
    difference() 
    {   base_table();
        color([1,0,0]) translate([0,-pl/2-2*br,br-h/2]) cube(br*[14,8,5],center=true);
        most_cut();
    }
}

pool_table();
