////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5,6,7,8,9,10]
controlpoints=rands(3,8,10)[part];//[1:20]
thickest=rands(5,30,10)[part];//[5:50]
detail = 0.999/20; //[0.01:0.001:0.5]
fn = 12; //[8:30]
rad=rands(1,12,10)[part];//[1:0.5:12]
tang=rands(0,5,10)[part];//[1:10]
//some random 4D points
v = [
  for(i = [0: controlpoints])[rands(0, 100*sign(i), 1)[0], rands(0, 100*sign(i), 1)[0], rands(0, 100*sign(i), 1)[0], rands(1, thickest, 1)[0]]
];
module yourmodule(i){
    //anything in this module will be copeid and rotatdet along curve (v) at (detail) intevall
    for (j=[0:360/rad:360]){
    rotate([j,0,0])translate([0,0, bez2(i, v)[3]*0.5])
        
        // anything here//////////////
        scale([0.5,0.5,1])rotate([0, 90, 0])cube( [bez2(i, v)[3]/2*tang,bez2(i, v)[3]/2,bez2(i, v)[3]/2], $fn= fn,center=true);
    //////////////////
        }
    }  
  
  
  module headcase(){
//head trunk      
headv1=[[0,0,0,5],[3,0,1,5],[6,0,0.2,3.6],[9,0,-0.50,3.3],[12,0,-1,3.1],[13,0,-2.7,2.7],[14.9,0,-4.5,0.8],[14.9,0,-4.5,1.2],[14.9,0,-4.5,1.2]];
//upper tooth
      headv12=[[9,0,-1.3,2],[13.8,0,-4.0,1.1]];

//nose ridge
headv2=[[0,0,0,5],[-0.5,0,2,4.5],[4.1,0,2,5.3],[4.1,0,2,5.3],[8,0,2,0],[8,0,2,0],[11,0,1.1,2],[12.5,0,0,2],[13.5,0,-1.5,2],[14.5,0,-3.5,1.5]];
//eye ridge-nostrils
headv3=[[0,0,0,5],[0,0,0,5],[-1.7,2.2,4.2,2],[1.5,3.3,3.7,2],[4.9,3.7,4.3,1],[7.3,2.9,6.8,1],[4,-0.5,1.1,0],[10.5,2.4,-4,1],[12.5,3.7,5,1],[14.5,1.0,-2.5,0.2]];
      
headv4=[[0,0,0,5],[0,0,0,5],[-1.7,-2.2,4.2,2],[1.5,-3.3,3.7,2],[4.9,-3.7,4.3,1],[7.3,-2.9,6.8,1],[4,0.5,1.1,0],[10.5,-2.4,-4,1],[12.5,-3.7,5,1],[14.5,-1.0,-2.5,0.2]];
//Jaw
headv5=[[0,0,0,5],[0,2.0,0.5,4],[3,2.5,-0.2,3.5],[9,1,0.8,2.6],[9,1,0.8,2.6],[3,0,-6.55,2.2],[8,2,-3.5,1.6],[10,2,-4.6,1.4],[11.9,1,-5.5,1.0],[11.9,-0,-5.5,1.0]];
      
headv6=[[0,0,0,5],[0,-2.0,0.5,4],[3,-2.5,-0.2,3.5],[9,-1,0.8,2.6],[9,-1,0.8,2.6],[3,-0,-6.55,2.2],[8,-2,-3.5,1.6],[10,-2,-4.6,1.4],[11.9,-1,-5.5,1.0],[11.9,-0,-5.5,1.0]];
headv7=[[0,0,0,5],[0,0.0,0.5,4],[3,0,-0.2,3.5],[6,-0,0.2,2.6],[4,-0,-6.55,2.2],[8,-0,-3.5,1.6],[10,-0,-4.6,1.4],[11.9,-0,-5.5,1.0],[11.9,-0,-5.5,1.0]];
      
      bline(headv1,20);
      bline(headv12){
union(){   translate([0,0.6,-0.1])rotate([-40,180,15])cylinder(d=1,d2=0,h=1.3);
           translate([0,-0.6,-0.1])rotate([40,180,15])cylinder(d=1,d2=0,h=1.3);}
          };
      bline(headv2){union(){
          rotate([0,30,0])cylinder(d=1,d2=0,h=1.8);
          }};
      bline(headv3,20){translate([0,0,0.3])rotate([-65,60,0])cylinder(d=1,d2=0,h=1.5);};
      bline(headv4,20){translate([0,0,0.3])rotate([65,60,0])cylinder(d=1,d2=0,h=1.5);};
      bline(headv5,20){translate([0,0.1,0.3])rotate([-75,60,0])cylinder(d=1,d2=0,h=1.1);};
      bline(headv6,20){translate([0,-0.1,0.3])rotate([75,60,0])cylinder(d=1,d2=0,h=1.1);};
      bline(headv7,20)rotate([0,150,0])cylinder(d=1,d2=0,h=2);
      
      }
  
  headcase();
  
  
  
  
  
//main call with vector v abd three children
*bline(v){
cube(0.001);
*  union(){  
for (j=[0:360/rad:360]){
rotate([j,0,0])
translate([0,0, 1])
scale([0.5,0.5,1])rotate([0, 90, 0])cube( [1,1,1], $fn= fn,center=true);
}}

 union(){
 cube([5,.1,.1],center=true);
 cube([.1,.1,5],center=true);
     cube([.1,5,.1],center=true);}
 
 color("Red")union(){
 cube([5,.1,.1],center=true);
 cube([.1,5,.1],center=true);
      cube([.1,.1,5],center=true);}
 
 }
// Bline module
module bline(v) {
   
 // head pos 
 translate(t(bez2(1 , v))) rotate( t(bez2euler(1, v)))rotate([0,0,180])scale(bez2(1  , v)[3] )children(1);
   // head pos 
 translate(t(bez2(0 , v))) rotate( t(bez2euler(0, v)))rotate([0,0,0])scale(bez2(1  , v)[3] )children(2);
    translate(t(bez2(0 , v)))rotate(bez2euler (0,v))  scale(bez2(0  , v)[3] )  children(0);
     
    for(i = [detail: detail: 1]) {
      
translate(t(bez2(i  , v)))rotate(bez2euler (i,v))  scale(bez2(i  , v)[3] ) children(0);
        
      hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
          sphere(r = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]) sphere(r = bez2(i - detail, v)[3], $fn = fn);
      }
    }
  }
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
