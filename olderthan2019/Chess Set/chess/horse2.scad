style= rands(0.01,0.99,100);

Knightshead(); 
module Knightshead
(){$fn = 12;
buck();
mirror([0,1,0])buck();
 
v=[
[0,0,12,[12.9,11.3,5]],
[0,0,20,[10.9,7.3,3]],
[-2,0,25,[8.9,6.3,3]],
[-6,0,30,[6,5.5,3]],
[-6.5,0,35,[6,6.5,3]],
[-7,0,40,[5,5.5,3]],
[-5,0,45,[5,5,2]],
 
 [0,0,44,[4,6.5,2]],
[2,0,43,[3.5,5.5,1]],
[5,0,40,[2.5,3,1]], 
[9,0,34,[4.5,3.5,2]],
 [9,0,32.5,[4,3.5,2]],
 [10.5,0,30.9,[2,3.5,1]],
 [11.3,0,30,[1,2.5,0.5]]
]; 

v2=[
 
[-5,0,45,[5,5,2]],
 
 [-2,0,39,[6,6.45,7]],
[3,0,38,[2,4.5,7]],
[5,0,36,[2,4,7]], 
 
 [9,0,32.5,[4,3.7,3]],
 [10.5,0,30.9,[2,3.5,1]]
];
v3=[
 
[-5,0,45,[5,5,2]],
  
 [-3,0,42,[7,6.0,2]],
 [-3,0,39,[7,6.8,3]],
 [-2.8,0,35,[5,6.5,3]],
[-2,0,34.9,[5,5.8,3]],
[3,0,34,[2,3.0,3]],
 
[5.9,0,31,[2,3.1,2]], 
[7.9,0,29,[3,3.4,1]],
 [9,0,28.1,[2,2,1]]
];

face =[
[-8.8,-6,48.9,[0.7,0.3,0.5]],
[-7.2,-4.9,47,[1.9,1.4,0.5]],
[-6.6,-4.0,45.7,[2.4,1.9,1.6]],
[-5.7,-2.8,44,[3.7,2.7,1]],
[1,-1,42,[1,1,1]],
[1,-4.7,42,[1.6,1,1.4]],
[1,-1,42,[1,1,1]],
[09.2,-1.4,33.2,[1,1,1]],
[09.2,-2.4,33.2,[1,1.5,1.7]],
[09,-2.9,34.3,[1.5,1.2,1.7]],
[10.7,-2.8,35.1,[1,1,0.8]],
[11,-2.2,34.5,[1.8,1,0.7]],
[11.23,-1,33.9,[2,1,0.5]]
];

neck = [[-10, -0,0,[20,15,15]],[10, -15,0,[1,8,19]],[22, 22,0,[1,1,6]],[40, 8,0,[12,12,1]],[32, 0,0,[8,12,10]],[21, -6,0,[9,-3,1 ]],[21, -13,0,[3,6,6]] ,[19, -13,0,[3,3,5]] ];
 ShowControl(v) ;
ShowControl(v2) ;
ShowControl(v3) ;
 ShowControl(face) ; 
mirror([0,1,0])ShowControl(face) ;

translate([-1, 0, 13])rotate([0,-90,90]){
 
extrudeT(neck,30,0.15,0.60,0,0.5){//mane
scale([1,1.5,1])hull(){
translate( [0,0.1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,-0.1])rotate([0,90,0])sphere(0.1);
translate( [0,0.1,-0.1])rotate([0,90,0])sphere(0.1);
}}
extrudeT(neck,30,0.15,0.60,0,1){//mane
scale([0.8,1.4,0.8])hull(){
translate( [0,0.1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,0.1])rotate([0,90,0])sphere(0.1);
translate( [0,-1,-0.1])rotate([0,90,0])sphere(0.1);
translate( [0,0.1,-0.1])rotate([0,90,0])sphere(0.1);
}} 

 }
}
module buck(){ translate([-5,-4.5,38])rotate([90,0,0])scale([0.5,0.5,0.45])rotate_extrude($fn=40)
{ 
intersection(){square(10);offset(r=1)offset(r=-2)offset(r=2,$fn=5){
 square([10,5]);
 translate([style[31]*10,5,0])rotate(90*style[28])square([1,1]);
 translate([style[33]*10,5,0])rotate(90*style[29]) square([1,1]);
 translate([style[34]*10,5,0])rotate(90*style[29]) square([2,2]);
}}
}}
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
      hull() {
         translate(lerp(v1, v2, i)) scale(lerp(s1, s2, lerp(i,SC3(i),0.5))) rotate([0,0,360/24])ssphere(1);
         translate(lerp(v1, v2, i - d)) scale(lerp(s1, s2, lerp(i - d,SC3(i - d),0.5))) rotate([0,0,360/24]) ssphere(1);
      }
   }
}
module ssphere()
{
hull(){
 sphere([0.25,0.25,1]);
 for(r=[0:360/12:360]){
rotate([0,0,r])translate([0.8,0,0.15])sphere(0.3,$fn=16);
rotate([0,0,r])translate([0.8,0,-0.15])sphere(0.3,$fn=16);
}}}

module extrudeT(v,d=8,start=0,stop=1,twist=0,gap=1) {
         detail=1/d;

    for(i = [start+detail: detail: stop]) {
if($children>0){
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) rotate([twist*i,0,0])children(j);
        translate(t(bez2(i - detail*gap, v))) rotate(bez2euler(i - detail*gap, v))scale(bez2(i- detail*gap  , v)[3]) rotate([twist*(i- detail),0,0])children(j);
      }
    }else{
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) rotate([twist*i,0,0])rotate([0,-90,0])sphere(1);
        translate(t(bez2(i - detail*gap, v))) rotate(bez2euler(i - detail*gap, v))scale(bez2(i- detail*gap  , v)[3]) rotate([twist*(i- detail),0,0])rotate([0,-90,0])sphere(1);
      }}
}


  }

function t(v) = [v[0], v[1], v[2]];

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function SC3(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function clamp(a, b = 0, c = 10) = min(max(a, b), c);

function gauss(i, n = 0) = n > 0 ?
   let (x = gauss(i, n - 1)) x + (x - SC3(x)) : let (x = i) x + (x - SC3(x));
 function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
for(i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * ( t)]): v[0] * (1 - t) + v[1] * ( t);
function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));