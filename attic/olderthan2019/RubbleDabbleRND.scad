//
part = 1; //[1,2,3,4,5,6]
//Basic Width
W=133.35 ;
//Basic Breadth
B=66.675 ;
//Basic Height
H=25.4+rnd(-15,1);
//Basic Base
Base=3;
//Rubble Size
AvrgFeatureSize=20+rnd(-5,5);
//number of
cubes=60+rnd(-20,20);
//number of
spheres=0+rnd(4);
//number of
cylinders=3+rnd(4);
//number of
mounds=2+rnd(4);
//number of
craters=5;
//Height adjustments 
MoundHeightMultiplier=rnd(0.3)+0.1;
// cratering adjustments
Cratering=rnd(2);



Az=AvrgFeatureSize;

//basic base
 translate([-W/2,-B/2,0])cube([W,B,Base]);
// rubble and mounds  differenced with a upsideown rubble pile for some craterinf

difference(){
union(){
plate();
mounds();}


translate([0,0,H +Az])rotate([180+rnd(-14,14),+rnd(-14,14),0])scale([1.1,1.1,Cratering])plate();
}

// craters
 module caterplate(){
intersection(){
// extra bounded to make sure
 translate([-W *0.5,-B *0.5,0])cube([W ,B ,H+Az]);
union(){
 
//speres
if(craters>0)for(i=[1:craters]){
 
q2=rndc()*Az+[0.1,0.1,0.1];
 
 put()scale(q2 )sphere($fn=15,center=true);
}
 

 
 }


}
 
}  


// basic rubble pile
 module plate(){
intersection(){
// extra bounded to make sure
 translate([-W *0.5,-B *0.5,0])cube([W ,B ,H+Az]);
union(){

// cubes
if(cubes>0)for(i=[1:cubes]){
q1=rndc()*Az+[0.1,0.1,0.1];
put()scale(q1)kwaicube(center=true);
 
}
//speres
if(spheres>0)for(i=[1:spheres]){
 
q2=rndc()*Az+[0.1,0.1,0.1];
 
 put()scale(q2 )sphere($fn=15,center=true);
}
// cylinders
if(cylinders>0)for(i=[1:cylinders]){
 
q3=rndc()*Az+[0.1,0.1,0.1];
 put()scale(q3 )cylinder($fn=15,center=true);
 }

 
 }


}
 translate([-W/2,-B/2,0])cube([W,B,Base]);

}  

module mounds(){
// Mounds or minor hill
if(mounds>0)for(i=[1:mounds]){
intersection(){
 translate([-W *0.5,-B *0.5,0])cube([W ,B ,H+Az]); 
hull(){
 translate([-W *0.5,-B *0.5,0])cube([W ,B ,Base]);
translate([-W *0.85*0.5,-B*0.85 *0.5,0])translate([rnd(W*0.85) ,rnd(B*0.85) ,rnd(H*MoundHeightMultiplier)])scale(Az*0.5,Az*0.5,Base)cylinder(r1=1,r2=1,h=0.01, $fn=7);
 }
 }}}
// wrapper for  Ground module
module put ()
{
R=rndR();
v=v3rnd();
V=[v[0]*(W/2-H*0.3),v[1]*(B/2-H*0.3),abs(v[2])*H/4];
 

ground()  translate(V)rotate(R)children();
 
}

 
//  create a footprint  and join with feature 
module ground()
{
hull(){

intersection(){
 translate([-W*0.85*0.5,-B*0.85*0.5,0])cube([W*0.85,B*0.85,H+Az]);
children();
}
 linear_extrude(0.01)offset(r=H*0.2,$fn=7)intersection(){
 square([W-min(W*0.1,B*0.1),B-min(W*0.1,B*0.1)],center=true);
 projection() children();
}
}
}


 module kwaicube()
{
n=0.5;
hull(){
translate([-n,-n,-n])rotate(rndR())cube(0.05);
translate([ n,-n,-n])rotate(rndR())cube(0.05);
translate([ n, n,-n])rotate(rndR())cube(0.1);
translate([-n, n,-n])rotate(rndR())cube(0.05);
translate([-n,-n, n])rotate(rndR())cube(0.05);
translate([ n,-n, n])rotate(rndR())cube(0.05);
translate([ n, n, n])rotate(rndR())cube(0.1);
translate([-n, n, n])rotate(rndR())cube(0.05);
}

}

// helpers
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
//random number 

function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
//random color triplet or other use 0 to 1 triplet

function v3rnd(c=1) = [rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0]] * c;
//general use -1 to 1 triplet