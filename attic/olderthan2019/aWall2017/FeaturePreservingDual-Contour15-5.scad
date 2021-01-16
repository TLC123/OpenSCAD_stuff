opU = 1; // 1 union
opI = 2; // 1 intersection
opS = 3; // 1 subtraction
opT = 4; // M transformation 4X4 functional
opH = 5; // 1 Convex hull
opE = 6; // 3 Extrude 2d shape, simple Z extrude of a subtree of Z plane cut (Q collapsed to z=0)
opO = 7; // 1 offset usually by distance but xyz surface normal or ambinet occlusion is possiblites
opD = 8; // ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]
opX = 9; // ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]
f_cube = 10; // unit radius cube
f_sphere = 11; // unit radius sphere
f_torus = 12; // unit radius torus
//named numbers
opc = 0;params = 1;subTree = 2;x = 0;y = 1;z = 2;null3 = [0, 0, 0];tiny = 0.01;far = 10000;
 
//scenegraph descriptor
scenegraph = [opT, [ [1,0, 1], [0, 0, 0], [1, 1, 1] ],
 [ [opT, [ [0, 0, 0], [0, 0, 0], [1, 1, 1] ],
     [ [opU, 0/*round union !!*/, [ 
         [opT, [  [ 0, 0  , 0],   [-54.4881, -1.1109, -21.3758],  [1, 1, 1] ],
             [  [f_sphere, [[15,12,9], 3,1]] ]]
 


         ]
    ]
    ]
 ]
 ]
];


// scenegraph=[opT,[ [ 00, 0, 0],[ 0, 0,0],[ 1, 1,1]],
//  [[opO,0,
// 
// [ [cR3,[5]] ,[cR3,[3]] 
// 
// ]]
// ]];
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// It starts here
 cell = autobound(scenegraph, cubic = false, pad = 0.125);
 
//cell = [[-10,-10,-10],[10,10,10]];
 
*translate([100, 0, 0]) color("Red") showcell(cell);
*translate([100, 0, 0]) unglymarch(scenegraph, cell, c = 6);

*color("Red") showcell(cell);
* showfield(scenegraph, cell*2, len3(cell[1] -
 cell[0]) / 100);
 
translate([-0, 0, 0]) color("Red") showcell(cell);
 
translate([ 0, 0, 0]) DualC(scenegraph, cell , depth =3);
 

//////////////////////////////////////////////////////////////////////////////////////
/* Dual Contour 
 This DC runs in two stages because unmutable data and fake QEF solver
 first we run trough all octnodes with sign change
 for each find each crossed edge, construct planes, encode cell hash,
 return a [hash of the cellbase coord, a vertex coord, 
 3 prototype faces to hypothetical neighbous hashes,list of feature planes] 
 all these cell packages are concatenated to a list and the octtree is done with

 The list is filtered for some junk
 A clean list of points is established each with corresponding index as the filterlist

 A face worker runs the raw hash referencing faces searches for points with corresponding hash and building a list of faces with point index instead of hash numbers 

 Usually the fitting of features are done in the octtree but here its delayed to after a mesh connectivity is established.
We establish a list of neighbouring faces for each point and calculate each face mindpoint.
since each ponit now is associated with a bag of planes
we can iterativley constrain each point closer to an avarege of its feature planes
and circumvent the QEF solver.
A few loops alternating constraining to planes and avareging between neigbours
results in a nicelt spaced mesh. (a few edgecase bugs)
*/
module DualC(scene, cell_in, depth = 3) {
 cell = len(cell_in) == 0 ? autobound(scene, cubic = false, pad =
 0.5) : cell_in;* color("Red") showcell(cell);
 RawMesh = octree(cell, scene, depth);
 t = polishup(RawMesh, cell,5);
 //// echo(cell,len(t[0]),len(t[1]) );
// for(i=t[0])echo(i);
 //// polyhedron(t[0], t[1]);
trender2(t);
texport(t);
}

function polishup(v, cell,voxel_treshold ) =
let (filterv = [
 for (i = [0: len(v) - 1])
 if (v[i][1][0] != undef) v[i]
 ], points = [
 for (i = [0: len(filterv) - 1]) filterv[i][1]
 ], 
// for(i=[0:len(v)-1]){if(v[i][1][0] !=undef) echo (v[i]);//translate(v[i][1])cube(0.6);}
 faces = faceworker(filterv), 
neighbours = [ for (i = [0: len(points) - 1])[ for (j = [0: len(faces) - 1])
 if (faces[j][0] == i || faces[j][1] == i || faces[j][2] == i || faces[j][3] == i) j] ], 
t = relax(points, faces, neighbours, filterv, cell,voxel_treshold  ))
t
//[points,faces]
;

