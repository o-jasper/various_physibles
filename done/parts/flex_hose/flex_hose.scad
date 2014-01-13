//by Jasper den Ouden (ojasper.nl)
//Inspired by http://www.thingiverse.com/thing:43272 by Stefan Langemark
//
// Public domain

// Note that is seems to work in implicidCAD too.

$fs=0.1;

t=0;
r = 10;
n = 6;

l=0;
da_dl = 5;
ln = n;

pk = 2; //Kind of pole.

allow_rotate=false;

module female()
{   translate([0,0,r/1.3]) difference()
    {   sphere(r+t); 
        if( !allow_rotate ) translate([0,0,r*(1+1/1.4)]) cube(r*[2,2,2], center=true);
    }
}

module male_petals_sub()
{   for( a = [0:360/n:360] ) rotate(a) //Petals
         {   translate([r,0,r/1.3]) scale([0.7,1/5,1]) sphere(r); }
}
module male()
{
    difference()
    {   translate([0,0,r/1.3]) sphere(r);
        male_petals_sub(r=r,n=n);
        translate([0,0,r*(1+1/1.4+1/1.3)]) cube(r*[2,2,2], center=true);
    }
}

//Pole between two sections.
module pole()
{   el = 0.2*r;
    rl = l+2*el;
    union() translate([0,0,-el]) if( l>0 ) 
    {   if( pk== 1)
        {   linear_extrude(height=rl, twist= (l+r/2)*da_dl)
                for( a=[0:360/ln:360] ) rotate(a) translate([r/2,0]) circle(r/10);
            linear_extrude(height=rl, twist= -(l+r/2)*da_dl) 
                for( a=[0:360/ln:360] ) rotate(a) translate([r/2,0]) circle(r/10);
            translate([0,0,l-0.4*r]) 
                cylinder(r1=r/2, r2=0.65*r, h=r);
            translate([0,0,0.5*r]) 
                cylinder(r2=r/2, r1=0.65*r, h=r);
        }
        if( pk==2 )
        {   linear_extrude(height= rl) union()
            {   circle(r/6);
                for( a = [0:360/ln:360] ) rotate(a+180/ln) //Petals
                                         {   translate([r/2,0]) circle(r/3); }
            }
        }
    }
}
//Male to female section.(For zero infill print)
module f_m_flex()
{   union()
    {   difference()
        {   pole(l=l, pk=pk, da_dl=da_dl, r=r, ln=ln);
            translate([0,0,l]) male_petals_sub(r=r,n=n);
        }
        translate([0,0,l]) male(r=r,n=n);
        rotate([180,0]) female(r=r,t=t, allow_rotate=false);
    }
}
//Male male section.(For zero infill print)
module m_m_flex()
{   union()
    {   difference()
        {   pole(l=l, pk=pk, da_dl=da_dl, r=r, ln=ln);
            rotate([0,180]) male_petals_sub(r=r,n=n);
            translate([0,0,l]) male_petals_sub(r=r,n=n);
        }
        translate([0,0,l]) male(r=r,n=n);
        rotate([180,0]) male(r=r,n=n);
    }
}

module as_show()
{   m_m_flex(l=20);
    
    translate([+2*r,0]) female();
    translate([-2*r,0]) male();
}
