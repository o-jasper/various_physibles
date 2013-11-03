//Author Jasper den Ouden 24-10-2013
// Placed in public domain

$fn=60;

//Clamps (small) drills for easier manual handling.
sr=2;
s=0.7;

dr=0.4;

t=4;
l=30;
w=10;

male=true;

module base(ds=0)
{
    intersection()
    {   translate([-t,-l/2,w]/2) cube([t,l,w],center=true);
        difference()
        {   translate([t/2,0,w/2]) scale([1,l/(4*t),1]) sphere(2*t);
            translate([0,l/4-t/2]) cylinder(r=s+ds,h=w);
        }
    }
}

module d(ds=0)
{
    translate([-t/2,(l-t)/2]) cylinder(r1=t/2+ds,r2=t+sd,h=w);
    difference()
    {   translate([-t/2-50*ds,(l-t)/4,3*w/4+2*s]) 
            cube([t+100*ds,(l-t+100*ds)/2,w/2-4*s+ds],center=true);
        translate([0,l/2,w]) rotate([0,45,0]) cube([1.5*t-ds,l/2+100*ds,1.5*t-ds],center=true);
    }
}

module male(ds=0)
{
    translate([t/2,-(l-t)/2]) difference()
    {   union()
        {   base(ds); 
            d(ds);
        }
        translate([0,l/4-t/2]) cylinder(r=dr,h=w); //Drill groove
        translate([w,-l/2+3*sr,w/2]) rotate([0,-90,0]) cylinder(r=sr,h=8*w); //Screw.
    }
}

module female()
{
    translate([t/2,-(l-t)/2]) difference()
    {   union()
        {   hull()
            {   translate([0,0,w]) rotate(180) rotate([180,0,0]) base();
                translate([t/3,l/4+t/2,w/2]) rotate(20) scale([1/2,1,1]) sphere(w/2);
            }
            linear_extrude(height=w) hull()
            {   translate([-t/2,(l-t)/2]) circle(0.8*t);
                translate([t/2,l/4-t]) circle(t/2);
            }
        }
        translate([-t/2,(l-t)/2]) for(a=[-40,-20,-10,0]) rotate(a) 
            translate([t/2,-(l-t)/2]) d(2*s);
        translate([-t/2,0,0]) cube([t,l/2+t,8*w],center=true);
            
        translate([0,l/4-t/2]) cylinder(r=dr,h=w); //Drill groove
        translate([w,-l/2+3*sr,w/2]) rotate([0,-90,0])  //Screw and nut.
        {   cylinder(r=sr,h=8*w);
            translate([0,0,w-1.55*t]) cylinder(r2=3*sr,r1=4*sr,h=t,$fn=6);
        }
    }
}

module thumby()
{   rotate(-4) male();
    color("blue") female();
}
thumby();
