/* Explanation of pattern syntax: 

   1 = square 1x1 ;
 
   [1] = square 1x1 ;

   [1,2] = square 1x2; 

   [[1,1],[2,2]] = square bounded by corners 1,1 and 2,2;

   [[0,0,1]] = circle r=1 at 0,0; 

   [[0,0,1],[1,1,1]] = two circles r=1 at 0,0 and 1,1; 

   [[0,0,1],[1,1,1]] = line from 0,0 to 1,1 with width=1;

   [[0,0,1],[1,1,2]] = wedge from 0,0 to 1,1 with width=1 to two;

   [[0,0],[10,10],[5,20]] = polygon of those points.

   [[0,0,1],[10,10,1],[5,20,1]] = "rounded polygon" with circles as points .
*/
 

X=30;
Y=20;
Z=20;
$fn=70;
orient=[0,0,0];
/* [Edge Breaks Defaults] */
// inner chamf
ich=0.01;
// outer chamf
och=0.01;
// inner rounding
ird=0.05;
// outer rounding
ord=0.05;
//offset
of=0.0;
/* [X plane] */
//view source for explanation of pattern syntax
helpX=666;
// stock profile pattern
Xstock=[[[0,Z,1],[0,7,3] ],[[0,7,3],[0,0,3] ],];
// Holes and cut outs pattern
Xholes=[   ] ;
//over all edges [ich,och,ird,ord,of]
XallBreak=[0.1,0.1,0.3,0.3,of];
//stock edges [ich,och,ird,ord,of]
XstBreak=[0,0,0,0,of];
//holes edges [ich,och,ird,ord,of]
XhoBreak=[0,0,0,0,of];
XaddBack=[ ];
Xturn=1;//[1:true,0:false]
/* [Y plane] */
//view source for explanation of pattern syntax
helpY=666;
// stock profile pattern
Ystock=[[
[X/2-2.5,0],[X/2-2.5-0.5,0.5,0],
[X/2-2.5,1],[X/2-2.5-0.5,1.5,0],
[X/2-2.5,2],[X/2-2.5-0.5,2.5,0],
[X/2-2.5,3],[X/2-2.5-0.5,3.5,0],
[X/2-2.5,4],[X/2-2.5-0.5,4.5,0],
[X/2-2.5,5],[X/2-2.5-0.5,5.5,0],
[X/2-2.5,6],[X/2-2.5-0.5,6.5,0],
[X/2-2.5,7],[X/2-2.5-0.5,7.5,0],

[X/2+2.5,7.5],[X/2+2.5+0.5,7,0],
[X/2+2.5,6.5],[X/2+2.5+0.5,6,0],
[X/2+2.5,5.5],[X/2+2.5+0.5,5,0],
[X/2+2.5,4.5],[X/2+2.5+0.5,4,0],
[X/2+2.5,3.5],[X/2+2.5+0.5,3,0],
[X/2+2.5,2.5],[X/2+2.5+0.5,2,0],
[X/2+2.5,1.5],[X/2+2.5+0.5,1,0],
[X/2+2.5,0.5],[X/2+2.5+0.5,0,0]

],[[X/2,Z,1],[X/2,7, 2.9]  
]];
// Holes and cutouts pattern
Yholes=[  ];
//over all edges [ich,och,ird,ord,of]
YallBreak=[0.01,0.01,0.003,0.003,of];
//stock edges [ich,och,ird,ord,of]
YstBreak=[ich,och,ird,ord,of];
//holes edges [ich,och,ird,ord,of]
YhoBreak=[ich,0,ird,0,of];
YaddBack=[ ];
Yturn=0;//[1:true,0:false]
/* [Z plane] */
//view source for explanation of pattern syntax
helpZ=666;
// stock profile pattern
Zstock= [[X/2,Y/2,2.8],[[X/2+10,Y/2,  1],[X/2-10,Y/2,1],] ];
echo(len(Zstock),len(Zstock[0]),len(Zstock[0][0]),len(Zstock[0][0][0])) ;
// Holes and cutouts pattern
Zholes=[  ];
//over all edges [ich,och,ird,ord,of]
ZallBreak=[0.1,0.1,0.3,0.3,of];
//stock edges [ich,och,ird,ord,of]
ZstBreak=[ich,och,ird,ord,of];
//holes edges [ich,och,ird,ord,of]
ZhoBreak=[ich,0,ird,0,of];
ZaddBack=[ ];
Zturn=0;//[1:true,0:false]

