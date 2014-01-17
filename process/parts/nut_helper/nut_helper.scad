
include<o-jasper/nut.scad>
$fs=0.3;

//Base knob design.
module knob(r,t,h,n=12, rs=-1)
{
    rs= (rs<0 ? 5*r/n : t);
    difference()
    {   intersection()
        {   cylinder(r=r+1.5*t,h=h);
            translate([0,0,h/2]) scale([r+1.5*t,r+1.5*t,1.2*h]/h) sphere(h);
        }
        for(a=[0:360/n:360*(1-1/n)]) rotate(a) 
            translate([r+1.5*t,0,-h]) cylinder(r=rs,h=8*h,$fn=12);
    }
}

//Substract 
module nut_helper(sr=sR,nt=nt,nh=nh,t=-1,bt=-1)
{   t= (t<0 ? sr : t);
    bt = (bt<0 ? nh : bt);
    difference()
    {   knob(nt/2,t,bt+nh);
        translate([0,0,bt]) linear_extrude(height=2*nh) nut2d();
        translate([0,0,-nh]) cylinder(r=sr,h=8*nh,$fn=max($fn,20));
    }
}
module nut_helper_thin(sr=sR,nt=nt,nh=nh,t=-1)
{   t= (t<0 ? sr : t);
    nut_helper(sr=sr,nt=nt,nh=nh,t=t,bt=t);
}

module nut_winged(sr=sR,nt=nt,nh=nh,t=-1,bt=-1)
{
    t= (t<0 ? sr : t);
    bt = (bt<0 ? nh : bt);
    difference()
    {   union()
        {   hull()
            {   cylinder(r=nt/2+t, h=bt+1.5*t);
                cylinder(r=nt/2+1.4*t, h=bt);
            }
            translate([0,t]) rotate([90,0,0]) linear_extrude(height=2*t) intersection()
            {   union() for(x=(sr+4*t)*[1,-1]) translate([x,0]) scale([1,2]) circle(4*t);
                translate([0,4*t]) square(t*[16,8],center=true);
                translate([0,8*t]) rotate(45) square(t*[16,16],center=true);
            }
        }
        translate([0,0,bt]) linear_extrude(height=2*nh) nut2d();
        translate([0,0,-nh]) cylinder(r=sr,h=8*nh,$fn=max($fn,20));
    }
}

module screw_cap(sr=sr,nt=nt)
{
    difference()
    {   scale([1,1,1.5]) sphere(nt/2);
        translate([0,0,-nt]) cylinder(r=sr,h=1.5*nt);
        translate([0,0,-1.1*nt]) cylinder(r=8*nt,h=nt);
    }
}

screw_cap();
//nut_winged();