function relax(points, faces, neighbours, filterv, cell,voxel_treshold , c =  5) = c >
 0 ?
 let (midpoints = [
 for (i = [0: len(faces) - 1]) avrg(
 [points[faces[i][0]], points[faces[i][1]], points[faces[i][
 2
 ]], points[faces[i][3]]])
 ], points2 = [
 for (i = [0: len(points) - 1]) len(neighbours[i]) > 0 ? findp2p(
 avrg([
 for (j = [0: len(neighbours[i]) - 1]) midpoints[
 neighbours[i]
 [j]]
 ]), filterv[i][3], cell[0] , cell[1],voxel_treshold ) : points[i]
 ])
relax(points2, faces, neighbours, filterv, cell, c - 1): [points,
 faces
];
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// arrange bundary box from sloppy to proper orientation of minor corner and major corner
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];

function octree(cell, scene, subdivision = 6) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (O = cell[0], S = cell[1], C = (O + S) / 2, D = S - O, maxD = max(
 D.x, D.y, D.z), eO = eval(O, scene), eC = eval(C, scene), p1 = O,
 p2 = ([S.x, O.y, O.z]), p3 = ([O.x, S.y, O.z]), p4 = ([O.x,
 O.y, S.z
 ]), p5 = ([S.x, S.y, O.z]), p6 = ([S.x,
 O.y, S.z
 ]), p7 = ([O.x, S.y, S.z]), p8 = ([S.x,
 S.y, S.z
 ]), p9 = C)
// if 
subdivision > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ? [] : concat(
 // else split cell in 8 new cells constructed by corners and center point
octree(bflip(p1, C), scene, subdivision - 1), octree(bflip(p2, C), scene, subdivision - 1), 
octree(bflip(p3, C), scene, subdivision - 1), octree(bflip(p4, C), scene, subdivision - 1), 
octree(bflip(p5, C), scene, subdivision - 1), octree(bflip(p6, C), scene, subdivision - 1), 
octree(bflip(p7, C), scene, subdivision - 1), octree(bflip(p8, C), scene, subdivision - 1)) :
 let (
e1 = eval(p1, scene), e2 = eval(p2, scene), 
e3 = eval(p3, scene), e4 = eval(p4, scene), 
e5 = eval(p5, scene), e6 = eval( p6, scene),
e7 = eval(p7, scene), e8 = eval(p8, scene), 
face1 = [encode(C), encode(C + [0, -D.y, 0]), encode(C + [0, -D.y, -D.z]), encode(C + [ 0, 0, -D.z ]) ], 
face2 = [encode(C), encode(C + [-D.x, 0, 0]), encode(C + [-D.x, 0, -D.z ]), encode(C + [0, 0, -D.z]) ], 
face3 = [encode(C), encode(C + [ 0, -D.y, 0 ]), encode(C + [-D.x, -D.y, 0]), encode(C + [-D.x, 0, 0]) ], 
planelista = makepl(scene, e1, e2, e3, e4, e5, e6, e7, e8, p1, p2, p3, p4, p5, p6, p7, p8), // list of planes intersecting edges of current cell
 planelistb = [
 for (i = [0: len(planelista) - 1])
 if (planelista[i][1] != [undef]) planelista[i]
 ], //filter planelist
 planelistc = len(planelistb) <= 0 ? concat(planelistb, [
 [p9, un(v3(evalnorm(p9, scene)))]
 ]) : planelistb, // if plane list is short add p9
 pointa = push(C, scene, C - D * 1, C + D * 1), // Snap vertecies to nearst zero boundary inside cell
 planeC = len(planelistb) > 0 ? avrg(
 [
 for (i = [0: len(planelistb) - 1]) planelistb[i][0]
 ]) : pointa, pointb = normeq(planelistc) <= 0.1 ? pointa :
 findp2p(planeC, planelistc, C - D * 1, C + D * 1,len3(D) ), // feature detector
 pointc = pointb // lerp(pointb, push(planeC,scene,C-D*0.49 ,C+D* 0.49),0.5)
 )
