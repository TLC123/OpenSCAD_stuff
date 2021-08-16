test();

module test(){

cubemesh=combinepolyhedron(cubemesh3(),cubemesh2());
gluemesh=glue(cubemesh[0],cubemesh[1]);
echo(gluemesh);
echo("before",len(cubemesh[0]));
echo("glued",len(gluemesh[0]));

polyhedron(gluemesh[0],gluemesh[1]);
}

function combinepolyhedron(p1,p2)=
    [concat(p1[0],p2[0]),concat(p1[1], shiftindex( p2[1], len(p1[0]) ) )];
function shiftindex(v,s)=[for(vv=v)[for(vvv=vv)vvv+s]];
function glue(points,faces)=
    let( upoints=unique(points),nfaces= [for(i=faces)[for(j=i)
    search([points[j]],upoints,1)[0]]])[upoints,nfaces];
function  unique(m) = [   for (i = [0: len(m) - 1])    if (search([m[i]],m,1)==[i]) m[i] ];
function flatten(l) = [ for (li = l, lij = li) lij ];


function pointsnormal(facenormals,neighbours)=[
    for (i = [0: len(points) - 1]) len(neighbours[i]) > 0 ?
    un(addl([for (j = [0: len(neighbours[i]) - 1]) facenormals[neighbours[i][j] ] ]))
    :un(points[i])];

function facenormals (points,faces)= [
    for (i = [0: len(faces) - 1]) face_normal(
    [for(ii=[0: len(faces[i]) - 1]) points[faces[i][ii]] ])];

function facemidpoints (points,faces)= [
    for (i = [0: len(faces) - 1]) avrg(
    [for(ii=[0: len(faces[i]) - 1]) points[faces[i][ii]] ])];

function pointneighbours (points,faces)= [
    for (i = [0: len(points) - 1])[for (j = [0: len(faces) - 1])
    if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j]];

function face_normal(v)= len(v)>3?un(face_normal([v[0],v[1],v[2]])
    +face_normal(concat([v[0]],[for(i=[2:len(v)-1])v[i]]))):let(u=v[0]-v[1],w=v[0]-v[2])
    un([u[1]*w[2]-u[2]*w[1],u[2]*w[0]-u[0]*w[2],u[0]*w[1]-u[1]*w[0]]);

function pointneighbourscenterpoint(midpoints,neighbours,points)=
    [for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 ?
    avrg([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ]):points[i]];

function un(v)=v/max(norm(v),1e-64);

function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function addl(v, i=0, r=[0,0,0]) = i<len(v) ? addl(v, i+1, r+v[i]) : r;

function smoothmesh(points, faces,  c = 1) =
    let (neighbours =  pointneighbours (points,faces),t = relaxmesh(points, faces, neighbours, c))
    t;

function relaxmesh(points, faces, neighbours, c = 1) = c >0 ?
    relaxmesh(pointneighbourscenterpoint(facemidpoints(points+pointsnormal(facenormals(points,faces),neighbours)*0.35,faces),neighbours,points), faces, neighbours, c - 1): [points, faces];
    


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


[0, 1, 2],
[0,  2, 3]


]
];