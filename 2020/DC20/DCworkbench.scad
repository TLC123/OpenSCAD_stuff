include<DCgeometry.scad>
include<DCparser_eval.scad>
include<DCbb.scad>
include<DCmath.scad>
//include<DCtet.scad>
include<DCcache.scad>
include<DCcube.scad>
include<DCedge.scad>
include<DCsplitface4.scad>
include<DCfitness.scad>
// to do  write new flattness check done
// filter relax point neighborgs done
// cornershy full probe done
// speed - efficient data structures cache n lookup -tried
// TODO is point part of open edge elimination






 





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

function clamp(a, b=0, c=1) =  min(max(a, min(b, c)), max(b, c));
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








$evalcache=    undef;
$calledfromctoba=false;


//build
$treshold=1/240; //curv tolerance
divs=5 ;
simplifyonbuild=false;
minfacesforsimp=40 ;
maxfacesforsimp =1000 ;
ECbuildcount=2;
maxedges=8192;
ECshuffle=false;

massage1=1;
fitmeshm1=true;
ECm1= false;
ECm1count=2;

massage2=30;
FaceSplitm2=true;
maxlimsplit=1000;
ECm2= true;
ECm2count=10;
fitmessharpm2=true
;

massage3=0;

$fitmeshsharp=2;
$fitmeshsharpS=1
; // smooth step per shapening
cmsfaktor=0.95;
fitinbox=false;
QEFsteps=50;
QEFshy=1;
fitstep=4;
fitshy=1;
fitstracesteps=6;
fitstraceshy=0.99;
Maxacute=.48;
flatness=0.99;
cornershy=0.5;
freezeclose=0.01;
freezecloseon =false;
quads=false; //dont work with EC
fitstrace=false;
fitsplit=false;
fitsplittrace=false;

verbose=true;
ECverbose=false;
//scenegraph  =  randomscene(spread=rnd(9,13));
// scenegraph  =  fixedScene( );
// 
// scenegraph  = function(p)  min( norm(p-[2,0,.5])-1 ,max(abs(p.x),abs(p.y),abs(p.z) )-1 );
  scenegraph  = function(p) ant(p);
 
// echo(norm([0,1,2])-1, scenegraph,eval([0,1,2], scenegraph) );
 //  randomCUscene(spread=rnd(9,13));
  k= polygonize (scenegraph ,divs);
//scenecell=[[1,1,1],autobound(scenegraph,cubic=true,pad=.4)[1]];
// showcell(scenecell);

 union(){sphere(0.1);

//renderquads  ( k);
  render   ( k);
//     xo=scenecell[0].x;
//     yo=scenecell[0].y;
//     
//     for(i=[scenecell[0].x:scenecell[1].x])for(j=[scenecell[0].y:scenecell[1].y]) 
//         color([ clamp01(sin(100*(k[i+xo][j+yo]))) ,max(0,-sign(k[i+xo][j+yo]))*clamp01(sin(100*(k[i+xo][j+yo]))),0]) 
//     translate([i,j])square(1);

}
//polygon(k);
echo("done");
 ;

// rendererror(k,scenegraph );

function polygonize (scenegraph,divisions=1)= let(
 scenecell= autobound(scenegraph,cubic=true,pad=0.2) ,
 scenecellCH= autobound(scenegraph,cubic=true,pad=.4) ,
 $scenecell=scenecellCH,
//eth2=echo(str("Bounding Cell: ",scenecell )),
//eth3=let (v=pow(2,divs))echo(str("Subdivisions: ", v,"X",v,"X",v," =", v*v*v )),
// showcell(scenecell), 
$cellmaxsize=cellmax(scenecell),
$cms=$cellmaxsize/pow(divisions,2),
//
// echo(str("Constructing cache ")),
//  $evalcache=       octobaCh(scenegraph,scenecellCH,divisions) , 
// 
//final=[for(i=[scenecell[0].x:scenecell[1].x])[for(j=[scenecell[0].y:scenecell[1].y]) eval([i,j,lerp(scenecell[0].z,scenecell[1].z,0.5)],scenegraph)]],
 
 
//// simple scenes are 3 times faster with no cache 
   eth3v=echo(str("Constructing raw mesh " )),
    rawmesh=       octoba(scenegraph,scenecell,divisions) ,
//    echraw=echo( str("raw mesh   -  Points: ",len(rawmesh[0]),"  Faces: ",len(rawmesh[1]))),
    
    eth4=echo(str("Gluing raw mesh " )),
    gluedrawmesh=        ( rawmesh)  ,
//    ech07=echo( str("glued mesh -  Points: ",len(gluedrawmesh[0]),"  Faces: ",len(gluedrawmesh[1]))),
//    
//    
//    eth5=echo(str("Preprocessing glued mesh " )),
//    
//     intermesh1=meshmassage1(gluedrawmesh,scenegraph ,massage1),
//     intermesh2=meshmassage2(intermesh1,scenegraph ,massage2),
//      final=meshmassage3(intermesh2,scenegraph ,massage3),
      end=0
)
   //  snapmesh(scenegraph, gluedrawmesh );

