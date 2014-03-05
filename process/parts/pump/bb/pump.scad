
include<oneway.scad>

R=10; H=60;

s=0.1;

module bb_pump()
{
    difference()
    {   union()
        {   cylinder(r=R+t,h=H);
            linear_extrude(height=t) difference()
            {   hull()
                {   circle(R+2*t);
                    for(x=(R+3*t)*[1,-1]) translate([x,0]) circle(3*t);
                }
                for(x=(R+3*t)*[1,-1]) translate([x,0]) circle(2*t);
            }
            for(x=(R+3*t)*[1,-1]) translate([x,0]) cylinder(r=3*t,h=2*br);
        }
        translate([0,0,t]) cylinder(r=R,h=H);
        translate([0,-4*R,br+t]) rotate([-90,0,0]) cylinder(r=br,h=8*R);
        for(x=(R+3*t)*[1,-1]) translate([x,0,-t]) cylinder(r=2*t,h=8*br);
    }
    for(y=[R,-R-9*br]) translate([0,y,br+t]) 
        rotate([-90,0,0]) ball_check_valve(t=t,br=br,ri=ri);
}

module bb_plunger(fancy_center=false,fr=1)
{
    difference()
    {   cylinder(r=R-s,h=H);
        translate([0,0,t]) cylinder(r=R-t,h=H);
    }
    difference()
    {   linear_extrude(height=H) intersection()
        {   for(a=[0,90]) rotate(a) square([t,4*R],center=true);
            circle(R);
        }
        if(fancy_center)
        {   for(z=[R:R:H-R]) rotate_extrude() translate([(R+t)/2,z]) circle(R/2-t,$fn=4);
            for(z=[0:R:H-R]) translate([0,0,z+R/2])
            {   cylinder(r1=R/2,r2=0,h=R/2);
                translate([0,0,-R/2]) cylinder(r2=R/2,r1=0,h=R/2);
            }
        }
    }
    for(y=[4*t,-2*t]) translate([0,y,H]) rotate([90,0,0]) 
       linear_extrude(height=2*t) difference()
    {   hull()
        {   for(x=R*[1,-1]) translate([x,R]) circle(fr+2*t);
            circle(R);
        }
        translate([0,R/3]) circle(R/2);
        for(x=R*[1,-1]) translate([x,R]) circle(fr);
    }
}

module show()
{   bb_pump();
    translate([0,0,4*t+H*$t/2]) color("blue") bb_plunger();
    translate([0,2*R+2*R*$t,br+t]) rotate([-90,0,0]) color("red") bb_slide_over();
}

show();

