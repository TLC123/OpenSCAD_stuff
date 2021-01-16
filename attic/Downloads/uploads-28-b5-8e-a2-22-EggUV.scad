//Easter Egg Maker 2015 from Richard Swika
//Rev: 15.3.15.0 - changed to use trigons instead of quads by default to avoid non-plannar faces that seem to cause problems with some cgs operations; you can still you quads if you aren't using csg; added a simple base for 3D printing that makes the egg hollow; added clearance setting; added moduleMode
//Rev: 15.3.14.0 - added spacial oversampling and antiAliasing; many internal improvements; changed height to depth; removed density, use overSampling; adde code to echo settings to console
//Rev: 15.3.13.0 - fixed issues with non-mainifold geometry! 
//Rev: 15.3.12.0 - added repeat flag and made repeated images seemless
//Rev: 15.3.10.0 pre-release
//2014-2015 Richard Swika -  Creative Commons - Attribution - Non-Commercial license.

//* [Global] */ 
//These are just the default values; you normally will overide these in another file

//the following three statements are repeated in the include file for image patterns
//the number of horizontial pixels in the image
image_width=16;

//the number of vertical pixels in the image
image_height=4;

//you can edit the sample pattern manually here
image=[0,1,0,1,0,1,0,1, 0,1,0,1,0,1,0,1,
            0,1,0,1,0,1,0,1, 0,1,0,1,0,1,0,1,
            0,1,0,1,0,1,0,1, 0,1,0,1,0,1,0,1,
            1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1];

//repeat the pattern all over the egg or just put it inside the boundry defined below
repeat=true;//[false,true]

//the number of image cycles per image flip; 1 for none; 2 for seamless
period=2; //[1:100]

//overSampling controls the density of the mesh based on image size and scaling
//it reduces artifacts from mismatched sampling rates
//a setting of 1 means you will get one grid vertex per image pixel
//anti-Aliasing automatically turns on when overSampling is set greater than 1
//use integer values >1 for high quality results, or values <= 1 for draft mode
//BEWARE of making this value too large or using to large of an image!!!!
//you can also set vcount and ucount directly to override the overSampling setting
overSampling=1; //[0.1..4] 

//set true to put the Egg on a simple base for printing (takes a long time, use for final render only - may take 10 minutes or more for hi-res models)
onBase=false; //[false/true] 

//amount to seperate the egg from the base so they can be separated afer printing
clearance=0.1; //mm
 
 //adjust the amount of displacement, more than 20 to 50 is normal; 100 would be unusually high
depth=50; //[-50:1000]

//Length of the egg (mm)?.
egg_length=60; //[30:200]

//What shape egg? (use 7 for a hen egg; 0 for a sphere; 100 for a blimp)
egg_shape=7; //[0:100]

//when false the egg will have quads where possible instead of all trigons
//this can lead to problems with non-plannar surfaces when using csg
//so only use it true if when not using a base
allTrigon=true; //[false,true]

//image left boundry in degrees
ud0=0; //[0:359]

//image right boundry in degrees
ud1=360; //[0:360]

//image top boundry in degrees
vd0=0; //[0:180]

//image bottom boundry in degrees
vd1=45; //[0:180]

//set true to turn off the demo egg so you can use the modules instead
moduleMode=false; //[false,true];

/* [Hidden] */ //don't touch below this line unless you need to adjust under the hood

//the number of points around each edge loop forming the egg
ucount = let(c=floor(image_width*overSampling*360/(ud1-ud0))) (c>12) ? c : 12;

//the number of edge loops forming the egg
vcount = let(c=floor(image_height*overSampling*180/(vd1-vd0))) (c>12) ? c : 12;

//helper functions
//average of a list
function ave(v) = sum(v) / len(v);

// sum of a list
function sum(v,i=0) =  
      i < len(v)  
        ? (v[i] + sum(v,i+1))
        :  0;

function ud(ui) = ui*360/ucount;
function vd(vi) = vi*180/vcount;

//this is the meat of the problem
function map(x,x0,x1,y0,y1) = y0+((x-x0)*(y1-y0)/(x1-x0));
function uvmap(ui,vi) =  repeat ? displace(ui,vi) : 
                                    (ud(ui)>=ud0&&ud(ui)<ud1&&vd(vi)>=vd0&&vd(vi)<=vd1) ? displace(ui,vi) : 0;
function displace(ui,vi) = (vi==0)||(vi==vcount) 
//at poles we will use the average for this vi
       ? ave([for (ui=[0:ucount-1]) antiAlias(
            map(ud(ui),ud0,ud1,0,image_width),map(vd(vi),vd0,vd1,0,image_height))]) 
    //and straight antiAliasing elsewere
    : antiAlias(
        map(ud(ui),ud0,ud1,0,image_width),map(vd(vi),vd0,vd1,0,image_height)) ; 
