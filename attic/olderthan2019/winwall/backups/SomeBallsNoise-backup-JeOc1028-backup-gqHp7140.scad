/*
SomeBalls.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of the 'metaball' and uses "Marching Cubes" to register the isosurface which is the interaction of the various balls. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 



*/
Resolution =1;//[5:5:50]
MinSubdivisions=3;//[2:1:10] 
// Smaller number larger blob
Thresh1 = 0.5;// [1.5:0.01:2.5]
Diagnostic=false;
Oversize=-0.3;
// List Format [[x,y,z,r],[x,y,z,r]]
//MyBallList=[[50, 50, 50, -11],[25, 5, 5, 35],[95, 5, 75, 45],[-35, 5, 75, 55]];//Threshold = 1.95
MyBallList=[ for(i=[0:4])Lotto(i)];

DrawMetaballs(MyBallList,Thresh1);
//color(rndc())for(i=[0:8]){translate([rands(0, 125, 1)[0],rands(15, 30, 1)[0],rands(15, 35, 1)[0]])rotate([0,90,0])sphere(20,$fn=12);}


module DrawMetaballs(BallList,Threshold) {
 ColorList = [ for(i=[0:len(BallList)])rndc() ];
 
// boundary plus some extra
size=2;
DrawSubMetaballs(BallList,ColorList,Threshold,0,-size,size,size); 
    


 }
module DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z,Size,i=0) {    
  //  echo(i,Size);

suma = Sweetnoise (x, y, z);
sumb = Sweetnoise (x + Size, y, z );
sumc = Sweetnoise (x, y + Size, z);
sumd = Sweetnoise (x + Size, y + Size, z);
sume = Sweetnoise (x, y, z + Size);
sumf = Sweetnoise (x + Size, y, z + Size);
sumg = Sweetnoise (x, y + Size, z + Size);
sumh = Sweetnoise (x + Size, y + Size, z + Size);
sumcolor =lim31(1,[suma,suma,suma]);





// test for empty and full Cubes
 if (Size>pow(Resolution, MinSubdivisions)||i<MinSubdivisions) { 
    h=Size*0.5  ;
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y+h,z,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y+h,z,h,i+1);
    
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x,y+h,z+h,h,i+1);
    DrawSubMetaballs(BallList,ColorList,Threshold,x+h,y+h,z+h,h,i+1);
    
    }else {
    
if (  suma >=  Thresholdd && sumb >=  Thresholdd && sumc >=  Thresholdd && sumd >=  Thresholdd && sume >=  Thresholdd && sumf >=  Thresholdd && sumg >=  Thresholdd && sumh >=  Thresholdd) {if (Diagnostic){translate([x, y, z]) %cube(Size);}} 
else if ( suma > Threshold && sumb > Threshold && sumc > Threshold && sumd > Threshold && sume > Threshold && sumf > Threshold && sumg > Threshold && sumh > Threshold) {
translate([x, y, z])  color(sumcolor) cube(Size);} 


else if(Size>Resolution){ 
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
   //echo(sumcolor);
    color(sumcolor)hull(){
        
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
}}




//Corner piece
module Corner(u=0.5,v=0.5,w=0.5) {scale([u,v,w])
polyhedron
    (points = [	       [0,0,0],[1,0,0],[0,1,0],[0,0,1],],      faces = [		  [0,0,1],[0,0,2],[0,0,3],[1,2,3]
		  ]
     );}
     
     function lim31(l, v) = v / len3(v) * l;
     function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// Random color

function Lotto(i) = [rands(i*30,i*30+ 30, 1)[0],rands(0, 65, 1)[0],rands(0, 75, 1)[0],rands(21, 24, 1)[0]];

//Field function
     function ColorField3D(x, y, z, BallSack,Colorsack, i) = (i == 0) ? Powercolor(x, y, z, BallSack[0])*Colorsack[0]: Powercolor(x, y, z, BallSack[i])*Colorsack[i] + ColorField3D(x, y, z, BallSack,Colorsack, i - 1);

function Powercolor(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2]))); 
     
//function Powerball(x, y, z, Ball) = (Ball[3] / sqrt((x - Ball[0]) * (x - Ball[0]) + (y - Ball[1]) * (y - Ball[1]) + (z - Ball[2]) * (z - Ball[2])));
 function Powerball(x, y, z, Ball)   = Coldnoise (x,y,z);
// Recursive Field Evaluation
function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): Powerball(x, y, z, BallSack[i]) + BallField3D(x, y, z, BallSack, i - 1);
function rndc() = [round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2];
     //interpolate
function inter(t,r,Threshold)=(t==r)?1:(t>Threshold)?(r<Threshold)? abs(Threshold-t)/abs(t-r) :0 :(r>Threshold)? abs(Threshold-t)/abs(t-r) :1 ;
// Recursive find min/max extremes
function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + abs(v[i][3]) + Resolution, findMax(v, select, i + 1)): v[i][select] + abs(v[i][3]) + Resolution;
function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - abs(v[i][3]) - Resolution, findMin(v, select, i + 1)): v[i][select] - abs(v[i][3]) - Resolution;
function Coldnoise (x,y,z,seed=211448)= 
((19990303/(abs((x)%10)+1))
+(19990303/(abs((y)%10)+1) )
+(19990303/(abs((z)%10)+1) )
+(19990303/(abs(seed)+1) ))%1 ;
function Sweetnoise (x,y,z,seed=211448,scale=1)=tril( (SC3(x%1)), (SC3(y%1)), (SC3(z%1)),
    Coldnoise (floor(scale*x ) ,floor(scale*y ) ,floor(scale*z ) ,seed),
    Coldnoise (floor(scale*x  +1),floor(scale*y ) ,floor(scale*z ) ,seed),
    Coldnoise (floor(scale*x ) ,floor(scale*y +1) ,floor(scale*z ) ,seed),
    Coldnoise (floor(scale*x ) ,floor(scale*y ) ,floor(scale*z +1) ,seed),
    Coldnoise (floor(scale*x  +1),floor(scale*y ) ,floor(scale*z+1 ) ,seed),
    Coldnoise (floor(scale*x ) ,floor(scale*y +1) ,floor(scale*z +1) ,seed),
    Coldnoise (floor(scale*x  +1),floor(scale*y +1) ,floor(scale*z ) ,seed),
    Coldnoise (floor(scale*x +1) ,floor(scale*y  +1),floor(scale*z +1) ,seed));
    
   function SC3 (a)=    1-   (a * a * (3 - 2 * a));
function tril(x,y,z,V000,V100,V010,V001,V101,V011,V110,V111) =	
V111* (1 - x)* (1 - y)* (1 - z) +
V011* x *(1 - y) *(1 - z) + 
V101* (1 - x) *y *(1 - z) + 
V110* (1 - x) *(1 - y)* z +
V010* x *(1 - y)* z + 
V100* (1 - x)* y *z + 
V001* x *y* (1 - z) + 
V000* x *y *z;