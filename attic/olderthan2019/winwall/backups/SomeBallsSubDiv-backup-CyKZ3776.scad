/*
SomeBalls.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of the 'metaball' and uses "Marching Cubes" to register the isosurface which is the interaction of the various balls. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 

Future work : 
For obvious reasons linearly interpolated marching cubes. 
A more elegant cube solution than just hulling corners. 
Cube subdivision for speed up.

*/
Resolution = 15;
MinSubdivisions=4; // 
// Smaller number larger blob
Threshold = 1.65;// Smaller number larger blob
Diagnostic=false;
Oversize=0.2;
// List Format [[x,y,z,r],[x,y,z,r]]
MyBallList=[[50, 50, 50, 35],[25, 5, 5, 25],[95, 5, 75, 15]];//
DrawMetaballs(MyBallList);


module DrawMetaballs(BallList) {
// boundary plus some extra
size=max(findMax(BallList, 0),findMax(BallList, 1),findMax(BallList,2));
DrawSubMetaballs(BallList,findMin(BallList, 0)-(size*Oversize),findMin(BallList, 1)-(size*Oversize),findMin(BallList, 2)-(size*Oversize),size*(Oversize*2+1)); 
    


 }
module DrawSubMetaballs(BallList,x,y,z,Size,i=0) {    
    echo(i,Size);
union(){
suma = BallField3D(x, y, z, BallList, len(BallList) - 1);
sumb = BallField3D(x + Size, y, z, BallList, len(BallList) - 1);
sumc = BallField3D(x, y + Size, z, BallList, len(BallList) - 1);
sumd = BallField3D(x + Size, y + Size, z, BallList, len(BallList) - 1);
sume = BallField3D(x, y, z + Size, BallList, len(BallList) - 1);
sumf = BallField3D(x + Size, y, z + Size, BallList, len(BallList) - 1);
sumg = BallField3D(x, y + Size, z + Size, BallList, len(BallList) - 1);
sumh = BallField3D(x + Size, y + Size, z + Size, BallList, len(BallList) - 1);
// test for empty and full Cubes
AB=Size;

if (Size>pow(Resolution, MinSubdivisions)||i<MinSubdivisions) { 
    h=Size*0.5  ;
    DrawSubMetaballs(BallList,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,x+h,y+h,z+h,h,i+1);
    
    }else {
    
if (  suma <= Threshold && sumb <= Threshold && sumc <= Threshold && sumd <= Threshold && sume <= Threshold && sumf <= Threshold && sumg <= Threshold && sumh <= Threshold) {if (Diagnostic){translate([x, y, z]) %cube(Size);}} 
else if ( suma > Threshold && sumb > Threshold && sumc > Threshold && sumd > Threshold && sume > Threshold && sumf > Threshold && sumg > Threshold && sumh > Threshold) {
translate([x, y, z]) cube(Size);} 


else if(Size>Resolution){ 
    h=Size*0.5  ;
    DrawSubMetaballs(BallList,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,x+h,y+h,z+h,h,i+1);}
else { 
    
    // For every corner inside treshold make and rotate a corner piece, hull the lot.
 color(rndc())hull() {
if (suma > Threshold){
    translate([x, y, z]) rotate([0, 0, 0]) Corner(AB,0,0);}
if (sumb > Threshold){
    translate([x + Size, y, z]) rotate([0, 0, 90]) Corner();}
if (sumc > Threshold){
    translate([x, y + Size, z]) rotate([0, 0, -90]) Corner();}
if (sumd > Threshold){
    translate([x + Size, y + Size, z]) rotate([0, 0, 180])Corner();}
    
if (sume > Threshold){
    translate([x, y, z + Size]) mirror([0, 0, 1]) rotate([0, 0, 0]) Corner();}
if (sumf > Threshold){
    translate([x + Size, y, z + Size]) mirror([0, 0, 1]) rotate([0, 0, 90]) Corner();}
if (sumg > Threshold){
    translate([x, y + Size, z + Size]) mirror([0, 0, 1]) rotate([0, 0, -90]) Corner();}
if (sumh > Threshold){
    translate([x + Size, y + Size, z + Size]) mirror([0, 0, 1]) rotate([0, 0, 180]) Corner();}}
    }
}}}
//Corner piece
module Corner(u=0.5,v=0.5,w=0.5) {scale([u,v,w])
polyhedron
    (points = [
	       [0,0,0],[1,0,0],[0,1,0],[0,0,1],], 
     faces = [
		  [0,0,1],[0,0,2],[0,0,3],[1,2,3]
		  ]
     );}
//Field function
function Powerball(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2])));
// Recursive Field Evaluation
function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): Powerball(x, y, z, BallSack[i]) + BallField3D(x, y, z, BallSack, i - 1);
// Random color
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
// Recursive find min/max extremes
function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + v[i][3] + Resolution, findMax(v, select, i + 1)): v[i][select] + v[i][3] + Resolution;
function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - v[i][3] - Resolution, findMin(v, select, i + 1)): v[i][select] - v[i][3] - Resolution;