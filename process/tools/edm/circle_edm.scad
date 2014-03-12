//
//  Copyright (C) 12-03-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

R=100;
q=10;
s=2;
d=10;

module sw()
{
    difference()
    {   translate([q,q]/2) square([1,1]*(R-1.5*q));
        square((q/2+d+2*s)*[1,1]);
    }
    translate((q/2+s)*[1,1]) square([d,d]);
}

//sw();

module qh(a,b,r=q/2)
{   hull(){ translate(a) circle(r); translate(b) circle(r); } }

module springy_1()
{
    f=1;c=1.6;
    qs=q+s; 
    ty=floor((R-q)/(2*q))*qs;
    for(i=[1:2:(R-q)/(2*q)]) translate([0,i*qs])
    {   qh([d+qs*(c+f*i),0],[R,0]);
        qh([R,0], [R,-qs]);
        qh([d+qs*(c+f*i),0],[d+qs*(c+f*i),qs]);
        qh([d+qs*(c+f*i),qs],[R,qs]);
    }
    qh([R,ty],[R-qs,R-qs]);
}

module springy()
{
    for(a=[0:90:270]) rotate(a) 
        {   translate((q/2+s)*[1,1]) square([d,d]);
            qh((q/2+d/2+s)*[1,1],[R-q/2,R-q/2]);
            for(s=[1,-1]) scale([1,s]) springy_1();
        }
    for(a=[0,90]) rotate(a) qh([-R,0],[R,0]);
}

springy();
