
//
//function AdjustBezier(v,l, precision = 0.001)=
//l<norm(v[0]-v[3])?let(e=echo("Cant be that short, sorry"))
//[v[0],v[0] ,v[3] ,v[3]]:
//let(
//current_lenght=len3bz(v),
//error=l/current_lenght,
//e=echo(l,current_lenght,error),
//new_v=[v[0],v[0]+(v[1]-v[0])*error,v[3]+(v[2]-v[3])*error,v[3]]
//)
//abs(1-error)>precision?AdjustBezier(new_v,l):v;
//


function len3bz(v, precision = 0.01, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + norm(bez2(t, v) - bez2(t + precision, v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for (i = [0: len(v) - 2]) v[i]* (t)  + v[i + 1] * (1 - t)
]): v[0]* (t)  + v[1]* (1 - t) ;

module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
 
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate(t(v[i])) sphere(0.05);
        translate(t(v[i - 1])) sphere(0.05);
      }
    }
}

module ShowBezier(v,steps=50) { // translate(t(v[0])) sphere(v[0][3]);
 step=1/steps;
    for (i = [-step:step:  1+step]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate(t(bez2(clamp(i), v) ))sphere(0.05);
        translate(t(bez2(clamp(i+step), v))) sphere(0.05);
      }
    }
}


function t(v) = [v.x, v.y, v.z];
function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function NormalizeBezierControl(v)=
[v[0],v[0]+UnitNormal (v[1]-v[0])  ,v[3]+UnitNormal (v[2]-v[3]) ,v[3]];
 
function UnitNormal (v)=v/max(norm(v),1e-32);// div by zero safe
function len3ct(p) =
  let( l = [for(i=[1:len(p)-1]) norm(p[i]-p[i-1]) ] )
  l*[for(i=[0:len(l)-1]) 1];
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper 
//
//for(r2=[0:360/16:360*1]){
//for(r=[0:360/30:360*1]){
//rr=r-360/30;
//MyBezier= ([[0,0,0],[sin(r),0,cos(r)],[sin(r2)+1,0,cos(r2)],[1,0,0]]);
//l=len3bz(MyBezier);
//MyBezier2= ([[0,0,0],[sin(rr),0,cos(rr)],[sin(r2)+1,0,cos(r2)],[1,0,0]]);
//l2=len3bz(MyBezier2);
////translate ([r/10,r/10])circle(0.1);
////translate ([r/10,(r/10)%36])circle(0.1);
//translate ([0,0,r2/10])
//
//linear_extrude(0.1)hull()
//{
//translate ([r/10,l*10])circle(0.1);
//translate ([(rr)/10,l2*10])circle(0.1);
//}
//
//}}

//color("red")for(r2=[0:360/16:360*1]){
//for(r=[0:360/30:360*1]){
//rr=r-360/30;
//MyBezier= ([[0,0,0],[sin(r),0,cos(r)],[sin(r2)+2,0,cos(r2)],[2,0,0]]);
//l=len3bz(MyBezier);
//MyBezier2= ([[0,0,0],[sin(rr),0,cos(rr)],[sin(r2)+2,0,cos(r2)],[2,0,0]]);
//l2=len3bz(MyBezier2);
////translate ([r/10,r/10])circle(0.1);
////translate ([r/10,(r/10)%36])circle(0.1);
//translate ([0,0,r2/10])
//linear_extrude(0.1)hull(){
//translate ([r/10,l*10])circle(0.1);
//translate ([(rr)/10,l2*10])circle(0.1);
//}
//
//}}

rotate([90,0,0])
for(x=[1.2]){
for(x2=[1.2]){
for(r2=[360:-360/16:0]){
for(r=[0:360/30:360*1]){

rr=r-360/30;
MyBezier= ([[0,0,0],[sin(r)*x,0,cos(r)*x],[sin(r2)*x2+1,0,cos(r2)*x2],[1,0,0]]);
l=len3bz(MyBezier);
MyBezier2= ([[0,0,0],[sin(rr)*x,0,cos(rr)*x],[sin(r2)*x2+1,0,cos(r2)*x2],[1,0,0]]);
l2=len3bz(MyBezier2);
//translate ([r/10,(r/10)%36])circle(0.1);
color([0,0,1])
translate ([0, 0,r2/10])
linear_extrude(0.1
)hull(){
translate ([r/10,l*10 ])circle(0.1);
translate ([(rr)/10,l2*10])circle(0.1);
}

color([1,0,0])
translate ([0,20,r2/10])
linear_extrude(0.1
)hull(){
translate ([r/10,(
//un(MyBezier[1]-MyBezier[0])*
un(MyBezier[2]-MyBezier[3])*
un(MyBezier[3]-MyBezier[0]) +

un(MyBezier[1]-MyBezier[0])*
//un(MyBezier[2]-MyBezier[3])*
un(MyBezier[0]-MyBezier[3]) +

un(MyBezier[1]-MyBezier[0])*
un(MyBezier[2]-MyBezier[3])
//un(MyBezier[3]-MyBezier[0]) +
)*2


  ])circle(0.1);

translate ([rr/10,(
//un(MyBezier2[1]-MyBezier2[0])*
un(MyBezier2[2]-MyBezier2[3])*
un(MyBezier2[3]-MyBezier2[0])+

un(MyBezier2[1]-MyBezier2[0])*
//un(MyBezier2[2]-MyBezier2[3])*
un(MyBezier2[0]-MyBezier2[3])+

un(MyBezier2[1]-MyBezier2[0])*
un(MyBezier2[2]-MyBezier2[3])
//un(MyBezier2[3]-MyBezier2[0])+



)*2 ])circle(0.1);}


}}

}}



//ShowControl(MyBezier) ; 
//ShowBezier(MyBezier) ;

//echo(l);
//echo(len3ct(MyBezier));
//echo(len3ct(MyBezier)/len3bz(MyBezier));
function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function un (v)=v/max(norm(v),1e-32);// div by zero safe
 