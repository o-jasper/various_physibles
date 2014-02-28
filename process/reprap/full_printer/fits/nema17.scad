include</home/jasper/oproj/physical/reprap/i3ext/inc/nema17.scad>

$realnema=true;

sw=43; //Stepper size.
sh=48;

module nema()
{
    if($realnema) nema17(); 
    else translate([0,0,-sh/2]) color("gray") cube([sw,sw,sh],center=true);
}

//nema();
//translate([0,0,-sh/2]) cube([sw,sw,sh],center=true);
