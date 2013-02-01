
// Can-based soldering iron holder. 

can_r = 30; //Radius of can.
can_h = 100; //Height of can.
can_taper = 5; //Taper of can.(slant on end.

can_a = 37;

duct_n = 5;
duct_r = plate_w;

min_w = -2;
plate_w = 10;

module holder_part()
{
    sx = (2*can_r -plate_w)/can_r;
    sy = (can_h/2-plate_w)/can_r;
    
    r = can_r+plate_w;
    rh = can_r;

    difference()
    {   translate([0,0,-plate_w]) 
            cylinder(r = r, h=can_h+plate_w);
        cylinder( r = can_r, h=2*can_h);
        rotate(v=[1,0,0],a=90) 
        {   translate([r,can_h/2,-2*can_r]) 
                scale([sx,sy,1]) cylinder(r=can_r, h=4*can_r);
//            translate([r,can_h/2, can_r/2]) 
//                scale([sx,sy,1]) cylinder(r1=can_r,r2=2*can_r, h=4*can_r);
        }
        for(i=[0:duct_n])
        {   
            translate([rh*sin(-i*160/duct_n),rh*cos(-i*160/duct_n),-plate_w]) 
                rotate(v=[0,1,0], a= -can_a) 
                translate([0,0,-can_h]) cylinder(r = duct_r, h = 4*can_h);
        }
    }
}

holder_part();