abs(eC) < maxD * 1.75 * 0.5 ? [
 [encode(C), C, [
 sign(e1) == sign(e2) ? [] : sign(e1) > 0 ? face1 : rev(face1),
 sign(e1) == sign(e3) ? [] : sign(e1) > 0 ? rev(face2) : (
 face2),
 sign(e1) == sign(e4) ? [] : sign(e1) > 0 ? rev(face3) : (
 face3)
 ], planelistb]
] : [];
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// are these normals almost the same?
function normeq(pl) = 
let (sums = avrg([
 for (i = [0: len(pl )- 1])
 for (j = [0: len(pl) - 1])(-1 + dot(pl[i][1], pl[j][1]))
])) abs(sums);

////////////
////////////
////////////
////////////
////////////
// feature detector fake QEF-solver
function findp2p(inp, pl, mi, ma,voxel_treshold, f = 15) =
let (p = inp/*mima3(inp, mi, ma)*/)
f > 0 && len(pl) > 0   ?

 let (q = avrg([ for (i = [0: len(pl) - 1]) let (new_p=point2plane(p, pl[i][0], pl[i][1])) if(len3(new_p-p)<voxel_treshold)new_p
 ]), df = q - p) 

 findp2p((p + (df * 0.9)), pl, mi, ma,voxel_treshold,  f - 1)  :p;
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
let (p = mima3(inp, mi, ma)) let (q = evalnorm(p, scene), np = p + un(
 [q.x,
 q.y, q.z
 ]) * (-q[3] * 0.95)) c > 0 ? push(np, scene, mi, ma, c - 1) : np;

//  find the zero point between two points of difrent sign
function inter(t, r) = (sign(t) == sign(r)) ? undef: abs(0 - t) / max(
 abs(t - r), 0.0000001); //find zero point


// build list of planes at intersected edges [p,N]
function makepl(scene, e1, e2, e3, e4, e5, e6, e7, e8, p1, p2, p3, p4,
 p5, p6, p7, p8) =
let (
s12 = inter(e1, e2), s13 = inter(e1, e3), s14 = inter(e1, e4), s52 = inter(e5, e2), 
s53 = inter(e5, e3), s58 = inter(e5, e8), s64 = inter(e6, e4), s62 = inter(e6, e2), 
s68 = inter(e6, e8), s74 = inter(e7, e4), s73 = inter(e7, e3), s78 = inter(e7, e8),
 
p12 = (s12 == undef) ? [lerp(p1, p2, 0.5), [undef]] : let (mp1 = lerp(p1, p2, s12))[mp1, un(v3(evalnorm(mp1, scene)))], 
p13 = (s13 == undef) ? [ lerp(p1, p3, 0.5), [undef] ] : let (mp2 = lerp(p1, p3, s13))[mp2, un(v3(evalnorm(mp2, scene)))],
 
 p14 = (s14 == undef) ? [lerp(p1, p4, 0.5), [ undef ]] : let (mp3 = lerp(p1, p4, s14))[mp3, un(v3(evalnorm(mp3, scene)))],
 p52 = (s52 == undef) ? [lerp(p5, p2, 0.5), [undef]] : let (mp4 = lerp(p5, p2, s52))[mp4, un(v3(evalnorm(mp4, scene)))], 
p53 = (s53 == undef) ? [ lerp(p5, p3, 0.5), [undef] ] : let (mp5 = lerp(p5, p3, s53))[mp5, un(v3(evalnorm(mp5, scene)))],
 p58 = (s58 == undef) ? [lerp(p5, p8, 0.5), [ undef ]] : let (mp6 = lerp(p5, p8, s58))[mp6, un(v3(evalnorm(mp6, scene)))],
 p64 = (s64 == undef) ? [lerp(p6, p4, 0.5), [undef]] : let (mp7 = lerp(p6, p4, s64))[mp7, un(v3(evalnorm(mp7, scene)))],
 p62 = (s62 == undef) ? [ lerp(p6, p2, 0.5), [undef] ] : let (mp8 = lerp(p6, p2, s62))[mp8, un(v3(evalnorm(mp8, scene)))],
p68 = (s68 == undef) ? [lerp(p6, p8, 0.5), [ undef ]] : let (mp9 = lerp(p6, p8, s68))[mp9, un(v3(evalnorm(mp9, scene)))],
p74 = (s74 == undef) ? [lerp(p7, p4, 0.5), [undef]] : let (mp10 = lerp(p7, p4, s74))[mp10, un(v3(evalnorm(mp10, scene)))], 
p73 = ( s73 == undef) ? [lerp(p7, p3, 0.5), [undef]] : let (mp11 = lerp( p7, p3, s73))[mp11, un(v3(evalnorm(mp11, scene)))], 
p78 = (s78 == undef) ? [lerp(p7, p8, 0.5), [ undef ]] : let (mp12 = lerp(p7, p8, s78))[mp12, un(v3(evalnorm(mp12, scene)))])

