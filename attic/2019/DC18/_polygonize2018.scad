
//Sample box fitting from distance sampling by scene parsing.
 // (?Cache distance function in octtree/Tetrahexacontatree )
//Raw polygon mesh from distance sampling by scene parsing.

//Refine mesh
//    Snap mesh points to scene surface, iterate 
//    Simplify dense mesh
//    Split out of bounds edges amd snap new points to sharp features 
//Verify quality and repeat refine until sufficient 
//Present results.
include <polytools.scad>
include<DCgeometry.scad>
include<DCparser_eval.scad>


//sphere(1);
smoothstrengh= 0.7;
edgetreshold=0.33;
sharptreshold=0.40;

cell=5;

//v1=rnd()*120;
//v2=rnd(0.1,0.25);
//v3=rnd(-1,1);
//v4=rnd(-1,1);
//v5=rnd(-1,1);
//v6=rnd(3,4);
//v7=rnd(-1,1);
//v8=rnd(-1,1);
//v9=rnd(-1,1);
//v10=rnd(2,v6);
//v17=rnd(-2,2);
//v18=rnd(-2,2);
//v19=rnd(-2,2);
//v110=rnd(2,v6);
//echo(smoothstrengh,edgetreshold,sharptreshold);
//function evalv(p)=
//max(max(p.x*sin(v1)-v2 -p.z*cos(v1) ,p.y,cube(p-[v3,v4,v5],0.35+v6,1)),-sphere(p-[v7,-v8,v9],v10),-cube(p-[v17,-v18,v19],v110));
scenegraph =  
    union(0.01,[  for(i=[0:2])
    translate([rnd(-10,10),rnd(-10,10),rnd(-10,10)],
                [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)],[ cube(rnd(5,10))])])     
]      )   ;

function evalv(p)=eval(p,scenegraph)
;
//minR(
//cube(p+[0,1.1,1],2,0),
//max(cube(p-[0,1.1,1],2,0),-sphere(p,1)),   
//0.001);
// x=-1;y=0;z=1;    
//function evalv(p)=sphere(p,4)+ (sin(atan2(p.y,p.x)*4))*(1-abs(un(p).z)) ;
//function evalv(p)=torus(p, tx = 3, ty = 2);
//
//function evalv(p)=
// 
//let(r=3,hr=2)
//minRlist([
//tube(p+[sin(0)*r,cos(0)*r,0],hr),
//tube(p+[sin(120)*r,cos(120)*r,0],hr),
//tube(p+[sin(240)*r,cos(240)*r,0],hr)
//,
//sphere(p+[sin(60)*r,cos(60)*r,0],hr),
//sphere(p+[sin(180)*r,cos(180)*r,0],hr),
//sphere(p+[sin(300)*r,cos(300)*r,0],hr)
//]
//,hr*0.5)
//;
// function evalv(p)=
// 
//let(r=3,hr=2)
//minRlist([
//cube(p+[3,0,0],2),
//cube(p+[0,3,0],2),
//cube(p+[0,0,3],2),
//],2);

function minRlist(l,r)=let(sl=quicksort(l))minR(l[2],minR(l[1],l[0],r),r) ;//minRlistworker(  (sl),len(l)-1,r) ; 
function minRlistworker(l,c,r)=c>0? minR(minRlistworker(l,c-1,r), l[c], r) : l[0]  ;

function quicksort(kvs) = 
  len(kvs)>0
     ? let( 
         pivot   = kvs[floor(len(kvs)/2)], 
         lesser  = [ for (y = kvs) if (y  < pivot) y ], 
         equal   = [ for (y = kvs) if (y == pivot) y ], 
         greater = [ for (y = kvs) if (y  > pivot) y ] )
          concat( quicksort(lesser), equal, quicksort(greater))
      : [];


 

function rev(v) = [
 for (i = [len(v) - 1: -1: 0]) v[i]
];

 

// main  
 pv=[for(x=[-cell:cell],y=[-cell:cell],z=[-cell:cell])
 let(i=full(x,y,z))if(i[0][0]!=undef )i
];


mesh=glue(cbpl(pv,len(pv)));

//  mesh1=refitmesh(mesh,2);
  mesh1=[fit(mesh),mesh[1]];


  meshlist2=splitfaces(mesh1[0],mesh1[1]);

 meshx= glue (cbpl(meshlist2,len(meshlist2)));
 
  mesh2=refitmesh(meshx,3,sharp=false);
 //intersection(){
