points = [
    for ([0: 5])[rnd(-11, 11), rnd(-11, 11)]
];
faces = [
    [
        [10, 10],
        [10, -10],
        [-10, -10]
    ],
    [
        [10, 10],
        [-10, -10],
        [-10, 10]
    ],
];
res = subInsert(points, faces);
for (i = res) polyhedron(i, [    [0, 1, 2]]);
    for (i = points) translate(i) sphere(.4);


function subInsert(points, polys, b = 0, p = 0) =
let (
e=echo(str("point:",b," face:",p ," ",len(points)-1," ",len(polys)-1)),
pone = points[b], 
face = polys[p], 
hit = doesIntersect(face, pone), 
ec=echo(hit),
noChange = !hit, 
npolys = hit ? spiltFace(polys, p, pone) : polys)
  hit ? subInsert(points, npolys, b, p=0) :
p < len(polys)-1 ? subInsert(points, npolys, b, p + 1) :
  

b < len(points) -1 ? subInsert(points, npolys, b + 1, p=0) :

npolys;

function doesIntersect(poly, point) = 
   // !is_list(poly) ? false : len(poly) != 3 ? false :
    let (
    insideAB = 0 >  (point2line(point, poly[0], poly[1])), 
    insideBC = 0 >  (point2line(point, poly[1], poly[2])), 
    insideCA = 0 >   (point2line(point, poly[2], poly[0]))
        ,e=echo(poly,point,insideAB ,insideBC,insideCA)
)
insideAB && insideBC && insideCA;


function spiltFace(p, s, insert) =
let (
 poly = [    for (i = [0: len(p) - 1])        if (i != s) p[i]], 
 oldFaces = p[s],  
 newFaces = [
    [insert, oldFaces[0],     oldFaces   [1]    ],
    [insert, oldFaces[1],       oldFaces [2]    ],
    [insert, oldFaces[2],       oldFaces [0]    ]
],
 e=echo(str("create new: ",newFaces)))
concat(poly, newFaces);

function addTo(p, a) = [
    for (i = p) i + a
];

function clamp(v, a, b) = min(max(min(a, b), v), max(a, b));



function point2line(c, a, b) = ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x));
module polyline(p) {
    for (i = [0: max(0, len(p) - 2)]) line(p[i], p[wrap(i + 1, len(p))]);
} // polyline plotter
module line(p1, p2, width = 0.5) { // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}

function rnd(a = 1, b = 0, s = []) =
s == [] ? (rands(min(a, b), max(a, b), 1)[0]) :
(rands(min(a, b), max(a, b), 1, s)[0]);

function rndc(a = 1, b = 0) = [rnd(a, b), rnd(a, b), rnd(a, b)];

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function dot(a, b) = a * b;

//function heron(a, b, c) =
//let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));
//
//function polyarea(p1, p2, p3) = heron(norm(p1 - p2), norm(p2 - p3), len3(p2 - p1));
//
//function un(v) = is_list(v) ? v / max(is_undef(norm(v)) ? 0 : norm(v), 1e-16) : v;
////function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
//function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;
//
//function addlp(v, i = 0, r = [0, 0, 0]) = i < len(v) ? addlp(v, i + 1, r + v[i]) : r;
//
//function faceNormal(v) = len(v) > 3 ? un(faceNormal([v[0], v[1], v[2]]) + faceNormal(concat([v[0]], [
//    for (i = [2: len(v) - 1]) v[i]
//]))) : let (u = v[0] - v[1], w = v[0] - v[2])
//un([u[1] * w[2] - u[2] * w[1], u[2] * w[0] - u[0] * w[2], u[0] * w[1] - u[1] * w[0]]);
//
//function p2n(pa, pb, pc) =
//let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]]);
//
//function v3(p) = [p.x, p.y, p.z]; // vec3 formatter