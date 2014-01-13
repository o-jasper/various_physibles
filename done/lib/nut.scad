//Author Jasper den Ouden
// Placed in public domain.

//Nut thickness.
nt = 5.8;
//Nut height.
nh = 2.6;

sr = 1.3;
module nut_profile()
{
    intersection()
    {   square([nt,4*nt], center=true);
        rotate(120) square([nt,4*nt], center=true);
        rotate(240) square([nt,4*nt], center=true);
    }
}

module nut_and_length(l)
{
    nut_profile(nt=nt,nh=nh);
    translate([0,l/2]) square([nt,l],center=true);
}
