
// Low-spec flexible driveshaft
// (hopefully! not sure how it will work out..)

ra = 3;
t = 4;
r = ra + 1.2*t;
d = r + t/4;

s = 0.5;

t_rod = 0.8*t;
f=1.3;

module link_hole() {
    translate([d,0,-4*t]) cylinder(r=ra, h=8*t, $fn=32);
    for(a=[0,180]) rotate([a,0]) translate([d,0, t/2]) cylinder(r1=r,r2=r+4*t, h=8*t);
}

// A link in the chain, connecting two directions so it can keep its angle.
// (hopefully)
module link() {
    difference() { hull() {
            translate([d, 0]) scale([r, r, f*t]/r) sphere(r);
            translate([-d, 0]) scale([r, f*t, r]/r) sphere(r);
        }
        link_hole();
        rotate([90,0]) rotate(180) link_hole();
    }
}

module link_printable() {
    intersection() {
        rotate([45,0]) link();
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
                for(z=[-t-s, t+s]) translate([0,0,z]) cube([8*l, 2*r, t-s/2], center=true);
                translate([l/2,0,-1.5*t]) cylinder(r=l/2-r+t/2, h=3*t);
            }
            for(x = pos) translate([x,0]) {
                translate([0,0,-4*t]) cylinder(r=ra, h=8*t, $fn=32);
                translate([0,0,-t/2-s]) cylinder(r=r + s, h=t+2*s, $fn=32);
            }
        }
    }
}

module rod_printable() {
    l = 100;
    intersection() {
        rotate([90,0]) rod(l);
        cube([8*l,2*r, 2*r-t/3], center=true);
    }
}

module plug() {
    sr = 0.6;
    $fs = 0.1;
    difference() {
        union() {
            cylinder(r=ra-s, h=2.5*t-2*s, $fn=32);
            intersection() {
                translate([0,0,t]) scale([1,1,f]) sphere(ra+t/2);
                cylinder(r=ra+r/2, h=t);
            }
        }
        for(x=[-ra,ra]/3) translate([x,0,-t]) cylinder(r=sr, h=8*t);
        translate([0,0,-t]) cylinder(r1=2*ra, r2=0, h=2*t);
    }
}

module show_print_ish() {
    rod_printable(100);
    translate([0,2*r]) link_printable();
    plug();
}
//show_print_ish();

module show_plugs() {
    translate([0, 2.5*t-1.5*s]) rotate([90,0]) plug();
    //rotate(180) translate([0, 2.5*t-1.5*s]) rotate([90,0]) plug();
}

module show() {
    rod_printable(100);
    rotate([0,90*$t,0]) {
        color("green") show_plugs();
        color("blue") translate([-d+0.1,0]) rotate([45,0]) link_printable();
        translate([-2*d+0.1, 0]) rotate(90*$t) rotate(180) rotate([90,0]) {
            color("green") show_plugs();
            rod_printable(100);
        }
    }
}
show();
// TODO animate it.
