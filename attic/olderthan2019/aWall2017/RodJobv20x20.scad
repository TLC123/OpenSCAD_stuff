/* [main] */
Distance=60;//
////sides
fn=30;//
/* [Top Rod(2)] */
Knuckle_Rotate=60;//
Knuckle_Pitch=25;//
Knuckle_Roll=0;//
 L2=50;//
Nut_R2=7;// 
Nut_H2=10;// 
//Fat_R2=10;//
//Fat_L2=10;//
Corner2=5;//
/* [Bottom Rod(1)] */
 L1=50;//
L1offset=-15;
Nut_R1=7;// 
Nut_H1=10;//
// 
////Corner Radius
Corner1=5;//
Knuckle_RotateB=0;//
Knuckle_PitchB=0;//
Knuckle_RollB=0;//
/* [Details] */
//
//
wristoffset1=0.96;//
wristoffset2=0.96;//
//
struttslimr1=0.79;//
struttsliml1=0.5;//
struttslimr2=0.79;//
struttsliml2=0.5;//
 

 
/* [Hidden] */
 
 
wrist1=Distance/3*wristoffset1;
wrist2=Distance/3*wristoffset2;
 {
 
RodJob(Knuckle_RotateB,Knuckle_PitchB,Knuckle_RollB);
}


module RodJob(Knuckle_Rotate1,Knuckle_Pitch1, Knuckle_Roll1){
difference(){
 color("lightblue")union(){
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) translate([L1offset,0,0]) rotate([0,90,0])   x20x20k(0,L1 );

hull(){
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) translate([L1offset,0,0]) rotate([0,90,0])   x20x20c(0,L1*struttsliml1  );

rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([L1offset,0,wrist1]) rotate([0,90,0])     Rcylinder(Nut_R1*struttslimr1,L1*struttsliml1,Corner1,fn);

color("LemonChiffon") rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([L1offset,0,wrist1]) rotate([0,90,0])     Rcylinder(Nut_R1*struttslimr1*0.5,L1*struttsliml1*0.5,0,fn);
}


hull(){ 
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([L1offset,0,wrist1]) rotate([0,90,0])     Rcylinder(Nut_R1*struttslimr1,L1*struttsliml1,Corner1,fn);

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2,L2*struttsliml2,Corner2,fn);
}
color("LemonChiffon")hull(){ 
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([L1offset,0,wrist1]) rotate([0,90,0])  Rcylinder(Nut_R1*struttslimr1*0.5,L1*struttsliml1*0.5,0,fn);

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2*0.5,L2*struttsliml2*+.5,0,fn);
}

hull(){
color("LemonChiffon")translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2*0.5,L2*struttsliml2*0.5,0,fn);

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2,L2*struttsliml2,Corner2,fn);


translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,0]) rotate([0,90,0]) {x20x20c(180,L2*struttsliml2);
}

}
 
translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,0]) rotate([0,90,0]) {x20x20k(180,L2);
}

}

  

 


}





rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) translate([L1offset,0,0])rotate([0,90,0]){%x20x20(L1*5 );} 


translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate])   
rotate([0,90,0]){%x20x20(L2*5 );}

}

module x20x20 (l,r,r,f,c)
{
linear_extrude(l,center=true) union(){
rotate(0) profile20();
rotate(90)profile20();
rotate(180)profile20();
rotate(270) profile20();
}}
module x20x20k (a,l,r,r,f,c)
{
linear_extrude(l,center=true)  
rotate(90+a) profilekey();
 
}
module x20x20c (a,l,r,r,f,c)
{
linear_extrude(l,center=true)  
rotate(90+a) profileconnect();
 }
module profile20(){
	polygon(points = [[0, 0], [-9.56066, 9.56066], [-8.5, 10], [-4.75, 10], [-3.1, 8], [-5.3, 8], [-5.3, 6.57279], [-2.72721, 4], [0, 4], [0, 2.5], [0, 2.5], [0, 4], [2.72721, 4], [5.3, 6.57279], [5.3, 8], [3.1, 8], [4.75, 10], [8.5, 10], [9.56066, 9.56066]]);
}
module profilekey(){
offset(0.5,$fn=20)offset(-0.5)	polygon(points = [[-4.75, 14], [-4.75, 10], [-3.1, 8], [-5.3, 8], [-5.3, 6.57279], [-2.72721, 4], [0, 4], [0, 2.5], [0, 2.5], [0, 4], [2.72721, 4], [5.3, 6.57279], [5.3, 8], [3.1, 8], [4.75, 10], [4.75, 14]]);

}
module profileconnect(){
offset(0.5,$fn=20)offset(-0.5)		polygon(points = [[-4.75, 14], [-4.75, 10], [-3.1, 8],   [3.1, 8], [4.75, 10], [4.75, 14]]);

}
module Rcylinder(radius,lenght,rcorner,fn=32){
rotate_extrude(angle = 360, convexity = 4,$fn=fn) 
{
intersection(){
offset(r =rcorner)  {offset(r = -rcorner) {square([radius*2,lenght],center=true);}}
translate([max(lenght/2,radius),0,0])square([max(lenght,radius*2),max(lenght,radius*2)],center=true);
}
}
} 
 