//sphere(2);
//cm= facemidpoints(mesh0[0],mesh0[1]);

// for(i=meshlist2)color(rndc())polyhedron(i[0],i[1]);
polyhedron(mesh2[0],mesh2[1]);
function splitfaces(points,faces)=
[for (i=[0:len(faces)-1])
let(
poly=faces[i],
p0=points[poly[0]],
p1=points[poly[1]],
p2=points[poly[2]],
p01=lerp(p0,p1,0.5),
p12=lerp(p1,p2,0.5),
p20=lerp(p2,p0,0.5),
e01=abs(evalv(p01)),
e12=abs(evalv(p12)),
e20=abs(evalv(p20)),
//snapped
sp0=fit([[p0]])[0],
sp1=fit([[p1]])[0],
sp2=fit([[p2]])[0],
nsp0=un(evalnorm2(sp0)),
nsp1=un(evalnorm2(sp1)),
nsp2=un(evalnorm2(sp2)),
sp01=findp2p(p01, [[p0,nsp0],[p1,nsp1]]),
sp12=findp2p(p12, [[p1,nsp1],[p2,nsp2]]),
sp20=findp2p(p20, [[p2,nsp2],[p0,nsp0]]),
l01=norm(p0-p1),
l12=norm(p1-p2),
l20=norm(p2-p0),

lim=edgetreshold,
pvt=[e01>lim,e12>lim,e20>lim])
 (pvt== [false, false, false])  ?[[p0,p1,p2],[[0,1,2]]]:
 (pvt== [true, false, false]) ?[[p0,sp01,p1,sp12,p2,sp20],[[0,1,4],[1,2,4]]]:
 (pvt== [false, true, false]) ?[[p0,sp01,p1,sp12,p2,sp20],[[2,3,0],[3,4,0]]]:
 (pvt== [false, false, true])? [[p0,sp01,p1,sp12,p2,sp20],[[2,5,0],[2,4,5]]]:
 (pvt== [true, true, false]) ?[[p0,sp01,p1,sp12,p2,sp20] ,[[0,1,3],[0,3,4],[1,2,3]]]:
 (pvt== [ false,true, true]) ?[[p0,sp01,p1,sp12,p2,sp20],[[0,2,3],[0,3,5],[3,4,5]]]:
 (pvt== [ true,false, true]) ? [[p0,sp01,p1,sp12,p2,sp20],[[1,2,5],[2,4,5],[0,1,5]]]:
  [[p0,sp01,p1,sp12,p2,sp20],[[0,1,5],[1,2,3],[3,4,5],[1,3,5]]]

]
;

 

//for(i=mesh0[0])
//line(i,i+ un( (i))*eval(i),0.05);
// }
 //echo(mesh0); 
function rndc( )=[rnd(),rnd(),rnd()];

function full(x,y,z)=
let(p=[x,y,z],
p000= (p+[0,0,0]),
p100= (p+[1,0,0]),
p010= (p+[0,1,0]),
p011= (p+[0,1,1]),
p001= (p+[0,0,1]),
p110= (p+[1,1,0]),
p101= (p+[1,0,1]),
p111= (p+[1,1,1]),
e000=eval(p+[0,0,0]),
e100=eval(p+[1,0,0]),
e010=eval(p+[0,1,0]),
e011=eval(p+[0,1,1]),
e001=eval(p+[0,0,1]),

e110=eval(p+[1,1,0])
,
e101=eval(p+[1,0,1]),
e111=eval(p+[1,1,1]),

t1=tet(e000,e100,e101,e111,p000,p100,p101,p111),
t2=tet(e000,e101,e001,e111,p000,p101,p001,p111),
t3=tet(e000,e001,e011,e111,p000,p001,p011,p111),
t4=tet(e000,e011,e010,e111,p000,p011,p010,p111),
t5=tet(e000,e010,e110,e111,p000,p010,p110,p111),
t6=tet(e000,e110,e100,e111,p000,p110,p100,p111))
 cbp(t1,cbp(t2,cbp(t3,cbp(t4,cbp(t5,t6)))))

