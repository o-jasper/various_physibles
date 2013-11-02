//Author Jasper den Ouden 24-10-2013
// Placed in public domain

//Clamps (small) drills for easier manual handling.

r=10;
ar=0.5;
h=r;
sr=2;
s=0.5;

a=40;

module thumby(female=true)
{
    intersection()
    {   scale([1,1,h/(1.5*r)]) sphere(r);
        difference()
        {   translate([0,0,-h/4]) cube([8*r,8*r,h/2],center=true);
            translate([0,-4*r]) rotate([-90,0,0]) cylinder(r=ar,h=8*r);
            translate([r/2,0,-h]) cylinder(r=sr,h=8*h);
            if(female) translate([-r,0]) rotate([0,-a,0]) cube([r/2,r/2,8*h],center=true);
        }
    }
    if(!female)
        union()
        {   intersection()
            {   scale([1,1,h/(1.5*r)]) sphere(r);
                cube([8*r,8*r,h],center=true);
                translate([-r,0]) rotate([0,a,0]) cube([r/2-s,r/2-s,8*h],center=true);
            }
        }
}

module thumby_male(){ thumby(false); }
module thumby_female(){ thumby(true); }

module thumby_assembled()
{
    translate([0,0,-0.1]) color("blue") thumby_male();
    rotate([180,0,0]) thumby_female();
}

thumby_assembled();
//thumby_male();
