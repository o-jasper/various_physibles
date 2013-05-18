//by Jasper den Ouden (ojasper.nl)
//Inspired by http://www.thingiverse.com/thing:43272 by Stefan Langemark
//
// Public domain

$fs=0.1;

t=0;
r = 10;
f = (r+t)/r;
n = 6;

l=0;
da_dl = 5;
ln = 6;

module female(t=t,r=r)
{   intersection()
    {   sphere(f*r); 
        translate([0,0,r/3]) cube(f*r*[4,4,sqrt(2)],center=true);
    }
}

module section(l=l,t=t,r=r,n=n, w_female=true)
{
    cylinder(r=r/2, h = l+2*r);
    if( l>0 ) 
    {   linear_extrude(height=l+r/2, twist= (l+r/2)*da_dl) 
            for( a=[0:360/ln:360] ) rotate(a) translate([r/2,0]) circle(r/10);
        linear_extrude(height=l+r/2, twist= -(l+r/2)*da_dl) 
            for( a=[0:360/ln:360] ) rotate(a) translate([r/2,0]) circle(r/10);
    }
    difference()
    {   union()
        {   if( w_female ){ female(t,r); }
            translate([0,0,l+f*r/sqrt(2)]) 
            {   cylinder(r1=f*r/sqrt(2), r2=r/5, h=r);
                translate([0,0,r/2]) sphere(r);
            }
        }            
        for( a = [0:360/n:360] ) rotate(a) //Petals
            {   translate([r,0,l+1.5*r]) scale([0.7,1/5,1]) sphere(r); }
        translate([0,0,l+5*r]) cube(6*[r,r,r], center=true);
    }
}

module section_set(w,h)
{
    for( i=[1:w] ) for( j=[1:h] ) translate(2.5*f*r*[i,j]) section();
}

section(30);
