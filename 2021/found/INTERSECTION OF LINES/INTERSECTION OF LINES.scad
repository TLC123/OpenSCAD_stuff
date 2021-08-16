function xdot(a,b)= a.x*b.y-a.y*b.x;
function ndot(a,b)= a.x*b.x-a.y*b.y;
//function  IntersectionOfLines(pa1, pa2, pb1, pb2)=
//let(
//da = [(pa1.x-pa2.x),      (pa1.y-pa2.y)], 
//db = [(pb1.x-pb2.x),      (pb1.y-pb2.y)],
//the = da.x*db.y - da.y*db.x                 )
//(the == 0)? 
//undef: /* no in tersection*/
//let (
//A = (pa1.x * pa2.y - pa1.y * pa2.x),
//B = (pb1.x * pb2.y - pb1.y * pb2.x)         )
//[( A*db.x - da.x*B ) / the , ( A*db.y - da.y*B ) / the]
//;

function  IntersectionOfLines(pa1, pa2, pb1, pb2)=
let( da = pa1-pa2, db = pb1-pb2 ,the = xdot(da,db))
(the == 0)? undef: /* no in tersection*/
let (P=[xdot(pa1,pa2),xdot(pb1,pb2)])
[ndot(P,[db.x,da.x])   , ndot(P,[db.y,da.y]) ]/ the
;
// demo code
pa1=[rnd(100),rnd(100)];
pa2 =[rnd(100),rnd(100)];
pb1=[rnd(100),rnd(100)];
pb2=[rnd(100),rnd(100)];
I=IntersectionOfLines(pa1, pa2, pb1, pb2);
line(pa1, pa2);
line(pb1, pb2);


// show in red if intersecting 
// else extend linese outside segments
if(I.x>min(pa1.x,pa2.x)&&I.x<max(pa1.x,pa2.x)
&&I.y>min(pa1.y,pa2.y)&&I.y<max(pa1.y,pa2.y))
{color("red")translate(I) sphere(3);
}
else{
translate(I) sphere(3);
hull(){
translate(I) sphere(0.5);
translate(pa1) sphere(0.5);}
hull(){
translate(I) sphere(0.5);
translate(pb1) sphere(0.5);}
}


echo(I);

module line(p1,p2){hull(){
translate(p1) sphere(1);
translate(p2) sphere(1);
}}

function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);