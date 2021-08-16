
$fn = 50;
point_C = [rnd(-20, 20), rnd(-20, 20), rnd(-20, 20)];
point_B = [rnd(-20, 20), rnd(-20, 20), rnd(-20, 20)];
point_A = [rnd(-20, 20), rnd(-20, 20), rnd(-20, 20)];
center = Incenter(point_A, point_B, point_C);
inradius = point_to_line(center,point_A, point_B);
hull(){translate(point_A) sphere(0.1);
translate(point_B) sphere(0.1);
translate(point_C) sphere(0.1);}
color("red") translate(center) sphere(inradius);
echo(center, inradius);

function Incenter(A, B, C) =
let (
a=norm(B-C),
b=norm(A-C),
c=norm(A-B),
  p = a + b + c, 
  Ox = (a * A.x + b * B.x + c * C.x) / p, 
  Oy = (a * A.y + b * B.y + c * C.y) / p,
  Oz = (a * A.z + b * B.z + c * C.z) / p
    )
[Ox, Oy, Oz];

function point_to_line(p,a,b)=
let(
pa = p - a, 
ba = b - a,
h = clamp( (pa*ba)/ (ba*ba)))
norm( pa - ba*h ) ;
function clamp(a, b = 0, c = 1) = min(max(a, b), c); 

 
function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);

 
