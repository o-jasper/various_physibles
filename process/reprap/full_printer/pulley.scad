//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module pulley_pos() //At the position of the pulley.
{   d=hl-zrd;//tbr+3*t+2*sr/3;
    for(s=[1,-1]) rotate(45) scale([1,s,1]) translate([d,d]/sqrt(2)) child();
}

$fs=0.1;
module pulley(dec_ball=false, dec_ball_internal=true,dec_ball_extra=false,pt=1.5*t,f=1/8)
{   dr= pr/2+sr/2;
    difference()
    {   rotate_extrude() difference()
        {   hull()
            {   translate([sr,0]) square([pr-sr-t,pt]);
                for(y=[f*t,pt-f*t]) translate([pr,y]) circle(f*t);
            }
            translate([pr+f*t,pt/2]) scale([f*t/pt,1/3]) circle(pt);
        }
        //Taking out stuff.
        if(dec_ball) for(a=[0:60:300]) rotate(a) translate([dr,0,pt]) 
        {   if(dec_ball_internal)
            {   translate([0,0,-pt/2]) scale([1,1,1.8])
                    sphere(min(pr/2-sr/2-t/5, dr/2-t/8)); 
            }
            else
            {   sphere(min(pr/2-sr/2-t/5, dr/2-t/8)); }
        }
        if(dec_ball_extra) for(a=[0:60:300]) rotate(30+a) 
            translate([pr-t/2,0,pt+t/8]) sphere(t/2.6);
    }
}

pulley();