//t1=tet(e000,e110,e011,e101,
//       p000,p110,p011,p101),
//
//t2=tet(e000,e110,e010,e011,
//       p000,p110,p010,p011),
//
//t3=tet(e000,e110,e100,e101,
//       p000,p110,p100,p101),
//
//t4=tet(e011,e101,e000,e001,
//       p011,p101,p000,p001),
//
//t5=tet(e011,e101,e110,e111,
//       p011,p101,p110,p111))
// cbp(t1,cbp(t2,cbp(t3,cbp(t4,t5))))

;

function cbp(p1,p2)= (combinepolyhedron(p1,p2));

function cbpl(l,n,c=0)=c<n-1?cbp(l[c],cbpl(l,n,c+1)):l[c];

 function evalnorm2(q  ) =
let (tiny = 0.00001, 
e = evalv(q  ))[
e - evalv([q.x - tiny, q.y, q.z]  ), 
e - evalv([q.x, q.y - tiny, q.z]  ), 
e - evalv([q.x, q.y, q.z - tiny] )];

function refitmesh(m ,c = 2,sharp=false)=let (
points=m[0],faces=m[1],
neighbours =  pointneighbours (points,faces),
newmesh=refitworker(points, faces, neighbours,sharp,c)
 

)
[newmesh[0],newmesh[1]]
;


function getsharps(points,faces,neighbours)=
let(
fn=facenormals (points,faces),
pn=pointsnormal(points,fn,neighbours)
)
[
for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 ?

let(r=abs(  addl([for (j = [0: len(neighbours[i]) - 1]) dot (un(pn[i]),un(faces[neighbours[i][j]])) ])-len(neighbours[i])  ))
r<sharptreshold?false :true
:false

]
;

function pointneighbourscenterpoint(midpoints,neighbours,points)=
    [for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 ?
   lerp(points[i], avrgp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ]),1):points[i]];

function refitworker(points, faces, neighbours,sharp,c=2)=c >0 ?
let(
sharps=sharp==true? getsharps(points,faces): [for(i=points)false],

imesh=lerp([points, faces],relaxmesh(points, faces, neighbours, sharps, 1),smoothstrengh),
wpoints=fit([fit(imesh )]) ,
mwpoints=sharpen(wpoints, faces, neighbours)
)
refitworker(mwpoints, faces, neighbours,sharp,c-1):
[points, faces]
;

function fit(m)=  
[for(i=m[0])i- un(evalnorm2(i))*evalv(i)*1];



function sharpen(points, faces, neighbours)=
let(
midpoints=  facemidpoints(points  ,faces),
fittedmidpoints=fit([fit([midpoints])]),
normalatfmidpoints=[for(i=fittedmidpoints)evalnorm2(i)], 
newpoints=[
for(i=[0:len(points)-1])

 findp2p(points[i],[
for(j=[0:len(neighbours[i])-1])
let(k=neighbours[i][j])
[fittedmidpoints[k],normalatfmidpoints[k]]
]
 )
 ] 
)

newpoints;

function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;


////////////
// feature detector fake QEF-solver
function findp2p(inp, pl,   f = 15) =
let (p = inp )
f > 0 && len(pl) > 0   ?

 let (q = avrgp([ for (i = [0: len(pl) - 1]) 
let (new_p=point2plane(p, pl[i][0], un(pl[i][1])))  new_p
 ]), df = q - p) 

 findp2p((p + (df * 0.99)), pl,   f - 1)  :p;
////////////
////////////
////////////
////////////
////////////

