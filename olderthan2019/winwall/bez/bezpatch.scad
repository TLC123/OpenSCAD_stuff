////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
wind=[-60,0,60];
Wingskin=1;

thickest=15;//[5:50]
detail = 20; //[0.01:0.001:0.5]
fn = 10; //[8:30]
//rad=5;//[1:0.5:12]
//tang=2;//[1:10]
//some random 4D points
tip=[200,75,00,1];
v1 = [[0,-50,0,1],[50,50,120,1],[0,150,0,1]];

v2 = [[100,-50,20,1],[110,10,-10,1],[100,10,50,1]];
v3 = [v1[0],v2[0]];

v4 = [v1[2],v2[2]];
  
 v5 = [[200,50,0,1],[200,50,0,1],[200,50,0,1]];

v6 = [v2[0],v5[0]];

v7 = [v2[2],v5[2]];

  Skinflap(v1[0],v2[0],v5[1],v5[1],v2[2],v1[2],8);
   module Skinflap(e3, e2, e1, f1, f2, f3, detail) {
   c = (e3 + e2 + e1 + f2 + f3) / 5 + wind;
   echo(e3, e1, f3, c);
   translate(t(c)) sphere(5);
   v1 = [e3, (f1 + c + c+ c) / 4, f3];v2 = [e2, (f1 + c + c) / 3, f2];v3 = [e3, e2];
   v4 = [f3, f2];v5 = [e1, f1];v6 = [e2, e1];v7 = [f2, f1];
   bpatch(v1, v2, v3, v4, detail);
   bpatch(v2, v5, v6, v7, detail);
 }
 module bpatch(v1, v2, v3, v4, d) {
   detail = 0.999 / d; 
   for (i = [detail: detail: 1]) {
     for (j = [detail: detail: 1]) {
       poly(bez4(i, j, v1, v2, v3, v4), bez4(i, j - detail, v1, v2, v3, v4),
         bez4(i - detail, j, v1, v2, v3, v4), Wingskin);
       poly(bez4(i, j - detail, v1, v2, v3, v4), bez4(i - detail, j - detail,
         v1, v2, v3, v4), bez4(i - detail, j, v1, v2, v3, v4), Wingskin);
     }
   }
 }

 function bez4(i, j, v1, v2, v3, v4) = ((bez2(j, v3)) * i + (bez2(j, v4)) * (1 -
   i)) * 0.5 + ((bez2(i, v1)) * j + (bez2(i, v2)) * (1 - j)) * 0.5;
 
 
 
 
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
module draw(s,f,h){hull(){translate(t(s))sphere(h); translate(t(f)) sphere(h);} }
module poly(p1,p2,p3,h){hull(){translate(t(p1))sphere(h);translate(t(p2))  sphere(h);translate(t(p3))sphere(h);}}

function vsharp(v)=[for(i=[0:0.5:len(v)-1])v[floor(i)]];