[p12, p13, p14, p52, p53, p58, p64, p62, p68, p74, p73,
 p78];
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//function encode(p)=str("X", (p.x),"Y", (p.y),"Z", (p.z));// build search key from xyz
//find and connect surrounding points to faces
// new encode: hash a vertex by seeded pseudo random 
function encode(v) =
let (xseed = round(rnd(1e8, -1e8,    round(v.x * 1e6))), 
yseed = round(rnd(1e8, - 1e8, xseed +  round(v.y * 1e6))), 
zseed = round(rnd( 1e8, -1e8, yseed + round(v.z * 1e6))), 
hash =
 round (rnd(1e8, -1e8, zseed)))
hash;

function faceworker(v) =
let (index = [
 for (i = [0: len(v) - 1]) v[i][0]
], a = [
 for (i = [0: len(v) - 1])
 if (v[i][2][0] != [])[find(v[i][2]
 [0][0], index), find(v[i][2]
 [0][1], index), find(v[i][2]
 [0][2], index), find(v[i][2]
 [0][3], index)]
], b = [
 for (i = [0: len(v) - 1])
 if (v[i][2][1] != [])[find(v[i][2]
 [1][0], index), find(v[i][2]
 [1][1], index), find(v[i][2]
 [1][2], index), find(v[i][2]
 [1][3], index)]
], c = [
 for (i = [0: len(v) - 1])
 if (v[i][2][2] != [])[find(v[i][2]
 [2][0], index), find(v[i][2]
 [2][1], index), find(v[i][2]
 [2][2], index), find(v[i][2]
 [2][3], index)]
])
concat(a, b, c);
//reverse list(face)
function rev(v) = [
 for (i = [len(v) - 1: -1: 0]) v[i]
];
//like search() but works with string key used to build polyhedron 
//function find(key,list)=[for(i=[0:len(list)-1])if(key==list[i][0])i][0];
// new find(): dont relies on strings anymore so it can use faster search. 
function find(key, list) = search(key, list, num_returns_per_match =
 1)[0];
// return vec4 of normal and distance at point q
//////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// marching cubes manifold
module unglymarch(scene, cell, c = 5) {
 O = cell[0];
 S = cell[1];
 C = (O + S) / 2;
 D = S - O;
 maxD = len3(D.x, D.y, D.z);
 eC = eval(C, scene);
 p1 = O;
 p2 = ([S.x, O.y, O.z]);
 p3 = ([O.x, S.y, O.z]);
 p4 = ([O.x, O.y, S.z]);
 p5 = ([S.x, S.y, O.z]);
 p6 = ([S.x, O.y, S.z]);
 p7 = ([O.x, S.y, S.z]);
 p8 = ([S.x, S.y, S.z]);
 if (eC < maxD * 2) {
 if (eC < -maxD) {
 translate(C) cube(D, center = true);
 } else if (c > 0) {
 unglymarch(scene, bflip(p1, C), c - 1);
 unglymarch(scene, bflip(p2, C), c - 1);
 unglymarch(scene, bflip(p3, C), c - 1);
 unglymarch(scene, bflip(p4, C), c - 1);
 unglymarch(scene, bflip(p5, C), c - 1);
 unglymarch(scene, bflip(p6, C), c - 1);
 unglymarch(scene, bflip(p7, C), c - 1);
 unglymarch(scene, bflip(p8, C), c - 1);
 } else {
 // Unfinnished fullMC 
 //hull(){
 // 
 //if (eval(p1,scene)<0)translate(p1) cube(D/100,center=true);
 //if (eval(p2,scene)<0)translate(p2) cube(D/100,center=true);
 //if (eval(p3,scene)<0)translate(p3) cube(D/100,center=true);
 //if (eval(p4,scene)<0)translate(p4) cube(D/100,center=true);
 //if (eval(p5,scene)<0)translate(p5) cube(D/100,center=true);
 //if (eval(p6,scene)<0)translate(p6) cube(D/100,center=true);
 //if (eval(p7,scene)<0)translate(p7) cube(D/100,center=true);
 //if (eval(p8,scene)<0)translate(p8) cube(D/100,center=true);
 //}
 translate(C) cube(D, center = true);
 }
 } else {}
}
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
function evalnorm(q, scene) =
let (tiny = 0.00001, e = eval(q, scene))[e - eval([q.x - tiny, q.y, q
 .z
], scene), e - eval([q.x, q.y - tiny,
 q.z
], scene), e - eval([q.x, q.y, q.z - tiny], scene), e];
 
