 


// group coplanar faces of polyhedron into sub patches

m=splitcoplanar(islands());
union(){for(poly=m)color(rands(0,1,3)) polyhedron(poly[0],poly[1]);}

function splitcoplanar(m) =
let (
    un = function(v) v / max(norm(v), 1e-64),

    normalOfFace = function(v) len(v) > 3 ? un(face_normal([v[0], v[1], v[2]]) + face_normal(concat([v[0]], [
        for (i = [2: len(v) - 1]) v[i]
    ]))) : let (u = v[0] - v[1], w = v[0] - v[2]) un([u[1] * w[2] - u[2] * w[1], u[2] * w[0] - u[0] * w[2], u[0] * w[1] - u[1] * w[0]]),
    toBaseForm = function(pn)[decimalround(0.001,pn[1]), decimalround(0.001,distancePoint2Plane(pn[0], [0, 0, 0], pn[1]))],
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
        for (fNB = uniqueFNBFs)[m[0], 
            [ for (f = [0: len(m[1]) - 1])
                if (faceNormalsBaseform[f] == fNB) m[1][f] ]]    ]
                    
    // list of coplanar ployhedron
) listOfMeshlets;

function decimalround(r,v)=is_list(v)?[for(i=v)decimalround(r,i)]:v-(v % r);


function islands()=let ( st=1/2,hardCodedFaces=[for(x=[0:st:10],y=[0:st:10],f=[0:1])
f==0?[p([x,y]),p([x,y+st]),p([x+st,y])]:
[p([x+st,y]),p([x,y+st]),p([x+st,y+st])]
],
    points=unique(flatten(hardCodedFaces)),        
nfaces= [for(face=hardCodedFaces)[for(vert=face)
    search([vert],points,1)[0]]])
[points,nfaces];    
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));

function p(v)=[v.x,v.y,((v.x+v.y)*0.2)+1*clamp(sin(v.x*40)+(cos(v.y*30)),.23,(10-v.y-v.x)*.5)] ;
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