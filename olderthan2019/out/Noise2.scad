/*
Noise.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of "Marching Cubes" over Noise. A isosurface which is the interaction of the Noise field in tree octaves: half, one and four. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 

*/
Resolution = 0.5;
randseed=rands(0, 49709639, 1)[0];
Threshold = 0.45;// Smaller number lrger blob
function f(a)= floor(a/Resolution)*Resolution;
DrawSubMetaballs(  Threshold,-1,-10,-1,10) ;
function Octavenoice(x, y, z,seed=randseed) =let(SML=lim31(1,[20,60,380]))(Sweetnoise (x*4.1, y*4.1, z*4.1,seed)*SML[0]+Sweetnoise (x, y, z,seed)*SML[1]+  Sweetnoise (x/2.1, y/2.1, z/2.1,seed)*SML[2]);
    
    

module DrawSubMetaballs(  Threshold,xs,ys,zs,size,i=0) {
 

for (x = [xs: Resolution: xs+size]) {
for (y = [ys: Resolution: ys+size]) {
for (z = [zs: Resolution: zs+size]) {
    

suma = Octavenoice (x, y, z);
sumb = Octavenoice (x + Resolution, y, z );
sumc = Octavenoice (x, y + Resolution, z);
sumd = Octavenoice (x + Resolution, y + Resolution, z);
sume = Octavenoice (x, y, z + Resolution);
sumf = Octavenoice (x + Resolution, y, z + Resolution);
sumg = Octavenoice (x, y + Resolution, z + Resolution);
sumh = Octavenoice (x + Resolution, y + Resolution, z + Resolution);
sumcolor =[1-abs(Sweetnoise (x, y, z))%1,1-abs(Sweetnoise (x, y, z,94385))%1,1-abs(Sweetnoise (x, y, z,93658))%1];

     //echo(suma);
    // For every corner inside treshold make and mirror a corner piece, hull the lot.
  
    color(sumcolor)hull(){
  
        sab=inter(suma,sumb,Threshold)*Resolution;
sac=inter(suma,sumc,Threshold)*Resolution;
sae=inter(suma,sume,Threshold)*Resolution;
sba=inter(sumb,suma,Threshold)*Resolution;
sbd=inter(sumb,sumd,Threshold)*Resolution;
sbf=inter(sumb,sumf,Threshold)*Resolution;
sca=inter(sumc,suma,Threshold)*Resolution;
scd=inter(sumc,sumd,Threshold)*Resolution;
scg=inter(sumc,sumg,Threshold)*Resolution;
sdb=inter(sumd,sumb,Threshold)*Resolution;
sdc=inter(sumd,sumc,Threshold)*Resolution;
sdh=inter(sumd,sumh,Threshold)*Resolution;
sea=inter(sume,suma,Threshold)*Resolution;
seg=inter(sume,sumg,Threshold)*Resolution;
sef=inter(sume,sumf,Threshold)*Resolution;
sfh=inter(sumf,sumh,Threshold)*Resolution;
sfe=inter(sumf,sume,Threshold)*Resolution;
sfb=inter(sumf,sumb,Threshold)*Resolution;
sge=inter(sumg,sume,Threshold)*Resolution;
sgh=inter(sumg,sumh,Threshold)*Resolution;
sgc=inter(sumg,sumc,Threshold)*Resolution;
shg=inter(sumh,sumg,Threshold)*Resolution;
shf=inter(sumh,sumf,Threshold)*Resolution;
shd=inter(sumh,sumd,Threshold)*Resolution;
if (suma  < Threshold){    translate([x, y, z])  Corner(sab,sac,sae);}
if (sumb  < Threshold){    translate([x + Resolution, y, z])  Corner(-sba,sbd,sbf);}
if (sumc  < Threshold){  translate([x, y + Resolution, z])  Corner(scd,-sca,scg);}
if (sumd  < Threshold){    translate([x + Resolution, y + Resolution, z]) Corner(-sdc,-sdb,sdh);}
    
if (sume  < Threshold){   translate([x, y, z + Resolution])  Corner(sef,seg,-sea);}
if (sumf  < Threshold){   translate([x + Resolution, y, z + Resolution])  Corner(-sfe,sfh,-sfb);}
if (sumg  < Threshold){    translate([x, y + Resolution, z + Resolution])  Corner(sgh,-sge,-sgc);}
if (sumh  < Threshold){    translate([x + Resolution, y + Resolution, z + Resolution]) Corner(-shg,-shf,-shd);}
}


}}}}
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
function Coldnoise (x,y,z,seed=69940 )= 
((3754853343/((abs((floor(x+40)) ))+1))%1
+(3628273133/((abs((floor(y+44) ) ))+1) )%1
+(3500450271/((abs((floor(z+46 )) ))+1) )%1
+(3367900313/(abs(seed)+1) )/1)%1 ;

function Sweetnoise (x,y,z,seed=69840)=tril( SC3(x-floor(x)), (SC3(y-floor(y))), (SC3(z-floor(z))),
    Coldnoise ((x ) ,(y ) ,(z ) ,seed),
    Coldnoise ((x+1  ),(y ) ,(z ) ,seed),
    Coldnoise ((x ) ,(y+1 ) ,(z ) ,seed),
    Coldnoise ((x ) ,(y ) ,(z+1) ,seed),
    Coldnoise ((x  +1),(y ) ,(z+1 ) ,seed),
    Coldnoise ((x ) ,(y+1 ) ,(z+1 ) ,seed),
    Coldnoise ((x+1 ),(y+1) ,(z ) ,seed),
    Coldnoise ((x +1) ,(y+1),(z+1 ) ,seed));
    
   function SC3 (a)= (a * a * (3 - 2 * a))
   ;
function tril(x,y,z,V000,V100,V010,V001,V101,V011,V110,V111) =	
/*V111* (1 - x)* (1 - y)* (1 - z) +
V011* x *(1 - y) *(1 - z) + 
V101* (1 - x) *y *(1 - z) + 
V110* (1 - x) *(1 - y)* z +
V010* x *(1 - y)* z + 
V100* (1 - x)* y *z + 
V001* x *y* (1 - z) + 
V000* x *y *z
*/
V000*  (1 - x)* (1 - y)* (1 - z) +
V100*  x *(1 - y) *(1 - z) + 
V010*  (1 - x) *y *(1 - z) + 
V001*  (1 - x) *(1 - y)* z +
V101*  x *(1 - y)* z + 
V011*  (1 - x)* y *z + 
V110*  x *y* (1 - z) + 
V111*  x *y *z

;
function Octavenoice(x, y, z,seed=randseed) =let(SML=lim31(1,[20,60,380]))(Sweetnoise (x*4.1, y*4.1, z*4.1,seed)*SML[0]+Sweetnoise (x, y, z,seed)*SML[1]+  Sweetnoise (x/2.1, y/2.1, z/2.1,seed)*SML[2]);
    