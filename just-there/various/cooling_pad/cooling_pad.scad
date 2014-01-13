$fs=0.1;

t=1;
d=4;

w=40;l=80;

module teardrop(r) //Look at the MCAD version.. MCAD needs to simplify their shit.
{   circle(r);
    translate([-r/sqrt(2),0]) rotate(45) square([r,r],center=true);
}

module hole()
{   //teardrop(d/2-t/2); 
    circle(d/2-t/2);
}

module corner()
{   translate(-[d,d]/2) intersection()
    {   rotate_extrude(){ translate([d/2,0]) rotate(-90) hole(); }
        translate([0,0,-4]*d) cube([8,8,8]*d);
    }
}

module corner_n_len(len)
{
    corner();
    translate([0,-d/2]) rotate([90,0,0]) 
        linear_extrude(height=len-1.5*d) rotate(-90) hole();
}

/*intersection()
{   rotate_extrude(){ translate([d/2,0]) rotate(-90) hole(); }
    translate([-4,-8,-4]*d) cube([8,8,8]*d);
}
for( x=[d/2,1.5*d] ) translate([x,0]) 

translate([d,l-d]) intersection()
{   rotate_extrude(){ translate([d/2,0]) rotate(-90) hole(); }
    translate([-4,0,-4]*d) cube([8,8,8]*d);
    } */

module loop(w,l, dx,dy)
{
    translate([w-d/2,0]) rotate(270) corner_n_len(w+dx-d);
    translate([w-d/2,l-d/2]) corner_n_len(l);
    translate([0,l-d/2]) rotate(90) corner_n_len(w);
    translate([0,dy]) rotate(180) corner_n_len(l-dy);
}

module multi_loop(w,l,dx=3*d,dy=2*d)
{
    if( w>d && l>0 )
    {
        loop(w,l, dx,dy);
        translate([dx-d,dy]) multi_loop(w-1.5*dx,l-2*dy, dx=dx,dy=dy); 
    }
}

//multi_loop(w,l);
//translate([d,d]) multi_loop(w-2*d,l-2*d);

module round(R)
{
    
    if( R>d ) translate([R-d/2,0]) intersection()
    {   rotate_extrude(){ translate([d/2,0]) rotate(-90) hole(); }
        translate([-4,-8,-4]*d) cube([8,8,8]*d);
    }
    intersection()
    {   rotate_extrude(){ translate([R-d,0]) rotate(-90) hole(); }
        translate([-4,0,-4]*w) cube([8,8,8]*w);
    }
}

module outside_in()
{   for( s=[1,-1] ) scale([1,s,1]) translate([0,d]) for( R = [d/2:2*d:w/2] )
    {   round(R);
        scale([-1,1,1]) round(R-d);
    }
    translate([d/2,d]) rotate([90,0,0]) rotate(-90) 
        linear_extrude(height=2*d) hole();
}

//outside_in();

module cutter(a1,a2)
{
    union()
    {   rotate(a1) translate([-4,0,-4]*w) cube([8,8,8]*w);
        rotate(a2) translate([-4,-8,-4]*w) cube([8,8,8]*w);
    }
}

module corner_a(R,a1,a2)
{
    intersection()
    {   rotate_extrude(){ translate([R-d,0]) rotate(-90) hole(); }
        cutter(a1,a2);
    }
}

module inside_out_cut()
{
    dx=2*d;
//dx=R*sin(a);
    upto=floor(w/(2*d));
    
    for( i = [2:1:upto] )
    {   corner_a(d*i, asin(dx/(d*(i+0.5))),-asin(dx/(d*(i+0.5))));
        if( i>1 && i!=upto) scale([1, (i%2==0) ? 1 : -1,1]) rotate(asin(dx/(d*(i+0.5)))) 
                                translate([d*i-d/2,0]) intersection()
                            {   rotate_extrude(){ translate([d/2,0]) rotate(-90) hole(); }
                                translate([-4,-8,-4]*w) cube([8,8,8]*w);
                            }
    }
    
    translate([2*d,0]) rotate([0,90,0]) linear_extrude(height=w) hole();
    
    translate([2.3,-2]*d) intersection()
    {   rotate_extrude(){ translate([2*d,0]) rotate(-90) hole(); }
        translate([-8,0,-4]*w) cube([8,8,8]*w);
        rotate(-30) translate([-8,0,-4]*w) cube([8,8,8]*w);
    }
    translate([w/2-d/2,-2*d]) intersection()
    {   rotate_extrude(){ translate([d,0]) rotate(-90) hole(); }
        translate([-8,0,-4]*w) cube([8,8,8]*w);
    }
    translate([w/2-d/2,-d]) rotate([0,90,0]) linear_extrude(height=w/2-2*d) hole();
    
    corner_a(d*i, asin(dx/(d*(i+0.5))),-asin(dx/(d*(i+0.5))));
}

module inside_out()
{
    difference()
    {   rotate_extrude()
        {   square([w,d+t],center=true); 
            intersection()
            {   translate([w/2,0]) scale([1,1.4]) circle(d/2+t/2); 
                square([8*w,d+t],center=true); 
            }
        }
        inside_out_cut();
    }
}
inside_out_cut();

*difference() 
{   inside_out();
    translate([-4,-4]*w) cube([8,8,8]*w);
}
    
