//  test();
//helppolytools();
module helppolytools()
{
echo(str(chr(13),
"function combinepolyhedron(p1,p2) ",chr(13),
"function shiftindex(v,s) ",chr(13),
"function glue(points,faces) ",chr(13),
"function unique(m) ",chr(13),
"function flatten(l) ",chr(13),
"function pointsnormal(points,facenormals,neighbours) ",chr(13),
"function facenormals (points,faces) ",chr(13),
"function facemidpoints (points,faces) ",chr(13),
"function pointneighbours (points,faces) ",chr(13),
"function face_normal(v)",chr(13),
"function pointneighbourscenterpoint(midpoints,neighbours,points) ",chr(13),
"function un(v) ",chr(13),
"function avrg(l) ",chr(13),
"function addl(v, i=0, r=[0,0,0])  ",chr(13),
"function smoothmesh(points, faces,  c = 1,neighbours) ",chr(13),
"function relaxmesh(points, faces, neighbours, c = 1)  ",chr(13)
));

}
module test(){

cubemesh=combinepolyhedron(cubemesh3(),cubemesh2());
gluemesh=smoothmesh(glue(cubemesh[0],cubemesh[1]));
echo(gluemesh);
echo("before",len(cubemesh[0]));
echo("glued",len(gluemesh[0]));

polyhedron(gluemesh[0],gluemesh[1]);
}
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries

function cbpl(l,n,c=0)= let($L=l)cbplw(len(l)); 
function cbplw(n,c=0)=  c<n-1?  (cbp($L[c],cbplw(n,c+1))):$L[c];
function cbp(p1,p2)=(combinepolyhedron((p1),(p2)));
function combinepolyhedron(p1,p2)=len(p1)==0&&len(p2)==0?[]:len(p1)==0||p1[0][1]==undef?p2:len(p2)==0||p2[0][1]==undef?p1:
    [concat(p1[0],p2[0]),concat(p1[1], shiftindex( p2[1], len(p1[0]) ) )];

function shiftindex(v,s)=[for(vv=v)[for(vvv=vv)vvv+s]];

function glue(points,faces)=
faces==undef?glue(points[0],points[1]):
    let( usedpoints=([for(i=faces,j=i)points[j]]),

upoints=truepoints(unique(usedpoints)),
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

function normmesh(m)=[[for(i=m[0])un(i)],m[1]]; 

function flatten(l) = [ for (li = l, lij = li) lij ];


function pointsnormal(points,facenormals,neighbours)=[
    for (i = [0: len(points) - 1]) len(neighbours[i]) > 0 ?
    un(addlp([for (j = [0: len(neighbours[i]) - 1]) facenormals[neighbours[i][j] ] ]))
    :un(points[i])];
    
    

function facenormals (points,faces)= [
    for (i = [0: len(faces) - 1]) face_normal(
    [for(ii=[0: len(faces[i]) - 1]) points[faces[i][ii]] ])];

function facemidpoints (points,faces)= [
    for (i = [0: len(faces) - 1]) avrgp(
    [for(ii=[0: len(faces[i]) - 1]) points[faces[i][ii]] ])];

function pointneighbours (points,faces)= [
    for (i = [0: len(points) - 1])[for (j = [0: len(faces) - 1])
    if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j]];

function face_normal(v)= len(v)>3?un(face_normal([v[0],v[1],v[2]])
    +face_normal(concat([v[0]],[for(i=[2:len(v)-1])v[i]]))):let(u=v[0]-v[1],w=v[0]-v[2])
    un([u[1]*w[2]-u[2]*w[1],u[2]*w[0]-u[0]*w[2],u[0]*w[1]-u[1]*w[0]]);

function pointneighbourscenterpoint(midpoints,neighbours,points)=
    [for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 ?
    avrgp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ]):points[i]];

function un(v)=v/max(norm(v),1e-64);

//function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;

 function addlp(v, i=0, r=[0,0,0]) = i<len(v) ? addlp(v, i+1, r+v[i]) : r;

//function addl(v, i=0, r=undef) =r==undef?addl(v, 0, v[0]*0): i<len(v) ? addl(v, i+1, r+v[i]) : r;


function smoothmesh(points, faces,  c = 1,neighbours) =
faces==undef?smoothmesh(points[0],points[1],  c,neighbours):
neighbours==undef?smoothmesh(points[0],points[1],  c,pointneighbours (points,faces)):
    let ( t = relaxmesh(points, faces, neighbours, c))
    t;


function relaxmesh(points, faces, neighbours, c = 1) = c >0 ?
    relaxmesh(
pointneighbourscenterpoint(
    facemidpoints(points
// +pointsnormal(points,facenormals(points,faces),neighbours)*0.35
,faces),neighbours,points)
, faces, neighbours, c - 1):
 [points, faces];


    
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function dot(a,b)=a*b;
function heron(a, b, c) =
    let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));
function polyarea(p1, p2, p3) = heron(norm(p1 - p2), norm(p2 - p3), len3(p2 - p1));

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
//,    [23, 22, 21]
//,    [23,  21, 20]

]
];


function cubemesh2() = [
[

[-10, -10, 10],
[10, -10, 10],
[10, 10, 10],
[-10, 10, 10]
],
[


[ 1,0, 2],
[ 2,0,  3]


]
];

 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p)  )]);
} // polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}
