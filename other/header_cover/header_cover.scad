// Author Jasper den Ouden
//Placed in public domain.

//Distance between header bits.
d = 2.54;
//Number of headers length.
n=2;
//Number of headers width.
m=10;


module cov_1()
{
    difference(){ circle(d); circle(d/2); }
}

module cov_n()
{
    difference()
    {   union() for( i= [1:n] ) for(j=[1:m]) translate(d*[i,j]) circle(d); 
        for( i= [1:n] ) for(j=[1:m]) translate(d*[i,j]) circle(0.42*d); 
    }
}

$fs=0.1;
linear_extrude(height=9) cov_n();
