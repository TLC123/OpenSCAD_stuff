$fn=60;


v=[[-3.5,8.5,6,2],[-4,8.5,2,2],[0,11,2,2],[4,8.5,2,2],[3.5,8.5,6,2]];
v2=[[-3.5,8.5,6,2],[-4,8.5,2,1],[0,11,2,1],[4,8.5,2,1],[3.5,8.5,6,2]];
v3=[[-3.5*0.9,8.5*0.9,0,1],[-4*0.9,8.5*0.9,0,1],[0,10,0,1],[4*0.9,8.5*0.9,0,1],[3.5*0.9,8.5*0.9,0,1]];
translate([0,0,10 ])sphere(2);
for (a=[0:45:330]){
rotate([0,0,a ]){
rotate([0,0,22.5])translate([10,0,7.5])rotate([0,35,0])sphere(1.4);

detail = 1/20;
fn=60;
for(i = [detail: detail: 1]) {

  hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v)[3], $fn = fn);
      }
 hull() {
        translate([bez2(i, v2)[0], bez2(i, v2)[1], bez2(i, v2)[2]]) rotate(bez2euler(i, v2)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v2)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v2))) rotate(bez2euler(i - detail, v2)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v2)[3], $fn = fn);
      
     translate([bez2(i, v3)[0], bez2(i, v3)[1], bez2(i, v3)[2]]) rotate(bez2euler(i, v3)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v3)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v3))) rotate(bez2euler(i - detail, v3)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v3)[3], $fn = fn);
  sphere(1);}

v41=[bez2(i, v2),[-0,0,5,1],[0,0,10,2],[0,0,10,3]];
v42=[bez2(i-detail, v2),[-0,0,5,1],[0,0,10,2],[0,0,10,3]];
  for(ii = [detail: detail: 1]) {
      i=(ii);
 
        
      hull() {
        translate([bez2(i, v41)[0], bez2(i, v41)[1], bez2(i, v41)[2]]) rotate(bez2euler(i, v41)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v41)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v41))) rotate(bez2euler(i - detail, v41)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v41)[3], $fn = fn);
      
     translate([bez2(i, v42)[0], bez2(i, v42)[1], bez2(i, v42)[2]]) rotate(bez2euler(i, v42)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v42)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v42))) rotate(bez2euler(i - detail, v42)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v42)[3], $fn = fn);
  sphere(1);}
    }}
}
}


module bline(v) {
detail = 1/10; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
     translate([bez2(0  , v)[0],bez2(0  , v)[1],bez2(0  , v)[2]])rotate(bez2euler (0,v))           yourmodule(0,rad);
    for(ii = [detail: detail: 1]) {
      i=(ii);
 
        
      hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v)[3], $fn = fn);
      
  
  }
    }
  }

module yourmodule(i,rad){
    //anything in this module will be copeid and rotatdet along curve (v) at (detail) intevall
    for (j=[0:360/rad:360]){
    rotate([j,0,0])translate([0,0, bez2(i, v)[3]*0.5])
        
        // anything here//////////////
    *    scale([0.5,0.5,1])rotate([0, 90, 0])cube( [bez2(i, v)[3]/2*tang,bez2(i, v)[3]/2,bez2(i, v)[3]/2], $fn= fn,center=true);
    //////////////////
        }
    }  
module ShowControl(v)  
  {  // translate(t(v[0])) sphere(v[0][3]);
      for(i=[1:len(v)-1]){
       // vg  translate(t(v[i])) sphere(v[i][3]);
          hull(){
              translate(t(v[i])) sphere(1);
              translate(t(v[i-1])) sphere(1);
              }          }
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
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(i,n=0)=n>0?let(x=gauss(i,n-1))x+(x-SC3(x)):let(x=i)x+(x-SC3(x));