/*
SomeBalls.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of the 'metaball' and uses "Marching Cubes" to register the isosurface which is the interaction of the various balls. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 



*/
Resolution = 1;//[5:5:50]
MinSubdivisions=6;//[2:1:10] 
// Smaller number larger blob
Thresh1 = 0.7;// [1.5:0.01:2.5]
Diagnostic=false;
Oversize=0.5;
// List Format [[x,y,z,r],[x,y,z,r]]
//MyBallList=[[0, 0, 0, 15]];//Threshold = 1.95
balls=ceil(rands(1,20, 1)[0]);
echo(balls,20/sqrt(balls*2));
MyBallList=[ for(i=[0:balls-1])Lotto(20/sqrt(balls*2))];
cylinder(100,1,1,center=true);
rotate([90,0,0])cylinder(100,1,1,center=true);
rotate([0,90,0])cylinder(100,1,1,center=true);





DrawMetaballs(MyBallList,Thresh1);
//color(rndc())for(i=[0:8]){translate([rands(0, 125, 1)[0],rands(15, 30, 1)[0],rands(15, 35, 1)[0]])rotate([0,90,0])sphere(20,$fn=12);}


module DrawMetaballs(BallList,Threshold) {
     ColorList = [ for(i=[0:len(BallList)])lim31(1,rndc()) ];
 for(i=[0:len(BallList)-1]){
 
      
 color("Blue",0.1) % translate([BallList[i][0],BallList[i][1],BallList[i][2]])  sphere(BallList[i][3]);
     
 color("RED",0.5) # translate([BallList[i][0],BallList[i][1],BallList[i][2]])  sphere(BallList[i][3]*Thresh1);
     };
 
// boundary plus some extra
x=findMin(BallList, 0);
y= findMin(BallList, 1);
 z=findMin(BallList, 2);
 mx=findMax(BallList, 0);
my= findMax(BallList, 1);
 mz=findMax(BallList, 2);
size=max(mx-x,my-y,mz-z)*(1+Oversize);
sx=x+(mx-x)/2-size/2;
 sy=y+(my-y)/2-size/2;
 sz=z+(mz-z)/2-size/2;
     //%translate([x+(mx-x)/2,y+(my-y)/2,z+(mz-z)/2])cube(size,center=true);
DrawSubMetaballs(BallList,ColorList,Threshold,sx,sy,sz,size); 
    


 }
module DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z,Size,i=0) {    
  //  echo(i,Size);
 h=Size*0.5  ;
//echo( Ballprox3D(x+h ,y+h, z+h, BallList, len(BallList) - 1)<Size);

suma =  BallField3D(x, y, z, BallList, len(BallList) - 1) ;
sumb =  BallField3D(x + Size, y, z, BallList, len(BallList) - 1) ;
sumc =  BallField3D(x, y + Size, z, BallList, len(BallList) - 1) ;
sumd =  BallField3D(x + Size, y + Size, z, BallList, len(BallList) - 1) ;
sume =  BallField3D(x, y, z + Size, BallList, len(BallList) - 1) ;
sumf =  BallField3D(x + Size, y, z + Size, BallList, len(BallList) - 1) ;
sumg =  BallField3D(x, y + Size, z + Size, BallList, len(BallList) - 1) ;
sumh =  BallField3D(x + Size, y + Size, z + Size, BallList, len(BallList) - 1) ;
sumcolor =lim31(1, ColorField3D(x, y, z, BallList,ColorList, len(BallList) - 1));
//echo (suma);
    


// test for empty and full Cubes
/* if (i<MinSubdivisions && Ballprox3D(x+h ,y+h, z+h, BallList, len(BallList) - 1)<Size*2.5){ 
   
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y+h,z+h,h,i+1);
    
    }else {*/

if (  (suma <= Threshold && sumb <= Threshold && sumc <= Threshold && sumd <= Threshold && sume <= Threshold && sumf <= Threshold && sumg <= Threshold && sumh <=Threshold)&& Ballprox3D(x+h ,y+h, z+h, BallList, len(BallList) - 1)>Size*6 &&i>MinSubdivisions-2) {if (Diagnostic){translate([x, y, z]) %cube(Size);}} 
else if ( suma > Threshold && sumb > Threshold && sumc > Threshold && sumd > Threshold && sume > Threshold && sumf > Threshold && sumg > Threshold && sumh > Threshold&&i>MinSubdivisions-2){
translate([x, y, z])  color(sumcolor) cube(Size);} 


else if(i<MinSubdivisions ){ 
    h=Size*0.5  ;
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y+h,z+h,h,i+1);}
else { 

    // For every corner inside treshold make and mirror a corner piece, hull the lot.
   //echo
    //color(rndc())
    color(sumcolor)
    hull(){
        
        sab=inter(suma,sumb,Threshold)*Size;
sac=inter(suma,sumc,Threshold)*Size;
sae=inter(suma,sume,Threshold)*Size;
sba=inter(sumb,suma,Threshold)*Size;
sbd=inter(sumb,sumd,Threshold)*Size;
sbf=inter(sumb,sumf,Threshold)*Size;
sca=inter(sumc,suma,Threshold)*Size;
scd=inter(sumc,sumd,Threshold)*Size;
scg=inter(sumc,sumg,Threshold)*Size;
sdb=inter(sumd,sumb,Threshold)*Size;
sdc=inter(sumd,sumc,Threshold)*Size;
sdh=inter(sumd,sumh,Threshold)*Size;
sea=inter(sume,suma,Threshold)*Size;
seg=inter(sume,sumg,Threshold)*Size;
sef=inter(sume,sumf,Threshold)*Size;
sfh=inter(sumf,sumh,Threshold)*Size;
sfe=inter(sumf,sume,Threshold)*Size;
sfb=inter(sumf,sumb,Threshold)*Size;
sge=inter(sumg,sume,Threshold)*Size;
sgh=inter(sumg,sumh,Threshold)*Size;
sgc=inter(sumg,sumc,Threshold)*Size;
shg=inter(sumh,sumg,Threshold)*Size;
shf=inter(sumh,sumf,Threshold)*Size;
shd=inter(sumh,sumd,Threshold)*Size;
if (suma > Threshold){    translate([x, y, z])  Corner(sab,sac,sae);}
if (sumb > Threshold){    translate([x + Size, y, z])  Corner(-sba,sbd,sbf);}
if (sumc > Threshold){  translate([x, y + Size, z])  Corner(scd,-sca,scg);}
if (sumd > Threshold){    translate([x + Size, y + Size, z]) Corner(-sdc,-sdb,sdh);}
    
if (sume > Threshold){   translate([x, y, z + Size])  Corner(sef,seg,-sea);}
if (sumf > Threshold){   translate([x + Size, y, z + Size])  Corner(-sfe,sfh,-sfb);}
if (sumg > Threshold){    translate([x, y + Size, z + Size])  Corner(sgh,-sge,-sgc);}
if (sumh > Threshold){    translate([x + Size, y + Size, z + Size]) Corner(-shg,-shf,-shd);}
}
    }
}

