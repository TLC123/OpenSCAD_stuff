include <hull.scad>;
cloud1=pointInSphere([100,0,0],10);
cloud2=pointInSphere([0,0,10],20,159);
 cloud3=pointInSphere([0,100,0],10);
 cloud12=concat(cloud1,cloud2);
 cloud23=concat(cloud2,cloud3);
 
  cloud(cloud12);
  cloud(cloud23);
// 
//a= ([ cloud12,hull(cloud12)]);
//b= ([ cloud23,hull(cloud23)]);
// 
// 
//
// 
////b1=translateMesh(a,[rnd(-10,10),rnd(-10,10),rnd(-10,10)]);
////b=scaleMesh(b1,rnd(0.5,2));
//  p=concat(cutPoints(b,a),cutPoints(a,b));
// 
//ap=concat (a[0],p);
//bp=concat (b[0],p);
//
//af= ([ ap,hull(ap)]);
//bf= ([ bp,hull(bp)]);
// 
// polyhedron(a[0],a[1]);
// polyhedron(b[0],b[1]);
// 
// for(i=p)translate(i)sphere(.5);
//  color("blue"){
//  for(i=a[0])translate(i)sphere(.5);
// for(i=b[0])translate(i)sphere(.5);
// }

module cloud(p)
{
    hull()    polyhedron(p,[[each[0:len(p)-1]]]);
    }

 function cutPoints(polyhedra1,polyhedra2)=
 let(
 edges1=getEdges(polyhedra1),
 faces1=getFaces(polyhedra2)
 )
 [for(f=faces1)  for(e=edges1) 
  let(  res=  pointOfItersection(f,e)  )  if(res!=[])
//      echo(str("     ", e,"  ",res  ))
      res ]
 
 
 ;
function wrap(x,x_max=1,x_min=0) =

 (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers 

function getEdges(polyhedra)=
let( points=polyhedra[0],faces=polyhedra[1])
 
[for(f=faces)let(l=len(f)-1)for( p=[0:l]) [points[f[p]],points[f[wrap(p+1,l)]]]   ]
;
function getFaces(polyhedra)=
let( points=polyhedra[0],faces=polyhedra[1])
[for(f=faces) [for(p=f) points[p]  ]  ]

;
function getMesh (soup)=
[[for(i=soup) each[i[0],i[1],i[2]]  ],

[for(i=[0:3:(len(soup)-1)*3])[i,i+1,i+2] ]
    ]

;
 function getpoints(soup)=unique([for(i=soup,j=i)j]);

//function doesIntersect (face,line)=
//!is_list(face)||!is_list(line)?false:
// len(face) !=4|| len (line)!=3?false:
//
//let (
////e=echo(len(face),len(line)),
// 
////intersectPlane= sign(distanceFromPlane (face,line[0])) != sign(distanceFromPlane (face,line[1])) ,
//insideAB=0>sign(distanceFromPlane ([line[0],face[0],face[1]],line[1])),
//insideBC=0>sign(distanceFromPlane ([line[0],face[1],face[2]],line[1])),
//insideCA=0>sign(distanceFromPlane ([line[0],face[2],face[0]],line[1])))
//// intersectPlane&&
//insideAB&&insideBC&&insideCA 
// 
//;


function pointOfItersection (face,line)=
let(
p0=line[0],
p1=line[1],
 
d0= distanceFromFace (face,p0),

d1=distanceFromFace (face,p1)
)
 sign(d0) == sign(d1)? []: 
 let(
insideAB= sign(distanceFromFace ([p0,face[0],face[1]],p1)) >=0,
insideBC= sign(distanceFromFace ([p0,face[1],face[2]],p1))>=0,
insideCA= sign(distanceFromFace ([p0,face[2],face[0]],p1))>=0
)
insideAB||insideBC||insideCA?[]:
 
let (
 
l=abs(d0)+abs(d1),

 
f= abs(d0)/l,
P= lerp(p0,p1,f)
)
 P
 ;

 

function dot(a,b)=a*b;


function distanceFromFace(face,vertex)=
let( N=faceNormal(face), P= face[0] )
dot (N,vertex-P)
;
function faceNormal(v)= len(v)>3?un(faceNormal([v[0],v[1],v[2]])
+faceNormal(concat([v[0]],[for(i=[2:len(v)-1])v[i]]))):
    let(u=v[0]-v[1],w=v[0]-v[2] 
)
un( cross(u,w));
function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] *
v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);

 function  projectPoint2plane(p,o,n) =  p-n* dot (p-o,n); 

