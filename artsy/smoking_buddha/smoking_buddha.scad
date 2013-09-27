
rim_h=5;

module buddha()
{  rotate(-7) import("buddha-fixed-bottom.stl"); }

module cutout()
{   translate([0,0,14.5]) linear_extrude(height=30) 
    { circle(15); translate([0,40]) square([30,80],center=true); }
}

module slider()
{   intersection()
    {   buddha(); 
        difference()
        {   cutout();
            translate([0,0,17.5+rim_h]) cylinder(r=20,h=100);
            translate([0,0,17.5]) cylinder(r=13,h=100);
        }
    }
}

module foot()
{   cylinder(r1=3,r2=4, h=5); }

module smoking_buddha()
{
    union()
    {   difference()
        {
            buddha();
            cutout();
            //translate
            for(a=[-180:30:0]) rotate(a) translate([15,0,-10]) //Air holes.
                               {   cylinder(r=2,h=40);
                                   translate([0,0,40]) cylinder(r1=2,r2=0,h=5.5);
                               }
            hull()
            {   translate([0,0,44]) cylinder(r=15,h=1);
                translate([0,12,76]) cylinder(r=1,h=1);
            }
            translate([-100,12,76]) rotate([0,90,0]) cylinder(r=1,h=200);
            translate([-1.5,-1,77]) rotate([225,0,0]) 
            {   cylinder(r1=1,r2=5,h=10);
                translate([0,0,10]) sphere(5);
            }
        }
        //Feet(off surface so air can come in.
        translate([0,-2]) for(a=[0:90:270]) rotate(45+a) translate([25,0]) foot();
        translate([0,23]) foot();
        for(s=[1,-1]) translate([s*25,-4]) foot();
        translate([0,-25]) foot();
    }
}
smoking_buddha();
