
t=1;
d= 10;
r = d/4-t/2;

drda= d/360;

da=20;

R=50;

total_a=floor((R-t)/(360*drda))*360;

$risky=false; //activates a hole i am not sure the location is parameter-proof.

module base_obj(r)
{
    translate([0,0,-r]) cylinder(r1=r,r2=r/4,h=2*r);
    //sphere(r,$fn=5);
}

module spiral()
{   for( a = [0:da:total_a] ) hull()
    {   rotate(a) translate([drda*a,0]) base_obj(r);
        rotate(a-da) translate([drda*(a-da),0]) base_obj(r);
    }
}

module pipe_cut()
{   translate([d/2-2*t,0])
    {   spiral(total_a=total_a-180);
        rotate(180) spiral();
        translate([-drda*total_a,d/2]) rotate([90,0,0]) cylinder(r=r,h=drda*total_a);
        translate([-drda*(total_a-180),d/2]) rotate([90,0,0]) cylinder(r=r,h=drda*total_a);
    }
}

module body()
{   translate([0,0,-r-t]) linear_extrude(height= 2*(r+t)) difference()
    {   union()
        {   circle(drda*total_a+r);
            translate([-drda*total_a-t,-1.5*d]) square([2*d,1.5*d]);
        }
        translate([d+t-drda*total_a,-1.5*d]) 
        {   translate(-drda*total_a*[1,1]) square(drda*total_a*[1,1]);
            if($risky) translate([d/2,-d-r-t]) circle(r+t);
        }        
    }
}

module spiral_pad()
{
    difference()
    {   body();
        color("blue") pipe_cut();
    }
}

module show()
{
    difference()
    {   spiral_pad();
        translate([0,0,4*R]) cube([8,8,8]*R,center=true);
    }
}

//pipe_cut();
show();

