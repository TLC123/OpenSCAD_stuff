
$fn = 20;
point_C = [rnd(-20, -5), rnd(5, 20)];
point_B = [rnd(5, 20), rnd(5, 20)];
point_A = [rnd(5, 20), rnd(-20, -5)];
center = circle_by_three_points(point_A, point_B, point_C);
radius = len3(point_C - center);
translate(point_A) circle(2);
translate(point_B) circle(2);
translate(point_C) circle(2);
color("red") translate(center) circle(radius);
echo(center, radius);


function circle_by_three_points(A, B, C) =
let (
  yD_b = C.y - B.y,  xD_b = C.x - B.x,  yD_a = B.y - A.y,
  xD_a = B.x - A.x,  aS = yD_a / xD_a,  bS = yD_b / xD_b,
  cex = (aS * bS * (A.y - C.y) + 
  bS * (A.x + B.x) -    aS * (B.x + C.x)) / (2 * (bS - aS)),
  cey = -1 * (cex - (A.x + B.x) / 2) / aS + (A.y + B.y) / 2
)
[cex, cey];
function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);

function len3(v) = sqrt(pow(v.x, 2) + pow(v.y, 2));