b=sqrt(X*X+Y*Y+Z*Z)/3;
mx=max(X,Y,Z);
% rotate(orient)union(){ 

if(Xturn==1){translate([0,Y/2,0])  rotate([  0,90,00]) rotate([  0,00,90])translate([0,0,-b])linear_extrude(1 ,convexity=68) intersection(){Xplane();square(mx);}
translate([-b,0,0])translate([0,Y/2,0])cylinder(1,Y/2,Y/2);
}
else{
rotate([  0,90,00]) rotate([  0,00,90])translate([0,0,-b])linear_extrude(1 ,convexity=68) Xplane();
}
 
if(Yturn==1){rotate([  90,0,0])translate([0,0,b]) linear_extrude(1 ,convexity=68) translate([X,Y/2])rotate([0,0,90])intersection(){Yplane();square(mx);}
translate([0,-b,0])translate([0,0,Z/2])rotate([0,90,0])cylinder(1,Y/2,Y/2);}
else {rotate([  90,0,0])translate([0,0,b]) linear_extrude(1 ,convexity=68) Yplane();}


if(Zturn==1){ translate([0,0,-b]) linear_extrude(1 ,convexity=68) translate([X/2,0])intersection(){Zplane();square(mx);}
translate([0,0,-b])translate([X/2,0,0])rotate([90,0,0])cylinder(1,Y/2,Y/2);}


else {translate([0,0,-b])    linear_extrude(1 ,convexity=68) Zplane();}



}
 rotate(orient)
intersection( convexity=68){
    //  rotate([  90,0,0])translate([0,0,-Y]) linear_extrude(Y ,convexity=68) Yplane();
 
if(Xturn==1)
 {translate([X*0.5,Y*0.50,0]) rotate_extrude( convexity=68) 
intersection(){Xplane();square(mx);}}
else
{     rotate([  0,90,00]) rotate([  0,00,90])linear_extrude(X ,convexity=68) Xplane();
} 

if(Yturn==1)
 {
  translate([0,Y*0.5,Z*0.5]) 
rotate([0,90,0])rotate_extrude( convexity=68) 
intersection(){Yplane();square(mx);}}

else
{     rotate([  90,0,0])translate([0,0,-Y]) linear_extrude(Y ,convexity=68) Yplane();
} 
if(Zturn==1)
 {
 translate([X*0.5,0,Z*0.5]) 
  rotate([-90,0,0]) rotate_extrude( convexity=68)     
  intersection(){Zplane();square(mx);}}
else
{     linear_extrude(Z ,convexity=68) Zplane();
} 
   
}


module Xplane(){
 offset(XallBreak[4])
 oround(XallBreak[3])
 iround(XallBreak[2])
 ochamf(XallBreak[1])
 ichamf(XallBreak[0]){

 difference(){
 offset(XstBreak[4]){
 oround(XstBreak[3])
 iround(XstBreak[2])
 ochamf(XstBreak[1])
 ichamf(XstBreak[0])
 makeplate(Xstock);}

 offset(XhoBreak[4]){
 oround(XhoBreak[3])
 iround(XhoBreak[2])
 ochamf(XhoBreak[1])
 ichamf(XhoBreak[0]) 
makeplate(Xholes);}}
makeplate(XaddBack);
}}
 

module Yplane(){
 offset(YallBreak[4])
 oround(YallBreak[3])
 iround(YallBreak[2])
 ochamf(YallBreak[1])
 ichamf(YallBreak[0]){

 difference(){
 offset(YstBreak[4]){
 oround(YstBreak[3])
 iround(YstBreak[2])
 ochamf(YstBreak[1])
 ichamf(YstBreak[0])
 makeplate(Ystock);}

 offset(YhoBreak[4]){
 oround(YhoBreak[3])
 iround(YhoBreak[2])
 ochamf(YhoBreak[1])
 ichamf(YhoBreak[0]) 
 makeplate(Yholes);}}
makeplate(YaddBack);
}}
 

module Zplane(){
 offset(ZallBreak[4])
 oround(ZallBreak[3])
 iround(ZallBreak[2])
 ochamf(ZallBreak[1])
 ichamf(ZallBreak[0]){

 difference(){
 offset(ZstBreak[4]){
 oround(ZstBreak[3])
 iround(ZstBreak[2])
 ochamf(ZstBreak[1])
 ichamf(ZstBreak[0])
 makeplate(Zstock);}

 offset(ZhoBreak[4]){
 oround(ZhoBreak[3])
 iround(ZhoBreak[2])
 ochamf(ZhoBreak[1])
 ichamf(ZhoBreak[0]) 
makeplate(Zholes);}}
makeplate(ZaddBack);
}}
 


module ioround(r=1)
{
offset(-r)offset(r*2)offset(-r)children();
}
module oround(r=1)
{
offset(r)offset(-r)children();
}
module iround(r=1)
{
offset(-r)offset(r)children();
}


