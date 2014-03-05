br=3.7;
t=1.6;
ri=-1;

module cut(feed_hole=true)
{  
    ri= (ri<0 ? br/3 : ri);
    hull()
    {   translate([0,0,-br]) cylinder(r=br,h=3*br); //Bottom hole.
        cylinder(r=ri,h=3*br); //Narrowing.
    }
    cylinder(r=ri,h=4*br); //Narrowing, ensure the visualization does it decently.
    hull()
    {   translate([0,0,4*br]) sphere(ri); //Ball, closing location.
        translate([0,0,5*br]) sphere(br); //Ball, closing location.
        translate([0,0,6*br]) cylinder(r1=br+t/2,r2=br,h=br); //to location of ball.
    }
    //Feeding the ball.
    if(feed_hole) translate([0,0,6*br]) rotate([90,0,0]) cylinder(r=br,h=8*br);
    difference()
    {   translate([0,0,6*br]) cylinder(r=br,h=8*br); //Top hole.
        //Grating to hold back ball.
        translate([0,0,7*br]) linear_extrude(height=br) for(a=[45,135]) rotate(a)
            square(br*[0.4,4],center=true);
    }
}
//Cover for feeding the ball.
module feed_hole_cover()
{   intersection()
    {   translate([0,0,5*br]) rotate([90,0,0]) cylinder(r=br,h=8*br);
        difference()
        {   cylinder(r=br+t,h=9*br);
            cut(t=t,br=br,feed_hole=false);
        }
    }
    intersection()
    {   translate([0,-br-t,5*br]) cube([br,br,3*br],center=true);
        cylinder(r=br+t,h=9*br);
    }
}

module outer_shape(br,t)
{   intersection()
    {   hull(){ circle(br+t); translate([0,br]) circle(br); }
        square((br+t)*[2,2],center=true);
    }
}

module slide2d()
{   difference()
    {   outer_shape(br+t/4,t+t/4);
        outer_shape(br+s,t+s);
    }
}
//Slides over the side.
module bb_slide_over()
{   linear_extrude(height=5*br) slide2d(t=t,br=br); 
}

module ball_check_valve(feed_hole=true)
{   difference()
    {   linear_extrude(height=9*br) outer_shape(br=br,t=t);
        cut(t=t,br=br,ri=ri,feed_hole=feed_hole);
    }
}
//translate([30,0]) slide_over();
ball_check_valve();
//cut();
//translate([0.1,0.1,0.1]) color("blue") feed_hole_cover();

