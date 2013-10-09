//Copyright (c) 2013 Jasper den Ouden, 
// placed in public domain or creative commons CC0, whichever you choose

//Maraca intended to be printable as a single layer.('vaselike')

//Generating a model could take a while.

$fn=80;
$fs=0.5;

R=40; stem_len=R;

s=1;
module outer_shape()
{
    intersection()
    {   translate([0,0,0.5*R]) sphere(0.82*R);
        translate([0,0,-R/2]) scale([0.4,0.4,1]) sphere(2*R);
        difference()
        {   cylinder(r1=R,r2=0,h=1.5*R);
            for(a=[0:60:300]) rotate(a)
                scale([1,4]) cylinder(r1=0.1*R,r2=0,h=0.3*R,$fn=4);
            cylinder(r1=0.2*R,r2=0,h=0.3*R);
        }
    }
}

f=0.5; 
module body()
{
    sf=0.07; hf=0.4;
    union()
    {   difference()
        {   outer_shape();
            for(a=[0:60:300]) rotate(a) union() //CUts out insides
            {   translate([f*R,0,-R]) cylinder(r=sf*R,h=1.1*R);
                hull()
                {   translate([f*R,0]) cylinder(r=sf*R,h=s);
                    translate([f*R/2,0,hf*R/2]) cylinder(r=0.4*R,h=s);
                    translate([0,0,hf*R]) cylinder(r=0.6*R,h=s);
                }
            }
            translate([0,0,hf*R+s]) cylinder(r1=0.6*R,r2=0.12*R,h=(1.3-hf)*R);
        }
        intersection()
        {   union()
            {   translate([0,0,0.8*R]) 
                {   sphere(0.05*R);
                    for(a=[0:60:360]) rotate(30+a)
                        rotate([37,0,0]) scale([1,2]) translate([0,0,-0.04*R]) 
                        cylinder(r=0.05*R,h=R, $fn=4);
                }
                cylinder(r1=0.4*R,r2=0,h=0.4*R,$fn=6);
                cylinder(r=0.07*R,h=0.8*R,$fn=6);
            }
            outer_shape();
        }
    }
}

module bit() 
{   intersection()
    {   translate([0,0,0.2*R]) scale([1,1,3]) sphere(0.12*R);
        cylinder(r1=0.05*R,r2=0.4*R,h=R);
        cylinder(r1=0.4*R,r2=0,h=0.5*R);
    }
}

module maraca(stem_len=stem_len)
{
    union()
    {   body();
        difference()
        {   union() for(a=[0:60:360]) rotate(a) translate([f*R,0]) bit();
            for(a=[0:60:360]) rotate(a) cube(R*[0.04,1,5],center=true);
            cylinder(r1=0.35*R,r2=0,h=0.6*R);
        }
        th=0.2*R;
        if(stem_len>0)
        {
            intersection()
            {   union()
                {   for(a=[0:60:360]) rotate(a)
                                          translate([0.2*R,0,1.1*R]) scale([1,0.6])
                                          cylinder(r=0.1*R,h=stem_len-th/2-0.1*R,$fn=4);
                }
                cylinder(r=0.25*R,h=8*R);
            }
            difference()
            {   rotate_extrude()
                    translate([0.2*R,R+stem_len-th/2]) scale([0.1*R/th,1]) circle(th,$fn=4);
                for(a=[0:60:360]) rotate(a)
                    translate([0,0,R+stem_len-2*th]) scale([1,1,2])
                    rotate([0,90,0]) cylinder(r=0.1*R,h=stem_len-th/2,$fn=4);
            }
        }
    }
}

module maraca_no_stem()
{   maraca(stem_len=-R); }

module show(stem_len=stem_len)
{
    difference()
    {   maraca(stem_len=stem_len);
        cube([R,R,2*R]);
    }
}
module just_show(){ show(); }

module as_printable()
{   maraca(); }

maraca();
//show();
//outer_shape();