function pixel(x,y)=image[image_width-(abs(x) % image_width)-1+(abs(y) % image_height)*image_width]*depth/1000;
function antiAlias(x,y) = overSampling>1 ? let(x0=floor(x),x1=floor(x)+1,y0=floor(y),y1=floor(y)+1) (seamless(x0,y0)*((1-abs(x-x0))*(1-abs(y-y0)))+
                  seamless(x1,y0)*((1-abs(x-x1))*(1-abs(y-y0)))+
                  seamless(x0,y1)*((1-abs(x-x0))*(1-abs(y-y1)))+
                  seamless(x1,y1)*((1-abs(x-x1))*(1-abs(y-y1))))
    : seamless(floor(x+0.5),floor(y+0.5)); //perhaps use Round *****
function flip(i,s)=floor(abs(i)/s) % period ? ((s-abs(i)-1)) : abs(i);
function seamless(x,y) = pixel(flip(x,image_width),flip(y,image_height));

//egg equation adapted from http://www16.ocn.ne.jp/~akiko-y/Egg
//(y^2 + z^2)^2=4z^3 + (4-4c)zy^2
// c=0.7 produces an almost perfect hen egg outline+
// c=0 produces a perfect sphere
// c>1 produces an elongated egg shape
//z ranges from 0 to 1
function egg_outline(c,z)= z >=1 ? 0 : (sqrt(4-4*c-8*z+sqrt(64*c*z+pow(4-4*c,2)))*sqrt(4*z)/sqrt(2))/4;

//map the egg's surface from uv to xyz with these functions
//function x(ui,r) = r * sin(ui*360/(ucount-1));
function x(ui,r) = r * sin(ud(ui));
function y(ui,r) = r * cos(ud(ui));
function z(vi,r) = r * cos(vd(vi));	
function n(vi,r) = r * sin(vd(vi));	
function zi(vi) = (1+cos(vd(vi)))/2;	
center = 0; //set to 1 to center at small end; 0 to center on fat end

//to avoid degenerate geometry at the poles we can not use quads 
//so we will generate phantom points as if we were using quads, but use tris instead 
//just to simplify indexing, but will only link faces to a single point at each pole
//but we will use the phantom points to calculate average displacement at each pole
//lets make an egg
points = [ for (vi=[0:vcount]) 
    for (ui = [0 : ucount-1]) 
        let (d=uvmap(ui,vi),r=egg_outline(egg_shape/10,1-zi(vi))) 
                    [x(ui,r+n(vi,d)), y(ui,r+n(vi,d)),(z(vi,d)+zi(vi))-center]];
//echo(points=points);
faces =  (allTrigon)     
 ? [ for (vi=[0:vcount-1]) for (ui = [0:ucount-1])  for (p=[0:1])
    (vi==0)&&(p==0) ? [vi*ucount,ui+(vi+1)*ucount,(ui+1) % ucount+(vi+1)*ucount]
    : (vi==vcount-1)&&(p==0) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,(vi+1)*ucount]
    : (p==0) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,ui+(vi+1)*ucount]
    :[(ui+1) % ucount+vi*ucount,ui+(vi+1)*ucount,(ui+1)%ucount+(vi+1)*ucount]] 
: [ for (vi=[0:vcount-1]) for (ui = [0:ucount-1])  
    (vi==0) ? [vi*ucount,ui+(vi+1)*ucount,(ui+1) % ucount+(vi+1)*ucount]
    : (vi==vcount-1) ? [(ui+1) % ucount+vi*ucount,ui+vi*ucount,(vi+1)*ucount]
    : [(ui+1) % ucount+vi*ucount,ui+vi*ucount,ui+(vi+1)*ucount,(ui+1)%ucount+(vi+1)*ucount]] ;
//echo(faces=faces);

//a reusable embossible Egg, simply override the default properties
module embossedEgg(egg_length=egg_length,egg_shape=egg_shape){
     scale (egg_length) translate([0,0,max(depth/1000,0)])
         polyhedron(points=points,faces=faces);
}    

//this is the code for when you aren't using modules
if (!moduleMode) {
    if (onBase) {simpleBase() embossedEgg();}
    else embossedEgg();
    }
 
module simpleBase(egg_length=egg_length,$fn=64)
{       
    render() difference() {
        union(){
            translate([0,0,clearance]) children(0); //the egg positive
              difference(){
                scale(egg_length) {//construct a simple base sized for the egg
                    union(){//
                        cylinder(r1=0.2,r2=0.15,h=0.20);      
                        render() difference(){
                            scale([1,1,0.2]) sphere(r=.25);
                            translate([0,0,-1]) scale(2) cube(center=true);
                        }
                    };
                };
            children(); //remove material from where egg will sit
            }
        }
        //put a hole through the base and hollow out the egg to use less material
        union(){
            translate([0,0,-1]) cylinder(r=0.1*egg_length,h=egg_length*0.2,center=false,$fn=8);
            translate([0,0,egg_length*0.5]) scale([1.5,1.5,2]) sphere(r=0.2*egg_length,center=true,$fn=32);
        }
    }
}
 
echo(egg_length=egg_length,egg_shape=egg_shape,allTrigon=allTrigon);
echo(onBase=onBase,clearance=clearance,moduleMode=moduleMode);
echo(image_width=image_width,image_height=image_height,depth=depth);
echo(repeat=repeat,period=period);
echo(overSampling=overSampling);
echo(ud0=ud0,ud1=ud1,vd0=vd0,vd1=vd1);
echo(ucount=ucount,vcount=vcount);
