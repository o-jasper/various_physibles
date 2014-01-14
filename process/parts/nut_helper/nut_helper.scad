
include<../../../done/lib/nut.scad>

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
        translate([0,0,bt]) cylinder(r=nt/sqrt(3),h=2*nh,$fn=6);
        translate([0,0,-nh]) cylinder(r=sr,h=8*nh,$fn=max($fn,20));
    }
}
module nut_helper_thin(sr=sR,nt=nt,nh=nh,t=-1)
{   t= (t<0 ? sr : t);
    nut_helper(sr=sr,nt=nt,nh=nh,t=t,bt=t);
}

nut_helper_thin();