//////////////////////////////////////////////////////////////////////////////////////
 
//////////////////////////////////////////////////////////////////////////////////////
// testing primitives
//parser
function eval(p, scene) = parse(p, scene);

function parse(q, scene) =
let (opcode = scene[opc], p = scene[params])
//if code then
opcode == opX ? parseopX(q, p, scene[subTree]) : // 9 experimental
 opcode == opU ? parseopU(q, p, scene[subTree]) : // 1
 opcode == opI ? parseopI(q, p, scene[subTree]) : // 2
 opcode == opS ? parseopS(q, p, scene[subTree]) : // 3
 opcode == opT ? parseopT(q, p, scene[subTree]) : //4
 opcode == opH ? parseopH(q, p, scene[subTree]) : //5 hull behaves like union for now:
 opcode == opE ? parseopE(q, p, scene[subTree]) : //6
 opcode == opO ? parseopO(q, p, scene[subTree]) : //7
 opcode == opD ? parseopT(q, null3, scene[subTree]) : //8 deform behaves like null trnasform for now
// debugging with hardcoded cube 
opcode == f_cube ? cube(q, 7.5,0) : //10
 opcode == f_sphere ? chamfered_filleted_block_eval(q, p[0],p[1],p[2]) : //10
 opcode == f_torus ? torus(q, 15,5) : //10
 0;

function parseopH(q, p, scene) =
let (vp = [opU, 0, [
 for (i = [0: len(scene) - 1]) scene[i]
]], e = eval(q, vp))
Hulltrace(q, q, vp);

function parseopE(q, p, scene) = min([
 for (i = [0: len(scene) - 1]) max(eval([q.x, q.y, 0], scene[i]),
 max(0, abs(q.z)) - p)
]);

function parseopX(q, p, scene) = pow(addl([
 for (i = [0: len(scene) - 1]) pow(eval(q, scene[i]), 2)
]), 1 / 2);

function parseopU(q, p, scene) = minl([
 for (i = [0: len(scene) - 1]) eval(q, scene[i])
], p);

function parseopI(q, p, scene) = maxl([
 for (i = [0: len(scene) - 1]) eval(q, scene[i])
], p);

function parseopS(q, p, scene) = maxR(-minl([
 for (i = [1: max(1, len(scene) - 1)]) eval(q, scene[i])
], p), eval(q, scene[0]), p);

function parseopO(q, p, scene) = Offs(min([
 for (i = [0: len(scene) - 1]) eval(q, scene[i])
]), p);

function parseopT(q, M, scene) =let(
qn=un(q),
Tqm=Transf(q, M),
d=( qn.x*M[2][0]+qn.y*M[2][1]+qn.z*M[2][2])
) min([
 for (i = [0: len(scene) - 1]) eval(Tqm, scene[i])*M[2].x]);

function Transf(q, M) = invtransform(q, M[0], M[1], M[2]);

function Offs(q, M) = q - M;
//function Clampz(q,p)=[q[x],q[y],0];
function Hulltrace(q, qp, vp, c = 8) =
let (nm = evalnorm(qp, vp), n = [nm[0],
 nm[1], nm[2]
], m = nm[3])
c > 0 ? Hulltrace(q, qp + (n * max(1, abs(m))), vp, c - 1) :
 //eval(q+un(q)*far,vp)-len3(q-(un(qp-q)*far))
 len3(qp - q) - m;

function cR3(p, params) =
let (r = params[0])
torus(p, r, r / 4);
// end parser
//function cR3(q,r)=max(
//maxCH(abs(q.x)-3,abs(q.y)-3,1) ,
//maxCH(abs(q.x)-3,abs(q.z)-3,1) ,
//maxCH(abs(q.y)-3,abs(q.z)-3,1) )
// 
//; 
function ChamferBox(op, b = [1, 1, 1] /*[l,w,h]*/ , ch = 2 /*Chamfer*/ ,
 r = 1 /*radius*/ ) =
