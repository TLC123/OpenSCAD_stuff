include<DCmath.scad>
 
function evalnorm(q, scene) =
let (tiny = 0.000001, 
e = eval(q, scene))
[
eval([q.x + tiny, q.y, q.z], scene) - eval([q.x - tiny, q.y, q.z], scene),
eval([q.x, q.y + tiny, q.z], scene) - eval([q.x, q.y - tiny, q.z], scene), 
eval([q.x, q.y, q.z + tiny], scene) - eval([q.x, q.y, q.z - tiny], scene),
e];




 
//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
// testing primitives
//parser
function eval(p, scene ) =
//$evalcache!=undef? let(hit=octsearch(p,$scenecell,$evalcache)  
////,echo(str(p,"hit:",hit ))
//) 
//hit :

 
scene(p);


//function eval(p, scene) =
//parse(p, scene);


//
//function parse(q, scene) =
//let (opcode = scene[opc], p = scene[params])
////if code then
//opcode == opX ? parseopX(q, p, scene[subTree]) : // 9 experimental
// opcode == opU ? parseopU(q, p, scene[subTree]) : // 1
// opcode == opI ? parseopI(q, p, scene[subTree]) : // 2
// opcode == opS ? parseopS(q, p, scene[subTree]) : // 3
// opcode == opT ? parseopT(q, p, scene[subTree]) : //4
// opcode == opH ? parseopH(q, p, scene[subTree]) : //5 hull behaves like union for now:
// opcode == opE ? parseopE(q, p, scene[subTree]) : //6
// opcode == opO ? parseopO(q, p, scene[subTree]) : //7
// opcode == opD ? parseopT(q, null3, scene[subTree]) : //8 deform behaves like null trnasform for now
//// debugging with hardcoded cube 
//opcode == f_cube ? f_cube(q, p) : //10
// opcode == f_sphere ? f_sphere(q,p): //chamfered_filleted_block_eval(q, p[0],p[1],p[2]) : //10
// opcode == f_cylinder ? f_cylinder(q,p): 
// opcode == f_torus ? f_torus(q, p) : //10
// 0;
//
//function parseopH(q, p, scene) =
//let (vp = [opU, 0, [
// for (i = [0: len(scene) - 1]) scene[i]
//]], e = eval(q, vp))
//Hulltrace(q, q, vp);
//
//function parseopE(q, p, scene) = min([
// for (i = [0: len(scene) - 1]) max(eval([q.x, q.y, 0], scene[i]),
// max(0, abs(q.z)) - p)
//]);
//
//function parseopX(q, p, scene) = pow(addl([
// for (i = [0: len(scene) - 1]) pow(eval(q, scene[i]), 2)
//]), 1 / 2);
//
//function parseopU(q, p, scene) = minl([
// for (i = [0: len(scene) - 1]) eval(q, scene[i])
//], p);
//
//function parseopI(q, p, scene) = maxl([
// for (i = [0: len(scene) - 1]) eval(q, scene[i])
//], p);
//
//function parseopS(q, p, scene) = maxR(-minl([
// for (i = [1: max(1, len(scene) - 1)]) eval(q, scene[i])
//], p), eval(q, scene[0]), p);
//
//function parseopO(q, p, scene) = Offs(min([
// for (i = [0: len(scene) - 1]) eval(q, scene[i])
//]), p);
//
//function parseopT(q, M, scene) =let(
//qn=un(q),
//Tqm=Transf(q, M),
//d=( qn.x*M[2][0]+qn.y*M[2][1]+qn.z*M[2][2])
//) min([
// for (i = [0: len(scene) - 1]) eval(Tqm, scene[i])*M[2].x]);

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

function f_cR3(p, params) =
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

function f_cube(p,q) =len(q)==undef?f_cube(p,[q,0.001]) :
let (b=q[0],r=q[1],

d = abs3(p) - [b - r, b - r, b - r])
(min(max(d.x, d.y, d.z), 0.0) + len3(max3(d, 0.0)) - r);

function f_sphere(p, b = 1) = len3(p) - b;
function f_cylinder (p, b = 1) = max(abs(p.z)-b*10 ,norm([p.x,p.y]) - b);

function f_supersphere(p, r = 15, d = 2, c = 0) =
let (n = un(p)) len3(p) - r + (sin(atan2(n.y, n.x) * 8) * d + sin(
 atan2(atan2(n.y, n.x) / 90, n.z) * 8) * d);

function f_torus(p,qi) =
let ( tx = qi[0], ty = qi[1],q = [len3([p.x, p.z]) - tx, p.y]) len3(q) - ty;

function _torus_eval(pt, R, r) =
let (n = norm([pt[0], pt[1]]))
r - norm(pt - [pt[0], pt[1], 0] * R / n);

function box(p1, b = 0.71) =
let (p = p1 + [0.1, 0.6, 1.5]) len3(p) - b;

function minl(l, r=0, c = 0) = c < len(l) - 1 ? minR(l[c], minl(l, r, c +
 1), r) : l[c];

function maxl(l, r = 0, c = 0) = c < len(l) - 1 ? maxR(l[c], maxl(l,
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