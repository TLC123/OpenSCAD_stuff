function dot2(v) = dot(v, v);

function dot(v, w) = v * w;

function ndot(v, w) = v.x * w.x - v.y * w.y;

function shapeedge(p, a, b, r = 0) =
let (pa = p - a, ba = b - a, h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0), side = -1. * ((p.x - a.x) * (b.y - a.y) - (p.y - a.y) * (b.x - a.x)))
// skipp sqrt for now
[dot2(pa - ba * h) - r, sign(side)];

function sdDistLogic(a, b) = abs(b[0] - a[0]) < // if distances are
    0.00001 // closer than some fugde factor
    * max(max(b[0], a[0]), .1)    // that gets a little larger further out but never below 1
 ? (b[1] <= 0. && a[1] <= 0.) ? (b[1] < a[1] ? b : a) : (b[1] > a[1] ? b : a) :  //most + win 
 b[0] <= a[0] ? b : a; // or the common case;

function sdListDistLogic(l,best=[],count=[])=
    best==[]?sdListDistLogic(l,[10e64,0],len(l-1)):
    count>0?sdListDistLogic(l,sdDistLogic(best,l[count]),count-1):
    best;
    
function sdShape(p, shape) =
let (alledges = [
    for (i = [0: len(shape) - 1]) shapeedge(p, shape[i], shape[(i + 1) % (len(shape))], 0)
], v = sdListDistLogic(alledges)) sqrt(v[0]) * sign(v[1]);