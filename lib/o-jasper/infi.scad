
inf = 1000;

module inficube(pos)
{   translate(pos) cube(2*[inf,inf,inf], center=true); }
module infisquare(pos)
{   translate(pos) square(2*[inf,inf], center=true); }
