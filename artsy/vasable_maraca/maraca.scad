//Copyright (c) 2013 Jasper den Ouden, 
// placed in public domain or creative commons CC0, whichever you choose

//Maraca intended to be printable as a single layer.('vaselike')

//Generating a model could take a while.

$fn=80;
$fs=0.5;

R=40;       //Overall size.
t=2;        //Thicknesses.
stem_len=R; //Length of handle. Negative to disable handle.

s=0.6;
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
            difference() //Inside cavity.
            {   scale((R-t)*[1,1,1]/R) outer_shape();
                cube([4*R,4*R,s],center=true);
            }
            for(a=[0:60:300]) rotate(a) //Holes for pegs.
                translate([f*R,0]) cylinder(r1=sf*R,r2=2*sf*R,h=2*s);
            //Hole in top.
            translate([0,0,hf*R+s]) cylinder(r1=0.6*R,r2=0.12*R,h=(1.3-hf)*R);
        }
        intersection()
        {   union() //Inside beam
            {   cylinder(r1=0.4*R,r2=0,h=0.4*R,$fn=6);
                cylinder(r=0.07*R,h=0.8*R,$fn=6);
                translate([0,0,0.8*R]) //Spokes.
                {   sphere(0.05*R);
                    for(a=[0:60:360]) rotate(30+a) 
                        rotate([37,0,0]) scale([1,2]) translate([0,0,-0.02*R]) 
                        cylinder(r=0.05*R,h=R, $fn=4);
                }
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

module vasable_maraca(stem_len=stem_len)
{
    th=0.2*R;
    union()
    {   body();
        for(a=[0:60:360]) rotate(a) translate([f*R,0]) bit();
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

module vasable_maraca_no_stem()
{   vasable_maraca(stem_len=-R); }

module show(stem_len=stem_len)
{
    difference()
    {   vasable_maraca(stem_len=stem_len);
        cube([R,R,2*R]);
    }
}
module just_show(){ show(); }

module as_printable()
{   vasable_maraca(); }

show();
/*
difference()
{   body();
    cube([R,R,2*R]);
    }*/
//show();
//outer_shape();
