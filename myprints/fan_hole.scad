
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

module fit_profile()
{
    x = l+h; y= w-ww+rd+dx-wd;
/*    translate([x,y])
    {   translate([-dy,-w-dx]) circle(ex);
        translate([0,-w]) circle(ex);
        circle(ex);
        translate([-wh-h,-(w+ww)/2]) circle(ex);
//        translate([min(-(wh+h)+2*ex,0),0]) circle(ex);
    }
    translate([0,pw]) circle(ex);
    circle(ex);
    */
    minkowski()
    {
        polygon([[x-dy,y-w-dx], [x,y-w], [x,y], 
                 [0,pw], [0,0], [-h,0],
                 [x-wh-h, y-(w+ww)/2]]);
        circle(ex);
    }
//    translate([h-x+ex,-ex-pw-2*(rd+dx)]) color([1,0,0]) cube([x, ww +pw + 2*(ex+rd+dx), 10]);
//    l + h + dy+rd +3*ex;
}

t = 20;
a = 30; //10
module item()
{
    difference()
    {
        color([1,0,0]) linear_extrude(height=t) fit_profile();
        translate([l,0]) rotate([0,-a]) translate([0,0,-inf]) linear_extrude(height=2*inf) 
        window_profile();
        color([0,0,1]) translate([0,0,-inf]) linear_extrude(height=2*inf) pillar_profile();
    }
}

item();
