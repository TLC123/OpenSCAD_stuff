 include<halfedge.scad>

flattness=0.151;
// group coplanar faces of polyhedron into sub patches
 mesh= (islands());
 // union()polyhedron(mesh[0],mesh[1]);
  m=splitcoplanar(mesh);
 for(g=[0:len(m)-1]){
n=m[g];
edges=edges(n);
points=m[0][0];
faces=n[1];
 
elpe=unique(filteroutmax([for(i=[0:len(edges)-1])min(getedgeloop(i,edges))],len(edges)+1)); 

edgesgroupid=elpe;
 
//echo(elpe);
 if(edgesgroupid!=[])
 {
     

loops=[for(j=edgesgroupid) topointsindex(getedgeloop(j,edges),edges)] ;
      
 
for(lo=loops){color(rands(0,1,3))polyhedron(points,[lo]);}

 
    
}}
// union(){for(poly=m)color(rands(0,1,3)) polyhedron(poly[0],poly[1]);}
function topointsindex (ei,edges)=[for( i=ei)edges[i][0]];
function getedgeloop(e,edges,start,res2=[])=
 edges[e][2]!=[]?  len(edges)+1:
e==start?res2:
let(start=is_undef(start)?e:start)

getedgeloop(nextopen(edges[e][1],edges),edges,start,concat(res2,e))
;

function nextopen(e,edges)=edges[e][2]==[]?e:
nextopen( edges[edges[e][2]][1]


,edges);

function filteroutmax(v,mx)=[for(i=v)if (i!=mx )i];
    
function groupid(edgesid,edges)=
let(
nid=[for(i=edgesid)
   i>=len(edgesid)?i:
edges[i][2]!=[]?len(edgesid)+1 : 

 
edgesid[nextopen(i,edges)]<=edgesid[i]?

edgesid[nextopen(i,edges)]:edgesid[i]]
)
 
nid==edgesid?edgesid:
groupid(nid,edges)
;

function splitcoplanar(m) =
let (
    un = function(v) v / max(norm(v), 1e-64),

    normalOfFace = function(v) len(v) > 3 ? un(face_normal([v[0], v[1], v[2]]) + face_normal(concat([v[0]], [
        for (i = [2: len(v) - 1]) v[i]
    ]))) : let (u = v[0] - v[1], w = v[0] - v[2]) un([u[1] * w[2] - u[2] * w[1], u[2] * w[0] - u[0] * w[2], u[0] * w[1] - u[1] * w[0]]),
    toBaseForm = function(pn)[decimalround(flattness,pn[1]), decimalround(flattness,distancePoint2Plane(pn[0], [0, 0, 0], pn[1]))],
    point_to_line = function(p, a, b) let (ap = p - a, ab = b - a) a + dot(ap, ab) / dot(ab, ab) * ab,
    distancePoint2Plane = function(point, planes_origin, planes_normal) let (v = point - planes_origin) v.x * planes_normal.x + v.y * planes_normal.y + v.z * planes_normal.z,
    unique = function(m)[
        for (i = [0: max(0, len(m) - 1)])
            if (search([m[i]], m, 1) == [i]) m[i]],

    faceNormalsBaseform = ([
        for (f = m[1]) toBaseForm([m[0][f[0]], normalOfFace([
            for (p = f) m[0][p]
        ])])
    ]),
    uniqueFNBFs = unique(faceNormalsBaseform), // one bucket for each coplanar group
    listOfMeshlets = [
        for (fNB = uniqueFNBFs)
            (
        [m[0], 
            [ for (f = [0: len(m[1]) - 1])
                if (faceNormalsBaseform[f] == fNB) m[1][f] ]]   ) ]
                    
    // list of coplanar ployhedron
)( listOfMeshlets);

function decimalround(r,v)=is_list(v)?[for(i=v)decimalround(r,i)]:v-(v % r);


function islands()=let ( st=1/2 ,

hardCodedFacesa=[for(x=[0:st:10],y=[0:st:10],f=[0:1])
f==0?[p([x,y]),p([x,y+st]),p([x+st,y])]:
[p([x+st,y]),p([x,y+st]),p([x+st,y+st])]
],hardCodedFacesb=[for(x=[0:st:10],y=[0:st:10],f=[0:1])
    reverselist(
    f==0?[b([x,y]),b([x,y+st]),b([x+st,y])]:
    [b([x+st,y]),b([x,y+st]),b([x+st,y+st])]
)],
xe=[for(v=[0:st:10+st])[v,0]],
ye=[for(v=[00:st:10+st])[reverselist(xe)[0].x,v]],
xe2=[ for(v= reverselist(xe) )[v.x, reverselist(ye)[0].y ] ],
ye2=[for(v=reverselist(ye))[0,v.y]],
edge=concat(xe,ye,xe2,ye2),



    
hardCodedFacesc=[for(i=[0:len(edge)-1],f=[0:1])
    let(le=len(edge) )
reverselist(
 f==0?[b(edge[i]),b(edge[(i+1)%le]),p(edge[i])]:
 [b(edge[(i+1)%le]),p(edge[(i+1)%le]),p(edge[i])])
],

 hardCodedFaces=concat(hardCodedFacesa,hardCodedFacesb,hardCodedFacesc),
//hardCodedFaces=concat( hardCodedFacesc),
    points=unique(flatten(hardCodedFaces)),        
nfaces= [for(face=hardCodedFaces)[for(vert=face)
    search([vert],points,1)[0]]])
[points,nfaces];    
function reverselist(v)=[for(i=[len(v)-1:-1:0])v[i]];
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));

function p(v)=decimalround(0.0001 ,[v.x,v.y,((v.x+v.y)*0.2)+1*clamp(sin(v.x*40)+(cos(v.y*30)),.23,(10-v.y-v.x)*.5)] );
function b(v)=decimalround(0.0001 ,[v.x,v.y,0] );
function flatten(l) = [ for (li = l, lij = li) lij ];
 function unique (m)= [
        for (i = [0: max(0, len(m) - 1)])
            if (search([m[i]], m, 1) == [i]) m[i]];

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

module line(p1,p2){
  color("black")  hull(){
    translate(p1)cube(.05);
    translate(p2)cube(.05);
    }
    
    }