//range=[-20:1/2:20];for(x=range,y=range,z=range){if(antbody([x,y,z])<0)translate([x,y,z])cube(1/2,true);} 
function antbody(p) =
let (

//body defines as basically a string of sticks and spheres. little more to it ofc
body = [
[-5, 0, 0, 1],
[-4, 0, 1, 2],
[-2, 0, 2, 3],
[0, 0, 2, 3],
[3, 0, 2, 1],
[4, 0, 1, 1],
[7, 0, 4, 3],
[9, 0, 5, 3],
[12, 0, 4, 1],
[14, 0.5, 4, 3],
[15, 2, 2, 1],
[16, 0.7, -0.5, 0.5]
],

oddbod =
min(conecapsule(p, body[1], body[2], 2.0, 0.125),
min(conecapsule(p, body[3], body[4], 2.0, 0.125),
min(conecapsule(p, body[5], body[6], 2.0, 0.125),
min(conecapsule(p, body[9], body[10], 2.0, 0.125),
conecapsule(p, body[7], body[8], 2.0, 0.25)
)))),
evebod =
min(conecapsule(p, body[0], body[1], 2.0, 0.125),
min(conecapsule(p, body[2], body[3], 2.0, 0.125),
min(conecapsule(p, body[4], body[5], 2.0, 0.125),
min(conecapsule(p, body[6], body[7], 2.0, 0.125),
min(conecapsule(p, body[8], body[9], 2.0, 0.125),
conecapsule(p, body[10], body[11], 2.0, 0.125)   )))))
) synmin(oddbod, evebod, 0.60);


function antenna(p) =
let (
ant1 = [
[14.4062, 0.35, 5.21244, 0.525],
[16.4468, 1.52811, 7.89352, 0.49],
[18.9311, 2.96244, 8.66218, 0.525],
[20.728, 3.99987, 6.65596, 0.525],
[21.4749, 4.43109, 5.34974, 0.52]
],
oddant1 =
min(conecapsule(p, ant1[1], ant1[2], 1.0, 0.06),
(conecapsule(p, ant1[3], ant1[4], 1.0, 0.06))),
eveant1 =
min(conecapsule(p, ant1[0], ant1[1], 1.0, 0.06),
(conecapsule(p, ant1[2], ant1[3], 1.0, 0.06)))
) synmin(oddant1, eveant1, 0.30);


function antleg1(p) =
let (
leg1 = [
[5.5, 0.0, 2.5, 0.5],
[7.03209, 1.28558, 0.5, 0.75],
[11.8623, 6.49951, 2.0, 1.0],
[11.8623, 4.49951, -3.5, 0.75],
[13.944, 5.78509, -5.75, 0.65],
[15, 6.42788, -6, 0.5]
],
oddleg1 =
min(conecapsule(p, leg1[1], leg1[2], 3.0, 0.135),
(conecapsule(p, leg1[3], leg1[4], 3.0, 0.135))),
eveleg1 =
min(conecapsule(p, leg1[0], leg1[1], 3.0, 0.135),
min(conecapsule(p, leg1[2], leg1[3], 3.0, 0.135),
(conecapsule(p, leg1[4], leg1[5], 3.0, 0.135))))
) synmin(oddleg1, eveleg1, 0.50);


function antleg2(p) =
let (
leg1 = [
[4.75, 0, 1.75, 0.5],
[4.75, 2.31691, 0.127681, 0.75],
[4.75, 6.89365, 2.96554, 1],
[4.75, 7.93554, -2.94331, 0.75],
[4.75, 10.4261, -5.55044, 0.75],
[4.75, 11.4977, -5.86919, 0.5]
],
oddleg1 =
min(conecapsule(p, leg1[1], leg1[2], 3.0, 0.135),
(conecapsule(p, leg1[3], leg1[4], 3.0, 0.135))),
eveleg1 =
min(conecapsule(p, leg1[0], leg1[1], 3.0, 0.135),
min(conecapsule(p, leg1[2], leg1[3], 3.0, 0.135),
(conecapsule(p, leg1[4], leg1[5], 3.0, 0.135))))
) synmin(oddleg1, eveleg1, 0.50);

function antleg3(p) =
let (
leg1 = [
[3.5, 0.2, 0.25, 0.5],
[1.72499, 3.691, -0.26813, 0.75],
[-3.8651, 6.7605, 2.8302, 1],
[-4.66323, 6.43022, -3.07865, 0.75],
[-7.02376, 8.41093, -5.58159, 0.75],
[-8.071, 9.28967, -5.84825, 0.5]
],
oddleg1 =
min(conecapsule(p, leg1[1], leg1[2], 3.0, 0.135),
(conecapsule(p, leg1[3], leg1[4], 3.0, 0.135))),
eveleg1 =
min(conecapsule(p, leg1[0], leg1[1], 3.0, 0.135),
min(conecapsule(p, leg1[2], leg1[3], 3.0, 0.135),
(conecapsule(p, leg1[4], leg1[5], 3.0, 0.135))))) synmin(oddleg1, eveleg1, 0.50);

function legasm(p) =min(antenna(p),min(antleg1(p),min(antleg2(p),antleg3(p))));
function sdfAnt(p) =let ( p = [p.x, abs(p.y), p.z]) synmin(antbody(p), legasm(p), 0.60);

function conecapsule(p, p1, p2, w, z) =
let ( a = v3( lerp(p1, p2, 0.1)), b = v3(lerp(p1, p2, 0.9)), d1 = p1[3], d2 = p2[3] * 0.9, ba = b - a, pa = p - a, v = dot(pa, ba) / dot(ba, ba), h = clamp(v, 0.0, 1.0), d = lerp(d1, d2, smoothStep ( h)), r = d ) norm(pa - ba * h) - r;
function synmin(a, b, r) = 
//
//let (r=0, e = max(r * 0.02, (abs(a - b) / r))) min(a, b) - max(0.01, (r * e * 0.75 * (exp(1.0 - (e * 2.5)))) / max(a, b) * 0.5)
    // drop-in function for smin  
//    let(
//	   height= .75,
//       width=.05,
//       valleytreshold=0.99,
//           e =   max(valleytreshold,(abs(a-b)/r) ))
//       
//    min (a,b)- max(width,   (r*height*e*(exp(1.0-(e*.25  ))))  )
   min( a, b) 
;

function smin( a, b, k )= let(  h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 ) ) lerp( b, a, h ) - k*h*(1.0-h);
function clamp(a, b=0, c=1) = min(max(a, min(b, c)), max(b, c));
function smoothStep (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
function v3(p) = [p.x, p.y, p.z] + [0,0,0]; // vec3 formatter
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1, v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2]; 
 