
n=5;m=5; d=5; t=1; h=1;

module grid2d()
{
    for(i=[0:n]) translate([d*i,0]) square([t,d*m]);
    for(j=[0:m]) translate([0,d*j]) square([d*n,t]);
    translate([d*n,0]) square([d,d*m+d]);
    translate([0,d*m]) square([d*n+d,d]);
}

module grid(point=true,fancy=true)
{
    linear_extrude(height=h) difference()
    {   union()
        {   grid2d(n=n,m=m,t=t,d=d);
            if(fancy) translate(d*[2,2]) circle(2*d);
        }
        if(fancy) translate(d*[2,2]) circle(2*d-t);
    }
    difference()
    {   cube([n+1,m+1,n]*d);
        translate([-d,-d,n*d]) for(a=[0,-90]) rotate(a)
            rotate([-90,0,0]) cylinder(r=n*d+d,h=8*m*d);
        cube([n*d+d-t,m*d+d-t,2*n*d]);
    }
}

module gridx2()
{   grid(n=2*n-1,m=2*m-1); }

grid();