// intermesh;
gluedrawmesh;



function meshmassage1(x,scenegraph,  c=0)=c<1?x:

let( 
ech0=echo( str("M1 Start of prepass: ",massage1-c+1)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),

 i00= false? snapmesh(scenegraph, x ) : x,  
// ech001=echo( str("snapped " )),
 i0=  false ?  rlxmesh(scenegraph, i00 ): i00,  
//   ech010=echo( str("relaxed ", norm(addl( i00.x-i0.x)))), 
 i1= false? fitmeshsharp(scenegraph, i0 ,$fitmeshsharp,$fitmeshsharpS)  
:i0 ,    
//  ech000=echo( str("snapped " )),
 
 i2= fitmeshm1? fitmesh(scenegraph, i1 ,1  ):i1 ,  
// ech02=echo( str("fitted " )),


i6=ECm1 ? edgecollapseflat(i2,flatness, $cms*cmsfaktor,scenegraph,ECm1count):i2,
//ech06=echo( str("After edge collapse  -  Points: ",len(i6[0]),"  Faces: ",len(i6[1]))),
i7= false ? glue( i6):i6 ,
 //ech07=echo( str("glued  -  Points: ",len(i7[0]),"  Faces: ",len(i7[1]))),

 i8=  false ? fitmeshsharp(scenegraph, i7 ,$fitmeshsharp,$fitmeshsharpS)  
:i7 ,  
// ech08=echo( str("fitted ", norm(addl(i8.x-i7.x)))),
 i9= false? fitmesh(scenegraph, i8 ,1 ):i8 ,  
// ech02=echo( str("fitted " )),
 
return= (i9)
) 
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) 
meshmassage1(return,scenegraph, c-1);


function meshmassage2(x,scenegraph,c=0)=c<1?x:
let( 
ech0=echo( str("M2 Start of pass: ",massage2-c+1)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),

ix= false? fitmesh(scenegraph, x ,1  ):x ,  
 //ech02=echo( str("fitted " )),
 
 
i6=  FaceSplitm2 &&len(ix[1])<maxlimsplit?  glue(cbpl(splitfaces    (ix[0],ix[1],scenegraph, $treshold))):ix, 
 ech01=echo( str("splitface and glued  -  Points: ",len(i6[0]),"  Faces: ",len(i6[1]))),

// i7= true? snapmesh(scenegraph, i6   ):i6 ,  
 //ech02=echo( str("fitted " )),
 


i8=   fitmessharpm2 ? fitmeshsharp(scenegraph, i6 ,$fitmeshsharp,$fitmeshsharpS) :i6, 
// ech02=echo( str("fitted ", norm(addl(i7.x-i8.x))  )),

i9=  ECm2 ? edgecollapseflat(i8,flatness, $cms*cmsfaktor,scenegraph,ECm2count):i8,
//ech09=echo( str("After edge collapse  -  Points: ",len(i9[0]),"  Faces: ",len(i9[1]))),

return= (i9)
)
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) meshmassage2(return,scenegraph,c-1); 









function meshmassage3(x,scenegraph,  c=0)=c<1?x:

let( 
ech0=echo( str("M3 Start of postpass: ",massage3-c+1)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),

 i0= false? snapmesh(scenegraph, x ) : x,  
// ech000=echo( str("snapped ", norm(addl(x.x-i0.x)))),
 i1=  false ?  rlxmesh(scenegraph, i0 ): i0,  
// ech01=echo( str("relaxed ", norm(addl( i0.x-i1.x)))), 

 i2= false? fitmesh(scenegraph, i1 ,1  ):i1 ,  
// ech02=echo( str("fitted ", norm(addl(i1.x-i2.x)))),


i6= edgecollapseflat(i2,flatness, $cellmaxsize/16,scenegraph,25),
ech06=echo( str("Afteredgecollapse  -  Points: ",len(i6[0]),"  Faces: ",len(i6[1]))),
i7= false ? glue( i6):i6 ,
//ech07=echo( str("glued  -  Points: ",len(i7[0]),"  Faces: ",len(i7[1]))),

 i8= false? fitmesh(scenegraph, i7 ,3  ):i7 ,  
 //ech08=echo( str("fitted ", norm(addl(i8.x-i7.x)))),

 
return= (i8)
) 
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) 
meshmassage3(return,scenegraph, c-1);














