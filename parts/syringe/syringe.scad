// Author Jasper den Ouden 4-10-2013
// placed in public domain.

$fs=0.1;
$fn=120;

R=10;
t=1;

h=50;
eh = 5;

sa=360/6;

module inner_syringe()
{   union()
    {   translate([0,0,h-2*R-eh]) cylinder(r1=0,r2=R,h=R);
        translate([0,0,h-R-eh]) cylinder(r=R,h=eh);
        translate([0,0,h-R]) cylinder(r1=R,r2=0,h=R);
        linear_extrude(twist=360, height=h-R) union()
        {   circle(R-t);
            for(a=[0:sa:360]) rotate(a)  
                                  intersection(){ square([2*R,eh],center=true); circle(R); }
        }
    }
}

module outer_syringe()
{   union()
    {
        cylinder(r=R+t,h=h-R);
        translate([0,0,h-R]) cylinder(r1=R+t,r2=t, h=R+t);
        cylinder(r=t,h=h+2*t);
    }    
}

inner_syringe();
translate([2*(R+t),0]) outer_syringe();
