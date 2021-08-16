$fn=9;
t=0.3;
v = [
  for (t = [0: 5]) concat(rndc() * 100)
];
//ShowControl(v,t);
//extrudeT(v);
extrudeT(bez2spl(v,t)) {
  sphere(1);
 };
//ShowControl(bez2spl(v),t);
//for(i=[0:len(v)-1]){echo(bez2spl(v)[i]);color(rndc()){ShowControl(bez2spl(v)[i]);extrudeT(bez2spl(v)[i]);}}
function bez2spl(v, t = 0.3) =
let (L = len(v) - 1)[
  for (i = [0: L - 1]) let (isatend=i==L-1?0:1,isatstart=i==0?0:1,prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2))
  let (M = len3(v[next] - v[i]),
 N0 = un(v[i] - v[prev]),
 N1 = un(v[next] - v[i]), 
N2 = un(v[nnext] - v[next]), 
N01 = un(N0 + N1) * M * t*isatstart, 
N12 = un(N1 + N2) * M * t*isatend )
[v[i], v[i] + N01, v[next] - N12, v[next]]];

function un(v) = v / max(len3(v), 0.000001) * 1;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
  if (len(v[0][0]) != undef) {
    for (ii = [0: len(v) - 1]) {
      ShowControl(v[ii]);
    }
  } else
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate(t(v[i])) sphere(1);
        translate(t(v[i - 1])) sphere(1);
      }
    }
}

function t(v) = [v[0], v[1], v[2]];

function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
module extrudeT(v, d = 8, start = 0, stop = 1, twist = 0, gap = 1) {
  if (len(v[0][0]) != undef) {
    for (ii = [0: len(v) - 1]) {
      extrudeT(v[ii]) {
       children(0);children(1);children(2);children(3);children(4);
      };
    }
  } else {
    detail = 1 / d;
    for (i = [start + detail: detail: stop]) {
      if ($children > 0) {
        for (j = [0: $children - 1]) hull() {
          translate(t(bez2(i, v))) 
rotate( bez2euler(i, v) ) 

scale(bez2(i, v)[3]) rotate([twist * i, 0, 0]) children(j);
          translate(t(bez2(i - detail * gap, v)))
 rotate(bez2euler(i - detail , v)) 

scale(bez2(i - detail * gap, v)[3]) rotate([twist * (i - detail), 0, 0]) children(j);
        }
      } else {
        hull() {
          translate(t(bez2(i, v))) rotate(bez2euler(i, v)) scale(bez2(i, v)[3]) rotate([twist * i, 0, 0]) rotate([0, -90, 0]) sphere(1);
          translate(t(bez2(i - detail * gap, v))) rotate(bez2euler(i - detail * gap, v)) scale(bez2(i - detail * gap, v)[3]) rotate([twist * (i - detail), 0, 0]) rotate([0, -90, 0]) sphere(1);
        }
      }
    }
  }
}

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)
]): v[0] * (1 - t) + v[1] * (t);

function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function lim31(l, v) = v / len3(v) * l;