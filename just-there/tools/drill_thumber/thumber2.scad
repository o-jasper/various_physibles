//Author Jasper den Ouden 24-10-2013
// Placed in public domain

$fn=60;

//Clamps (small) drills for easier manual handling.
sr=1.8;
s=0.4;

dr=0.4;

t=4;
r=5;
ri=2;
l=9*sr;
w=l;

hw=w/3;
hwo=2*w/3;

sx= min(l/4, l/2-3*sr);

module teardrop(r) //Look at the MCAD version.. MCAD needs to simplify their shit.
{   circle(r);
    translate([-r/sqrt(2),0]) rotate(45) square([r,r],center=true);
}

module top(really=true)
{ 
    intersection()
    {   linear_extrude(height=t) difference()
        {   scale([w/l,1]/2) circle(l);
            translate([sx,0]) circle(sr);
        }
        difference()
        {   sphere(w/2);
            if(really) translate([sx,0,t/2]) cylinder(r1=2*sr,r2=3*sr,h=t,$fn=6);
            drill_space();
            if(really) translate([-l/2,w/6]) rotate([90,0,0]) 
                linear_extrude(height=l) difference()
                       {   circle(r); circle(ri); }
        }
    }
    
}
translate([0,0,0.1])color("blue") top();

module bottom()
{
    intersection()
    {   union()
        {   rotate([180,0,0]) top(false);
            intersection()
            {   translate([-l/2,w/6-s]) rotate([90,0,0]) cylinder(h=l,r=r-s);
                translate([r/2,0]) scale([(w+2*r)/w,1/2,1]) sphere(w/2);
            }
        }
        difference()
        {   cube([8*l,8*l,2*t],center=true);
            translate([-l/2,w]) rotate([90,0,0]) intersection()
            {   cylinder(r=ri+s, h=8*w);
                translate(-[s,s,s]) cube(8*[w,w,w]);
            }
        }
    }
}
bottom();
module drill_space()
{   translate([-l/6,-w,0]) rotate([-90,0,0]) cylinder(r=0.4,h=8*w); }
