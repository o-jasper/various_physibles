//Jasper den Ouden 13-10-2013, placed in public domain or CC0, whichever is preferred.

//Pulley a bead belt could run over
// MAYBE, not tested! rather arbitrary values!

n=12; //Number of beads if rightly round.
r=4;  //Bead radius.
rs=1; //Radius of string between beads.
rd=1; //distance between beads..
t=2;  //Thickness
pi= 3.14; //Wtf openscad.
R=n*(2*r+rd)/(2*pi); //Implied total radius.

module beadbelt_pulley()
{   difference()
    {   cylinder(r=R,h=2*(r+t));
        
        rotate_extrude() translate([R,t+r]) circle(rs);
        for(a=[0:360/n:360]) rotate(a) translate([R,0,t+r]) sphere(r);
        
    }
}

beadbelt_pulley();
