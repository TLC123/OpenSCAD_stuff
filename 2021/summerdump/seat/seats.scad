a=45+sin($t*360*4)*45;
$vpr=[45,-5,cos($t*360)*60];
rotate($vpr)translate([0,0,-1000])color("black")square(1000,true);
$vpt=[0,0,sin($t*360+180)*20];
$vpd=300+sin($t*360+90)*100;
seats=16;
rotate([0,-a,0]){
    if(a>27)%color("white",.3*(1-   $t)){
  cylinder(190,45,45,true);
    }
    color("lightgray",.5 ) translate([0,0,-150])  cylinder(100,45,45,true);
    color("lightgray" ) translate([0,0,-50])  cylinder(200,5,5,true);

   color("lightgray" ) difference(){
  translate([0,0,50])  hull(){
    cube([1,150,30],true);
  translate([0,0,70])  cube([1,50,30],true);}
  cylinder(150,50,3);
  }
     translate([0,0,-250]) color("lightgray" ) difference(){
  translate([0,0,50])  hull(){
    cube([1,200,30],true);
  translate([0,0,70])  cube([1,50,5],true);}
  cylinder(150,70,50);
  }
for(i=[-2:1])translate([0,0,i]*25) union(){
    %color("white",.2*$t)translate([0,0,-5])cylinder(.1,45,45,true);}
for(i=[-1:1])translate([0,0,i]*25)union(){
 
color(rands(0,1,3,i+1))for(r=[0:360/seats:360])
rotate(r)translate([33,0,0])rotate(-r)look_at([sin(a),0,cos(a)])rotate(r)seat();
color((rands(0,1,3,i+1)+[1,1,1])*.5)for(t=[0:360/(seats*.5):360]){r=t+(360/(seats*2));
  translate([0,0,0])rotate(r)translate([18,0,0])rotate(-r)look_at([sin(a),0,cos(a)])rotate(r)seat();
    }

}
}


module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));


function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);
module seat(){
    rotate(0){
   rotate([90,0,0]) linear_extrude(5,center=true,convexity=10)offset(.5,$fn=12)p();
  rotate([90,0,0])translate([0,0,2.5])  linear_extrude(1,center=true,convexity=10)offset(1,$fn=12)p();
  rotate([90,0,0])translate([0,0,-2.5])  linear_extrude(1,center=true,convexity=10)offset(1,$fn=12)p();
    }
}
module p(){rotate(45){
    
    
    translate([3.5,0])square([7.2,.1],true);
translate([-2,4])square([4.2,.1],true);
translate([0,2])square([.1,4],true);}}