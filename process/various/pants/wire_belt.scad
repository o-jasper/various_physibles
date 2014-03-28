//
//  Copyright (C) 16-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;

//Note: the melt mechanism is after the segments.

t=1.5;  //thicknesses.
lr=0.6; //Radius of line.
h=30;  //Height of belt.
sl=10; //Segment length.

include<o-jasper/nut.scad>

echo(1.5*(lr+t));

module segment(d=h-t)
{
    rels=d*[1,-1]/2;
    ir=lr+t;
    hull() for(x=rels) translate([x,0]) scale([ir,ir,0.65*sl]/sl) sphere(sl);
}

//Segment of belt.
module wire_segment(d=h-t)
{
    rels=d*[1,-1]/2;
    intersection()
    {   segment(h=h,lr=lr,sl=sl,d=d);
        translate([0,0,-sl/2]) linear_extrude(height=sl) difference()
        {   square([8*h,8*h],center=true);
            union() for(x=rels) translate([x,0]) circle(lr);
        }
    }
}
//Bead of belt(used in pairs.
module wire_bead()
{   wire_segment(sl=sl/2,d=0); }


module sub(r,d,inf=-1)
{   inf = (inf>0 ? inf : 8*d);
    difference()
    {   translate([0,-inf]) square(2*[inf,inf]);
        translate([d,0]) hull()
        {   translate([2*d,0]) square(2*[r,r],center=true);
            circle(r);
        }
    }
}

module flattened_segment(d=h-t)
{   rels=d*[1,-1]/2;
    intersection()
    {   segment(sl=sl,d=h-t);
        translate([0,0,-4*h]) linear_extrude(height=8*h) difference()
        {   square([8*h,1.5*(lr+t)],center=true);
            union() for(x=rels) translate([x,0]) circle(lr);
        }
    }
}

al=h; aiR=1.3*t;air=t; 
module wire_h_arching_segment(extra_round=true,holes=true,dimples=true)
{
    arch_r=h/2-lr-t;
    intersection()
    {   rotate([90,0,0]) wire_segment(sl=al,d=h-t);
        difference()
        {   cube([h+2*(lr+t),al,1.5*(lr+t)],center=true);
            //Substracts what makes the arches.
            scale([1,1,0.6]) rotate([0,90,0])
                rotate_extrude() translate([al/2,0]) 
                scale([(al/2-2*t)/arch_r,1]) circle(arch_r);
            if(holes) for(x=(h-4*t-4*lr)*[1,-1]/2) translate([x,0]) //Extra holes for fun.
                rotate_extrude() difference()
            {   translate([0,-4*t]) square([aiR+air,8*t]);
                translate([aiR+air,0]) circle(air);
            } //Dimples
            if(dimples) for(x=[-1,1]*(aiR+air+t)) for(y=(h-4*t-2*lr)*[1,-1]/2) 
                                    translate([y,x,lr+0.8*t]) sphere(t);
        }
        if(extra_round) union() for(x=[h-t,t-h]/2) hull()
        {   sphere(2*(lr+t)); 
            translate([x,0]) for(y=(al/2-2*t)*[1,0,-1]) translate([0,y]) sphere(2*t);
        }
    }
}
//Segment consisting with a frame with a thin plate.
module wire_flatback_segment(hole=false,d=h-t)
{
    rels=d*[1,-1]/2;
    intersection()
    {
        union()
        {   for(x=rels) translate([x,0])
            {   hull() for(y=(al-t)*[1,-1]/2) translate([0,y]) sphere(lr+0.8*t); }
            for(y=(al-t)*[1,-1]/2) translate([0,y]) 
            {   hull() for(x=rels) translate([x,0]) sphere(lr+0.8*t); }
            translate([0,0,-t]) cube([al,h,t],center=true);
        }
        difference()
        {   cube([h+t,al+t,1.5*(lr+t)],center=true);
            for(x=rels) translate([x,-al]) rotate([-90,0,0]) cylinder(r=lr,h=8*al);
            if(hole) translate([0,0,-2*t]) scale([al/2-2*t,h/2-2*t]/al) cylinder(r=al,h=8*t);
        }
    }
}
module wire_flatback_segment_hole(){ wire_flatback_segment(hole=true); }

module show_segments()
{
    d= al/2+2*t;
    wire_segment();
    translate([0,2*d]) wire_bead();

    translate([0,d]) wire_h_arching_segment();
    translate([0,3*d]) wire_h_arching_segment(holes=false,dimples=false);
    translate([0,5*d]) wire_flatback_segment();
    translate([0,7*d]) wire_flatback_segment_hole();
}
//Belt mechanism.

module wire_belt_male(d=h-t)
{   rels=d*[1,-1]/2;
    difference()
    {   union()
        {   intersection()
            {   hull() for(x=rels) for(y=[0,sl/2]) translate([x,y]) sphere(lr+t);
                translate([0,0,4*sl-0.75*(lr+t)]) cube(sl*[8,8,8],center=true);
            }
            //Leads to the screw holder.
            translate([0,0,-0.75*(lr+t)]) linear_extrude(1.5*(lr+t)) hull()
            {   translate([0,sl]) circle(shr+t);
                for(x=[1,-1]*(h/2-2*t)) translate([x,0]) circle(t);
            }
            for(x=[h,-h]/4) hull()
            {   translate([0,sl]) cylinder(r=shr+t,h=2*t);
                translate([x,0]) sphere(t);
            }
        }
        translate([0,sl]) cylinder(r=shr,h=8*t);
        translate([0,sl,-4*t]) cylinder(r=sr,h=8*t);
        for(x=rels) translate([x,-sl]) rotate([-90,0,0]) cylinder(r=lr,h=8*sl);
    }
}

bsl=60;
module wire_belt_female()
{
    intersection()
    {   union()
        {   translate([0,-sl+4*t]) rotate([90,0,0]) flattened_segment(h=h,t=t,lr=lr);
            scale([1,1,1.2]) hull()
            {   sphere(lr+5*t);
                translate([0,bsl]) sphere(lr+5*t);
            }
            translate([0,0,-0.75*(lr+t)]) linear_extrude(1.5*(lr+t)) hull()
            {   translate([0,sl]) circle(shr+t);
                for(x=[1,-1]*(h/2-2*t)) translate([x,0]) circle(t);
            }
        }
        translate([0,0,-0.75*(lr+t)]) linear_extrude(height=1.5*(lr+t)) difference()
        {   square([8*bsl,8*bsl],center=true);
            hull()
            {   circle(sR);
                translate([0,bsl]) circle(sR);
            }
        }
    }
}

module show_connector()
{   translate([0,h]) wire_belt_female();
    wire_belt_male();
}

module show()
{   show_connector();
    translate([h+4*t,0]) show_segments();
}
show();