// radius and chanfer work independently but not as inteded when combined
let (p = max3(abs3(op) - ((b - [ch, ch,
 ch
 ]) - [r, r, r]), 0.0), plane_normal = un([1, 1, 1]), // other directions may be useful
 ray_origin = [0, 0, 0], ray_direction = un(p), plane_origin = [ch,
 0, 0
 ], distance = (dot(plane_normal, (plane_origin - ray_origin))) /
 dot(plane_normal, ray_direction), location = ray_origin + (
 ray_direction * distance))
min(0, max(p.x, p.y, p.z)) + // tried to get them internal distances correct
 max(0, len3(max3(p - location, 0)) - r);










function chamfered_filleted_block_eval(p, size, ch, r) =
let (M = [
 [1, 0, 0],
 [0, 1, 0],
 [0, 0, 1], // box bounds
 [1, 1, 0] / sqrt(2), [0, 1, 1] / sqrt(2), [1, 0, 1] / sqrt(2), // edge chamfer bounds
 [1, 1, 1] / sqrt(3)
 ], // vertex chamfer bounds, 
 cr = (ch - sqrt(2) * r / tan(67.5)) / sqrt(2), d = _abs(p) - size /
 2 + [r,
 r, r
 ]) 

  (  // offset
   max(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3) ]) // distance inside scene

 +( norm(clampMin(M * d + [0, 0, 0, cr, cr, cr, cr * sqrt(3) ], 0))*0.1 -r)
); // distance outside scene









function clampMin(v, lim) = [
 for (vi = v) max(vi, lim)
];

function _abs(v) = [
 for (vi = v) abs(vi)
];
function plane(p, plane) =
let (q = p - plane[1]) dot(q, plane[0]);

function cube(p, b = 1, r = 0) =
let (d = abs3(p) - [b - r, b - r, b - r])
(min(max(d.x, d.y, d.z), 0.0) + len3(max3(d, 0.0)) - r);

function sphere(p, b = 1) = len3(p) - b;

function supersphere(p, r = 15, d = 2, c = 0) =
let (n = un(p)) len3(p) - r + (sin(atan2(n.y, n.x) * 8) * d + sin(
 atan2(atan2(n.y, n.x) / 90, n.z) * 8) * d);

function torus(p, tx = 2.9, ty = 0.61) =
let (q = [len3([p.x, p.z]) - tx, p.y]) len3(q) - ty;

function _torus_eval(pt, R, r) =
let (n = norm([pt[0], pt[1]]))
r - norm(pt - [pt[0], pt[1], 0] * R / n);

function box(p1, b = 0.71) =
let (p = p1 + [0.1, 0.6, 1.5]) len3(p) - b;

function minl(l, r, c = 0) = c < len(l) - 1 ? minR(l[c], minl(l, r, c +
 1), r) : l[c];

function maxl(l, r = 3, c = 0) = c < len(l) - 1 ? maxR(l[c], maxl(l,
 r, c + 1), r) : l[c];

function minR(d1, d2, r = 5) = r > 0 ?
 let (m = min(d1, d2))(abs(d1) < abs(r) && abs(d2) < abs(r)) || (d1 <
 r && d2 < r) ? min(m, r - len3([r - d1, r - d2])) : m : let (m =
 min(d1, d2), rr = -r)(d1 < rr && d2 < rr) ? min(m, len3([d1, d2]) -
 rr) : m;

function maxR(d1, d2, r) =
let (m = max(d1, d2))(d1 > -r && d2 > -r) ? max(m, -r + len3([-r - d1, -
 r - d2
])): m;

