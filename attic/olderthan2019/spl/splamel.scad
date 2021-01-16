$fn = 24;
detail=1;
 tension = 0.3;
 n = 9;
 thick = 16;
 turns=0;
 gap=1;
 showcontrol="no";

frontleg = [
   [7, -10, 0.8, [4, 2, 0.8]],
   [6.5, -9, 1.5, [4, 2, 1.5]],
   [6.5, -7, 1, [3, 3, 1]],
   [6, -5.3, 3.7, [2, 2.2, 1]],
   [6, -4.5, 14.7, [1.6, 1.5, 1]],
   [6, -5, 17, [2.6, 2.5, 1]],
   [6, -5, 19.7, [1.9, 1.8, 1]],
   [6, -7.5, 30.7, [3, 4, 4]],
   [5, -7.5, 35.7, [4, 8, 4]],
   [5, -7, 40.7, [3, 6, 3.]],
   [3, -3.5, 45.7, [2, 4, 3]]
];
backleg = [
   [7, 10 + 20, 0.8, [4, 2, 0.8]],
   [7, 10 + 21, 1.5, [4, 2, 1.5]],
   [6.5, 10 + 23, 1, [3.5, 3, 1]],
   [4.5, 11 + 24.7, 4.7, [2.5, 2.7, 1]],
   [4, 13 + 23.5, 14.7, [1.6, 1.5, 1]],
   [4, 12 + 25, 19, [2.6, 3.5, 1]],
   [4, 11 + 25, 20.7, [2.9, 2.8, 1]],
   [6, 7 + 22.5, 30.7, [3, 5, 4]],
   [5, 6 + 22.5, 35.7, [4, 8, 4]],
   [4, 6 + 23, 40.7, [4, 8, 3.]],
   [3.5, 6 + 23, 45.7, [4, 7, 4.]],
   [2, 1 + 23.5, 48.7, [3, 8, 4]]
];
face = [
   [5, -30, 56, [0.3, 0.3, 0.7]],
   [3.5, -29.5, 54, [1.5, 1, 1.5]],
   [2, -31, 53, [1, 1, 1]],
   [-1.1, -32.5, 52.4, [2.1, 3, 2.1]],
   [-2.2, -33.5, 53.5, [2, 1, 1.4]],
   [-2, -35.7, 54.1, [2.6, 1, 1]],
   [-0, -38, 53, [1, 1, 1]],
   [-1, -40, 51, [0.5, 0.5, 0.5]],
];
body1 =   [
 
 
[0,33,45,[3,3,3]],
[0,25,45,[4,2,8]],
[0,17,43,[8,2,11]],
[0,11,42,[10,2,13]],
[0,5,42,[11,2,13]],
[0,0,41,[8,5,12]],
[0,-3,39,[8,5,10]], 
[0,-11,38,[7.5,4,9]], 
[0,-15,37,[6,5,6]],
[0,-22,35,[2,2,4]],
[0,-29,40,[3,5,5]],
[0,-31,45,[4,4,4]],
[0,-33,49,[4,2,4]],
[0,-37,50,[3.5,3,3.5]],
[0,-41,51.4,[2.5,1,1.5]],
[0,-43,50.8,[2,2,1]],
[0,-43.4,49.5,[0.5,0.3,0.5]]
];
body2 = [
[0,46,24,[0.2,0.2,0.2]],
[0,43.5,30,[2,2,2]],
[0,41.5,34,[0.8,0.8,0.8]],
[0,37,44,[2,2,2]],
[0,33,46.5,[3,3,3]],
[0,25,48,[2,2,6]],
[0,17,52,[1,2,5]],
[0,11,54.1,[3,2,8]],
[0,5,54,[3,2,8.5]],
[0,0,50,[2,2,8]],
[0,-3,45,[2,2,7.5]], 
[0,-11,44,[3,2,7]], 
[0,-15,39,[4,2,6]],
[0,-22,38,[4,2,6]],
[0,-29,42,[3,5,5]],
[0,-30,51,[3,2,4]],
[0,-35.1,52.4,[4.1,2,3]],
[0,-37,53,[2,2,2]],
[0,-40,54.8,[1,1,1]],
[0,-42,53,[2,3.8,2]],
[0,-42,52,[2.5,4.1,1]]
];
spline(body1,d=detail,twist=360*turns,gap=gap);
spline(body2,d=detail,twist=360*turns,gap=gap);
spline(frontleg,d=detail,twist=360*turns,gap=gap);
mirror()spline(frontleg,d=detail,twist=360*turns,gap=gap);
spline(backleg,d=detail,twist=360*turns,gap=gap);
spline(face,d=detail,twist=360*turns,gap=gap);
mirror()spline(backleg,d=detail,twist=360*turns,gap=gap);
mirror()spline(face,d=detail,twist=360*turns,gap=gap);



 

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
module ShowSplControl(v) {
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
 