module iochamf(r=1)
{
offset(delta=-r,chamfer=true)offset(delta=r*2,chamfer=true)offset(delta=-r,chamfer=true)children();
}
module ochamf(r=1)
{
offset(delta=r,chamfer=true)offset(delta=-r ,chamfer=true) children();
}
module ichamf(r=1)
{
offset(delta=-r,chamfer=true)offset(delta=r ,chamfer=true) children();
}

 function fp_triangulate(a, n = [0, 0, 1], count = 0) = count > len(a) ?
   let (e = echo("Ear Clip Error: Possibly Selfintersecting Polygon"))
 a: len(a) == 1 ? a : len(a) == 2 ? a : len(a) == 3 ? [[a[0], a[1], a[2]]] : let (en = p2n([a[0], a[1], a[2]], n))
 sign(dot(en, n)) > 0 ?
   let (b = concat([
    for (i = [2: len(a) - 1]) a[i]], [a[0]]))
 concat([[a[0], a[1], a[2]]], fp_triangulate(b, n, count = 0)): fp_triangulate(shuffle(a, 1), n, count + 1);

 function shuffle(b, l = 0) =
 let (c = concat([
  for (i = [1: len(b) - 1]) b[i]], [b[0]]))
 l > 0 ? shuffle(c, l - 1) : c;

 module makeplate(P) {
if(len(P)==0){}
else
   if (isequalformat(P, 1)) {
     echo("case1");
     square(P);
   }
   else {
     if (isequalformat(P, [1])) {
       echo("case2");
       square(P[0]);
     }
     else {
       if (isequalformat(P, [1, 1])) {
         echo("case3");
         square([P[0], P[1]]);
       }
       else {
         if (isequalformat(P, [[1, 1]])) {
           echo("case4");
           square([P[0][0], P[0][1]]);
         }
         else {
           if (isequalformat(P, [[1, 1], [1, 1]])) {
             ex = max(P[0].x, P[1].x);
             ey = max(P[0].y, P[1].y);
             sx = min(P[0].x, P[1].x);
             sy = min(P[0].y, P[1].y);
             echo("case5");
             translate([sx, sy]) square([ex - sx, ey - sy]);
           }
           else {
             makeplateW(P);
           }
         }
       }
     }
   }
 }
 module makeplateW(P) {
   for (i = [0: len(P) - 1]) {
     if (len(P[i][0]) == undef) {
       setcircle(P[i]); 
        //echo("case6 ",P[i]);
     }
     else {
       if (len(P[i]) <= 3) hull()
       { //echo("case6b ",P[i]);
         makeplateW(P[i]);
       }
       else {
         nn=[0,0,-sign(Ar(P[i]))];    
         a = fp_triangulate(P[i],nn);
         //echo("case6c ",P[i],nn);
         //echo("       ",a);     
         for (j = [0: len(a) - 1]) hull() {
           makeplateW(a[j]);
         }
       }
     }
   }
 }
 
 module setcircle(P) {
   translate([P.x, P.y]) circle(ensure(P[2]), $fn = ensure(P[2]) * 20);
 }

 function ensure(i) = max(0.001, i == undef ? 0 : i);

 function dot(a, b) = a * b;

function p2n(p,n) =
let (pa = t(p[0]), pb = t(p[1]), pc = t(p[2]), u = pa - pb, v = pa - pc) pa==0||pb==0?n:un([u[1] * v[2] - u[2] * v[1], u[2] *
 v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);
function t(v)=[v.x,v.y,0];
 function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
 function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[c];

 function len3(v) = len(v) > 1 ? sqrt(addl([
 for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;

 function isequalformat(a, b, level = " ") =
 //let (er = echo(str(level, a, " = ", b, "->", a == b, " ", (a != undef && b != undef) ? len(a) == len(b) : false)))
 len(a) == undef ? (a != undef && b != undef) ? len(a) == len(b) : false : let (c = [
  for (i = [0: emax(len(b) - 1, len(a) - 1)]) isequalformat(a[i], b[i], str(level, " "))]) alltrue(c);

 function alltrue(a) =
 let (b = [
  for (i = a) true]) a == b;

 function emax(a, b) = max(a == undef ? 0 : a, b == undef ? 0 : b);
 
function ensure(i)=max(0.02,i==undef?0:i);
function rrnd(a=1,b=0,s= [])=round(rnd(a , b , s )/3 )*3;
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function  Ar(points, i=1) =
    let(
    area = (points [i-1].x+points[i].x) * (points[i-1].y-points[i].y))
    i<len(points)?
    area/2 +Ar(points, i+1) 
    :(points [i-1].x+points[0].x) * (points[i-1].y-points[0].y)/2;  
function circlecircle(x,r,n=8,a=45,center=[X/2,Y/2],start=0)=[for(ang=[start:a:start+a*n])[sin(ang)*x,cos(ang)*x,r]];
