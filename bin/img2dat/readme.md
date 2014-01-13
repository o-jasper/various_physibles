
# Image to text forms.
To my annoyance, imagemagick does not actually have anything decent on this :/

Note: [embossanova](https://cubehero.com/physibles/iamwil/embossanova) does a 
similar thing.

Uses SDL to turn a image to various tabular forms;

**rgba**,**rgb**,**gray**  tab-separated rgb(a)/grayscale on each line, 
an empty line for a new row. (Gnuplot eats this `set pm3d map; splot "yourfile.dat"`)

**gray.dat** tab-seperated gray scale values. A newline for each row. This can be
used with openscads
[surface](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Other_Language_Features#Surface).

## Usage 
Arguments:

1. input image (only obligatory one) anything SDL_image can load.
2. way to output; rgba | rgb | gray | gray.dat, all 'gnuplot style' except the last,
   which is just a table.(default `rgba`)
3. range of the image to use(default whole image, clamped to that)
4. factor each color counts in turning it to gray (default 1,1,0.8.0)"

The output goes into stdout.

## Examples
    
    #Straight into gnuplot.
    ./img2dat some_image.jpg gray | gnuplot -p -e "set pm3d map; splot '-'"
    #Into data file.
    ./img2dat some_image.jpg gray.dat > some_image.dat

With `some_image.dat` you can also use it in openscad with 
[surface](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Other_Language_Features#Surface):
`surface(file = "some_image.dat");`
