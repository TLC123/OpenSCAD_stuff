include<DCbb.scad>
include<DCgeometry.scad>
include<DCparser_eval.scad>
include<DCmesh_build.scad>
include<DCmesh_form.scad>
include <polytools.scad>
include<DCmath.scad>

//scenegraph descriptor
scenegraph = [opT, [ [0,0, 0], [0, 0, 0], [1, 1, 1] ],
 [  
       
               [f_sphere, 1] 
    
 


 
 ]
 ]
;


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
 //cell = autobound(scenegraph, cubic = false, pad = 0.125);
 
cell = [[-10,-10,-10],[10,10,10]];
 
*translate([100, 0, 0]) color("Red") showcell(cell);
*translate([100, 0, 0]) unglymarch(scenegraph, cell, c = 6);

*color("Red") showcell(cell);
 showfield(scenegraph, cell*2, len3(cell[1] -
 cell[0]) / 100);
 
translate([-0, 0, 0]) color("Red") showcell(cell);
 
translate([ 0, 0, 0]) DualC(scenegraph, cell , depth =2);
 echo(parse([1, 2, 0], scenegraph));
echo(sphere([1, 2, 0],1));
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
   color([abs(r), abs(g), abs(b)])

 translate([ix, iy, -1]) square(s, center = true);
 }
 }
}