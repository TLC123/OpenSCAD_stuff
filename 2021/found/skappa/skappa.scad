//Length
l=200;
//Width 
b=140;
//Height
h=90;
//Spout horizontal undercut 
piph=40;
//Spout vertical undercut 
pipv=30;
//Spout rounding 
pipr=5;
//Sides undercut
su=10;
//Rounding
radie=10;
//Wall thickness
vagg= 1;
//Handle lenght multiplier
hlm=1;
// Detail
fn=25;


//l=rnd(100,300);
//b=rnd(l/2,l);
//h=rnd(b/3,l);
//piph=rnd(1,l/3);
//pipv=rnd(1,l/3);
//su=rnd(0,rnd(0,b/2));
//pipr=rnd(1,min(l,b,h)/3);
//radie=rnd(1,min(l,b,h)/3);
//vagg= rnd(min(l,b,h)/30,min(l,b,h)/20);
// hlm=rnd(0.5,5);
 

//Handle
handtag=1;//[0,1]

/* [Hidden] */
 r=min(radie,h/4);

botten=[[0+radie,b/2-radie-su],[0+radie,-b/2+radie+su],[l-pipv-piph-radie,-b/2+radie+su],[l-pipv-radie,0],[l-pipv-piph-radie,b/2-radie-su]];

topp =[[0+radie,b/2-radie],[0+radie,-b/2+radie],[l-piph-radie,-b/2+radie] ,[l-piph-radie,b/2-radie]];
pip =[ [l-piph-radie,-b/2+radie],[l-pipr,0],[l-piph-radie,b/2-radie]];
 $fn=fn;
difference(){ 
union(){
if(handtag==1){
difference(){
union() {

 

minkowski(){ 
translate([-max(r*1.1,h/1.6180-r)*hlm+(r*3),0,h-r*0.38]*0.5-[vagg,0 ,0]){
rotate([90,0,0])linear_extrude(b/6,center=true)offset(r=r*0.9)offset(r=-r*0.9)square([max(r*1.1,h/1.6180-r)*hlm+r*3,max(radie,h-r)],center=true);}

sphere(r*0.3);}
}

union() {
translate([-max(r*1.1,h/1.6180-r)*hlm,0,h-r*0.38]*0.5-[vagg,0 ,0]){
rotate([90,0,0])linear_extrude(b,center=true)offset(r=r)offset(r=-r )square([max(r*1.1,h/1.6180-r-vagg)*hlm,max(r,h-r-vagg)],center=true);}}

minkowski(){ 

translate([-max(r*1.1,h/1.6180-r)*hlm,0,h-r*0.38]*0.5-[vagg,0 ,0]){
rotate([90,0,0])linear_extrude(b/6-vagg,center=true)offset(r=r*0.9)offset(r=-r*0.9)square([max(r*1.1,h/1.6180-r)*hlm,max(r,h-r)],center=true);}
 

sphere(r*0.3-vagg);}

}}


  union(){

hull()                                  {
minkowski(){translate([0,0,radie])linear_extrude(1e-16) polygon(botten);difference(){
sphere(radie);cylinder(radie,radie,radie);}
}

translate([0,0,h])linear_extrude(1e-16)offset(r=radie) polygon(topp);
translate([0,0,h])linear_extrude(1e-16)offset(r=pipr) polygon(pip);
}

 }

 }
 
union(){
hull()                                  {
minkowski(){translate([0,0,radie+vagg])linear_extrude(1e-16) offset(r= -vagg)polygon(botten);union(){
$fn=fn*2;
sphere(radie);cylinder(radie,radie,radie);}
}
translate([0,0,h])linear_extrude(1) offset(r=radie -vagg)polygon(topp);
translate([0,0,h])linear_extrude(1e-16)offset(r=pipr-vagg) polygon(pip);

}


}

  }


function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