//}




//Corner piece
module Corner(u=0.5,v=0.5,w=0.5) {scale([u,v,w])
polyhedron
    (points = [	       [0,0,0],[1,0,0],[0,1,0],[0,0,1],],      faces = [		  [0,0,1],[0,0,2],[0,0,3],[1,2,3]
		  ]
     );}
     
     function lim31(l, v) = v / len3(v) * l;
     function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// Random color

function Lotto(i) = [rands(-30,30, 1)[0],rands(-30, 35, 1)[0],(SC3(rands(0,1, 1)[0])-0.5)*50,i];

//Field function
     function ColorField3D(x, y, z, BallSack,Colorsack, i) = (i == 0) ? Powercolor(x, y, z, BallSack[0])*Colorsack[0]: Powercolor(x, y, z, BallSack[i])*Colorsack[i] + ColorField3D(x, y, z, BallSack,Colorsack, i - 1);

function Powercolor(x, y, z, Ball) = SC3(Ball[3]/( sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2]))))    ;
     function Proxyball(x, y, z, Ball) = (abs(x - Ball[0])  + abs(y - Ball[1]) + abs(z - Ball[2]) );
     
     function Powerball(x, y, z, Ball) =SC3(Ball[3]/( sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2])))) ;

 //function Powerball(x, y, z, Ball) = min(SC3(Ball[3]/abs(x - Ball[0])),SC3(Ball[3]/abs(y - Ball[1])),SC3(Ball[3]/abs(z - Ball[2]))) ;
//function Powerball(x, y, z, Ball) =Ball[3]/  ( (abs(x - Ball[0])  + abs(y - Ball[1])  + abs(z - Ball[2]))/2.5);
// Recursive Field Evaluation
function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): Powerball(x, y, z, BallSack[i]) + BallField3D(x, y, z, BallSack, i - 1);
  //   function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): max(Powerball(x, y, z, BallSack[i]) , BallField3D(x, y, z, BallSack, i - 1));
     
     
 function Ballprox3D(x, y, z, BallSack, i) = (i == 0) ? Proxyball(x, y, z, BallSack[0]): smin(Proxyball(x, y, z, BallSack[i]) , Ballprox3D(x, y, z, BallSack, i - 1));
function rndc() = [round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2];
     //interpolate
function inter(t,r,Threshold)=(t==r)?1:(t>Threshold)?(r<Threshold)? abs(Threshold-t)/abs(t-r) :0 :(r>Threshold)? abs(Threshold-t)/abs(t-r) :1 ;
// Recursive find min/max extremes
function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + abs(v[i][3]) + Resolution, findMax(v, select, i + 1)): v[i][select] + abs(v[i][3]) + Resolution;
function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - abs(v[i][3]) - Resolution, findMin(v, select, i + 1)): v[i][select] - abs(v[i][3]) - Resolution;
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));
function smin( a, b, k=0.2 )
=let( h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 ))mix( b, a, h ) - k*h*(1.0-h);
function clamp (a,b=0,c=10)=min(max(a,b),c);
function mix(a,b,h)=a*h+b*(1-h);