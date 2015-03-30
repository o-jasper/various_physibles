
// Low-spec flexible driveshaft
// (hopefully! not sure how it will work out..)

ra = 3;
t = 4;
r = ra + 1.2*t;
d = r + t/2;

t_rod = 0.8*t;
f=1.3;

module link_hole() {
    translate([d,0,-4*t]) cylinder(r=ra, h=8*t);
    for(a=[0,180]) rotate([a,0]) translate([d,0, t/2]) cylinder(r1=r,r2=r+4*t, h=8*t);
}

// A link in the chain, connecting two directions so it can keep its angle.
// (hopefully)
module link_whole() {
    difference() { hull() {
            translate([d, 0]) scale([r, r, f*t]/r) sphere(r);
            translate([-d, 0]) scale([r, f*t, r]/r) sphere(r);
        }
        link_hole();
        rotate([90,0]) rotate(180) link_hole();
    }
}

module link_whole_printable() {
    intersection() {
        rotate([45,0]) link_whole();
        //Flatten bottom(and rest, for symmetry)
        cube([8*r, 2*r-1.5*t, 2*r-1.5*t], center=true);
    }
}

module rod(l) {
    t = t_rod;
    pos = [0, l];
    intersection() {
        hull() for(x = pos) translate([x,0]) sphere(r);
        difference() {
            union() {
                for(z=[-t, t]) translate([0,0,z]) cube([8*l, 2*r, t], center=true);
                translate([l/2,0,-1.5*t]) cylinder(r=l/2-r+t, h=3*t);
            }
            for(x = pos) translate([x,0]) {
                translate([0,0,-4*t]) cylinder(r=ra, h=8*t);
                translate([0,0,-t/2]) cylinder(r=r, h=t);
            }
        }
    }
}

module rod_printable(l) {
    intersection() {
        rotate([90,0]) rod(l);
        cube([8*l,2*r, 2*r-t/3], center=true);
    }
}

rod_printable(100);
translate([0,2*r]) link_whole_printable();

// TODO animate it.
