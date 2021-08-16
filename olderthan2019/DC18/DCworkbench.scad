include<DCgeometry.scad>
include<DCparser_eval.scad>
include<DCbb.scad>
include<DCmath.scad>
include<DCtet.scad>
include<DCedge.scad>
 spread=7;


  scenegraph  =  
    union( max(0,rnd(-2,0)),[  for(i=[0:1])
    translate([rnd(-spread,spread),rnd(-spread,spread),rnd(-spread,spread)],
                [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)],[ 
rnd(2)>0.1?
cube([rnd(6,10),max(0,rnd(-1,0))]):
//cube([rnd(5,10),max(0,rnd(-1,0))])
sphere(rnd(6,10))
])])     
]      )   ;

k= polygonize (scenegraph );

union(){sphere(0.1);

render ( k);
}
echo("done");

// rendererror(k,scenegraph );

function polygonize (scenegraph,divisions=2)= let(
 scenecell=autobound(scenegraph,cubic=true,pad=0.2),
eth2=echo(str("Bounding Cell: ",scenecell )),

// showcell(scenecell),
th=(cellmax(scenecell)/pow(2,max(1,divisions))) ,
thb=th ,
tha=(th*th)*2 ,
treshold=1/80,
eth=echo(str("TresholdB: ",thb )),
eth1=echo(str("TresholdA: ",tha )),
et0h1=echo(str("TresholdC: ",treshold )),
rawmesh=       octoba(scenegraph,scenecell,divisions) ,
//rawmesh0=       cuboba(scenecell) ,
 
//rawmesh=          gridly(scenegraph,scenecell,pow(2,divisions)),
gluedrawmesh=          glue( rawmesh)  ,
ech=echo( str("Base Mesh      -  Points: ",len(rawmesh[0]),"  Faces: ",len(rawmesh[1]))),
echi=echo(str("Glued Mesh     - Points: ",len(gluedrawmesh[0]),"  Faces: ",len(gluedrawmesh[1]))),
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
    final=meshmassage(gluedrawmesh,scenegraph,[th,tha,thb,treshold],1),
 
 end=0) final;

function meshmassage(x,scenegraph,Ts,c=0)=c<1?x:
let(th=Ts[0],tha=Ts[1],thb=Ts[2],treshold=Ts[3],
ech0=echo( str("Start of pass: ",c)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),
i0=fitmesh(scenegraph, x ,4),
//i1=     edgecollapse       (i0,thb *0.2,-1,-1,tha,scenegraph),// 
////    ech1=echo( str("EC Mesh    -  Points: ",len(i1[0]),"  Faces: ",len(i1[1]))),
//i2=  glue(i1),
//    ech2=echo( str("Glue Mesh  -  Points: ",len(i2[0]),"  Faces: ",len(i2[1]))),
// i3=  fitmesh(scenegraph, i2 ,3), 
//    ech3=echo( str("Fit Mesh  -  Points: ",len(i3[0]),"  Faces: ",len(i3[1]))),


i3=  glue(cbpl(splitfaces    (i0[0],i0[1],scenegraph,treshold))), 
 
    ech3=echo( str("Split Mesh  -  Points: ",len(i3[0]),"  Faces: ",len(i3[1]))),

i5=  fitmeshsharp(scenegraph, i3 ,2 ,2 ) ,
i6=  fitmeshsharp(scenegraph, i5 ,2 ,2 ) ,
   ech6=echo( str("Fit Sharp  -  Points: ",len(i6[0]),"  Faces: ",len(i6[1]))),

i7=  glue(cbpl(splitfaces    (i6[0],i6[1],scenegraph,treshold))), 
 
    ech7=echo( str("Split Mesh  -  Points: ",len(i7[0]),"  Faces: ",len(i7[1]))),

 i8=  fitmeshsharp(scenegraph, i7 ,2 ,1 ) ,
   ech8=echo( str("Fit Sharp  -  Points: ",len(i8[0]),"  Faces: ",len(i8[1]))),


//i5=edgeflip(i5,scenegraph,c=10),


//i9=glue(edgeflip(i8,scenegraph,c=10)),
// i10=  fitmeshsharp(scenegraph, i9 ,2 ,2) ,

return= (i8)
)
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) meshmassage(return,scenegraph,Ts,c-1);

 





function cellmax(cell)=let(O = cell[0], S = cell[1],D = S - O) max( D.x, D.y, D.z) ;

function fitmesh(scene,m,c=1,neighbours)=
neighbours ==undef?  fitmesh(scene,m,c,pointneighbours (m[0],m[1])):
c>0?
    fitmesh(scene, smoothmesh( fits(m[0],scene) ,m[1],2,neighbours)   ,c-1,neighbours):

[fits(m[0],scene) ,m[1]];



