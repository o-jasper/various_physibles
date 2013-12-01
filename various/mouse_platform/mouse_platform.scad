
$fn=30;

module teardrop(r) //Look at the MCAD version.. MCAD needs to simplify their shit.
{   circle(r);
    translate([-r/sqrt(2),0]) rotate(45) square([r,r],center=true);
}

R=40;t=1;
h=R+2*t;
n=4;
s=0.5;

module profile(s=0)
{   difference()
    {   circle(R-t-s);
        for(a=[0:360/n:360*(1-1/n)]) rotate(a) translate([0,R-t]) circle(3*t+s);
    }
}

module hole_circle()
{
    n=8;
    for(a=[0:360/n:360*(1-1/n)]) rotate(a) translate([0,4*t]) circle(t);
    circle(1.5*t);
}

da=360/sqrt(37);
module artsy_cut()
{
    amax = 360*R/(4*t);
    for( a=[360:da:amax] ) rotate(a) translate([0,a*(R-10*t-s)/amax]) circle(t);
    for( a=[0.55*amax:da:0.55*amax+300] ) rotate(a+0.2*da) 
            translate([0,a*(R-10*t-s)/amax]) hole_circle();
}

module top_base()
{   linear_extrude(height=h) difference(){ circle(R); artsy_cut(); }
}

module top()
{
    rotate([180,0,0]) difference()
    {   top_base();
        difference()
        {   translate([0,0,-h-t]) linear_extrude(height=2*h) profile();
            translate([0,0,3*h/4]) cylinder(r=3*t,h=h);
        }
        cylinder(r=2*t,h=h-t);
        for(a=[0:360/n:360*(1-1/n)]) rotate(a) 
            {   translate([0,R-s-6*t]) cylinder(r=2*t+s,h=2*h);
            }
    }
}
//top();

module bottom()
{
    ri = R*sin(180/n)/2;
    echo(ri);
    for(a=[0:360/n:360*(1-1/n)]) rotate(a) 
    {   translate([0,R-s-6*t]) cylinder(r=2*t,h=2*h);
        
    }
    difference()
    {   linear_extrude(height=h-t) profile(s=s);
        difference()
        {   translate([0,0,2*t]) linear_extrude(height=h) profile(s=s+t);
            cylinder(r=3*t,h=h/4);
            for(a=[0:da:360-da]) rotate(a)
                rotate([90,0,0]) translate([0,0,-t]) linear_extrude(height=2*t) difference() 
            {   square([h,h]/4); translate([h/4,h/4-t]) circle(h/4-3*t); }
        }
        for(a=[0:360/n:360*(1-1/n)]) rotate(a+180/n) translate([0,-R/2,ri+3*t]) 
           rotate([90,0,0]) linear_extrude(height=8*R) intersection()
             rotate(-90) teardrop(ri);
        translate([0,0,t]) cylinder(r=2*t,h=h);
        translate([0,0,-t]) linear_extrude(height=h) difference(){ artsy_cut(); circle(4*t); }
//           translate([-/2,0,4*t])
//               cube([R*sin(180/n),8*R,h-8*t]);
    }
}
bottom();