// project a point to a plane
function point2plane(p, o, n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane
function dist_point2plane(p, o, n) =
let (v =  p-o)  ( (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane

// push point along gradient to zero boundary in a few steps
function push(inp, scene, mi, ma, c = 4) =
let (p = mima3(inp, mi, ma)) let (q = evalnorm2(p, scene), np = p + un(
 [q.x,
 q.y, q.z
 ]) * (-q[3] * 0.95)) c > 0 ? push(np, scene, mi, ma, c - 1) : np;

//  find the zero point between two points of difrent sign
function inter(t, r) = (sign(t) == sign(r)) ? undef: abs(0 - t) / max(
 abs(t - r), 0.0000001); //find zero point






function smoothmesh(points, faces, sharps, c = 2) =
faces==undef?smoothmesh(points[0],points[1]):

    let (neighbours =  pointneighbours (points,faces),
     t = relaxmesh(points, faces, neighbours, sharps,c))
    t;


function relaxmesh(points, faces, neighbours,sharps, c = 1) = c >0 ?
    relaxmesh(
pointneighbourscenterpoint2(
    facemidpoints(points
//  +pointsnormal(points,facenormals(points,faces),neighbours)*0.35
,faces),neighbours,points, faces,sharps)
, faces, neighbours,sharps, c - 1)

: [points, faces];

// function pointneighbourscenterpoint2(midpoints,neighbours,points, faces,sharps)=
//let(faceareas=[ for(i=[0:len(faces)-1])
//Area_Of_A_Triangle_By_Points(points[faces[i][0]],points[faces[i][1]],points[faces[i][2]]) ])
//    [for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 &&!sharps[i]?
//let( areas=un([for (j = [0: len(neighbours[i]) - 1]) faceareas[neighbours[i][j] ] ]),
//     op=avrgp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ]),
//     np=addlp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ]*areas[j] ])
//) 
//
//lerp(op,np,0.25)
//
//
//:points[i]];

function Area_Of_A_Triangle_By_Points(a,b,c)=
Area_Of_A_Triangle_By_Sides(norm(a-b),norm(b-c),norm(c-a))
;
function Area_Of_A_Triangle_By_Sides(a,b,c)=
    let(s=(a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)));

 
 function pointneighbourscenterpoint2(midpoints,neighbours,points,faces,sharps)=

    [for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 &&!sharps[i]?

     avrgp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ])


:points[i]];

function tet(e1,e2,e3,e4,p1,p2,p3,p4) =
let(
v=[e1,e2,e3,e4],
p12=(p1+p2)/2,
p13=(p1+p3)/2,
p14=(p1+p4)/2,
p23=(p2+p3)/2,
p24=(p2+p4)/2,
p34=(p3+p4)/2)
(v==[0,0,0,1]) ?  [[p14,p24,p34],[[0,1,2]]]:
(v==[0,0,1,0]) ?  [[p23,p13,p34],[[0,1,2]]]:
(v==[0,0,1,1]) ?  [[p23,p13,p14,p24],[[0,1,2],[0,2,3]]]:
(v==[0,1,0,0]) ?  [[p12,p23,p24],[[0,1,2]]]:
(v==[0,1,0,1]) ?  [[p23,p12,p14,p34],[[1,0,2],[2,0,3]]]: 
(v==[0,1,1,0]) ?  [[p12,p13,p34,p24],[[0,1,2],[0,2,3]]]: 
(v==[0,1,1,1]) ?  [[p12,p13,p14],[[0,1,2]]]: 
(v==[1,0,0,0]) ?  [[p13,p12,p14],[[0,1,2]]]: 
(v==[1,0,0,1]) ?  [[p12,p13,p34,p24],[[1,0,2],[2,0,3]]]: 
(v==[1,0,1,0]) ?  [[p23,p12,p14,p34],[[0,1,2],[0,2,3]]]: 
(v==[1,0,1,1]) ?  [[p23,p12,p24],[[0,1,2]]]: 
(v==[1,1,0,0]) ?  [[p23,p13,p14,p24],[[1,0,2],[2,0,3]]]: 
(v==[1,1,0,1]) ?  [[p13,p23,p34],[[0,1,2]]]:  
(v==[1,1,1,0]) ?  [[p24,p14,p34],[[0,1,2]]]:[[],[]];

function v2c(v)= [v[0],v[1],v[2]]*(0.5+0.5*v[3]);

function eval(p)=
asign(evalv(p));


 function sphere(p, b = 1) = norm(p) - b;
 function cylinder(p, b = 1) = max(norm([p.x,p.y]) - b,abs(p.z)-b);
 function tube(p, b = 1) = max(abs(norm([p.x,p.y]) - b*2/3)-b/3,abs(p.z)-0.7);

function cube(p, b = 1, r = 0.001) =
let (d = abs3(p) - [b - r, b - r, b - r])
(min(max(d.x, d.y, d.z), 0.0) + norm(max3(d, 0.0)) - r);
function max3(a, b) = [max(a[0], b),
 max(a[1], b), max(a[2], b)
];

function asign(x)=max(0,sign(x));

function len3(v) = len(v) > 1 ? sqrt(addl([
 for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;
//function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
function v3(p) = [p.x, p.y, p.z]; // vec3 formatter
function abs3(v=[0,0,0]) = [abs(v[0]), abs(v[1]), abs(v[2])
];
