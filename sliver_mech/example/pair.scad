
include<MCAD/involute_gears.scad>

$fn=60;
s=0.2;
sr=1.2;
th=2;

pitch = 400;
mf= 49*pitch/(500*36);
module g(n)
{   gear(number_of_teeth=n, circular_pitch=pitch,flat=true, bore_diameter=2*sr); }

n=8;
module pgear()
{   linear_extrude(height=th) g(n); }

module holder(cheap=false)
{
    w=3*sr;
    linear_extrude(height=th) difference()
    {   hull()
        {   circle(3*sr); 
            translate([2*n*mf+s,0]) circle(3*sr);
        }
        circle(sr);
        translate([2*n*mf+s,0]) circle(sr);
        if(cheap) translate([n*mf+s/2,0]) intersection()
        {   rotate(45) union()
            {   square([w,w],center=true);
                for(a=[0:90:270]) //Note: this only works for small ones.
                              rotate(a) translate([w+sr,0]) square([w,w],center=true);
            }
            square([2*n*mf,4*sr],center=true);
        }
    }
}

module as_assembled()
{
    color("blue") for(z=[-th,+th]) translate([0,0,z]) holder();
    rotate(360*$t/n) pgear(); 
    translate([2*n*mf+s,0]) rotate(180/n-360*$t/n) pgear();
}
as_assembled();
