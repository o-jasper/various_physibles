
// Inspired by http://507movements.com/mm_069.html
//
//NOTE... this is derped without math..

module nudgewheel(r,d)
{
    difference()
    {   circle(r);
        translate([r+d,0]) circle(1.5*d);
    }
    intersection()
    {
        translate([r-d/2,0]) scale([1.7,1]) circle(d/2);
//        translate([r,0]) circle(d/2);
        circle(r+2*d);
    }
}
//nudgewheel(40,3);

//Receptwheel
module recepwheel(r,n)
{
    d=6.24*r/n;
    for(a=[0:360/n:360*(1-1/n)]) rotate(a) difference()
    {   translate([r-d,0]) scale([2,1]) circle(d);
        translate([r+d,-d]) circle(sqrt(2)*d);
    }
}

distance= 2*r+0.6*d;

$t=-1;
n=24;
r=40; d=6.24*r/n; r2=r/3;
rotate(70/n - 360*$t/(2*1.2)) color("blue") recepwheel(r,n);
translate([r+r2+0.7*d,0]) rotate(360*($t/2+0.38)) nudgewheel(r2,d);
