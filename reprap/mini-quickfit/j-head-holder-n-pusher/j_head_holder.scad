//
//  Copyright (C) 21-09-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module slide(r)
{
    d = 10*(jh_lr +t);
    union()
    {   circle(r);
        translate([d,0]) square(2*[d,r],center=true);
    }
}

module base()
{   linear_extrude(height = th) square([w,l],center=true); }

h=dd+2*jh_sh;
module holder_add(p,a) //Single holder added features.
{
    translate(p) rotate(a) union()
    {   linear_extrude(height = h)
        {   circle(jh_lr+t);
            for(x=pusher_d*[1,-1]) translate([x,0]) circle(sr+t/2);
            translate([0,jh_lr/2]) square((jh_sr+t/2)*[2,2],center=true);
        }
        //Pegs the screws go through.
        for(x=pusher_d*[1,-1]) translate([x,0])cylinder(r=(nt/2+t/2),h=max(nh,jh_sh));
    }
}
module holder_cut(p,a) //Single holder substracted features.
{
    q=t;
    translate(p+[0,0,-q]) rotate(a)
    {   rotate(90) linear_extrude(height=l) slide(jh_sr); //Small radius slide in/out.
        for(x=pusher_d*[1,-1]) translate([x,0]) //Hole for screws and nuts.
                      {   cylinder(r=sr,h=l);
                          linear_extrude(height=t+nh) nut_profile(nt);
                      }
        linear_extrude(height=q+2*dd) rotate(90) slide(jh_lr); //Large radius slide bottom
       
        translate([0,0,q+dd+jh_sh]) cylinder(r=jh_lr, h=l); //The j-head drops a bit here.
        translate([0,0,q+2*dd+jh_sh])  //Small large radius slide top.
            linear_extrude(height=l) rotate(90) slide(jh_lr);
    }
}

//use jh_pusher instead, even if you just need one.
module single_holder(with_base=true) 
{   p=[0,0,0];
    difference()
    {   union(){ if(with_base) base(); holder_add(p,0); }
        holder_cut(p,0);
    }
}
module jh_plateless_holder()
{   single_holder(false); }

module jh_holder()
{   p=[0,jh_lr+t/4,0];
    difference()
    {   union()
        {   base(w=w); 
            holder_add(p,0);holder_add(-p,180);
        }
        holder_cut(p,0);
        holder_cut(-p,180);
        //Two holes for air flow/wiring, plus holes for potential mounting.
        // Might want to design a sucktion system and mayb
        for(x=[l,-l]/2) translate([x,0]) 
        {   rotate(45) cube([w/6,w/6,l],center=true);
            for(y=[1,-1]*w/6) translate([0,y,-l]) cylinder(r=sr,h=3*l);
        }
        //Cut off bits that stick out.
        for(y=[l,-l]) translate([0,y]) cube([4*w,l,8*w],center=true);
    }
}

//Thin sliver you can slide in if it is felt it is too  loose.
module jh_sliver()
{   sz = l/2-jh_lr-t/4;
    intersection()
    {   union()
        {   linear_extrude(height=2*dd) slide(jh_lr);
            linear_extrude(height=2*dd+jh_sh) slide(jh_sr);
        }
        difference()
        {   cube([2*sz,2*jh_lr,l],center=true);
            translate([0,0,-t]) 
            {   cylinder(r=jh_lr,h=dd+t);
                linear_extrude(height=l) rotate(180) slide(jh_sr);
            }
            translate([-jh_lr,0]) cube([3*jh_lr,8*jh_lr,2*dd],center=true);
            translate([0,0,jh_sh+th-2*dd]) cylinder(r=jh_lr,h=l);
        }
    }
}

module printable()
{
    jh_holder();
    translate([0,l/2 + jh_lr+t]) jh_sliver();
//    translate([0,-l/2 - jh_lr-t])jh_pusher();
}

module show()
{
    x=jh_lr+t/4;
//    translate([0,x,h+t]) jh_pusher();
    jh_holder();
    translate([0.1,x+0.1,0.1]) rotate(90) ///rotate([180,0,0]) 
    {   color([0,0,1]) jh_sliver();
        translate([0,0,dd]) color([0,1,0]) cylinder(r=jh_sr,h=jh_sh);
    }

}

show();
//single_holder(false);//this is without any quickfit-like thing.

//translate([0,w]) jh_holder();


module jh_holder_quickfit()
{   jh_holder(w=100); }
