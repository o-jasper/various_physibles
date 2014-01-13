// Author Jasper den Ouden 4-10-2013
// placed in public domain.
//
//  Do _not_ use medically. I retract all responsibility i can, *you* be
// responsible with what you do with these geometries.

//Currently everything here intended to be printed with one layer.
// (slicers --spiral-vase is good)

$fs=0.1;
$fn=120;

R=10; //Radius of syringe.
t=1; //Thickness of wall. (added to radius of outer part so it can slide.)

h=50;//height of cylinder.
//eh = 5;

//Part of the syringe on the inside, the moving bit.
// `rotate_grab` puts a slot in for which i may make a grabbed.(or it may be useless)
// `hand_syringe` adds a handle. (the module makes it)
//Needs to be printed as one layer, _with_ a bottom if either of the above is true.
module inner_syringe(rotate_grab=true, hand_syringe=false)
{   
    difference()
    {   union()
        {   rotate_extrude() difference()
            {   union()
                {   polygon([[0,0], [0.6*R,0], [R,R], [R,h-R],[0,h]]);
                    if(hand_syringe)
                    {   translate([0,-2*R]) square([0.6*R,2*R]);
                    }
                }
                //Room to clamp 'rubber'(a balloon/condom might work)
                translate([R,h-2.2*R]) 
                    scale([1,1.5]) rotate(45) square([R,R]*0.6,center=true);
                if(rotate_grab) translate([0,h-R]) rotate(45) square(1.2*[R,R],center=true);
            }
            if(hand_syringe) translate([0,0,-1.7*R]) intersection()
            {   union() for(a=[90,-90]) rotate([0,a,0]) 
                        cylinder(r1=0.6*R,r2=0.3*R, h=1.2*R);
                difference()
                {   sphere(R);
                    translate([0,0,-2.3*R]) cube(R*[4,4,4],center=true);
                }
            }
        }
        if(rotate_grab)
        {   cube([0.9*R,0.4*R,2*(h-R)],center=true); //Thing can slide in, rotate to grab it.
            scale([1,1,2]) rotate([0,45,0]) cube(R*[0.4,2,0.4],center=true);
        }
    }
}
//The body of the syringe.(Print as on layer, no bottom or top)
module outer_syringe()
{   union()
    {
        cylinder(r=R+t,h=h-R);
        translate([0,0,h-R]) cylinder(r1=R+t,r2=t, h=R+t);
        cylinder(r=t,h=h+2*t);
    }    
}
//syringe with sort of handle. Print one layer, with bottom.
module hand_syringe()
{   inner_syringe(rotate_grab=false, hand_syringe=true); }

module as_printable()
{   translate([-2*(R+t),0,2*R]) hand_syringe();
    inner_syringe();
    translate([2*(R+t),0]) outer_syringe();
}

module as_assembled(hand_syringe=true) //Note: very little to see.
{   outer_syringe();
    if(hand_syringe){ hand_syringe(); }
    else            { inner_syringe(); }
}

as_printable();
//as_assembled();
