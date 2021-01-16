////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
$vpd =650;
$vpr =[ 128.25, 59.50, 105.23 ];
//View translation
Vtr= [ 89.16, 66.01, 72.67 ];


seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
controlpoints=5;//[1:20]
thickest=15;//[5:50]
detail = 10; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v = [
  for(i = [0: controlpoints])[rands(0, 10*sign(i), 1)[0]+ i*40, rands(0, 200*sign(i), 1)[0], rands(0, 200*sign(i), 1)[0], rands(1, thickest, 1)[0]]
];

  
  
  
  
  
  
  
  
///call functions 
 
    
  
  
  
  
//main call
color(rndc())
  difference(){
  extrudeT(v,50){     
translate([0,2,0]) scale(0.2) rotate([0,90,0])cylinder(r=8,h=2);  
  };
  
  extrudeT(v,50,-0.005,1.005){ scale(0.2) sphere(1);     
translate([0,2,0]) scale(0.2) rotate([0,90,0])cylinder(r=7,h=2);  
  };
  
  
    DistrubuteAlong(v,10,-0.005,1.005){ scale(0.2) sphere(1);     
translate([0,2,0]) scale(0.2) rotate([90,0,0])cylinder(r=7,h=20,center=true);  
  };
  
  
  }
  
  color(rndc()) extrudeT(v,25){translate([0,-2,0]) scale(0.2)rotate([0,90,0]) sphere(4);  
  };
  
  
  color(rndc()) DistrubuteAlong(v,25){
translate([0,0,2]) scale(0.2)rotate([0,90,0]) sphere(4);  
  };
  
  color(rndc())  DistrubuteAlong(v,8){
translate([0,0,-4]) scale(0.2)rotate([0,90,0]) cube(5,center=true);  
  };color(rndc())
  
  
  extrudeT(v,25){
translate([0,0,-2]) scale(0.2) cube(5,center=true);  
    
    };
  
  
  
// Bline module
module extrudeT(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start+detail: detail: stop]) {
       for (j=[0:$children-1]) 
      hull() {
        translate(t(bez2(i,v))) rotate(bez2euler(i, v))scale(bez2(i  , v)[3]) children(j);
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v))scale(bez2(i- detail  , v)[3]) children(j);
      }
    }
  }

  
  
// Bline module
module DistrubuteAlong(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start: detail: stop-detail]) {
      
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           scale(bez2(i  , v)[3])children();
           
        
      
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
  module knuckel(){
rotate(rndR())translate([0,0,1])rotate([90,0,0])sphere(4,$fn=5)    ;
rotate(rndR())translate([0,0,1])rotate([90,0,0])sphere(3,$fn=5)    ;
rotate(rndR())translate([0,0,3])rotate([90,0,0])sphere(3,$fn=5)    ;
}
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];
function midpoint(start,end) = start + (end  - start )/2;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
