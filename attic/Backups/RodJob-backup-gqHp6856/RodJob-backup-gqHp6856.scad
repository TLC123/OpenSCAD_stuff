/* [main] */
Distance=160;//
//sides
fn=30;//
/* [Top Rod(2)] */
Knuckle_Rotate=60;//
Knuckle_Pitch=45;//
Knuckle_Roll=0;//
R2=10;//
L2=40;//
Nut_R2=30;// 
Nut_H2=20;// 
Fat_R2=5;//
Fat_L2=5;//
Corner2=3;//
/* [Bottom Rod(1)] */
R1=10;//
L1=30;//
Nut_R1=20;// 
Nut_H1=20;//
//Fattening of Radius
Fat_R1=5;//
//Fattening of end caps
Fat_L1=5;//
//Corner Radius
Corner1=3;//
Knuckle_Rotate1=0;//
Knuckle_Pitch1=0;//
Knuckle_Roll1=0;//
/* [Details] */


wristoffset1=0.6;//
wristoffset2=0.6;//

struttslimr1=0.9;//
struttsliml1=0.75;//
struttslimr2=0.9;//
struttsliml2=0.75;//
roundratio1=0.1;//
roundratio2=0.1;//
/* [Symetry] */
Zmirror=0;//[1,0]
// Rotational duplication
Ang=60;//
Copies=6;//
/* [Hidden] */

wrist1=Distance/3*wristoffset1;
wrist2=Distance/3*wristoffset2;
ic=(R1+R2)/2*roundratio1;//
oc=(Nut_R1+Nut_R2)/2*roundratio2;//
if(Zmirror==1) union (){RodJob();mirror([0,0,1])RodJob();}
else{
for (i=[0:Ang*Copies])rotate([i,0,0]) RodJob();}
module RodJob(){
difference(){
color("LightGrey")union(){
hull(){
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1]) rotate([0,90,0])   Rcylinder(Nut_R1+Fat_R1,L1+Fat_L1,Corner1,fn);

rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([0,0,wrist1]) rotate([0,90,0])     Rcylinder(Nut_R1*struttslimr1,L1*struttsliml1,Corner1,fn);

color("Blue") rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([0,0,wrist1]) rotate([0,90,0])     Rcylinder(Nut_R1*struttslimr1*0.5,L1*struttsliml1*0.5,0,fn);
}


hull(){ 
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([0,0,wrist1]) rotate([0,90,0])  Rcylinder(Nut_R1*struttslimr1,L1*struttsliml1,Corner1,fn);

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2,L2*struttsliml2,Corner2,fn);
}
color("Blue")hull(){ 
rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])translate([0,0,wrist1]) rotate([0,90,0])  Rcylinder(Nut_R1*struttslimr1*0.5,L1*struttsliml1*0.5,0,fn);

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2*0.5,L2*struttsliml2*+.5,0,fn);
}

hull(){
color("Blue")translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2*0.5,L2*struttsliml2*0.5,0,fn);

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,-wrist2]) rotate([0,90,0]) Rcylinder(Nut_R2*struttslimr2,L2*struttsliml2,Corner2,fn);


translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate]) translate([0,0,0]) rotate([0,90,0]) {Rcylinder(Nut_R2+Fat_R2,L2+Fat_L2,Corner2,fn);
}

}
}

rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])rotate([0,90,0]){#Dbell(R1,L1,Nut_R1,Nut_H1 ,ic,oc,fn);
} 

translate([0,0,Distance])rotate([Knuckle_Roll,Knuckle_Pitch,Knuckle_Rotate])   

rotate([0,90,0]){#Dbell(R2,L2,Nut_R2,Nut_H2 ,ic,oc,fn);}
}

rotate([Knuckle_Roll1,Knuckle_Pitch1,Knuckle_Rotate1])rotate([0,90,0]){%cylinder(L1*5,R1,R1,$fn=fn,center=true);} 

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
 
