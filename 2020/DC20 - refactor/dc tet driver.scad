include<DCtet.scad>
include <DCmath.scad>
include<DCbb.scad>
//include<DCsplitface.scad>
//include<DCfitness.scad>
//fitstep=8;
//fitshy=.8;
//QEFsteps=8;
//QEFshy=.8;
// treshold=.5;
//  scene   = function(p) ant(p)-1;
//    scene   = function(p)   min(  min(norm(p-[3,3,0])-5.5 ,norm(p-[-3,-0,0])-5.5) ,sdRoundBox(   p,   [2,2,10],0.25) );
//scene=function(p)sdSupersphere(p,6.28,.057,2);
  scene   = function(p)norm(p)-5.5;
  
 union(){
 SD_Render(scene,4);
  sphere(0.001);
      }

module SD_Render(scene,fn=1){
 scenecell= autobound(scene,cubic=true,pad=0.5 );
 
O = scenecell[0];
S = scenecell[1]; 
D = S - O;
maxD = max( abs (D.x), abs (D.y), abs (D.z));
St=D/fn  ;
    SD_RenderW(scene,scenecell,fn);
}

module SD_RenderW(scene,scenecell,fn=5,ff=[1,1,1]){
  //ff flipfield
O = scenecell[0];
S = scenecell[1]; 
C = (O + S) / 2;
D = S - O;
maxD = max( abs (D.x), abs (D.y), abs (D.z));
St=D/fn  ;
    if (abs(scene(C))<=maxD *1.5)
    {
       if (fn>0){
           I=[-1:2:1];
           fxxx=[for(x=I,y=I,z=I)[-x,-y,-z]];
 
               pxxx=[ (O+[0  ,0,  0]), (O+[D.x,0,  0]), (O+[0  ,D.y,0]), (O+[0,D.y,D.z]), (O+[0,0,D.z]), (O+[D.x,D.y,0]), (O+[D.x,0,D.z]),(O+[D.x,D.y,D.z])];
           for(i=[0:7]){
       SD_RenderW(scene, ([C,pxxx[i]]),fn-1,fff(ff,fxxx[i]));
           } 
           }
else
{  
   f=(max(0,ff.x)+max(0,ff.y)+max(0,ff.z))%2 ;
 m=f==0?fp_flip( meshcellW(scenecell, scene  ) )
    :          ( meshcellW(scenecell, scene  ) );
  
if(m!=[[],[]])    { 
//    echo(m);
//for(n=splitfaces(m[0],m[1],scene,treshold)) 
  n=m;
    {  
//        echo(n);
//      if(n!=[[],[]])echo(n);
     polyhedron(n[0],n[1]);
 } 
}}}

}
 function fff(a,b)=[a.x*b.x,a.y*b.y,a.z*b.z];
function  eval(p,scene)= scene(p);
function evalnorm(q, scene) =
let (tiny = 0.000001, 
e = eval(q, scene))
[
eval([q.x + tiny, q.y, q.z], scene) - eval([q.x - tiny, q.y, q.z], scene),
eval([q.x, q.y + tiny, q.z], scene) - eval([q.x, q.y - tiny, q.z], scene), 
eval([q.x, q.y, q.z + tiny], scene) - eval([q.x, q.y, q.z - tiny], scene),
e];

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////




function  smin(  a,  b, k )= 
let(
     h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 )    )
     
     lerp( b, a, h ) - k*h*(1.0-h);
    

function synmin(a, b, r) =
 smin(a, b, r);
// 
//let (
//r=0,
//    e = max(r * 0.02, (abs(a - b) / r))
//) min(a, b) - max(0.01, (r * e * 0.75 * (exp(1.0 - (e * 2.5)))) / max(a, b) * 0.5)
//
//;

function conecapsule(p, p1, p2, w, z) =
let (
    a = v3( lerp(p1, p2, 0.1)),
    b = v3(lerp(p1, p2, 0.9)),
    d1 = p1[3],
    d2 = p2[3] * 0.9,
    ba = b - a,
    pa = p - a,
    v = dot(pa, ba) / dot(ba, ba),
    h = clamp(v, 0.0, 1.0),
    d = lerp(d1, d2, smoothStep ( h)),
    r = d // / 2.0 ,

) norm(pa - ba * h) - r;
function smoothStep (a) =let (b = clamp(a))(b * b * (3 - 2 * b));

 function antbody(p) =
let (

    //body defines as basically a string of sticks and spheres. little more to it ofc
    body = [
        [-5, 0, 0, 1],
        [-4, 0, 1, 2],
        [-2, 0, 2, 3],
        [0, 0, 2, 3],
        [3, 0, 2, 1],
        [4, 0, 1, 1],
        [7, 0, 4, 3],
        [9, 0, 5, 3],
        [12, 0, 4, 1],
        [14, 0.5, 4, 3],
        [15, 2, 2, 1],
        [16, 0.7, -0.5, 0.5]
    ],


    oddbod =
    min(conecapsule(p, body[1], body[2], 2.0, 0.125),
        min(conecapsule(p, body[3], body[4], 2.0, 0.125),
            min(conecapsule(p, body[5], body[6], 2.0, 0.125),
                min(conecapsule(p, body[9], body[10], 2.0, 0.125),
                    conecapsule(p, body[7], body[8], 2.0, 0.25)
                )))),
    evebod =
    min(conecapsule(p, body[0], body[1], 2.0, 0.125),
        min(conecapsule(p, body[2], body[3], 2.0, 0.125),
            min(conecapsule(p, body[4], body[5], 2.0, 0.125),
                min(conecapsule(p, body[6], body[7], 2.0, 0.125),
                    min(conecapsule(p, body[8], body[9], 2.0, 0.125),


                        conecapsule(p, body[10], body[11], 2.0, 0.125)
                    )))))

) synmin(oddbod, evebod, 0.60);