function cellmax(cell)=let(O = cell[0], S = cell[1],D = S - O) max( D.x, D.y, D.z) ;



module render(k){
    echo(str(" Points: ",len(k[0]),"  Faces: ",len(k[1])));
    polyhedron(untagall(k[0]),k[1]);}

module renderquads(k){
    echo(str(" Points: ",len(k[0]),"  Faces: ",len(k[1])));
    ut=untagall(k[0]);
    for(i=k[1]){ 
         if(len(i)==3)
    color([rnd(0.5,0.75),rnd(0.5,0.75),0])
        polyhedron(ut,[i]);
     else       
         
     color([1,0,0])
        polyhedron(ut,[i]);
}
    }
    
module rendererror(k,scene){ 

for(f=[0:len(k[1])-1]){
lff=len(k[1][f])-1;
     for( i=[0:lff]){
    nexti=wrap(i+1,lff+1);
  p1= k[0][k[1][f][i] ];
p2= k[0][k[1][f][nexti]] ;
mp=lerp(p1,p2,0.5);
if (abs(eval(mp,scene))>0.05) color("red")translate(v3(mp))sphere(0.5);
if (abs(eval(p1,scene))>0.05) color("blue")translate(v3(p1))sphere(0.5);

}}
}
   function randomscene(spread)=
  subtraction(0,[
  
    union( max(0,rnd(-2,0)),[  for(i=[0:2])
    translate([rnd(-spread,spread),rnd(-spread,spread),rnd(-spread,spread)],
                [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)]
              //  [rotate([rnd(-0,0),rnd(-0,0),rnd(-0,0)]
    ,[ 
rnd(2)>0.08?
cube([rnd(6,10),max(0,rnd(-1,0))]):
//cube([rnd(5,10),max(0,rnd(-1,0))])
sphere(rnd(8,10))
])])     
]      ),
    
        union( max(0,rnd(-2,2)),[  for(i=[0:1])
    translate([rnd(-spread,spread)/2,rnd(-spread,spread)/2,rnd(-spread,spread)/2],
             [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)],
           //        [rotate([rnd(-0,0),rnd(-0,0),rnd(-0,0)],
        [ 
rnd(2)>1.5?
cube([rnd(5,6),max(0,rnd(-1,0))]):
//cube([rnd(5,10),max(0,rnd(-1,0))])
rnd(2)>1?
        cylinder(rnd(3,3)):
torus([rnd(5,5),rnd(2,3)])
])])     
]      )
      
    ])
  
    ;  
function randomCUscene(spread)=
 
  
    union( max(0,rnd(-2,0)),[  for(i=[0:1])
    translate([rnd(-spread,spread)/2,rnd(-spread,spread)/2,rnd(-spread,spread)/2],
                [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)],[ 
rnd(2)>0?
cube([rnd(6,10),max(0,rnd(-1,0))]):
//cube([rnd(5,10),max(0,rnd(-1,0))])
cylinder(rnd(1,1))
])])     
]      )
    
         
  
    ;
    
    function fixedScene()= [3, 0, [[1, 0, [[4, [[9.63949, -7.76829, 6.90702], [0, 0, 0], [1, 1, 1]], [[4, [[0, 0, 0], [-15.3487, 8.50304, 30.6397], [1, 1, 1]], [[10, [9.98978, 0]]]]]], [4, [[-5.651, -7.03204, -6.32308], [0, 0, 0], [1, 1, 1]], [[4, [[0, 0, 0], [35.2507, -32.0059, -58.8596], [1, 1, 1]], [[10, [7.43592, 0]]]]]], [4, [[0.590227, -1.60332, 10.9945], [0, 0, 0], [1, 1, 1]], [[4, [[0, 0, 0], [30.555, 20.7602, -34.7237], [1, 1, 1]], [[10, [8.85311, 0]]]]]]]], [1, 1.03967, [[4, [[-4.05771, 3.89623, -1.71894], [0, 0, 0], [1, 1, 1]], [[4, [[0, 0, 0], [38.7652, -46.8557, -45.8064], [1, 1, 1]], [[13, 3]]]]], [4, [[0.471724, -2.0528, 5.08755], [0, 0, 0], [1, 1, 1]], [[4, [[0, 0, 0], [-24.0278, -34.7017, -45.3052], [1, 1, 1]], [[10, [5.28709, 0]]]]]]]]]];