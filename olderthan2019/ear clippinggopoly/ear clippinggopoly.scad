b = [
[[1,-5,4],[10,-10,1],[-1,-2,1],[4,9,1]]
,[[0, 0, 0], [-5, 1, 2], [0, 2, 0], [1, 1,0], [2, 2, 0], [2, 1, 0.5], [2, 0, 0], [1, 1, 0]]
];
 $fn = 100;
linear_extrude(1)makeplate(b);
 

//
//for(i=[0:len(a)-1])
// 
//color(rands(0,1,3))hull(){makeplateW(a[i]);}
function fp_triangulate(a, n = [0, 0, 1], count = 0) = count > len(a) ?
  let (e = echo("Ear Clip Error: Possibly Selfintersecting Polygon"))
a: len(a) == 1 ? a : len(a) == 2 ? a : len(a) == 3 ? [[a[0], a[1], a[2]]] : let (en = p2n([a[0], a[2], a[1]],n))
sign(dot(en, n)) > 0 ?
  let (b = concat([
    for (i = [2: len(a) - 1]) a[i]], [a[0]]))
concat([[a[0], a[1], a[2]]], fp_triangulate(b, n, count = 0)): fp_triangulate(shuffle(a, 1), n, count + 1);

function shuffle(b, l = 0) =
let (c = concat([
  for (i = [1: len(b) - 1]) b[i]], [b[0]]))
l > 0 ? shuffle(c, l - 1) : c;
module makeplate(P) {
if (isequalformat(P,1)){echo("case1");square(P);}
else{
if (isequalformat(P,[1])){square(P[0]);}
else{
if (isequalformat(P,[1,1])){square([P[0],P[1]]);}
else{
if (isequalformat(P,[[1,1]])){square([P[0][0],P[0][1]]);}
else{
if (isequalformat(P,[[1,1],[1,1]])){
ex=max(P[0].x,P[1].x);
ey=max(P[0].y,P[1].y);
sx=min(P[0].x,P[1].x);
ey=min(P[0].y,P[1].y);
 translate([sx,sy])square([ex-sx,ey-sy]);}
else{
makeplate(P);
}}}}}

}
module makeplateW(P ) {
  for (i = [0: len(P) - 1]) {
    if (len(P[i][0]) == undef) {
      setcircle(P[i]);
    } else {
      if(len(P[i]<4))hull()
       {makeplateW(P[i]);}
      
      else{
            a = fp_triangulate(P[i]);
            echo(a);
            for (j = [0: len(a) - 1]) hull() {
            makeplateW(a[j]);}
      }
    }
  }
}
module setcircle(P) {
  translate([P.x, P.y]) circle(ensure(P[2]),$fn=ensure(P[2])*20 );
}

function ensure(i) = max(0.001, i == undef ? 0 : i);

function dot(a, b) = a * b;

function p2n(p,n) =
let (pa = p[0], pb = p[1], pc = p[2], u = pa - pb, v = pa - pc) pa==0||pb==0?n:un([u[1] * v[2] - u[2] * v[1], u[2] *
 v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);

function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c];

function len3(v) = len(v) > 1 ? sqrt(addl([
 for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;
function isequalformat(a, b, level = " ") =
//let (er = echo(str(level, a, " = ", b, "->", a == b, " ", (a != undef && b != undef) ? len(a) == len(b) : false)))
len(a) == undef ? (a != undef && b != undef) ? len(a) == len(b) : false : let (c = [
  for (i = [0: emax(len(b) - 1, len(a) - 1)]) isequalformat(a[i], b[i], str(level, " "))]) alltrue(c);

function alltrue(a) =
let (b = [
  for (i = a) true]) a == b;

function emax(a, b) = max(a == undef ? 0 : a, b == undef ? 0 : b);