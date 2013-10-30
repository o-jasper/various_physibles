
include<../gear_outer.scad>

s=0.2;
sr=0.5;
th=1;

pitch = 180;
mf= 49*pitch/(500*36);
module g(n)
{   gear_outer(number_of_teeth=n, circular_pitch=pitch); }

n=8;
module gear()
{   linear_extrude(height=th) difference(){ g(n); circle(sr); } }

rotate(360*$t) gear(); 
translate([2*n*mf+s,0]) rotate(180/n-360*$t) gear();

module holder()
{
    linear_extrude(height=th) difference()
    {   hull()
        {   circle(3*sr); 
            translate([2*n*mf+s,0]) circle(3*sr);
        }
        circle(sr);
        translate([2*n*mf+s,0]) circle(sr);
    }
}
holder();
