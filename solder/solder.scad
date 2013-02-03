
plate_w = 10;
// Can-based soldering iron holder. 

pillar_r = plate_w*0.7;
pillar_hole_r = pillar_r/2;

flat_foot_p = true;

solder_r = plate_w; //Radius at holding place soldering iron.
solder_room = 2*plate_w;

can_r = 30; //Radius of can.
can_h = 100; //Height of can.
can_a = 40; //Angle of can(and thus soldering iron.

can_sheeth_w = -plate_w; //Optional sheeth over entire can.

base_square_p = false; //Whether soldering iron base is square.
base_min_front_p = false; //Whether to minimize front width.
base_back_p = true; //Whether backside has base too.

base_h = plate_w; //Height of base.
base_wall_h = plate_w; //Height of a little wall in the base.

base_l = (can_h*sin(can_a)+can_r*cos(can_a))+2*plate_w; //Length of base.
//Width of front of soldering iron base.
base_front_w = (base_square_p ? 2*(can_r+plate_w) : 
                (base_min_front_p ? 2*pillar_r : 2*(can_r-plate_w)));

reinforcement_r = can_r; //Radius of side reinforcement.
base_wall_w = plate_w/3; //Wall of little container at bottom.(if any)

friction_plug_r = pillar_hole_r; //Plug for friction.
friction_plug_h = base_h/2;

front_pillar_a = 20;

can_inner_r = 25;
can_inner_h = plate_w;;

can_top_h = 2*plate_w;
can_bottom_h = 1*plate_w;
can_hold_start_z = plate_w;
can_hold_end_z = 0;

module donut(R,r)
{ rotate_extrude(convexity = 10){ translate([R,0]) circle(r); } }

//duct();

module holder_part()
{
    difference()
    {   union()
        {   donut(can_r,plate_w);
            translate([0,0,can_h]) donut(can_r,plate_w);
            translate([0,reinforcement_r-can_r-plate_w]) 
                cylinder(r=reinforcement_r, h=can_h);

            if(can_sheeth_w>0) //The sheeth.
            { cylinder(r= can_r + can_sheeth_w, h = can_h); }
        }
        cylinder(r=can_r, h = 3*can_h);
        translate([0,0,-plate_w]) cylinder(r=can_r-plate_w, h = 3*can_h);
    }
}

module holder_front()
{
    rotate_extrude(convexity = 10)
    {
        polygon([[solder_room,-can_bottom_h],
                 [solder_room+plate_w/2,-can_bottom_h],
                 [can_inner_r,0], [can_r,0], [can_r,plate_w],
                 [solder_room+plate_w/2, can_top_h], [solder_room, can_top_h],
                 [solder_r,can_hold_start_z], [solder_r,can_hold_end_z]]);
    }
}

module pillar(h)
{
    difference()
    {   cylinder(h=h, r=pillar_r);
        translate([0,0,-h]) cylinder(h=3*h, r=pillar_hole_r);
    }
}

module holder_base_fn(bw,fw,l,h, br)
{
    r = bw/2;
    difference()
    { union()
        { translate([-fw/2,pillar_r-l]) 
            { linear_extrude(height=h)
                    polygon([[0,pillar_r],[pillar_r,0],[fw-pillar_r,0], 
                             [fw,pillar_r], 
                             [fw/2 + r,l-pillar_r],
                             [fw/2 - r,l-pillar_r]]);
                
                translate([pillar_r,pillar_r]) cylinder(r=pillar_r, h=h);
                translate([fw-pillar_r,pillar_r]) cylinder(r=pillar_r, h=h);
            }
            if(base_back_p)
            {  scale([1,br/r]) cylinder(r=r, h=h);
            }
        }
        if( !base_back_p )
        { translate([0,pillar_r,-h]) 
                scale([1,max(can_r*cos(can_a),pillar_r)/(br-pillar_r)])
                cylinder(r= br-pillar_r, h = 3*h);
        }
    }
}

module friction_plug_holes()
{
    fpr = friction_plug_r; fph = friction_plug_h;
    translate([can_r,0,-fph]) cylinder(r=fpr, h= 2*fph);
    translate([-can_r,0,-fph]) cylinder(r=fpr, h= 2*fph);
    translate([0,2*pillar_r-base_l,-fph]) cylinder(r=fpr, h= 2*fph);
}

module holder_base()
{   bw = 2*(can_r+plate_w);
    br = can_r*cos(can_a)+plate_w;
    w = base_wall_w;
    difference()
    {   if(base_wall_h > 0 && bw > 12*base_wall_w)
        { difference()
            {   holder_base_fn(bw, base_front_w, base_l, base_h+base_wall_h, br);
                translate([0,w,base_h])
                    holder_base_fn(bw-2*w, base_front_w-2*w, base_l, 
                                   base_h+base_wall_h, br-2*w);
            }
        }
        else
        { holder_base_fn(bw, base_front_w, base_l, base_h, br); }
    }
}

//Flat footed holder with the option of a bin.(on both sides)
module holder()
{
    r= can_r + plate_w;
    br = can_r*cos(can_a)+plate_w;
    ph = r*sin(can_a) +plate_w/2;
    q= can_h*cos(can_a)/cos(front_pillar_a); 
    pl = base_front_w/(2*sin(60)*cos(front_pillar_a));
    difference()
    { union()
        {   translate([0,0,ph]) rotate(v=[1,0,0], a= can_a) 
                holder_part();
            translate([can_r,0]) pillar(ph);
            translate([-can_r,0]) pillar(ph);
            
            if( flat_foot_p )
            {
                translate([0,2*pillar_r-base_l, plate_w*sin(front_pillar_a)]) 
                    rotate(v=[1,0,0], a = -front_pillar_a) 
                    pillar(q);
                holder_base();
            }
            else //fork_foot_p true
            {   
                translate([0,2*pillar_r-base_l, plate_w*sin(front_pillar_a)]) 
                rotate(v=[1,0,0], a = -front_pillar_a) 
                    translate([0,0,pl])
                {   pillar(q-pl);
                    rotate(v=[0,1,0], a=120)
                    {   pillar(pl/cos(60));
                        translate([0,0,pl/cos(60)]) sphere(pillar_r);
                    }
                    rotate(v=[0,1,0], a=-120)
                    {   pillar(pl/cos(60));
                        translate([0,0,pl/cos(60)]) sphere(pillar_r);
                    }
                }
                if( base_back_p )
                {   if( base_wall_h > 0 )
                    { difference()
                        {   scale([1,br/r]) cylinder(r=r, h=base_h+base_wall_h);
                            translate([0,0,base_h])
                                scale([(r-base_wall_w)/r,(br-base_wall_w)/r]) 
                              cylinder(r=r, h=base_h+base_wall_h);
                        }
                    }
                    else
                    { scale([1,br/r]) cylinder(r=r, h=base_h); }
                }
            }
        }
        translate([0,0,ph]) //Cleans out can holder.
                rotate(v=[1,0,0], a= can_a) 
            cylinder(r=can_r, h = 3*can_h);
        translate([0,0,ph]) //Cleans out can holder.
            rotate(v=[1,0,0], a= can_a) cylinder(r=can_r, h = 3*can_h);
        //Cleans out bottom.
        translate([0,0,-2*(r+can_h)]) cube(4*(r+can_h)*[1,1,1], center=true);
    }
}

holder();
translate([0,0,ph]) rotate(v=[1,0,0], a= can_a) 
translate([0,reinforcement_r-can_r-plate_w+can_r,can_h+2*plate_w]) color([0,0,1])
   holder_front();
