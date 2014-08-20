
angle = 60;  // Slice of the pie.
R = 100;
t = 4;
tz = t;

r = 20; //Drop and siphon size.

h = 50;

cd = 20; //Size of center shape.
module centershape() {
    square([cd,cd], center=true);
}

module base2d(t=t) { 
    
    minkowski() {
        intersection() {
            circle(R);
            translate([-R,0]) square(2*[R,R]);
            rotate(180-angle) translate([-R,0]) square(2*[R,R]);
        }
        if(t>0) circle(t);
    }
    translate([-cd/2-r,0]) circle(r + t);
}

side_extra = false;
bottom_extra = true;

hbe = tz + 2*t;
tbe = t;


a = 0;
f=0.6;


// TODO place siphon.

// TODO thicker rims for strength.

difference() {
    union() {
        difference() {
            rotate(a) union() {
                linear_extrude(height=h) base2d();
                // Extras on sides for strength.
                if( side_extra ) for( g= [1, -1]) rotate(g==1  ? 0 : -angle) hull() {
                    translate([0, -g*t, 2*t]) scale([1,1,2]) sphere(t);
                    translate([t-R, -g*f*t, h-3*t]) scale([1,1,2]) sphere(t);
                }
            }
            rotate(a) translate([0,0,tz]) linear_extrude(height=2*h) base2d(t=0);
        }
        if( bottom_extra ) linear_extrude(height = 2*tz + t) {
                hull() {
                    circle(tbe/2);
                    rotate(90 + angle) translate([R, 0]) circle(tbe/2);
                }
                for(a2=[1.5*angle, angle/2]) hull() {
                    rotate(90 + angle) translate([R/2 + t,0]) circle(tbe/2);
                    rotate(90 + a2) translate([R,0]) circle(tbe/2);
                }
            }
        linear_extrude(height=h) minkowski() {
            centershape();
            circle(t);
        }
    }
    translate([0,0,-h]) linear_extrude(height=3*h) centershape();
}
