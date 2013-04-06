
pw = 54; //Pillar without edge stuff
dy = 10;
dx = 5;
rd = 5; //Size of rubbery thing.

inf =200;

module pillar_profile()
{
    polygon([[-inf,0], [0,0], [0,pw], [-dy, pw + dx],
             [-dy-rd, pw + dx+rd], [-inf, pw + dx+rd]]);
    translate([-inf,0]) square([inf-dy-rd,inf]);
}

w=72;
h= 16;
ww=60;
wh=56;
wd = 13; //Distance between windows.

module window_profile()
{
    translate([h,w-ww+rd+dx-wd]) 
    {   polygon([[0,0], [0,-w],[-dy,-w-dx],[-dy-rd,-w-dx-rd],[-h,-w-dx-rd], [-h,0]]);
        translate([-h-wh,-w-dx-rd]) square([wh,ww]);
        translate([-h-wh,ww-w-inf]) square([wh,inf]);
    }
}


ex = 20;
l  = 90;
sl = 30;
cr = 3;

module fit_profile()
{
    x = l+h; y= w-ww+rd+dx-wd;

    difference()
    {   union()
        {   minkowski() //TODO spring-like structure to make putting it on easier.
            {
                polygon([[x-dy,y-w-dx], [x,y-w], [x,y], 
                         [0,pw], [0,0], [-h,0],
                         [x-wh-h, y-(w+ww)/2]]);
                circle(ex);
            }
            translate([x+sl,y-w/2])
            {   circle(ex);
                translate([-sl/2,0]) square([sl,2*ex],center=true);
            }
        }
        translate([x+sl,y-w/2])
        {   circle(ex/2);
            translate([-sl,0]) square([2*sl,ex],center=true);
        }
        translate([x+ex/3,y+ex/3]) circle(cr); //Holes for adding insolation or something.
        translate([ex/3,pw+ex/3]) circle(cr);
        translate([-h,-ex/2]) circle(cr);
        translate([x-wh-h-ex, y-(w+ww)/2+ex/2]) circle(cr);
    }
}

t = 20; //Thickness of plate.
a = 10; //Angle of window.

mf = 0.2; //Fractions the mounting cylinders go at.
mh = 60; //Height of mounting cylinders.
mr = 5; //idem, radius. 

module item()
{
    
    x = l+h+ex/3;  y= w-ww+rd+dx-wd+ex/3;
    dx = ex/3 - x; dy = pw + ex/3 - y;
    
    difference()
    {
        color([1,0,0]) linear_extrude(height=t) fit_profile();
        translate([l,0]) rotate([0,-a]) translate([0,0,-inf]) linear_extrude(height=2*inf) 
        window_profile();
        color([0,0,1]) translate([0,0,-inf]) linear_extrude(height=2*inf) pillar_profile();

        translate([x+2*mf*dx, y+2*mf*dy, -t]) cylinder(r=mr, h=3*t);
        translate([x+(1-2*mf)*dx, y+(1-2*mf)*dy, -t]) cylinder(r=mr, h=3*t);
    }
    translate([x+mf*dx, y+mf*dy, -mh-t]) cylinder(r=mr, h=mh+t);
    translate([x+(1-mf)*dx, y+(1-mf)*dy, -mh-t]) cylinder(r=mr, h=mh+t);
}

item();