function fitmeshsharp(scene,mi,c=1,S=2 ,neighbours)= 
neighbours ==undef?  fitmeshsharp(scene,mi,c,S ,pointneighbours (mi[0],mi[1])):
c>0?
let(
 m= smoothmesh( mi[0] ,mi[1],S,neighbours), 
points=m[0], faces=m[1], 
 
midpoints=  facemidpoints(points  ,faces),
fittedmidpoints=fits(midpoints,scene),
 //relaxpoints=pointneighbourscenterpoint(midpoints,neighbours,points),
normalatfmidpoints=[for(i= midpoints)v3(evalnorm(i,scene))], 
newpoints=[
for(i=[0:len(points)-1])
len(neighbours[i])<1?points[i] :

 findp2p( points[i],[
for(j=[0:len(neighbours[i])-1])
let(k=neighbours[i][j])
[fittedmidpoints[k],normalatfmidpoints[k]]
] )  ] )
fitmeshsharp(scene,[newpoints,faces],c-1,S ,neighbours ): mi;



function gridly (scene,scenecell,divs=4)=
let(

D=scenecell[1]-scenecell[0]

)
 (cbpl([
for(
x=[scenecell[0].x:D.x/divs:scenecell[1].x],
y=[scenecell[0].y:D.y/divs:scenecell[1].y],
z=[scenecell[0].z:D.z/divs:scenecell[1].z])
let(
cell=[[x,y,z],[x,y,z]+D/divs],
O = cell[0],
S = cell[1],
m=meshcell([O,S], scenegraph )
)
 m]));
function cuboba(   cell ) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
 p1 = O,   
p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
p8 = ([S.x, S.y, S.z ]),            p9 = C)
[[p1,p2,p3,p4,p5,p6,p7,p8]*2,
[
[0,1,2],[2,1,4],
[0,2,3],[2,6,3],
[0,3,1],[1,3,5],
[1,5,7],[1,7,4],
[7,6,2],[4,7,2],
[6,7,3],[7,5,3]]];


function octoba( scene, cell,subdivision = 6) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
eO = eval(O, scene),  eC = eval(C, scene), 
p1 = O,   
p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
p8 = ([S.x, S.y, S.z ]),            p9 = C)
// if 
subdivision > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ? [[],[]] :   // else split cell in 8 new cells constructed by corners and center point
(
cbp(
cbp(
    cbp( octoba(scene,bflip(p1, C), subdivision - 1), octoba(scene,bflip(p2, C), subdivision - 1)), 
    cbp( octoba(scene,bflip(p3, C), subdivision - 1), octoba(scene,bflip(p4, C), subdivision - 1)))
,cbp( 
   cbp(octoba(scene,bflip(p5, C),   subdivision - 1), octoba(scene,bflip(p6, C), subdivision - 1)), 
   cbp( octoba(scene,bflip(p7, C),   subdivision - 1), octoba(scene,bflip(p8, C), subdivision - 1)) )
)) :
meshcell([O,S], scenegraph );




function fits(m,scene,c=3)= c>0? 
let(nm=[for(i=m) let(probe=evalnorm(i,scene)) i- un(v3(probe))*probe[3]*0.9 ]) fits(nm,scene,c-1):m;

  function fp_flip(w)=len(w[1])>0?[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]]:[[],[]];