function maxCH(d1, d2, r) =
let (m = min(-d1, -d2))(-d1 < r && -d2 < r) ? -min(m, -d1 + -d2 - r):
 -m;
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
module trender(t) {
 C0 = (un(rndc()) + [2, 0, 0]);
 C1 = (un(rndc()) + [2, 2, 0]);
 C2 = (un(rndc()) + [0, 2, 2]);
 for (i = [0: max(0, len(t[1]) - 1)]) {
 n = un(p2n(t[0][t[1][i][0]], t[0]
 [t[1][i][1]], t[0][t[1][i][
 2
 ]]));
 color(un((C0 * abs(n[0]) + C1 * abs(n[1]) + C2 * abs(n[2]) + [
 1, 1, 1
 ] * abs(n[2])) / 4)) polyhedron(t[0], [t[1][i]]);
 }
}
module trender2(t) {
 C0 = (un(rndc()) + [2, 0, 0]);
 C1 = (un(rndc()) + [2, 2, 0]);
 C2 = (un(rndc()) + [0, 2, 2]);
 for (i = [0: max(0, len(t[1]) - 1)]) {
 n = un(p2n(t[0][t[1][i][0]], t[0]
 [t[1][i][1]], t[0][t[1][i][
 2
 ]]));
 color((rndc(seed=i) + [0.5, 1, 1]) / 2) mupolyhedron(t[0], t[1][i]);
 }
}
module texport (t)
{
t0=t[1];
t2=fp_flatten([for(i=[0:len(t0)-1])let (t1=t0[i])[ [t1[0],t1[1],t1[2]],[t1[0],t1[2],t1[3]] ] ]);
echo([t[0],t2]);
}
module mupolyhedron(P, f) // polyhederon with quad edge flip optimization 
{
 p0 = P[f[0]];
 p1 = P[f[1]];
 p2 = P[f[2]];
 p3 = P[f[3]];
 m02 = lerp(p0, p2, 0.5); // midpoints - a quad has two
 m13 = lerp(p1, p3, 0.5);
 e02 = eval(m02); // disteance fiedl at mid points
 e13 = eval(m13);
 /////////////// /add convexity check here ///////// //////////////////
 if (abs(e02 - e13) < 0.001) // if almost the same flip to minimize needle triangles
 {
 if (len3(p0 - p2) < len3(p1 - p3)) // select shortes diagonal
 {
 //translate(m02)sphere(0.6,center=true); // show fliped edga
 polyhedron([p0, p1, p2], [
 [0, 1, 2]
 ]);
 polyhedron([p2, p3, p0], [
 [0, 1, 2]
 ]);
 } else {
 //translate(m13)sphere(0.6,center=true);// show fliped edga
 polyhedron([p1, p2, p3], [
 [0, 1, 2]
 ]);
 polyhedron([p3, p0, p1], [
 [0, 1, 2]
 ]);
 }
 } else if (abs(e02) < abs(e13)) // edge flipping - per quad for closeet feature 
 {
 // translate(m02)cube(0.6,center=true);// show fliped edga
 polyhedron([p0, p1, p2], [
 [0, 1, 2]
 ]);
 polyhedron([p2, p3, p0], [
 [0, 1, 2]
 ]);
 } else {
 // translate(m13)cube(0.6,center=true);// show fliped edga
 polyhedron([p1, p2, p3], [
 [0, 1, 2]
 ]);
 polyhedron([p3, p0, p1], [
 [0, 1, 2]
 ]);
 }
}
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] *
 v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);


function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
 function fp_flatten(l) = [   for (a = l)     for (b = a) b ];



//function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
 a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);

function rndc(a = 1, b = 0,seed) = [rnd(a, b,seed),
 rnd(a, b,seed+1), rnd(a, b,seed+2)
];
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[
 c];
