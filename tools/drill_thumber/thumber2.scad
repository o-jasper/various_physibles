//Author Jasper den Ouden 24-10-2013
// Placed in public domain

$fn=60;

//Clamps (small) drills for easier manual handling.
sr=1.8;
s=0.6;

dr=0.4;

t=4;
r=5;
ri=2;
l=9*sr;
w=0.7*l;

hw=w/3;
hwo=2*w/3;

sx= min(l/4, l/2-3*sr);

module teardrop(r) //Look at the MCAD version.. MCAD needs to simplify their shit.
{   circle(r);
    translate([-r/sqrt(2),0]) rotate(45) square([r,r],center=true);
}

module base()
{   intersection()
    {   union()
        {   scale([l/w,1,1.7*t/w]/2) sphere(w);
            translate([-l/2+t/2,0,t/4]) cube([t,t/2,t/2],center=true);
        }
        difference()
        {   cube([8*l,8*l,t],center=true);
            translate([sx,0,-l]) cylinder(r=sr,h=8*l);
        }
    }
}

module drill_space()
{   translate([-l/6,-w,0]) rotate([-90,0,0]) cylinder(r=0.4,h=8*w); }
module top()
{
    difference()
    {   intersection()
        {   union() 
            {   intersection()
                {   base();
                    translate([0,0,l]) cube(2*[l,l,l],center=true); //Just the top.
                }
                //Hinge shape.
                translate([-l/2,0,ri]) intersection()
                {    translate([0,-hw/2]) rotate([-90,0,0]) 
                        linear_extrude(height=hw) rotate(90) teardrop(r);
                    scale([0.7,1,0.7]) sphere(sqrt(hw*hw + 4*r*r)/2);
                }
                translate([-l/2+r,0,t/4]) scale([1,1,1/2]) sphere(hw/2);
            }
            translate([0,0,r]) cube([8*l,8*l,2*r],center=true);
        }//ends of the hinge.
        for(y=[hw/2,-hw/2-w]) translate([-l/2,y,ri]) rotate([-90,0,0]) cylinder(r=r,h=w);
        translate([-l/2,-w,ri]) rotate([-90,0,0])  //Hinge hole.
            linear_extrude(height=8*w) rotate(-90) teardrop(ri+s);
        drill_space();
    }
}
//top();

module bottom()
{
    difference()
    {   intersection()
        {   union() 
            {   intersection()
                {   union()
                    {   base();
                        //Hinge shape.
                        translate([-l/2,0,ri]) intersection()
                        {   translate([0,-hwo/2]) rotate([-90,0,0]) 
                                rotate(90) linear_extrude(height=hwo) 
                                rotate(180) teardrop(ri);
                            sphere(hwo/2);
                        }

                    }
                    translate([0,0,l]) cube(2*[l,l,l],center=true); //Just the top.
                }
                for(y=(hwo/2-ri)*[1,-1]) translate([-l/2,y,ri]) 
                {   rotate([0,90,0]) cylinder(r=ri,h=r);
                    translate([r,0]) scale([2,1,1]) sphere(ri);
                }
            }
            cube([8*l,8*l,3*r],center=true);
        }//ends of the hinge.
        translate([-l/2,-hw/2-s,ri]) rotate([-90,0,0]) 
            linear_extrude(height=hw+2*s) difference()
        {   circle(r+s);
            circle(ri+s);
        }
        translate([sx,0,t/4]) cylinder(r1=2*sr,r2=2*sr+l,h=l, $fn=6);
        
        drill_space();
    }
   
}
module as_print()
{
    bottom();
    translate([-l,0]) rotate(180) top();
}
as_print();
