animationDuration=5;// i seconds

fps=60;
frames=animationDuration*fps;

cycle=120;
globalTime=$t*(frames/fps);

square([frames/fps,.1]);
translate([globalTime,0])square([.1,.4],center=true);
translate([cycleTime(),0])square([.1,.4],center=true);



for(i=[0:1.018/fps:globalTime]){
     ct=cycleTime(i);
      y=cpg(ct)*.5+2;
          y2=waveshaper(ct);

//        translate([i,y])square([.1,.1],center=true);
        translate([i,y2])square([.05,.05],center=true);

            translate([i,ct])square([.05,.05],center=true);

    }


function cycleTime(t=globalTime)=((t* fps)/cycle)%1;
    
    
    function waveshaper(t)= centerOn(t+0.125,1,1) ;
    
    
     function centerOn(t,c=0,m=1)=c+cpg(t)*m;
    function fromto(t,a,b)= a+ bisignmap(cpg(t) )* (b-a);

function cpg(t)=sin(t*360);

function bisignmap(i)=(i+1)/2;



function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function mods(v,steps=3) = ( (v*steps)%1);

function mstep(v,steps=3) = (floor(v*steps)/steps );

function smooth(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function smooths(v, steps=3) = smooth(smooth(mods(v, steps))) / steps +
mstep(v, steps);

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function gauss(x) = x + (x - smooth(x));

function sinw(i)=gauss(i)-sin(i*360)/2;
function isinw(i)=sin(i*360)/2+smooth(i);

function cosw(i)=cos(i*360)/2 -0.5+i;
function icosw(i)=-cos(i*360)/2+0.5+i;





 PI = 3.14159265358979;

// Robert Penner's easing functions in GLSL.
// Available as a module for glslify. http://stack.gl/glsl-easings/

function  easeInOutCubic(  t)=  

      t<0.5 ? 4.*t*t*t : (t - 1.)*(2.*t - 2.)*(2.*t - 2.) + 1.;
 ;

function  easeInOutQuint(  t)=  

      t<.5 ? 16.*t*t*t*t*t : 1. +16.*(--t)*t*t*t*t;
 ;

function  easeOutQuad(  t)=   
      -1. * t * (t - 2.);
 ;

function  easeInQuad(  t)=   
      t * t;
 ;

 
function  bounceOut(  t)=   
    let(
 a = 4.0 / 11.0,
 b = 8.0 / 11.0,
 c = 9.0 / 10.0,

 ca = 4356.0 / 361.0,
 cb = 35442.0 / 1805.0,
 cc = 16061.0 / 1805.0,

 t2 = t * t
 )

    t < a
    ? 7.5625 * t2
    : t < b
      ? 9.075 * t2 - 9.9 * t + 3.4
      : t < c
        ? ca * t2 - cb * t + cc
        : 10.8 * t * t - 20.52 * t + 10.72;
 ;

function bounceInOut(  t)=   
    t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
 ;

function bounceIn(  t)=   
    1.0 - bounceOut(1.0 - t);
 ;


function elasticOut(  t)=   
    sin(-13.0 * (t + 1.0) * PI/2.) * pow(2.0, -10.0 * t) + 1.0;
 ;

function circularInOut(  t)=   
    t < 0.5
    ? 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
    : 0.5 * (sqrt((3.0 - 2.0 * t) * (2.0 * t - 1.0)) + 1.0);
 ;

function exponentialOut(  t)=   
    t == 1.0 ? t : 1.0 - pow(2.0, -10.0 * t);
 ;

function exponentialIn(  t)=   
    t == 0.0 ? t : pow(2.0, 10.0 * (t - 1.0));
 ;

function exponentialInOut(  t)=   
    t == 0.0 || t == 1.0
    ? t
    : t < 0.5
      ? +0.5 * pow(2.0, (20.0 * t) - 10.0)
      : -0.5 * pow(2.0, 10.0 - (t * 20.0)) + 1.0;
 ;