function len3(v) = len(v) > 1 ? sqrt(addl([
 for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;
function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
function v3(p) = [p.x, p.y, p.z]; // vec3 formatter
function abs3(v) = [abs(v[0]), abs(v[1]),
 abs(v[2])
];

function max3(a, b) = [max(a[0], b),
 max(a[1], b), max(a[2], b)
];

function mima3(a, b, c) = [min(max(a[0], b[0]), c[0]),
 min(max(a[1], b[1]), c[1]), min(max(a[2], b[2]), c[2])
];

function invtransform(q, T = [0, 0, 0], R = [30, 30, 30], S = [1, 1,
 1
]) =
let (p = q)
Vdiv(t([p.x, p.y, p.z, 1] * m_translate(T * -1) * m_rotate(R * -1)),
 S);

function Vdiv(v1, v2) = [v1[0] / v2[0],
 v1[1] / v2[1], v1[2] / v2[2]
];

function t(v) = [v.x, v.y, v.z];

function m_rotate(v) = [
 [1, 0, 0, 0],
 [0, cos(v.x), sin(v.x), 0],
 [0, -sin(v.x), cos(v.x), 0],
 [0, 0, 0, 1]
] * [
 [cos(v.y), 0, -sin(v.y), 0],
 [0, 1, 0, 0],
 [sin(v.y), 0, cos(v.y), 0],
 [0, 0, 0, 1]
] * [
 [cos(v.z), sin(v.z), 0, 0],
 [-sin(v.z), cos(v.z), 0, 0],
 [0, 0, 1, 0],
 [0, 0, 0, 1]
];

function m_translate(v) = [
 [1, 0, 0, 0],
 [0, 1, 0, 0],
 [0, 0, 1, 0],
 [v.x, v.y, v.z, 1]
];

function m_scale(v) = [
 [v.x, 0, 0, 0],
 [0, v.y, 0, 0],
 [0, 0, v.z, 0],
 [0, 0, 0, 1]
];
module showcell(cell) {
 d = cell[0] - cell[1];
 s = max(abs(d.x), (d.y), (d.z)) / 30;#
 translate([cell[0][0], cell[0][1],
 cell[0][2]
 ]) cube(s);#
 translate([cell[1][0], cell[0][1],
 cell[0][2]
 ]) cube(s);#
 translate([cell[1][0], cell[1][1],
 cell[0][2]
 ]) cube(s);#
 translate([cell[0][0], cell[1][1],
 cell[0][2]
 ]) cube(s);#
 translate([cell[0][0], cell[0][1],
 cell[1][2]
 ]) cube(s);#
 translate([cell[1][0], cell[0][1],
 cell[1][2]
 ]) cube(s);#
 translate([cell[1][0], cell[1][1],
 cell[1][2]
 ]) cube(s);#
 translate([cell[0][0], cell[1][1],
 cell[1][2]
 ]) cube(s);
}

function autobound(scene, cubic = (false), pad = 1) =
let (up = findbound([0, 0, 1], scene), down = -findbound([0, 0, -1],
 scene), north = findbound([0, 1, 0], scene), south = -findbound([
 0, -1, 0
], scene), west = findbound([1, 0, 0], scene), east = -findbound([-
 1, 0, 0
], scene), esd = min(east, south, down), wnu = max(west, north, up))
cubic == true ?
 let (d = [wnu, wnu, wnu] - [esd, esd,
 esd
 ])[[esd, esd, esd] - (d * pad), [wnu,
 wnu, wnu
 ] + d * pad] : let (d = [west, north,
 up
 ] - [east, south, down])[[east, south,
 down
 ] - d * pad, [west, north, up] + d * pad];

function autohull(scene) =
let (far = 1000, p1 = un([1, 1, 1]) * far, p2 = un([-1, -1, 1]) * far,
 p3 = un([1, -1, -1]) * far, p4 = un([-1, 1, -1]) * far, n = concat(
 autohullworker(p1, p2, p3, scene, far), autohullworker(p1, p2, p4,
 scene, far), autohullworker(p2, p3, p4, scene, far),
 autohullworker(p1, p4, p3, scene, far)))[
 for (i = [1: len(n) - 1]) let (v = findbound(n[i], scene))[n[i], v *
 n[i], v]];

function autohullworker(p1, p2, p3, scene, far, c = 4) =
let (e1 = un(t(evalnorm(p1, scene))), e2 = un(t(evalnorm(p2, scene))),
 e3 = un(t(evalnorm(p3, scene))), p12 = un(
 (p1 + p2) / 2) * far, p23 = un((p2 + p3) / 2) * far, p31 = un((p3 +
 p1) / 2) * far, C = un(avrg([e1, e2, e3])), meancurve = (dot(e1,
 e2) + dot(e3, e2) + dot(e1, e3)))
meancurve > 2.1 || c <= 0 ? [C] : concat(autohullworker(p1, p12, p31,
 scene, far, c - 1), autohullworker(p2, p23, p12, scene, far, c -
 1), autohullworker(p3, p23, p31, scene, far, c - 1),
 autohullworker(p12, p23, p31, scene, far, c - 1));

function findbound(vec, scene) =
let (VeryFar = 1e6 ,
 p1 = vec * VeryFar, 
p2 = p1 + un(vec  ),
e1 = abs(eval(p1, scene)),
 e2 = abs(eval(p2, scene)), 
scale = abs(e2 - e1) , 
corrected = (e1 / scale), 
distance = VeryFar - e1/scale //distance= VeryFar-corrected
)
//[p1,p2,e1,e2,scale,corrected,distance ]
distance ;
module showfield(scene, cell, s = 2) {
 S = len3(cell[1] - cell[0]);
 for (iy = [cell[0][1]: s: cell[1][1]]) {
 for (ix = [cell[0][0]: s: cell[1]
 [0]
 ]) {
 //en=evalnorm([ix ,iy,0],scene);
 e = eval([ix, iy, 0], scene);
 r = min(0, sign(-e)) * sin(e * 40);
 g = 1 / max(1, abs(e));
 b = sin(e * 40) * min(1, -min(0, e));
 color([abs(r), abs(g), abs(b)])
 //color( [abs(en.x),abs(en.y),abs(en.z)] ) 
 translate([ix, iy, -1]) square(s, center = true);
 }
 }
}