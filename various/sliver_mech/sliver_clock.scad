//
//  Copyright (C) 22-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<MCAD/involute_gears.scad>
//No idea if this shit works.

rh=2.5;
t=2;

th=2;

module escapement_gear(r,R,n,f)
{
    t= 6.14*r/n;
    circle(r);
    for(a=[0:360/n:360*(1-1/n)]) rotate(a) polygon([[r-t/2,-t/2],[R,f*t],[r-t/2,t/2]]);
}

module escapement(R,d,r)
{
    difference()
    {   union()
        {   difference()
            {
                union()
                {   translate([0,-R]) circle(R);
                    scale([1/2,1]) circle(0.7*R);
                }
                translate([0,-1.2*R]) difference()
                {   circle(R);
                    for(x=[R,-R]) translate([x,d]) 
                                      rotate(45) square([d,d],center=true);
                }
            }
            circle(0.3*R);
        }
        for(y=[0:4*rh:R-2*rh]) translate([0,y]) circle(rh);
    }
}

r=20;
R=40;
n=12;
f=0.2;
//escapement_gear(r,R,n,f);
//translate([0,1.4*R]) escapement(R,(R-r)/2);

module gear_outer(number_of_teeth=15,
                  circular_pitch=false, diametral_pitch=false,
                  pressure_angle=28,
                  clearance = 0.2,
                  gear_thickness=5,
                  rim_thickness=8,
                  rim_width=5,
                  hub_thickness=10,
                  hub_diameter=15,
                  bore_diameter=5,
                  circles=0,
                  backlash=0,
                  twist=0,
                  involute_facets=0,
                  flat=false)
{
	if (circular_pitch==false && diametral_pitch==false)
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

        gear_shape(number_of_teeth=number_of_teeth,
                   pitch_radius = pitch_radius,
                   root_radius = root_radius,
                   base_radius = base_radius,
                   outer_radius = outer_radius,
                   half_thick_angle = half_thick_angle,
                   involute_facets=involute_facets);
}

pitch = 250;
mf= 51*pitch/(500*36);

module g(n)
{   gear_outer(number_of_teeth=n, circular_pitch=pitch); }
module gp(ka,kb,m=ka+kb)
{ 
    if( k1+k2 != m )
    { echo("Error incorrect number of teeth for distance!"); 
    }
    g(ka);
    translate([0,mf*(ka+kb)]) rotate(180/kb) g(kb);
}

module show_sequence(hor=false)
{
    v = hor ? [0,70*mf] : [0,0,10*th];
    //(1/5 minute)
    translate(v*-1) 
    {   escapement_gear(r,R,n,f);
        translate([0,1.4*R]) escapement(R,(R-r)/2);
    }
        
    translate(v*0) gp(7,35,  42);  //x5 (1 minute)
    translate(v*1) gp(21,21, 42); //x1 (1 min) //*
    translate(v*1) sphere(4);
    
    translate(v*2) gp(7,35,  42); //x5  (5 min)
    translate(v*3) gp(28,14, 42); //x2  (10 min)
    translate(v*4) gp(6,36,  42);  //x6 (60 min = 1h) 
    translate(v*5) gp(21,21, 42); //x1  (1h) //*
    translate(v*5) sphere(4);
    
    translate(v*6) gp(36,6,  42);  //x6 (6h)
    translate(v*7) sphere(4);

    translate(v*7) gp(14,28, 42); //x2  (12h = 0.5d) 
    translate(v*8) g(21);

    translate([0,-mf*42]) 
    {
        translate(v*1) g(21);
        translate(v*5) g(21);
        translate(v*8) g(21);
    }
}

show_sequence();

module base_plate()
{
    hull()
    {   circle(mf*36+2*t);
        translate([0,mf*42]) circle(mf*36+2*t);
        translate([0,-mf*42]) circle(mf*21+2*t);
    }
}
base_plate();
