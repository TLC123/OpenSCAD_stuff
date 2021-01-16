$fn = 10;
t = 0.3;
v = [  for (t = [0: 50]) concat(rndc() * 100 )];
spl = v2spl(v, t);
//ShowControl(v);
spline(spl  ) ;
//ShowSplControl(spl,t);
 

 



















//for(i=[0:len(v)-1]){echo(v2spl(v)[i]);color(rndc()){ShowControl(v2spl(v)[i]);extrudeT(v2spl(v)[i]);}}
module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
  if (len(v[0][0]) != undef) {
      ShowSplControl(v);
      } else
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate(t(v[i])) sphere(1);
        translate(t(v[i - 1])) sphere(1);
      }
    }
}
module ShowSplControl(v) { // translate(t(v[0])) sphere(v[0][3]);
    for (i = [0: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate(t(v[i][0])) sphere(1);
        translate(t(v[i][1])) sphere(1);
      }
      hull() {
        translate(t(v[i][2])) sphere(1);
        translate(t(v[i][3])) sphere(1);
      }
    }
}
module spline(v, d = 8, start = 0, stop = 1, twist = 0, gap = 1) {
 
L=len3spl(v);
echo(L);
    detail = 2;
     det=1/(L*0.5);
    for (ii = [start + det: det: stop]) {
       i=L*ii;
      if ($children > 0) {
        for (j = [0: $children - 1]) hull() {
          translate(t(spl2(i, v)))
           rotate(spl2euler(i, v))
          scale(spl2(i, v)[3]) rotate([twist * ii, 0, 0])  rotate([0, -90, 0])children(j);
          translate(t(spl2(i - detail * gap, v)))
          rotate(spl2euler(i - detail, v))
          scale(spl2(i - detail * gap, v)[3]) rotate([twist * (ii - det), 0, 0])  rotate([0, -90, 0])children(j);
        }
      } 

else {
        hull() {
          translate(t(spl2(i, v))) 
 //rotate(spl2euler(i, v)) 
//scale(spl2(i, v)[3])
 rotate([twist * ii, 0, 0])
 rotate([0, -90, 0]) sphere(1);
          translate(t(spl2(i - detail * gap, v))) 
//rotate(spl2euler(i - detail * gap, v)) 
//scale(spl2(i - detail * gap, v)[3]) 
rotate([twist * (ii - det), 0, 0]) rotate([0, -90, 0]) sphere(1);
        }
      }
    }
  }


function spl2(stop,v, p = 0) =
let(L=len3bz(v[p])) 
p + 1 > len(v) - 1 || stop < L ? 
bez2(stop / L,v[p]) 
:
 spl2( stop - L, v,p + 1);



function t(v) = [v[0], v[1], v[2]];

function v2spl(v, t = 0.3) =
let (L = len(v) - 1)[
  for (i = [0: L - 1]) let (prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2))
  let (M = len3(v[next] - v[i]), N0 = un(v[i] - v[prev]), N1 = un(v[next] - v[i]), N2 = un(v[nnext] - v[next]), N01 = un(N0 + N1) * M * t, N12 = un(N1 + N2) * M * t)[v[i], v[i] + N01, v[next] - N12, v[next]]];
function v2round(v, t = 0.01) =
let (L = len(v) - 1)[
  for (i = [0: L - 1])
 let (prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2))
[  lerp(v[i],  v[next],t),lerp(v[i],  v[next],1-t)]];

function un(v) = v / max(len3(v), 0.000001) * 1;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));


function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)
]): v[0] * (1 - t) + v[1] * (t);

function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i

function spl2euler(i, v) = [0, -asin(spl2v(i, v)[2]), atan2(spl2xy(spl2v(i, v))[1], spl2xy(spl2v(i, v))[0])];

function spl2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function spl2v(i, v) = lim31(1, spl2(i - 0.0001, v) - spl2(i, v)); // unit vector at i
function lim31(l, v) = v / len3(v) * l;

function len3bz(v, precision = 0.1, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function len3v(v, acc = 0, p = 0) = p + 1 > len(v) - 1 ? acc : len3v(v, acc + len3(v[p] - v[p + 1]), p + 1);

function len3spl(v, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, acc + len3bz(v[p]), p + 1);

function v2t(v, stop, p = 0) = p + 1 > len(v) - 1 || stop < len3(v[p] - v[p + 1]) ? v[p] + un(v[p + 1] - v[p]) * stop : v2t(v, stop - len3(v[p] - v[p + 1]), p + 1);

function bz2t(v, stop, precision = 0.01, t = 0, acc = 0) = acc >= stop || t > 1 ? t : bz2t(v, stop, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));




function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];

function bzplot(v, res) = [
  for (i = [0: 1 / res: 1.001]) bez2(i, v)
];

function SC3(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function clamp(a, b = 0, c = 10) = min(max(a, b), c);
function flatten(list) = [ for (i = list, v = i) v ];
function gauss(i, n = 0) = n > 0 ?
  let (x = gauss(i, n - 1)) x + (x - SC3(x)) : let (x = i) x + (x - SC3(x));