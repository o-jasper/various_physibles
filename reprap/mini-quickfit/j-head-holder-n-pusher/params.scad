//
//  Copyright (C) 20-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<nut.scad>

$fn=60;

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

t=4;
d= 10; //.75; //max(5,jh_lr+t-r);
//Distance of the screws that push down the pusher. //NOTE: not continue down yet.
pusher_d = 14; // r+d+sr; 
