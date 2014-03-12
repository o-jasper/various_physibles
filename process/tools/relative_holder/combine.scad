//
//  Copyright (C) 14-01-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include <params.scad>
use<../edm/wobble_edm_holder.scad>
use<holder.scad>

module show_combine(z=t+h/2*$t)
{   translate([0,d,bt+z+mrh+t]) show_wobble_edm();
    show(z=z);
}
show_combine(z=10);
