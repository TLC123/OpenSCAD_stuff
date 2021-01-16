function autohull(model) =
/*
 In this new autohull we dont genrate random planes
 We start with the corner points of each face of a Tetrahedron
 continue and subdivide each side to finer spherical Geodesic polyhedron
 in a worker function 
 until the DISTANCE FIELD NORMAL at each corner converge 
 as a sum of their internal dot products.

Note that its not the facenormal of the sub facet but the normal of the field at the resulting guiding lattice. 

 We return the normalized averaged field vector and apply findbound as before 
 This process reduces the number of resulting planes un the right places
*/
let (
far = 100,                      // too far out field lines anrent too usefull
p1 = un([ 1,  1,  1]) * far,    // tet cornes
p2 = un([-1, -1,  1]) * far, 
p3 = un([ 1, -1, -1]) * far, 
p4 = un([-1,  1, -1]) * far, 
n = concat(                     // start recursive worker
autohullworker(p1, p2, p3, model, far), 
autohullworker(p1, p2, p4, model, far), 
autohullworker(p2, p3, p4, model, far), 
autohullworker(p1, p4, p3, model, far)))
                                // process reulting list of unit vectors to alist of bounding planes
[  for (i = [1: len(n) - 1]) let (v = findbound(n[i], model))[n[i], v * n[i], v]]
;




function autohullworker(p1, p2, p3, model, far, c = 4) =
// recursive worker of autohull()
let (
e1 = un(t(evalnorm(p1, model))), 
e2 = un(t(evalnorm(p2, model))), 
e3 = un(t(evalnorm(p3, model))), 
p12 = un((p1 + p2) / 2) * far, 
p23 = un((p2 + p3) / 2) * far, 
p31 = un((p3 + p1) / 2) * far, 
C = un(avrg([e1, e2, e3])), 
meancurve = (dot(e1, e2) + dot(e3, e2) + dot(e1, e3))   //dot product of 2 unit normals range from -1 to 1 so a summed meancurve = 3 indicates all normals are parallel
)
meancurve > 2 || c <= 0 ?
 [C] 
:
 concat(
autohullworker(p1, p12, p31, model, far, c - 1), 
autohullworker(p2, p23, p12, model, far, c - 1), 
autohullworker(p3, p23, p31, model, far, c - 1), 
autohullworker(p12, p23, p31, model, far, c - 1))
;



function findbound(vec, model) =
// same as before
let (VeryFar = 9999999999999, 
p1 = vec * VeryFar, 
p2 = p1 + vec, 
e1 = abs(eval(p1, model)), 
e2 = abs(eval(p2, model)), 
scale = abs(e2 - e1), 
corrected = (e1 / scale), 
distance = VeryFar - e1 //distance= VeryFar-corrected
)
 distance;


///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// A few of my work-horse function, nothing spectacular,
// but  as a non programmer i tent do name thing a bit odd

function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]]); // triangle to face normal(unit)
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c]; //adds up the items in a list
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l; // average the items in a list
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2]; //dot product or scalar product
function len3(v) = len(v) > 1 ? sqrt(addl([  for (i = [0: len(v) - 1]) pow(v[i], 2)])) : len(v) == 1 ? v[0] : v; //  2,3...n-dimensional distance function
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]); // rocksolid RND can be seeded or not
function rndc(a = 1, b = 0) = [rnd(a, b), rnd(a, b), rnd(a, b)]; // random triplet
function abs3(v) = [abs(v[0]), abs(v[1]), abs(v[2])];
function max3(a, b) = [max(a[0], b), max(a[1], b), max(a[2], b)];
function t(v) = [v.x, v.y, v.z]; // Isloate first triplet from list 
function v3(p) = [p.x, p.y, p.z]; // vec3 formatter
