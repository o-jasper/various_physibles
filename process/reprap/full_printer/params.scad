
t=4;
pt=10; //Plate thickness.

bh=20; //Bed height.
bw=200;

bsd=5;

bbr=4;//5; //Smooth rod radius.
sbr=3;

sw=43; //TODO correct value
sh=sw;
ssd=sw/6;

zrd=pt+t/2+sw/2; //... OR use gears at the bottom to get them as close as possible..
//zrd= pt+bbr+2*t; //Z rod distance.
dc=bbr/sqrt(2)+t; //Distance of bed corners to rods.

w=bw+2*pt+2*zrd-2*t; 
l=w; 
fh=40; //Front height.

bzd=min(bw/3, 100-bbr-t);

bt=1.5*t; //Bottom thickness of corners.

sr=2; //Screw radius.

rod_adjustable=false;

aw=2*t;

min_a=20;
max_a=70;

ad=(w-sqrt(2)*zrd)/cos(min_a)-t;
ah=3*aw;
aR=ad/5;
ar=aR/3;

adx= zrd+2*bbr+t;// w/2-pt-t-ah/2-2*bbr-t; //Distance from corners of thingy.

function bed_z(a) = ah/2-t + 2*ad*sin(a)-(fh-aw-3*t);

max_z=bed_z(max_a);
min_z=bed_z(min_a);

h=max_z+2*fh+2*bh; //Sizes.

tbr=20; //Timing belt radius.

pr = 10; //Radius of pulleys.
phz = 5*t+2*bbr+pr; //Distance 'it hangs'
hl=max(sw+pt+2*(t+sr),80); //Length it holds the plates.

xrh = bbr+bt+2*t; //How far the x rod hangs.
