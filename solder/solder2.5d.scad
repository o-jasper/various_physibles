//
//  Copyright (C) 05-11-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

plate_w = 5;

internal_w = 50;

f = 0.5;
s_h = max(40,2*plate_w);

solder_l = 250; //space reserved for soldering iron length.
solder_a = 45;
w = internal_w + 2*plate_w;
h = plate_w + solder_l*(1+1/6)*sin(solder_a) + s_h;
l = 2*plate_w + solder_l*cos(solder_a);

sliver_r = solder_l/6;
sliver_d = 2;

cut_d = 4;
cut_r = 1;

extra_w = l/4; //TODO widen the base

module sliver()
{ scale([0.7,1]) difference()
    { circle(sliver_r);
      circle(sliver_r - sliver_d);
      translate([0,-sliver_r]) square([sliver_r, 2*sliver_r]);
    }
}

module side_cut()
{ translate([-sliver_r,-sliver_r]) linear_extrude(height=2*cut_d) union()
    { sliver();
      translate([0,2*sliver_r-sliver_d]) scale([-1,1]) sliver();
      translate([0,2*(2*sliver_r-sliver_d)]) sliver();
    }
}

module side()
{ difference()
    { linear_extrude(height=plate_w) difference()
        { square([l,h]);
          square([f*l,plate_w]);
          square([plate_w,f*h]);
          polygon([[l,h], [f*l,h], [l,f*h]]);
        }
        translate([plate_w + sliver_r*cos(solder_a),
                   h-solder_l/2-h*0.05-plate_w, plate_w-cut_d]) 
          rotate(a=180+solder_a) side_cut();
    }
}

module bottom()
{ linear_extrude(height=plate_w) difference()
  { square([l,w]);
    translate([(1-f)*l,0]) square([l, plate_w]);
    translate([(1-f)*l,w-plate_w]) square([l,plate_w]);
  }
}

module backcir()
{ r= f*(h-s_h+2*plate_w);
  scale([extra_w/r,1]) circle(r);
}

module back()
{ r = f*(h-s_h+2*plate_w);
  linear_extrude(height=plate_w) difference()
  { union()
      { square([w,h-plate_w - s_h]);
        translate([0,-plate_w]) backcir();
        translate([w,-plate_w]) backcir();
      }
    translate([-2*extra_w,-2*r-plate_w]) 
        square([2*(w+2*extra_w), 2*r]);
    translate([0,-2*plate_w]) square([w,2*plate_w]);
    
    translate([0,(1-f)*h-plate_w]) square([plate_w,h]);
    translate([w-plate_w,(1-f)*h-plate_w]) square([plate_w,h]);
//    translate([plate_w,h-plate_w])
//        polygon([[0,0], [w-2*plate_w,0], [(w-2*plate_w)/2,-w/2]]);
  }
}
//TODO now the cut and, the metal, and the bolts
