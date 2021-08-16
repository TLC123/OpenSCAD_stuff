/* [main] */
Distance=rnd(120,260);//
//sides
fn=20;//
/* [Top Rod(2)] */
Knuckle_Rotate=rnd(-45,45);//
Knuckle_Pitch=rnd(-45,45);//
Knuckle_Roll=rnd(-45,45);//
R2=rnd(10,40);//
L2=rnd(20,50);//
Nut_R2=R2*rnd(1.5,2);// 
Nut_H2=rnd(10,40);// 
Fat_R2=rnd(5,40);//
Fat_L2=rnd(5,40);//
Corner2=rnd(3,R2/3);//
/* [Bottom Rod(1)] */
R1=rnd(10,30);//
L1=rnd(20,50);//
L1offset=rnd(-50,50);//
Nut_R1=R1*rnd(1.5,2);// 
Nut_H1=rnd(10,40);//
//Fattening of Radius
Fat_R1=rnd(5,40);//
//Fattening of end caps
Fat_L1=rnd(5,40);//
//Corner Radius
Corner1=rnd(3,R1/3);//
Knuckle_RotateB=0;//
Knuckle_PitchB=0;//
Knuckle_RollB=rnd(-45,45);//
/* [Details] */


wristoffset1=1;//
wristoffset2=1;//

struttslimr1=0.9;//
struttsliml1=0.75;//
struttslimr2=0.9;//
struttsliml2=0.75;//
roundratio1=0.1;//
roundratio2=0.1;//
/* [Symmetry] */
Zmirror=round(rnd(5));//[1,0]

// Rotational duplication
Copies=max(0,floor(rnd(-1,rnd(8))));//
Ang=360/(max(2,Copies-round(rnd())));//
/* [Hidden] */

wrist1=Distance/3*wristoffset1;
wrist2=Distance/3*wristoffset2;
ic=(R1+R2)/2*roundratio1;//
oc=(Nut_R1+Nut_R2)/2*roundratio2;//
if(Zmirror==1)
{ 
 
union (){rotate([Ang,0,0])RodJob();mirror([0,0,1])rotate([Ang,0,0])RodJob(0,0,Knuckle_RollB);}}
else if(Copies!=0)
{union(){
Knuckle_Rotate1=0;//
Knuckle_Pitch1=0;//
Knuckle_Roll1=Knuckle_RollB;//

minang=max(Ang,1);
for (i=[0:minang:minang*Copies])rotate([i,0,0]) RodJob(0,0,Knuckle_RollB);}}
else {
 
RodJob(Knuckle_RotateB,Knuckle_PitchB,Knuckle_RollB);
}
module RodJob(Knuckle_Rotate1,Knuckle_Pitch1, Knuckle_Roll1){
difference(){
color("LightGrey")union(){
hull(){
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) translate([L1offset,0,0]) rotate([0,90,0])   Rcylinder(Nut_R1+Fat_R1,L1+Fat_L1,Corner1,fn);

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


translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,0]) rotate([0,90,0]) {Rcylinder(Nut_R2+Fat_R2,L2+Fat_L2,Corner2,fn);
}

}
}

rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) translate([L1offset,0,0])rotate([0,90,0]){#Dbell(R1,L1,Nut_R1,Nut_H1 ,ic,oc,fn);
} 

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate])   

rotate([0,90,0]){#Dbell(R2,L2,Nut_R2,Nut_H2 ,ic,oc,fn);}
}

rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) translate([L1offset,0,0])rotate([0,90,0]){%cylinder(L1*5,R1,R1,$fn=fn,center=true);} 

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate])   

rotate([0,90,0]){%cylinder(L2*5,R2,R2,$fn=fn,center=true);}
}
module Rcylinder(radius,lenght,rcorner,fn=32){
rotate_extrude(angle = 360, convexity = 4,$fn=fn) 
{
intersection(){
offset(r =rcorner)  {offset(r = -rcorner) {square([radius*2,lenght],center=true);}}
translate([max(lenght/2,radius),0,0])square([max(lenght,radius*2),max(lenght,radius*2)],center=true);
}
}
}module Dbell(r,l,nr,nl ,ic=1,oc=1,fn=32){
rotate_extrude(angle = 360, convexity = 4,$fn=fn) 
{
intersection(){
translate([nr,0,0])square([nr*2,l+nl*2],center=true);
offset(r =oc)  offset(r = -(ic+oc)) offset(r =ic)union(){
translate([0,0,0])square([r*2,l],center=true);
translate([0,l/2+nl*0.5,0])square([nr*2,nl],center=true);
translate([0,-(l/2+nl*0.5),0])square([nr*2,nl],center=true);}

//#offset(r =ic)  {offset(r = -ic) {square([r*2,l],center=true);}}
}
}
}
 
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