function v3(p) = [p.x, p.y, p.z]; // vec3 formatter
// polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
hull() {
translate(p1) sphere(width);
translate(p2) sphere(width);
}
}
function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
(rands(min(a, b), max(   a, b), 1)[0]) 
: 
(rands(min(a, b), max(a, b), 1, s)[0])
; 
function rndc(a=1,b=0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function dot(a,b)=a*b;
function heron(a, b, c) =
let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));
function polyarea(p1, p2, p3) = heron(norm(p1 - p2), norm(p2 - p3), len3(p2 - p1));
function un(v)=is_list(v)? v/max( is_undef(norm(v))?0:norm(v),1e-16):v;

//function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;

 function addlp(v, i=0, r=[0,0,0]) = i<len(v) ? addlp(v, i+1, r+v[i]) : r;

function translateMesh (mesh,T)= [[for (vx=mesh[0])vx+T],mesh[1]];
function scaleMesh (mesh,s)= [  mesh[0] *s,mesh[1]];

function pointInSphere(p,r,n=30)=
let(rsq=r*r)[
for(i=[0:n])
    let(v=[rnd(-r,r),rnd(-r,r),rnd(-r,r)])
if((v.x*v.x+v.y*v.y+v.z*v.z)<rsq)v+p ];




function glue(points,faces)=
faces==undef?glue(points[0],points[1]):
    let( usedpoints=([for(i=faces,j=i)points[j]]),

upoints=truepoints(unique(points)),
nfaces= [for(i=faces)[for(j=i)
    search([points[j]],upoints,1)[0]]])
[upoints,nfaces];

function truepoints(p)=[for(i=p)if(i!=undef)i];

function  uniquejoin(m,n) =  
    concat(m,[   for (i = n)    if (search([i],m,1)==[[]]) i  ]);

//function  unique(m) = [   for (i = [0: len(m) - 1])    if (search([m[i]],m,1)==[i]) m[i] ];

function  unique(m,first,last) = last==undef?unique(m,0,len(m)-1) :
last-first>1? let(mid=(first+last)/2)
uniquejoin(  unique(m,first,floor(mid)),         unique(m,ceil(mid),last) )
 :m[first]==undef? [m[last]]: m[last]==undef?[m[first]] :concat([m[first]],[if( m[last]!=m[first])m[last]] ) ;

function cubemesh3() = [
[
[-10, -10, -10],
[10, -10, -10],
[10, 10, -10],
[-10, 10, -10],
[-10, -10, -10],
[10, -10, -10],
[10, -10, 10],
[-10, -10, 10],
[10, -10, -10],
[10, 10, -10],
[10, 10, 10],
[10, -10, 10],
[10, 10, -10],
[-10, 10, -10],
[-10, 10, 10],
[10, 10, 10],
[-10, 10, -10],
[-10, -10, -10],
[-10, -10, 10],
[-10, 10, 10],
[-10, -10, 10],
[10, -10, 10],
[10, 10, 10],
[-10, 10, 10]
],
[
//     [0, 1, 2, 3],
//     [7, 6, 5, 4],
//     [11, 10, 9, 8],
//     [15, 14, 13, 12],
//     [19, 18, 17, 16],
//    [23, 22, 21, 20]


[0, 1, 2],
[0,  2, 3]
,
[7, 6, 5],
[7,  5, 4],
[11, 10, 9],
[11, , 9, 8],
[15, 14, 13],
[15,  13, 12],
[19, 18, 17],
[19,  17, 16]
 ,    [23, 22, 21]
 ,    [23,  21, 20]

]
];