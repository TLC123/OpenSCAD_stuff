kingshead();
module kingshead (){$fn=60;
rotate_extrude(){
scale(2)intersection(){
square(10);
offset(r=0.5)offset(r=-1)offset(r=0.5)
union(){difference(){
circle(10);
translate([33.5,-4,0])circle(30,$fn=120);
;
}
}
}
}
rotate([0,0,0])w();
rotate([0,0,90])w();
rotate([0,0,180])w();
rotate([0,0,270])w();
translate([0,0,26])sphere(3);
module w(){

v=[[10,0,0,1],[10,0,5,1],[20,0,10,1],[10,0,20,1],[0,0,5,1],[0,0,10,0]];
detail = 1/20;
fn=10;
translate([0,0,15])for(i = [detail: detail: 1]) {

  hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
        translate([0,-1,0])  sphere(d = bez2(i, v)[3], $fn = fn);
        translate([0,1,0])  sphere(d = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]){ 
translate([0,-1,0])sphere(d = bez2(i - detail, v)[3], $fn = fn);
translate([0,1,0])sphere(d = bez2(i - detail, v)[3], $fn = fn);}
sphere();      }

}}}

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