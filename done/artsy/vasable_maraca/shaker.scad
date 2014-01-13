//Derived from http://www.thingiverse.com/thing:70744/ by thingiverse user
// bitswype, (his account has Chris as real name) 
// He linked to this youtube vid https://www.youtube.com/watch?v=RlyJ4OqkmGM
//(implying he has this account https://www.youtube.com/user/MrTheKeeser?feature=watch)
//
//He put it under the Creative Common Attribution license. 
//Hereby i, Jasper den Ouden (ojasper.nl), put it under the same license.
//(I take it the above satisfies the attribution at this point)

$fn = 50;

shaker_radius = 25;
shaker_height = 25;

handle_radius = 5;
handle_height = 25;

bead_radius = 6;
wall_thickness = 3;

vasable=true;

vasable_bottom_thickness = 0.5;

module base_item()
{
    bottom_thickness = (vasable ? vasable_bottom_thickness : wall_thickness);    
    difference()
    {
        color("grey") union() //Basic shape.
        {
            cylinder(r = shaker_radius, h = shaker_height);
            translate([0,0,shaker_height]) 
                cylinder(r1 = shaker_radius, r2 = handle_radius, h = handle_height);
            $translate([0,0,shaker_height+handle_height]) 
                cylinder(r = handle_radius, h = handle_height);
        }
        
        color("red") union()  //Cavity
        {
            translate([0,0,bottom_thickness]) 
                cylinder(r = shaker_radius-wall_thickness, 
                         h = shaker_height-bottom_thickness);
            translate([0,0,shaker_height]) 
                cylinder(r1 = shaker_radius-wall_thickness, r2 = handle_radius, 
                         h = handle_height-bottom_thickness);
        }
        
        color("green") union() 
        {
            translate([0,0,-wall_thickness])  //Holes for no reason/vasability.
                if( vasable )
                {    cylinder(r1 = bead_radius*0.6, r2 =bead_radius, h = 3*shaker_height); }
                else
                {    cylinder(r = bead_radius*0.65, h = 3*wall_thickness); }
            
            for( a = [0:60:300] ) //Holes for pegs
                rotate([0,0,a]) translate([0,shaker_radius/2,-wall_thickness]) 
                    cylinder(r = bead_radius*0.65, h = 3*wall_thickness);
        }
    }
}
//The bits that shake around.
module peg()
{
    union()
    {   cylinder(r = bead_radius*0.5, h =  wall_thickness);
        translate([0,0,wall_thickness]) 
            cylinder(r1 = bead_radius*0.5, r2 = bead_radius, h =  bead_radius);
        if(vasable) 
        {   translate([0,0,wall_thickness+bead_radius]) 
                cylinder(r1 = bead_radius, r2 = 0, h= bead_radius);
        }
    }
}
//Shaker that is vasable.
module vasable_shaker(vasable=true)
{   union()
    {   base_item(vasable=vasable); 
        for(a=[0:60:300]) rotate(a) translate([0,shaker_radius/2]) peg();
    }
}
//Non-vasable verion.(looks like it would be the same as unmodified)
module shaker(){ vasable_shaker(vasable=false); }

//Opened up for showing.
module just_show()
{   union()
    {   color("blue") for(a=[0:60:300]) rotate(a) translate([0,shaker_radius/2]) peg();
        difference()
        {   base_item();
            cube(size = [shaker_radius, 2*shaker_radius, shaker_height+handle_height]);
        }
    }
}

shaker();
//just_show();
