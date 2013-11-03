//Author Jasper den Ouden 24-10-2013
// Placed in public domain

//Think to help clamp a electrical drill into a vice.

h=50;

dy=50;
dx=35;
dr=15;

t=2;

module boormachine_houder()
{
    difference()
    {   linear_extrude(height=h) difference()
        {   square([dx+t,dy],center=true);
            minkowski()
            {   square([dx-2*dr,dy-2*dr+t/2],center=true);
                circle(dr);
            }
            difference()
            {   square([dx,dy-t],center=true);
                minkowski()
                {   square([dx-2*dr,dy-2*dr+t/2],center=true);
                    circle(dr+t/2);
                }            
            }
            square([dx-dr,2*dy],center=true);
        }
    }
    linear_extrude(height=t) difference()
    {   square([dx+t,dy],center=true);
        minkowski()
        {   square([dx-2*dr,dy-2*dr+t/2],center=true);
            circle(dr);
        }
        square([dx-dr,2*dy],center=true);
    }
    
    translate([0,(dy+t)/2]) linear_extrude(height=4*t) difference()
    {   circle(dx/2);
        circle(dx/2-t);
        translate([0,-dx/2-dr/4]) square([dx,dx],center=true);
    }
}

*intersection()
{   boormachine_houder();
//    translate([dx/2-2*t,0]) cube([dy,dy,2*h/3]);
}


h2=15;
l2=40;
t2=4;


module ridge(t2=t2)
{
    translate([1.5*h2,0]) rotate([-90,0,0]) scale([2,1,1]) cylinder(r=t2/2,h=dx-t2-t,$fn=4);
    translate([1.5*h2,dx-t2-t]) rotate([0,90,0]) scale([1,2,1]) cylinder(r=t2/2,h=dx-2*t2,$fn=4);
}

module pushdown()
{   a=50;
    difference()
    {   linear_extrude(height=l2) difference()
        {   union()
            {   circle(h2/2);
                square([1.5*h2,h2/2]);
                translate([1.5*h2,0]) square([dx-h2/2,dx-h2/2+t]);
            }
            circle(h2/3);
            translate([1.5*h2+t,-h2/2]) square([dx,dx]);
        }
    }
    for(z=[t2/2,l2/2,l2-t2/2]) translate([0,0,z]) ridge();
    translate([1.5*h2,dx-t2-t]) cylinder(r=t2,h=l2, $fn=4);
//    translate([1.5*h2+t-t2,0]) rotate([a,0,0]) cube([t2,(dx)/sin(a),t2]);
}

pushdown();
