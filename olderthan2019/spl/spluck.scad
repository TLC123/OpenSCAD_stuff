$fn = 40;
detail=6;

 
*  %  
    scale(0.7)rotate([0,0,0])
    import(file = "duck.stl",convexity=10); 
b= [
[0, 31, 25, [3.5, 3.5, 3.5]],
 [0, 27, 12, [10, 10, 10]],
 [0, 16, 0, [18, 18, 16]],
 [0, 6, 0, [24, 20, 20]],
 [0, -10, 3, [28, 25, 22]],
 [0, -10, 16-6, [9, 9, 12]],
 [0, -10, 30-6, [8, 10, 8]],
 [0, -7, 42-6, [15, 17, 17]], 
[0, -20, 40-6, [13, 10, 6]], 
[0, -30, 42-6, [8, 6, 2]]];
*spline(b,d=detail );
ShowControl(b);
//echo([for (i=[0:len(b)-1])[b[i][0],b[i][1],b[i][2],[b[i][3],b[i][3],b[i][3]]]]);

 

module spline(v, d = 8, start = 0, stop = 1, twist = 0, gap = 1) {
   if (len(v[0][0]) == undef) {
      t = 0.2;
      spl = v2spl(v, t);
      spline(spl, d , start, stop , twist , gap );
   } else {
      L = len3spl(v);
      echo(L);
      detail = d;
      det = 1 / (L / d);
      for (ii = [start + det: det: stop]) {
         i = L * ii;
         if ($children > 0) {
            for (j = [0: $children - 1]) color(cmin(spl2(i, v)[4])) hull() {
               translate(t(spl2(i, v))) rotate(spl2euler(i, v)) scale(spl2(i, v)[3]) rotate([twist * ii, 0, 0]) rotate([0, -90, 0]) children(j);
               translate(t(spl2(i - detail * gap, v))) rotate(spl2euler(i - detail, v)) scale(spl2(i - detail * gap, v)[3]) rotate([twist * (ii - det), 0, 0]) rotate([0, -90, 0]) children(j);
            }
         } else {
            color(cmin(spl2(i, v)[4])) hull() {
               translate(t(spl2(i, v)))
 //rotate(spl2euler(i, v))
 scale(spl2(i, v)[3]) 
//rotate([twist * ii, 0, 0]) 
//rotate([0, -90, 0]) 
sphere(1);
               translate(t(spl2(i - detail * gap, v))) 
//rotate(spl2euler(i - detail * gap, v))
 scale(spl2(i - detail * gap, v)[3]) 
//rotate([twist * (ii - det), 0, 0]) 
//rotate([0, -90, 0]) 
sphere(1);
            }
         }
      }
   }




}
module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
  if (len(v[0][0]) != undef) {
      ShowSplControl(v);
      } else
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
    color(un(rndc(i-1)))  hull() {
        translate(t(v[i])) sphere(1);
        translate(t(v[i - 1])) sphere(1);
      }
    }
}
module ShowSplControl2(v) {
   for (i = [0: len(v) - 1]) {
   color(un(rndc(i))){   
hull() {
         translate(t(v[i][0])) sphere(1);
         translate(t(v[i][1])) sphere(1);
      }
      hull() {
         translate(t(v[i][1])) sphere(1);
         translate(t(v[i][2])) sphere(1);
      }
   hull() {
         translate(t(v[i][2])) sphere(1);
         translate(t(v[i][3])) sphere(1);
      }
   }}
}
module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
   if (len(v[0][0]) != undef) {
      ShowSplControl(v);
   } else
      for (i = [1: len(v) - 1]) {
         // vg  translate(t(v[i])) sphere(v[i][3]);
         blendline(
            (t(v[i])), (t(v[i - 1])), (v[i][3]), (v[i - 1][3]));
      }
}
module blendline(v1, v2, s1 = 1, s2 = 1) {
   d = 1 / 1;
   for (i = [0 + d: d: 1]) {
      hull(rndc()) {
         translate(lerp(v1, v2, i)) scale(lerp(s1, s2,  SC3(i))) sphere(1);
         translate(lerp(v1, v2, i - d)) scale(lerp(s1, s2, SC3(i - d))) sphere(1);
      }
   }
}
function spl2(stop, v, p = 0) =let (L = len3bz(v[p])) p + 1 > len(v) - 1 || stop < L ? bez2(stop / L, v[p]) : spl2(stop - L, v, p + 1);

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];

function v2spl(v, t = 0.3) =let ( L = len(v) - 1)[   for (i = [0: L - 1]) 

let (
prev = max(0, i - 1), 
next = min(L, i + 1), 
nnext = min(L, i + 2)) 
let (
M = len3(v[next] - v[i]), 
N0 = un(v[i] - v[prev]), 
N1 = un(v[next] - v[i]), 
N2 = un(v[nnext] - v[next]), 
N01 = un(N0 + N1) * M * t, 
N12 = un(N1 + N2) * M * t,
P1= v[i] + N01,
P2=v[next] - N12,
L1=lerp(v[i],v[next],t),
L2=lerp(v[i],v[next],1-t),
O1=concat([P1[0],P1[1],P1[2]],[for(ii=[3:len(L1)-1])L1[ii]]),
O2=concat([P2[0],P2[1],P2[2]],[for(ii=[3:len(L2)-1])L2[ii]])
)

[v[i], O1, O2, v[next]]];

function un(v) = v / max(len3(v), 0.000001) * 1;

 
function len3(v) =  sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));

function len3spl(v, precision  = 0.211, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, precision, acc + len3bz(v[p], precision), p + 1);

function len3bz(v, precision = 0.211, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + len3(bez2(t, v) - bez2(t + precision, v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [   for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)]): v[0] * (1 - t) + v[1] * (t);

function t(v) = [v[0], v[1], v[2]];

function spl2euler(i, v) = [0, -asin(spl2v(i, v)[2]), atan2(spl2xy(spl2v(i, v))[1], spl2xy(spl2v(i, v))[0])];

function spl2xy(v) = lim31(1, [v[0], v[1], 0]);  

function spl2v(i, v) = lim31(1, spl2(i - 0.0001, v) - spl2(i, v));  

function lim31(l, v) = v / len3(v) * l;

function cmin(c) = c[0]==undef?[0.5,0.5,0.5]:[max(0, min(1, c[0])), max(0, min(1, c[1])), max(0, min(1, c[2]))];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function SC3(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function clamp(a, b = 0, c = 10) = min(max(a, b), c);

function gauss(i, n = 0) = n > 0 ?
   let (x = gauss(i, n - 1)) x + (x - SC3(x)) : let (x = i) x + (x - SC3(x));
 
