//
//  Copyright (C) 05-02-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//TODO
//* Distinguish between the 'end radius' and the 'in-corner' radius.
//* 3d stuff.(those kinds of corners too.
//* stuff will have to hold un somehow; screws/ tightening?

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

//TODO 'end'

//_grab(200,200, 100,100, 20);

module _corner(w,l, pd,pw, rr)
{
    q = [1,1]*(w/2-pw/2+rr);
   _grab(w,l,pd,pw,rr,cr);
   rotate(a=-90) _grab(w,l,pd,pw,rr,cr);
   translate([1,1]*pw/2) difference()
   {   square(q);
       translate(q) circle(rr);
   }
}

module corner(w,l, pd,pw, rr, cr)
{
    difference()
    {   union()
        {   _corner(w,l, pd,pw,rr);
            circle(w/2);
        }
        circle(cr);
    }
}

module t_section(w,l, pd,pw, rr, cr)
{
    difference()
    {   union()
        {   _corner(w,l,pd,pw,rr);
            rotate(a=90) _corner(w,l,pd,pw,rr);
        }
        circle(cr);
    }
}

//t_section(200,200, 100,100, 20, 20);

module x_section(w,l, pd,pw, rr, cr)
{
    difference()
    {   union()
        {   _corner(w,l,pd,pw,rr);
            rotate(a=90) _corner(w,l,pd,pw,rr);
            rotate(a=180) _corner(w,l,pd,pw,rr);
            rotate(a=270) _corner(w,l,pd,pw,rr);
        }
        circle(cr);
    }
}

corner(200,200, 100,100, 20, 20);
translate([410,0]) t_section(200,200, 100,100, 20, 20);
translate([820,0]) x_section(200,200, 100,100, 50, 20);

