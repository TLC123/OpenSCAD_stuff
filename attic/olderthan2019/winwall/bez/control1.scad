////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed

seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
controlpoints=2;//[1:20]
thickest=15;//[5:50]
detail = 10; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v = [
  [ -100, 0,100+rnd(30), 10]
,[0,0,0,10],  [ 100, 0,100+rnd(30), 10]
];

 * color ("blue")ShowControl(v);
  
  test= [ for( i=[1:len(v)-2])  let (
      n1=v[i]-un(un(v[i+1]-v[i])+un(v[i]-v[i-1]))*64,
      n2 = v[i], 
      n3 = v[i]-un(un(v[i+1]-v[i])+un(v[i]-v[i-1]))*-64
  )   [n1, n2, n3]  ];
 

   
  last=len(v)-1;
  
 
 nv=  concat(
  [v[0]],
  [v[0]-un(v[0]-v[1])*64],
  
  test[0],
  
  
 
  [v[last]-un(v[last]-v[last-1])*64], [v[last]] );

  echo(nv,len(nv),len(v));
///call functions 
 
    
  
  
  
  
//main call
color ("red")ShowControl(nv);
 color(rndc()) DistrubuteAlong(nv,25){
translate([0,0,0]) scale(0.2)rotate([0,90,0]) sphere(4);  
  };
  

  
  
// Bline module
module DistrubuteAlong(v,d=8,start=0,stop=1) {
         detail=1/d;
    for(i = [start+detail: detail: stop]) {
      
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           
        scale(bez2(i  , v)[3])
        children();
           
        
      
    }
  }
  //The recusive
  
module ShowControl(v)  
  {   translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
         translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(5);
              translate(t(v[i-1])) sphere(5);
              }          }
      }  
  
  
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim31(l, v) = v / len3(v) * l;
function un(v) = v / len3(v) * 1;

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
function rnd(i=1)=rands(-i,i,1)[0];