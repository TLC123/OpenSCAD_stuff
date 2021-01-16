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