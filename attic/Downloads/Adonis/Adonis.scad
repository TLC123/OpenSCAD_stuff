$fn = 20;

 
v = [
[0,0,30,[14,14,14],rndc()],
[0,-3,40,[15,14,17],rndc()],
[0,-2,95,[10,15,8],rndc()],
[0,0,100,[5,5,5],rndc()], 
[0,-3,120,[12,10,14],rndc()],
[0,1,140,[15,15,15],rndc()]];

v2 = [ 
[0,0,100,[3,3,3],rndc()],
[20,2,95,[7,7,6],rndc()],
[40,0,60,[4,5,4],rndc()],
[35,-21,30,[2,3,2],rndc()],
[35,-25,10,[2,8,2],rndc()],
[35,-20,-5,[1,3,1],rndc()]
];
v3 = [
  [0,0,100,[3,3,3],rndc()],
[-20,2,95,[7,7,6],rndc()],
[-40,0,60,[4,5,4],rndc()],
[-35,-21,30,[2,3,2],rndc()],
[-35,-25,10,[2,8,2],rndc()],
[-35,-20,-5,[1,3,1],rndc()]
];

v4 = [
[0,0,30,[7,7,7],rndc()],
[10,5,20,[7,8,7],rndc()],
[20,-5,-30,[5,5,5],rndc()], 
[15,0,-70,[4,4,5],rndc()],
[15,5,-80,[2,5,4],rndc()],
 [25,-20,-84,[2,10,2],rndc()]
];
v5 = [
[0,0,30,[7,7,7],rndc()],
[-10,5,20,[7,8,7],rndc()],
[-20,-5,-30,[5,5,5],rndc()],
[-15,0,-70,[4,4,5],rndc()],
[-15,5,-80,[2,5,4],rndc()],
[-25,-20,-84,[2,10,2],rndc()]
];

bline(v);
bline(v2);
bline(v3);
bline(v4);
bline(v5);

module bline(v)
{
step=1/15;

for(i=[step:step:1-step*5])
  
 color(un(rndc(i-1)))  union() {
t1=smooth_animate(i,v);
translate(v3(t1)) scale(t1[3]) sphere(1);
t2=smooth_animate(i+step,v)  ;      
translate(v3(t2))scale(t2[3]) sphere(1);
      }


}



function wrapi(x,tak) =  ((x  % tak) + tak) % tak; // wraps index 0 - x 
 
function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;

function smooth_animate(t,v)=let(
ll=len(v),        i=round(ll*t),       T=(ll*t+0.5)%1 , 
p0=    lerp(v[ wrapi(i-1,ll)], v[wrapi(i,ll)],0.5),
p1=    v[wrapi(i,len(v))], 
p2=    lerp( v[wrapi(i,ll)],v[ wrapi(i+1,ll)],0.5) ) 
lerp(lerp( p0,p1,T),lerp(p1,p2,T),T) ;

function v3(v) = [v[0], (v[1]), (v[2])];





module spline(v, d = 8, start = 0, stop = 1, twist = 0, gap = 1) {
   if (len(v[0][0]) == undef) {
      t = 0.3;
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
               translate(t(spl2(i, v))) rotate(spl2euler(i, v)) scale(spl2(i, v)[3]) rotate([twist * ii, 0, 0]) rotate([0, -90, 0]) sphere(1);
               translate(t(spl2(i - detail * gap, v))) rotate(spl2euler(i - detail * gap, v)) scale(spl2(i - detail * gap, v)[3]) rotate([twist * (ii - det), 0, 0]) rotate([0, -90, 0]) sphere(1);
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

function v2spl(v, t = 0.3) =let ( L = len(v) - 1)[   for (i = [0: L - 1]) let (prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2)) let (M = len3(v[next] - v[i]), N0 = un(v[i] - v[prev]), N1 = un(v[next] - v[i]), N2 = un(v[nnext] - v[next]), N01 = un(N0 + N1) * M * t, N12 = un(N1 + N2) * M * t)[v[i], v[i] + N01, v[next] - N12, v[next]]];

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