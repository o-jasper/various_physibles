//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//These three variables are supposed to be somewhat standard.
hw = 20; //Holding size.(must stay in rectangle centered here.
hl = 5; //Holding bar length.

module attach_methods(sr, nscrew,nplate) //The stuff extra on the component.
{
    linear_extrude(height=hl)
    {   if(nplate>0) for( i=[0:nplate-1] ) rotate(i*360/nplate) 
                translate([hw/4+hl/2,0]) square([hw/2+3*hl/2,2*hl], center=true); 
        if(nscrew>0) for( j=[0:nscrew-1] )
        {   rotate(180+j*360/nscrew) difference()
            {   union()
                {   translate([hw/4+hl/2,0]) square([hw/2+hl,2*hl], center=true); 
                    translate([hw/2+hl,0]) circle(hl);
                }
                translate([hw/2+hl,0]) circle(sr);
            }
        }
    }
}

//attach_methods(1.2,1,1);
