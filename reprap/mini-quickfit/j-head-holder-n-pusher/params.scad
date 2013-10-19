//
//  Copyright (C) 21-09-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<nut.scad>

$fn=60;

echo(sr);

s=1;
//This is intended to attach to the j-head and press down a bowden tube for 1.75mm.

//J-Head small and large radius. //TODO get actual values!
jh_sr= 6.5; 
jh_lr= 8.5;
jh_sh= 5; //Slot height.

jh_rh=6;  //'rim height' top part ..

dd = 2; //j-head 'drops' this much.

quickfit=true; //TODO length and width switched
w= 80; //100;(quickfit)
l= 40;
th=5;
//quickfit_s=0.5;

rt = 2.5; //Tube radius
r = 1.75;
t=4;
d=max(5,jh_lr+t-r);

///----Pusher
wr=3.5; //Screw head radius.(or washer radius, if you want that.
//-----