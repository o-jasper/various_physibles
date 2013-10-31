
#include<stdio.h>
#include<SDL/SDL.h>
#include<SDL/SDL_image.h>

//Lazy, from the SDL documentation
// NOTE: The surface must be locked before calling this!
Uint32 getpixel(SDL_Surface *surface, int x, int y)
{
    int bpp = surface->format->BytesPerPixel;
    /* Here p is the address to the pixel we want to retrieve */
    Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

    switch(bpp) {
    case 1:
        return *p;

    case 2:
        return *(Uint16 *)p;

    case 3:
        if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
            return p[0] << 16 | p[1] << 8 | p[2];
        else
            return p[0] | p[1] << 8 | p[2] << 16;

    case 4:
        return *(Uint32 *)p;

    default:
        return 0;       /* shouldn't happen, but avoids warnings */
    }
}

void read_range(const char* from, int* fi,int* fj,int* ti,int* tj)
{
    int gfi=*fi,gfj=*fj, gti=*ti,gtj=*tj;
    sscanf(from, "%d,%d,%d,%d", &gfi,&gfj, &gti,&gtj); 
    *fi = (*fi<gfi ? *fi : gfi);
    *fj = (*fj<gfj ? *fj : gfj);
    *ti = (*ti>gti ? *ti : gti);
    *tj = (*tj>gtj ? *fj : gtj);
}

int main(int argc,const char* argv[])
{
    if( argc<1 ){ printf("ERROR: Need an image to convert.\n");return -1; }

    if( argc>=2 && (!strcmp(argv[2],"--help") ||  !strcmp(argv[2],"-h")) )
    {
        printf("Usage arguments:\n");
        printf("1. input file (only obligatory one)\n");
        printf("2. way to output; rgba | rgb | gray | gray.dat, all 'gnuplot style' except the last,\n");
        printf("  which is just a table.\n");
        printf("3. range of the image to use(default whole image, clamped to that)\n");
        printf("4. factor each color counts in turning it to gray (default 1,1,0.8.0)");
        return -1;
    }

    SDL_Surface* surf= IMG_Load(argv[1]); //Load the image.
    
    int mode=0;
    if( argc>=3 )
    {        if( !strcmp(argv[2],"rgba") ){ mode=0; }
        else if( !strcmp(argv[2],"rgb") ){ mode=1; }
        else if( !strcmp(argv[2],"gray") ){ mode=2; }
        else if( !strcmp(argv[2],"gray.dat") ){ mode=3; }
        else{ printf("Error incorrect mode; %s\n", argv[2]); return -1; }
    }
    int fi=0,fj=0, ti=surf->w,tj=surf->h; //Optionally specify range
    if(argc>=4 && strcmp(argv[3],"whole")){ read_range(argv[2], &fi,&fj, &ti,&tj); }
    
    double fr=1,fg=1,fb=0.8,fa=0;
    if( argc>=5 )
    {   sscanf(argv[4], "%lf,%lf,%lf,%lf", &fr,&fg,&fb,&fa); }
    for(int i=fi ; i<ti ; i++ )
    {
        for(int j=fj ; j<tj ; j++ )
        {
            Uint32 cur = getpixel(surf, i,j);
            Uint8 r,g,b,a;
            SDL_GetRGBA(cur, surf->format, &r,&g,&b,&a);
            switch(mode)
            {
            case 0: printf("%d\t%d\t%d\t%d\n", r,g,b,a); break;
            case 1: printf("%d\t%d\t%d\n", r,g,b); break;
            case 2: printf("%f\n", fr*r + fg*g + fb*b + fa*a); break;
            case 3: printf("%f\t", fr*r + fg*g + fb*b + fa*a); break;
            }
        }
        printf("\n");
    }
    
}
