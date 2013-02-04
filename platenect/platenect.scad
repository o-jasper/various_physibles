//
//  Copyright (C) 05-02-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

module _grab(w,l, pd,pw, rr)
{
    sl = l-rr;
    difference()
    {   union() 
        {   translate([0,sl/2]) square([w,sl], center=true);
            translate([pw/2,sl]) scale([(w-pw)/(2*rr),1]) circle(rr);
            translate([-pw/2,sl]) scale([(w-pw)/(2*rr),1]) circle(rr);
        }        
        translate([0,l]) square([pw,2*(l-pd)], center=true);
    }
   
}
//_grab(200,200, 100,100, 20);

module corner(w,l, pd,pw, rr, cr)
{
    q = [1,1]*(w/2-pw/2+rr);
    difference()
    {   union()
        {   _grab(w,l,pd,pw,rr,cr);
            rotate(a=-90) _grab(w,l,pd,pw,rr,cr);
            circle(w/2);
            translate([1,1]*pw/2) difference()
            {   square(q);
                translate(q) circle(rr);
            }
        }
        circle(cr);
    }
}

//corner(200,200, 100,100, 20, 20);

module t_section(w,l, pd,pw, rr, cr)
{
    q = [1,1]*(w/2-pw/2+rr);
    difference()
    {   union()
        {   _grab(w,l,pd,pw,rr,cr);
            rotate(a=-90) _grab(w,l,pd,pw,rr,cr);
            rotate(a=90) _grab(w,l,pd,pw,rr,cr);
            translate([1,1]*pw/2) difference()
            {   square(q);
                translate(q) circle(rr);
            }
            translate([-pw/2 - q[1],pw/2]) difference()
            {   square(q);
                translate([0,q[1]]) circle(rr);
            }
        }
        circle(cr);
    }
}

//t_section(200,200, 100,100, 20, 20);

cross_ces