function splitfaces(points,faces,scene,treshold)=len(faces)<1?[[],[]]:
[for (i=[0:len(faces)-1])
let(
poly=faces[i],
p0=points[poly[0]],
p1=points[poly[1]],
p2=points[poly[2]],
p01=lerp(p0,p1,0.5),
p12=lerp(p1,p2,0.5),
p20=lerp(p2,p0,0.5),
p012=(p0+p1+p2)/3,
e01=abs(eval(p01,scene)),
e12=abs(eval(p12,scene)),
e20=abs(eval(p20,scene)),
e012=abs(eval(p012,scene)),
//snapped



lim01=norm(p0-p1)*treshold ,
lim12=norm(p1-p2)*treshold ,
lim20=norm(p2-p0)*treshold ,
lim012=min(lim01,lim12,lim20),
//lim01= treshold,
//lim12=treshold,
//lim20=treshold,

pvt=[e01>lim01,e12>lim12,e20>lim20,e012>lim012],
pvts=[e01>lim01,e12>lim12,e20>lim20]) // shot version saves a bunch of ||'s
 pvts== [false, false, false]  ?[[p0,p1,p2],[[0,1,2]]]:
// pvts== [false, false, false,true]  ?[[p0,sp01,p1,sp12,p2,sp20,p012],[[6,0,2],[6,2,4],[6,4,0]]]:
let(
//sp0=fit1(p0,scene),
//sp1=fit1(p1,scene),
//sp2=fit1(p2,scene),
//nsp0=un(v3(evalnorm(p0,scene))),
//nsp1=un(v3(evalnorm(p1,scene))),
//nsp2=un(v3(evalnorm(p2,scene))),
////
//sp01= ( findp2p( (p01), [[sp0,nsp0],[sp1,nsp1] ])),
//sp12= (findp2p( (p12), [[sp1,nsp1],[sp2,nsp2]])),
//sp20= (findp2p( (p20), [[sp2,nsp2],[sp0,nsp0]]))
//sp01=  fit1(p01,scene) ,
//sp12= fit1( p12,scene) ,
//sp20=  fit1(p20,scene) ,
// sp012=fit1(p012,scene)
sp01=   (p01 ) ,
sp12=  ( p12 ) ,
sp20=   (p20 )

)
 (pvts== [true, false, false ]) ?[[p0,sp01,p1,sp12,p2,sp20],[[0,1,4],[1,2,4]]]:
 (pvts== [false, true, false ]) ?[[p0,sp01,p1,sp12,p2,sp20],[[2,3,0],[3,4,0]]]:
 (pvts== [false, false, true ])? [[p0,sp01,p1,sp12,p2,sp20],[[2,5,0],[2,4,5]]]:

 (pvts== [true, true, false]) ? 
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
 norm(p0-p12)<norm(p01-p2)?[[0,1,3],[0,3,4],[1,2,3]]:[[1,3,4],[0,1,4],[1,2,3]] ] :

 (pvts== [ false,true, true ]) ?
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
  norm(p0-p12)<norm(p1-p20)?[[0,2,3],[0,3,5],[3,4,5]]:[[5,2,3],[0,2,5],[3,4,5]]]:

 (pvts== [ true,false, true]) ?
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
 norm(p1-p20)<norm(p01-p2)?[[1,2,5],[2,4,5],[0,1,5]]:[[1,4,5],[1,2,4],[0,1,5]]]:


// (pvt== [true,true,true ]) ? 
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
,[[0,1,5],[1,2,3],[3,4,5],[1,3,5]]]
//:

// (pvt== [false,false,false ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,2],[6,2,4],[6,4,0]]]
//:

//
// (pvt== [true,false,false,true ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,1],[6,1,2],[6,2,4],[6,4,0]]]:
// 
//(pvt== [false,true,false,true ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,2],[6,2,3],[6,3,4],[6,4,0]]]:
//
// (pvt== [false,false,true,true ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,2],[6,2,4],[6,4,5],[6,5,0]]]:
//
// (pvt== [false,true,true,true ]) ? //case blue
// [[p0,sp01,p1,sp12,p2,sp20,sp012],
//concat([[2,3,6],[2,6,0],[5,0,6]],
//norm(p12-p20)<norm(p2-p012)?[[3,5,6],[3,4,5]]:[[3,4,6],[4,5,6]])]:
//
// (pvt== [true,false,true,true ]) ? //case red
// [[p0,sp01,p1,sp12,p2,sp20,sp012],
//concat([[4,5,6],[2,4,6],[1,2,6]],
//norm(p20-p01)<norm(p0-p012)?[[5,1,6],[5,0,1]]:[[5,0,6],[0,1,6]])]:
//
// (pvt== [true,true,false,true ]) ?//case black
// [[p0,sp01,p1,sp12,p2,sp20,sp012],
//concat([[6,0,1],[6,3,4],[6,4,0]],
//norm(p01-p12)<norm(p1-p012)?[[1,3,6],[1,2,3]]:[[1,2,6],[2,3,6]])]:
//
// [[p0,sp01,p1,sp12,p2,sp20,sp012],concat( 
//norm(p01-p12)<norm(p1-p012)?[[1,3,6],[1,2,3]]:[[1,2,6],[2,3,6]],
//norm(p12-p20)<norm(p2-p012)?[[3,5,6],[3,4,5]]:[[3,4,6],[4,5,6]],
//norm(p20-p01)<norm(p0-p012)?[[5,1,6],[5,0,1]]:[[5,0,6],[0,1,6]]
//)]

]
;
function tagsharp(v)=[v.x,v.y,v.z,"sharp"];
function untagall(v)=[for(i=v)v3(i)];
function fit1(p,scene,c=0)=c>0?fit1( fits([p],scene)[0],scene,c-1):fits([p],scene)[0];

 
function findp2p(inp, pl,   f = 25) =
let (p =  (inp ) )
f > 0 && len(pl) > 0   ?

 let (q = avrgp([ for (i = [0: len(pl) - 1]) 
let (new_p=point2plane(p, pl[i][0], un(pl[i][1])))  new_p
 ]), df = q - p) 

 findp2p((p + (df * 0.6)), pl,   f - 1)  :p;
////////////
////////////
////////////
////////////
////////////

// project a point to a plane
function point2plane(p, o, n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane


module render(k){echo(str(" Points: ",len(k[0]),"  Faces: ",len(k[1]))); polyhedron(untagall(k[0]),k[1]);}
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
 