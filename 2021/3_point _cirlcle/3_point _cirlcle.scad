$fn = 20;
point_C = [rnd(-20, -5), rnd(5, 20)];
point_B = [rnd(5, 20), rnd(5, 20)];
point_A = [rnd(5, 20), rnd(-20, -5)];
center = circle_by_three_points(point_A, point_B, point_C);
radius = len3(point_C - center);
translate(point_A) text("A",size=2,"center");
translate(point_B) text("B",size=2,"center");
translate(point_C) text("C",size=2,"center");
color("red",.5) translate(center) circle(radius);
echo(center, radius);




point_test = [rnd(-20, 20), rnd(-10, 20)];
d= SDF_circle_by_three_points(point_test,point_A, point_B, point_C) ;
color("blue",.5)translate(point_test)circle(d);
echo(d);


function dot(a,b)= a*b;
function xdot(a,b)= a.x*b.y-a.y*b.x;
function ndot(a,b)= a.x*b.x-a.y*b.y;


function  IntersectionOfLines(pa1, pa2, pb1, pb2)=
let( da = pa1-pa2, db = pb1-pb2 ,the = xdot(da,db))
(the == 0)? undef: /* no in tersection*/
let (P=[xdot(pa1,pa2),xdot(pb1,pb2)])
[ndot(P,[db.x,da.x])   , ndot(P,[db.y,da.y]) ]/ the
;

//function circle_by_three_points(A, B, C) =
//let (
//  D_b = C - B,  
//  D_a = B - A,  
//  
//  aS = D_a.y / D_a.x,  
//  bS = D_b.y / D_b.x,
//  
//  cex = (
//  aS * bS * (A.y - C.y) +   
//       bS * (A.x + B.x) -    
//       aS * (B.x + C.x)
//       ) 
//       / (2 * (bS - aS)
//   ),
//  cey = -1 * (cex - (A.x + B.x) / 2) / aS + (A.y + B.y) / 2
//)
//[cex, cey];

function circle_by_three_points(A, B, C) =
let(
AB0=.5*(A+B),   BC0=.5*(B+C),
AB1=AB0+[-(B-A).y,(B-A).x],  BC1=BC0+[-(C-B).y,(C-B).x])
let( da = AB0-AB1, db = BC0-BC1 ,the = xdot(da,db))
(the == 0)? undef: /* no in tersection*/
let (D=[xdot(AB0,AB1),xdot(BC0,BC1)])
[ndot(D,[db.x,da.x])   , ndot(D,[db.y,da.y]) ]/ the ;


function SDF_circle_by_three_points(p,A, B, C) =
let(
AB0=.5*(A+B),   BC0=.5*(B+C),
AB1=AB0+[-(B-A).y,(B-A).x],  BC1=BC0+[-(C-B).y,(C-B).x])
let( da = AB0-AB1, db = BC0-BC1 ,the = xdot(da,db))
(the == 0)? undef: /* no in tersection*/
let (D=[xdot(AB0,AB1),xdot(BC0,BC1)])
let (center=[ndot(D,[db.x,da.x])   , ndot(D,[db.y,da.y]) ]/ the  )
let (a0= (2*360+atan2((A-center).y,(A-center).x))%360)
let (a1=(2*360+atan2((C-center).y,(C-center).x))%360)
 
   sdArc(  p-center,  (a0+a1)*.5,  abs(a0-a1)*.5 ,  norm(A-center)  )
;


// sca is the sin/cos of the orientation
// scb is the sin/cos of the aperture
function  sdArc(  p,  ac,  aw,   ra  )=
let (    p =p* [[sin(ac),cos(ac)],[-cos(ac),sin(ac)]])
 
let (    p =[ abs(p.x),p.y])
 
let (    k = (cos(aw)*p.x>sin(aw)*p.y) ? dot([p.y,p.x],[sin(aw),cos(aw)]) : norm(p) )
     sqrt( dot(p,p) + ra*ra - 2.0*ra*k )  ;



// non dependencies helper function for demo

function rnd(a = 1, b = 0, s = []) =s == [] ?
  (rands(min(a, b), max(a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);

function len3(v) = sqrt(pow(v.x, 2) + pow(v.y, 2));
 