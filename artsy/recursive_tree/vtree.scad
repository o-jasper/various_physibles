//
//  Copyright (C) 10-11-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fn=30;

$t=2;
$r=20;
$a=20;
$f=0.8;

module r(n)
{
    translate([-$t/2,0]) square([$t,$r]);
    translate([0,$r]) 
    {   circle($t/2);
        if(n>0) 
        {   rotate(+$a)  r(n-1,$r=$f*$r);
            rotate(-$a) r(n-1,$r=$f*$r);
        }
    }    
}

module tree(nt=3)
{   intersection()
    {   union()
        {   for(a=[0:360/nt:360*(1-1/nt)]) rotate(a) 
               rotate([90,0,0]) linear_extrude(height=8*$r) r(4,$r=20,$a=20,$f=0.8);
        }
        difference()
        {   union()
            {   translate([0,0,2.5*$r]) sphere(1.2*$r);
                cylinder(h=8*$r,r1=0.5*$r,r2=0.7*$r);
                translate([0,0,$r]) cylinder(h=1.5*$r,r1=0.5*$r,r2=1.2*$r);
            }
            translate([0,0,2.5*$r]) scale([0.5,0.5,1]) sphere($r);
            translate([0,0,2*$r]) 
                for(a=[0:360/nt:360*(1-1/nt)]) rotate(a+180/nt) 
                   rotate([90,0,0]) cylinder(r=0.2*$r,h=8*$r);
            translate([0,0,-$r]) cylinder(r=$r/6,h=8*$r);
            rotate_extrude() union()
            {   intersection()
                {   translate($r*[0.751,1.5]) circle(0.4*$r);
                    translate($r*[0.201,1.5]) circle(0.4*$r);
                }
                intersection()
                {   translate($r*[1.201,2.5]) circle($r/2);
                    translate($r*[0.601,2.5]) circle($r/2);
                }
                translate($r*[0.8,3.4]) circle(0.2*$r);
            }
        }
    }
}

//tree();

module roots(nr=3)
{   intersection()
    {   linear_extrude(height=2*$r) for(a=[0:360/nr:360*(1-1/nr)]) rotate(a+180/nr)
            r(4,$a=40,$r=6,$f=0.8);
        difference()
        {   translate([0,0,-0.5*$r]) sphere(1.2*$r);
            translate([0,0,0.7*$r]) sphere(0.2*$r);
        }
    }
}

module whole_tree()
{
    roots();
    tree();
}
intersection()
{   whole_tree();
    *translate([-4*$r,0]) cube($r*[8,8,8]);
}

