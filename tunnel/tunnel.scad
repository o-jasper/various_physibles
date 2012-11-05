//
//  Copyright (C) 13-02-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later verssion.
//

module undirected_tunnel(r,d,w)
{
  rotate(a=90, v=[1,0,0]) translate([r,0]) 
      scale([1,sqrt(d/r)]) //multmatrix([[1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1]])
      rotate_extrude(convexity = 10)
      translate([r,0]) scale([f,1]) circle(r = w, $fn = 100);
}
//Tunnel with width and height.
module tunnel(sx,sy, ex,ey, d, w)
{ rx = ex-sx;
  ry = ey-sy;
  dist = sqrt(rx*rx + ry*ry);
  translate([sx,sy]) rotate(a=atan2(ry,rx)) undirected_tunnel(dist/2, d,w);
}

tunnel(0,20,100,-50 + 100*$t,   20,4);
tunnel(-50,0,- 50 + 100*$t,40, 20,4);

cylinder(r=3, h=10);
/*
multmatrix([ [1,    0, 0, 0],
             [0,    1, 0, 0],
             [0,    0, 1, 0],
             [0.01,  0, 0, 1] ]) translate([0,0,-20]) cylinder(r=10,h=40);
*/
