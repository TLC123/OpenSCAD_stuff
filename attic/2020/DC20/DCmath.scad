
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
function rndcus(a = 1, b = 0) = [rnd(a, b),
 rnd(a, b), rnd(a, b)
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
function clamp(a, b=0, c=1) =  min(max(a, min(b, c)), max(b, c));

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


function tril(p,c)=let(
//[bias_x,bias_y,bias_z]
//[V000,V100,V010,V001,V101,V011,V110,V111]
bias_x=p.x,
bias_y=p.y,
bias_z=p.z,
V000=c[0],
V100=c[1],
V110=c[2],
V010=c[3],
V001=c[4],
V101=c[5],
V111=c[6],
V011=c[7]
)
lerp(
    lerp(
        lerp(V000,V001,bias_z),
        lerp(V010,V011,bias_z),
    bias_y
    ),
    lerp(
        lerp(V100,V101,bias_z),
        lerp(V110,V111,bias_z),
    bias_y
    )
    ,bias_x
);
