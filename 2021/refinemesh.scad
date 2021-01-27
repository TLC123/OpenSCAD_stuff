// Naive adaptive subdivision scheme for general mesh deformations.
// How it works is define a deformation function in a function litteral.
// Define target edge-lenght and a inittial larger multiple edge-length
// Then in recursion apply deformation to a copy of the mesh.
// For each DEFORMED triangle take note of what edegs are above larger treshold length.
// !! Split the ORIGINAL undeformed triangle !! by corresponding affected edges. Discard deformed copy. 
// Clean up results to a neat point,face form.
// Divide the treshold by two and repeat recurively until the larger threshold is less than target treshold.
// Apply a final deformation  of the subdivided original to obtain a defromed mesh with adaptve subdivision where it counts. 

include <BOSL2/std.scad>
 

lshape=[[-5,-5],[5,-5],[5,0],[0,0],[0,5],[-5,5]];
path_transforms=[affine3d_translate([0,0,0]),affine3d_translate([0,-2,4.5]),affine3d_translate([0,2,9])];
 
 s =   (  quadcube([8,8,8],center=true));

 // polyhedronMesh(s);
  bend=makeFunction_bend(360,[5,0,0]);
// echo(ref);
// echo(ref==s);
d=spherify(refine(s,.75));

bendt= refine(d, .5,bend );
//echo(T);
color("lightgreen")  polyhedronMesh(bendt);
 color("lightgreen")  polyhedronMesh( d );
// 


function spherify(m)=[[for(p=m[0])un(p)*4+[1,2,0]],m[1]];
 
function refine(m,limit,transform,thisCut)=
let(nullfunc=function(x)x)
let(transform=is_undef(transform)?nullfunc:transform)
is_undef(thisCut)?refine(m,limit,transform,getFirstCut(m,limit)) :
thisCut<=limit? transform (glue(m) ):
//echo(thisCut)
let(p=m[0])
let (tpoints=transform (m )[0])
    let( meshlets= [for(f=m[1]) split( [for(i=f)p[i]]  ,[for(i=f)tpoints[i]],thisCut)  ])
   let(newmesh=mergeMeshlets(meshlets))
    
    refine(newmesh,limit,transform,thisCut/2)
 ;

function split(vs,tvs, egdelimit) =
    len(vs)==4?quadsplit(vs,tvs, egdelimit):
let (e01 = dotself(tvs[0] - tvs[1]))
let (e12 = dotself(tvs[1] - tvs[2]))
let (e20 = dotself(tvs[2] - tvs[0]))
let (sqEdgeLimit = egdelimit * egdelimit)
 let (truth = [e01 > sqEdgeLimit, e12 > sqEdgeLimit, e20 > sqEdgeLimit])
let (nvs = [vs[0], (vs[0] + vs[1]) / 2, vs[1], (vs[1] + vs[2]) / 2, vs[2], (vs[2] + vs[0]) / 2])
truth == [true, true, true] ?  [nvs, [[0, 1, 5],[1, 2, 3],[3, 4, 5],[1, 3, 5]]] : 

truth == [true, false, false] ?  [nvs, [[0, 1, 4],[1, 2, 4]]] : 
truth == [false, true, false] ?  [nvs, [[0, 2, 3],[0, 3, 4]]] : 
truth == [false, false, true] ?  [nvs, [[0, 2, 5],[2, 4, 5]]] : 
truth == [false, true, true] ?  
dotself(nvs[3] - nvs[0]) < dotself(nvs[2] - nvs[5]) ? [nvs, [[0, 3, 5],[0, 2, 3],[3, 4, 5]]] : 
[nvs, [[0, 2, 5],[2, 3, 5],[3, 4, 5]]]: 
truth == [true, false, true] ?  
dotself(nvs[1] - nvs[4]) < dotself(nvs[2] - nvs[5]) ? [nvs, [[0, 1, 5],[1, 2, 4],[1, 4, 5]]] : 
[nvs, [[0, 1, 5],[1, 2, 5],[2, 4, 5]]]: 
truth == [true, true, false] ?  
dotself(nvs[1] - nvs[4]) < dotself(nvs[0] - nvs[3]) ? [nvs, [[0, 1, 4],[1, 3, 4],[1, 2, 3]]] : 
[nvs, [[0, 1, 3],[0, 3, 4],[1, 2, 3]]]: 
[vs, [[0, 1, 2]]];


