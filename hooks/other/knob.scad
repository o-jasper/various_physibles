
over_f = 1.5;
r=4;
R = over_f*r;

side_w = 4;

h_bottom=5;
r_bottom = 20;
r_top = r_bottom;

a= 30;

w = 20;
q=r_top/cos(a); //TODO from r_top

cut_x = w/2+w*sin(a)/2;
cut_r = cut_x*sin(a);

h = 2*cut_r*sin(90+a);
            
function sqr(x) = x*x;

module half_cross_section()
{ 
    hole_w = 2*(cut_x-cut_r - side_w); //TODO may be too thin.
    difference()
    {
        union()
        {
            difference()
            {
                union()
                {   rotate(a=a)
                    {   translate([q,r]) circle(R);
                        square([q,2*r]);
                    }
                    square([w,h], center=true);
                    translate([0,-h/2]) square([r_bottom,cut_y]);
                }
                translate([cut_x,0]) circle(cut_r);
            }
            translate([0,-h/2-h_bottom]) square([r_bottom-h_bottom, h_bottom]);
            translate([r_bottom-h_bottom,-h/2-h_bottom]) 
            difference()
            {   circle(h_bottom);
                translate([0,-h_bottom]) square(2*h_bottom*[1,1], center=true);
            }
        }
        if( hole_w>0 )
        {   square([hole_w, 10*(h+q)], center=true);
        } 
        translate([-(w+h+q),0]) square(2*(w+h+q)*[1,1],center=true);
    }
}

//TODO more places than potentially the center to run screws through.
module knob()
{   rotate_extrude() half_cross_section();
}

knob();
