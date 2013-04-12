
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

w=72; //TODO what are these values??
h= 16;
ww=60;
wh=56;
whe=4; //Less distortion needed to click in on the window.

wd = 13; //Distance between windows.

module window_profile()
{
    translate([h,w-ww+rd+dx-wd]) 
    {   polygon([[0,0], [0,-w],[-dy,-w-dx],[-dy-rd,-w-dx-rd],[-h,-w-dx-rd], [-h,0]]);
        translate([-h-wh,-w-dx-rd]) square([wh,ww]);
        translate([-h-wh,ww-w-inf]) square([wh+whe,inf]);
    }
}

ex = 20;
l  = 100;
sl = 30;
cr = 3;

x = l+h; y= w-ww+rd+dx-wd;

module fit_profile()
{
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
/*      translate([x+sl,y-w/2]) //Removed later.
        {   circle(ex/2);
            translate([-sl,0]) square([2*sl,ex],center=true);
        }*/
        translate([x+ex/3,y+ex/3]) circle(cr); //Holes for adding insolation or something.
        translate([ex/3,pw+ex/3]) circle(cr);
        translate([-h,-ex/2]) circle(cr);
        translate([x-wh-h-ex, y-(w+ww)/2+ex/2]) circle(cr);
    }
}

t = 10; //Thickness of plate.
a = 10; //Angle of window.

mf = 0.2; //Fractions the mounting cylinders go at.
mh = 30; //Height of mounting cylinders.
mr = 5; //idem, radius. 

module item()
{
    xp = l+h+ex/3;  yp= w-ww+rd+dx-wd+ex/3;
    dx = ex/3 - x; dy = pw + ex/3 - y;
    
    r1= ww-t;
    r2= l-ww; //sf=0.2;
    
    difference()
    {
        color([1,0,0]) union()
        {   linear_extrude(height=t) fit_profile();
            intersection()
            {   linear_extrude(height=2*t) fit_profile();
                translate([0,0,t]) union()
                {   translate([x,y-20]) sphere(t);
                    sphere(t);
                    translate([0,ww-2*t]) sphere(t);
                    rotate([-90,0]) cylinder(r=t, h=r1-t);
                    translate([l-ww,0]) sphere(t);
                    rotate([0,90]) cylinder(r=t, h=r2);
                }
            }                
        }
        translate([t+r1/2,t/4+r2/2,-inf])
        {   cube([r1,r2-1.5*t,3*inf], center=true); 
            translate([r1/2,0]) cylinder(r=(r2-1.5*t)/2, h=3*inf);
            translate([-r1/4,(r2-1.5*t)/2]) cylinder(r=r1/4, h=3*inf);
            translate([-r1/2+t/2,-4.75*t]) cylinder(r=1.5*t, h=3*inf);
        }

        translate([l,0]) rotate([0,-a]) translate([0,0,-inf]) linear_extrude(height=3*inf) 
                window_profile();

        color([0,0,1]) translate([0,0,-inf]) linear_extrude(height=3*inf) pillar_profile();

        translate([x+sl,y-w/2,-inf]) linear_extrude(height=3*inf)
        {   circle(ex/2);
            translate([-sl,0]) square([2*sl,ex],center=true);
        }
        
        translate([xp+2*mf*dx, yp+2*mf*dy, -t]) cylinder(r=mr, h=3*t);
        translate([xp+(1-2*mf)*dx, yp+(1-2*mf)*dy, -t]) cylinder(r=mr, h=3*t);
    }
    translate([xp+mf*dx, yp+mf*dy, 0]) cylinder(r=mr, h=mh+t);
    translate([xp+(1-mf)*dx, yp+(1-mf)*dy, 0]) cylinder(r=mr, h=mh+t);
}

scale([-1,1]) item();