function quadsplit(vs,tvs, egdelimit) =
let (e01 = dotself(tvs[0] - tvs[1]))
let (e12 = dotself(tvs[1] - tvs[2]))
let (e23 = dotself(tvs[2] - tvs[3]))
let (e30 = dotself(tvs[3] - tvs[0]))

let (sqEdgeLimit = egdelimit * egdelimit)
 let (truth = [e01 > sqEdgeLimit, e12 > sqEdgeLimit, e23 > sqEdgeLimit, e30 > sqEdgeLimit])

let (nvs = [vs[0], (vs[0] + vs[1]) / 2,vs[1], (vs[1] + vs[2]) / 2, vs[2], (vs[2] + vs[3]) / 2, 
vs[3], (vs[3] + vs[0]) / 2, ( vs[0]+vs[1]+vs[2]+vs[3] ) / 4] )
let(quads=bitMaskToValue(truth))
//echo(quads,truth)
[nvs,quadtable(quads)]

;
    function quadtable(i)=
[
[[0,2,4,6]],//0
[[0,1,8,6],[1,2,4,8],[4,6,8]],//1
[[2,3,8,0],[3,4,6,8],[0,8,6]],//2
[[1,2,3,8],[3,4,6,8],[0,1,8,6]],//3
[[5,6,0,8],[2,4,5,8],[0,2,8]],//4
[[0,1,5,6],[1,2,4,5]],//5
[[3,4,5,8],[0,2,3,8],[0,8,5,6]],//6
[[0,1,5,6],[1,3,4,5],[1,2,3]],//7
[[4,6,7,8],[0,2,8,7],[2,4,8]],//8
[[0,1,8,7],[1,2,4,8],[4,6,7,8]],//9
[[0,2,3,7],[3,4,6,7]],//10
[[3,4,6,7],[1,2,3,7],[0,1,7]],//11
[[5,6,7,8],[0,2,8,7],[2,4,5,8]],//12
[[2,4,5,1],[0,1,5,7],[5,6,7]],//13
[[0,2,3,7],[7,3,5,6],[3,4,5]],//14
[[7,0,1,8],[1,2,3,8],[3,4,5,8],[5,6,7,8]],//15
][i];
function bitMaskToValue(v=[0])= is_undef(v[0])?0:
 [for(j=v)1]* [for (i=[0:max(0,len(v)-1)]) toBit(v[i])*pow(2,i)] ;
function toBit(i) =is_bool(i)? (i?1:0):max(0,sign(i));



  function makeFunction_bend(x,y)=  function(m )  bendwork(m,x,y );

function bendwork(m,a,o) =
let (cell=getBoundingBox(m))
let(ztot=cell[1].z-cell[0].z)
let(offs=sign(a)>0?cell[1].x+o.x+ztot/2:cell[0].x+o.x )
let(o=[offs,0,0])
let(points=m[0],faces=m[1])
let(
points=[for(p=points)
    let(po=p.z/ztot)
//    let(p=[p.x,p.y,p.z]-o) 
    let(p=concat(p,[1]) ) 
let (p=p*
//[
//    [ cos(po *a), 0, sin(po *a),   0],
//    [        0, 1,        0,   0],
//    [-sin(po *a), 0, cos(po *a),   0],
//    [        0, 0,        0,   1]
//]

[
    [ cos(po *a),  sin(po *a),0,   0],
    [-sin(po *a), cos(po *a),  0,   0],
    [           0,        0,  1,   0],
    [           0,        0,  0,   1]
]

)
    let(p=[p.x,p.y,p.z])
    let(p=p+o) 
p
]
) [ points ,faces] ;

function sq(x)=x*x;

