//////////////////////////////////////////////////////////////////////////////////////
// arrange bundary box from sloppy to proper orientation of minor corner and major corner
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];
 
function autobound(scene, cubic = (false), pad = 1) =
let (
up = findbound([0, 0, 1], scene), 
down = -findbound([0, 0, -1], scene), 
north = findbound([0, 1, 0], scene), 
south = -findbound([ 0, -1, 0], scene), 
west = findbound([1, 0, 0], scene), 
east = -findbound([- 1, 0, 0], scene), 
esd = min(east, south, down), wnu = max(west, north, up)

)

cubic == true ?
 let (
scenecenter=[(east+west)/2,(south+north)/2,(up+down)/2],
scenemax=max(abs(east-west),abs(south-north),abs(up+down))/2,
d = [scenemax,scenemax, scenemax]

)

[scenecenter - (d * (1+pad)), scenecenter + d * (1+pad)] :

 let (d = [west, north,
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