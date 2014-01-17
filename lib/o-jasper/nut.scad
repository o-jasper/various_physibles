//Author Jasper den Ouden
// Placed in public domain.

//Nut thickness.
nt = 5.8;
//Nut height.
nh = 2.6;

sr = 1.3; //Screw radius.
sR=2; //much-bigger-than.

module nut2d()
{
    rotate(30) circle(nt/sqrt(3),$fn=6);

    /* intersection() //Should be identical.
    {   square([nt,4*nt], center=true);
        rotate(120) square([nt,4*nt], center=true);
        rotate(240) square([nt,4*nt], center=true);
        }*/
}
module nut_profile(){ echo("nut_profile depreciated, use nut2d instead"); nut2d(); }

module nut2d_with_length(l)
{   nut2d(nt=nt);
    translate([0,l/2]) square([nt,l],center=true);
}
