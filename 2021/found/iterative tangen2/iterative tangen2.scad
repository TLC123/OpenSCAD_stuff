threshold = 1e-12;
workarea = 100;


function  AcmeSolver(f0, f1, f2, ifind = undef, maxi = 0) =
let (
find = ifind == undef ? 
    (featurecenter(f0) * 0.4 + featurecenter(f1) * 0.3 
    + featurecenter(f2) * 0.3) : ifind, 
d0 =distancetofeature(f0, find), 
nf0 = normaltofeature(f0, find),
d1 = distancetofeature(f1, find), 
nf1 = normaltofeature(f1, find),
d2 = distancetofeature(f2, find), 
nf2 = normaltofeature(f2, find),
sum = abs(d0 - d1) + abs(d1 - d2) + abs(d2 - d0), 
avrg = (d0 + d2 +    d1) / 3,  
cf0 = (find + nf0 * (max(0, d0) - avrg) * 0.999),  
cf1 = (    find + nf1 * (max(0, d1) - avrg) * 0.999),  
cf2 = (find + nf2 * (    max(0, d2) - avrg) * 0.999),  
newfind = (cf0 + cf1 + cf2) / 3 )
sum < threshold || maxi > 6000 ? 
[find, avrg, maxi, sum]
:  AcmeSolver(f0,
f1, f2, newfind, maxi + 1);

function featurecenter(feat) = len(feat) == 2 && len(feat[0]) ==
  undef ? feat : len(feat) == 3 && len(feat[0]) == undef ? [feat.x,
    feat.y] : len(feat) == 2 && len(feat[0]) == 2 ? (feat[0] + feat[1]) /
  2 : [0, 0];

function distancetofeature(feat, find) = len(feat) == 2 && len(feat[0]) ==
  undef ? norm(feat - find) : len(feat) == 3 && len(feat[0]) == undef ?
  distancetocircle(feat, find) : len(feat) == 2 && len(feat[0]) == 2 ?
  distancetoline(feat, find) : 0;

function normaltofeature(feat, find) = len(feat) == 2 && len(feat[0]) ==
  undef ? normaltopoint(feat, find) : len(feat) == 3 && len(feat[0]) ==
  undef ? normaltocircle(feat, find) : len(feat) == 2 && len(feat[0]) ==
  2 ? normaltoline(feat, find) : 0;

function distancetopoint(point, find) = norm(point - find);

function distancetocircle(circle, find) = norm([circle.x, circle.y] -
  find) - circle[2];

function distancetoline(line, p) =
let (a = line[0], b = line[1], pa = p - a, ba = b - a, h = ((pa * ba) /
  (ba * ba)))
norm(pa - ba * h);

function normaltopoint(point, find) = (point - find) / norm(point -
  find);

function normaltocircle(circle, find) = ([circle.x, circle.y] - find) /
norm([circle.x, circle.y] - find);

function normaltoline(line, find) =
let (a = line[0], b = line[1], dtl2 = distancetoline(line, find))
un([distancetoline(line, find + [-1, 0]) - dtl2, distancetoline(line,
  find + [0, -1]) - dtl2]);
function un(v) = v / max(1e-15, norm(v));

// demo code
function randomfeature() =
let (s0 = round(rnd(2)))
(s0 == 0) ? [rnd(workarea), rnd(workarea), rnd(1, workarea * 0.5)] :
(s0 == 1) ? [rnd(workarea), rnd(workarea)] : (s0 == 2) ? [[rnd(
  workarea), rnd(workarea)], [rnd(workarea), rnd(workarea)]] : ["err"];

module showfeature(feat) {
  color("black") {
    if (len(feat) == 2 && len(feat[0]) == undef) {
      echo(" point ", feat);
      translate(feat) sphere(2);
    }
    if (len(feat) == 3 && len(feat[0]) == undef) {
      echo(" circle ", feat);
      linear_extrude(1)translate([feat.x, feat.y]) difference() {
        circle(feat[2]);
        circle(feat[2] - 1);
      }
    }
    if (len(feat) == 2 && len(feat[0]) == 2) {
      echo(" line ", feat);
      linear_extrude(1)hull() {
        translate(feat[0]) circle(1);
        translate(feat[1]) circle(1);
      }
      n1 = un(feat[0] - feat[1]);
      linear_extrude(0.2)hull() {
        translate(feat[0] + n1 * workarea) circle(0.2);
        translate(feat[1] - n1 * workarea) circle(0.2);
      }
    }
  }
}
module ring(d, i = 1) {
  linear_extrude(i)
  {
    translate(d[0]) difference() {
      circle(d[1], $fn = 60);
      circle(max(0,d[1] - 1), $fn = 60);
    }
  }
}

function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
  a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);



feature0 = randomfeature();
feature1 = randomfeature();
feature2 = randomfeature();
showfeature(feature0);
showfeature(feature1);
showfeature(feature2);
// try fo fit from midpoint
d =  AcmeSolver(feature0, feature1, feature2);
//[center,radius,solvedsteps,fit]

if (d[3] < threshold) {
echo(" Found Internal ", d);
  color("red") ring(d, 1.1);
}
else {
  color("yellow") ring(d);
  if (d[3] < workarea*0.1) {
    echo(" Found no internal solution in time. Best fit : ", d[3]);
  }
  else {
    echo(" Found no internal solution in time ");
  }

// try to fit from ouside
for (i = [0: 45: 360]) {
  cme = [sin(i) * workarea * 10, cos(i) * workarea * 10];
  de =  AcmeSolver(feature0, feature1, feature2, cme);
  if (norm(d[0] - de[0]) > threshold) {
    if (de[3] < threshold) {
      color([1, rnd(), rnd()]) ring(de);
      echo(" Found External ",de);
    }
    else {
      echo(" Found no external solution in time ");
    }
  }
}
// try to fit from Random State
for (i = [0:  10]) {
  cme = [rnd(workarea),rnd(workarea)];
  de =  AcmeSolver(feature0, feature1, feature2, cme);
  if (norm(d[0] - de[0]) > threshold) {
    if (de[3] < threshold) {
      color([1, rnd(), rnd()]) ring(de);
      echo(" Found Random State ",de);
    }
    else {
      echo(" Found no Random State solution in time ");
    }
  }
}

}