function antenna(p) =
let (
    ant1 = [
        [14.4062, 0.35, 5.21244, 0.525],
        [16.4468, 1.52811, 7.89352, 0.49],
        [18.9311, 2.96244, 8.66218, 0.525],
        [20.728, 3.99987, 6.65596, 0.525],
        [21.4749, 4.43109, 5.34974, 0.52]
    ],
    oddant1 =
    min(conecapsule(p, ant1[1], ant1[2], 1.0, 0.06),
        (conecapsule(p, ant1[3], ant1[4], 1.0, 0.06))),
    eveant1 =
    min(conecapsule(p, ant1[0], ant1[1], 1.0, 0.06),
        (conecapsule(p, ant1[2], ant1[3], 1.0, 0.06)))


) synmin(oddant1, eveant1, 0.30);


function antleg1(p) =
let (
    leg1 = [
        [5.5, 0.0, 2.5, 0.5],
        [7.03209, 1.28558, 0.5, 0.75],
        [11.8623, 6.49951, 2.0, 1.0],
        [11.8623, 4.49951, -3.5, 0.75],
        [13.944, 5.78509, -5.75, 0.65],
        [15, 6.42788, -6, 0.5]
    ],
    oddleg1 =
    min(conecapsule(p, leg1[1], leg1[2], 3.0, 0.135),
        (conecapsule(p, leg1[3], leg1[4], 3.0, 0.135))),
    eveleg1 =
    min(conecapsule(p, leg1[0], leg1[1], 3.0, 0.135),
        min(conecapsule(p, leg1[2], leg1[3], 3.0, 0.135),
            (conecapsule(p, leg1[4], leg1[5], 3.0, 0.135))))



) synmin(oddleg1, eveleg1, 0.50);

    
function antleg2(p) =
let (
    leg1 = [
        [4.75, 0, 1.75, 0.5],
        [4.75, 2.31691, 0.127681, 0.75],
        [4.75, 6.89365, 2.96554, 1],
        [4.75, 7.93554, -2.94331, 0.75],
        [4.75, 10.4261, -5.55044, 0.75],
        [4.75, 11.4977, -5.86919, 0.5]
    ],
    oddleg1 =
    min(conecapsule(p, leg1[1], leg1[2], 3.0, 0.135),
        (conecapsule(p, leg1[3], leg1[4], 3.0, 0.135))),
    eveleg1 =
    min(conecapsule(p, leg1[0], leg1[1], 3.0, 0.135),
        min(conecapsule(p, leg1[2], leg1[3], 3.0, 0.135),
            (conecapsule(p, leg1[4], leg1[5], 3.0, 0.135))))



) synmin(oddleg1, eveleg1, 0.50);

function antleg3(p) =
let (
    leg1 = [
        [3.5, 0.2, 0.25, 0.5],
        [1.72499, 3.691, -0.26813, 0.75],
        [-3.8651, 6.7605, 2.8302, 1],
        [-4.66323, 6.43022, -3.07865, 0.75],
        [-7.02376, 8.41093, -5.58159, 0.75],
        [-8.071, 9.28967, -5.84825, 0.5]
    ],
    oddleg1 =
    min(conecapsule(p, leg1[1], leg1[2], 3.0, 0.135),
        (conecapsule(p, leg1[3], leg1[4], 3.0, 0.135))),
    eveleg1 =
    min(conecapsule(p, leg1[0], leg1[1], 3.0, 0.135),
        min(conecapsule(p, leg1[2], leg1[3], 3.0, 0.135),
            (conecapsule(p, leg1[4], leg1[5], 3.0, 0.135))))



) synmin(oddleg1, eveleg1, 0.50);


function legasm(p) =
let (

)
min(antenna(p),
    min(antleg1(p),
        min(antleg2(p),
            antleg3(p)

        )));



function v3(p) = [p.x, p.y, p.z] + [0,0,0]; // vec3 formatter
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];

function ant(p) =
let (
    p = [p.x, abs(p.y), p.z]


) synmin(antbody(p), legasm(p), 0.60);

function sdRoundBox(   p,   b,   r )=
     let(q = sdAbs3(p) - b)
norm( sdMax3(q,0.0)) + min(  max (q.x,q.y,q.z),0.0) - r;

function sdMax3(a, b) = [max(a.x, b),
 max(a.y, b), max(a.z, b)
];
 function sdMin3(a, b) = [min(a.x, b),
 min(a.y, b), min(a.z, b)
];
function sdAbs3(v) = [abs(v[0]), abs(v[1]),
 abs(v[2])
];

function sdSupersphere(p, r = 15, d = 2, c = 0) =
let (n = un(p)) len3(p) - r + (sin(atan2(n.y, n.x) * 8) * d + sin(
 atan2(atan2(n.y, n.x) / 90, n.z) * 8) * d);