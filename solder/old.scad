
plate_w = 10;
// Can-based soldering iron holder. 

can_r = 30; //Radius of can.
can_h = 100; //Height of can.
can_taper = 5; //Taper of can.(slant on end.

can_a = 37;

duct_n = 5;
duct_r = plate_w/2;

min_w = -2;

cut_fx = -(can_r-plate_w)/2;
cut_x= 0;

rotate_extrude(convexity = 10)
{ square([can_r])
}


module holder_part()
{
    sx = (2*can_r -plate_w)/can_r;
    sy = (can_h/2-plate_w)/can_r;
    
    r = can_r+plate_w;
    rh = can_r; dn = duct_n-1;

    difference()
    {   translate([0,0,-plate_w]) 
            cylinder(r = r, h=can_h+plate_w);
        cylinder( r = can_r, h=2*can_h);
        rotate(v=[1,0,0],a=90) 
        {   translate([r,can_h/2,-2*can_r]) 
                scale([sx,sy,1]) cylinder(r=can_r, h=4*can_r);
        }
//        translate([0,can_r]) 
        for(i=[0:dn])
        {   
            translate([rh*sin(-i*180/dn),rh*cos(-i*180/dn)]) 
                rotate(v=[0,1,0],a=can_a) //TODO union it with..
                translate([0,0,-can_h]) cylinder(r=duct_r, h=3*can_h);
        }
    }
}

module holder_cutter()
{
    rotate(v=[1,0,0],a=90) 
    translate([0,0,-can_r]) linear_extrude(h=4*can_r)
        polygon([[-2*can_r,can_h/2],[-2*can_r,2*can_h],[2*can_r,2*can_h],
                 [2*can_r,can_h/2], [cut_fx,can_h/2],
                 [cut_x,0],[cut_x,-can_h], [-2*can_r,-can_h]]);

//    translate([0,0,can_h/2]) square([4*can_r,4*can_r,can_h],center=true);
//    translate([-2*can_r,0]) square([2*can_r,4*can_r,can_h]);
    //TODO
}

//holder_cutter();

//translate([0,4*can_r]) holder_part();