function scale8(m)=[[for(i=m[0])[i.x,i.y,i.z/8]],m[1]];
function mergeMeshlets(l)=
   let(points=[for(pl=l,p=pl[0])p])
  let(hcfaces=[for(pl=l,f=pl[1]) [for(p=f) pl[0][p] ]])
      let(faces=[for(f=hcfaces)[for(p=f)search([p],points,1)[0]]])
   [points, faces];
      
function getFirstCut(m,limit)=let(p=m[0])let(ceiling=sqrt(3)*max(maxX(p)-minX(p),maxY(p)-minY(p),maxZ(p)-minZ(p))) max2PowerOfBLessThanA(ceiling,limit);
 function all(v,bool=true)=len(search([bool] ,v,0)[0])==len(v);
function triangulate_vnf(m) = [m[0], triangulate_faces(m[0], m[1])];
function clamp(a, b = 0, c = 1) = min(max(a, min(b, c)), max(b, c));
function dotself(v) = v * v;
function dot(a, b) = a * b;
 function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) = min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);
function max2PowerOfBLessThanA(a,b)=(pow(2,floor(log(2,a/b)))*b);
function getBoundingBox (m) = let(p=m[0])[[minX(p),minY(p),minZ(p)],[maxY(p),maxX(p) ,maxZ(p)]];
function minX(p)=min([for(i=p)i.x]);
function maxX(p)=max([for(i=p)i.x]);
function minY(p)=min([for(i=p)i.y]);
function maxY(p)=max([for(i=p)i.y]);
function minZ(p)=min([for(i=p)i.z]);
function maxZ(p)=max([for(i=p)i.z]);



module polyhedronMesh(mesh){polyhedron(mesh[0],mesh[1]);}

function smoothMesh(points, faces,  c = 1,neighbours) =
is_undef(faces )?smoothMesh(points[0],points[1],  c,neighbours):
is_undef(neighbours)?let(neighbours=pointneighbours (points,faces)) smoothMesh(points ,faces,  c,neighbours):
//  echo("smoothMesh",points,faces,neighbours)

    let ( t = relaxmesh(points, faces, neighbours, c))
    t;


function relaxmesh(points, faces, neighbours, c = 1) = c >0 ?
 let(fmp=   facemidpoints(points ,faces))  
//echo(fmp) 
 relaxmesh(
pointneighbourscenterpoint(
 fmp,neighbours,points)
, faces, neighbours, c - 1):
 [points, faces];

function pointneighbours (points,faces)= [
    for (i = [0: len(points) - 1])
        [for (j = [0: len(faces) - 1])
    if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j]
        ];
        
function pointneighbourscenterpoint(midpoints,neighbours,points)=
[for (i = [0: len(points) - 1]) len(neighbours[i]) > 1 ?
avrgp([for (j = [0: len(neighbours[i]) - 1]) midpoints[neighbours[i][j] ] ]):points[i]];
    
function facemidpoints (points,faces)=
//echo("\nfacemidpoints",points,"\n",faces)
let(p=points)
[for (f=faces)  (p[f[0]]+p[f[1]]+p[f[2]])/3];
    



function avrgp(v) =len(v) > 1 ? [for(v)1]* v / (len(v)) : v;

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

function quadcube (v,center)=let(x=v.x,y=v.y,z=v.z,o=center?[0,0,0]:v )
 [[[x,y,z]+o,[-x,y,z]+o,[-x,-y,z]+o,[x,-y,z]+o,[x,y,-z]+o,[-x,y,-z]+o,[-x,-y,-z]+o,[x,-y,-z]+o ]*.5 , [[3, 2, 1, 0], [1, 5, 4, 0], [2, 6, 5, 1], [3, 7, 6, 2], [0, 4, 7, 3], [4, 5, 6, 7], [3, 2, 1, 0]]]  
 
 ;
  module polyhedronMesh(mesh){polyhedron(mesh[0],mesh[1]);}
function reverse(v)=[for (i=[len(v)-1:-1:0])v[i]];
