
# Image to text forms.
To my annoyance, imagemagick does not actually have anything decent on this :/

Uses SDL to turn a image to various tabular forms;

**rgba**,**rgb**,**gray**  tab-separated rgb(a)/grayscale on each line, 
an empty line for a new row. (Gnuplot eats this `set pm3d map; splot "yourfile.dat"`)

**gray.dat** tab-seperated gray scale values. A newline for each row.

## Usage 
Arguments:

1. input file (only obligatory one)
2. way to output; rgba | rgb | gray | gray.dat, all 'gnuplot style' except the last,
   which is just a table.
3. range of the image to use(default whole image, clamped to that)
4. factor each color counts in turning it to gray (default 1,1,0.8.0)");
