//by Jasper den Ouden (ojasper.nl)
//Inspired by http://www.thingiverse.com/thing:43272 by Stefan Langemark
//
// Public domain

$fs=0.1;

t=0.5;
r = 10;
f = (r+t)/r;
n = 6;

module section()
{
    cylinder(r=r/2, h = 2*r);
    difference()
    {   union()
        {   intersection()
            {   sphere(f*r); //Recipient.
                translate([0,0,r/3]) cube(f*r*[4,4,sqrt(2)],center=true);
            }
            translate([0,0,f*r/sqrt(2)]) 
            {   cylinder(r1=f*r/sqrt(2), r2=r/5, h=r);
                translate([0,0,r/2]) sphere(r);
            }
        }            
        for( a = [0:360/n:360] ) rotate(a) //Petals
            {   translate([r,0,1.5*r]) scale([0.7,1/5,1]) sphere(r); }
        translate([0,0,5*r]) cube(6*[r,r,r], center=true);
    }
}

section();
