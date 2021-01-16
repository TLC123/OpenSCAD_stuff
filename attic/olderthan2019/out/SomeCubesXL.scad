/*
SomeBalls.scad
Public Domain Code
Based on Metaballs By: William A Adams 	4 June 2011

This code is a simplified implementation of the 'metaball' and uses "Marching Cubes" to register the isosurface which is the interaction of the various balls. All Cubes are tested and a joint hull is generated of each corner that lies inside the threshold  of the metaball 



*/
Resolution = 3;//[5:5:50]
MinSubdivisions=0;//[2:1:10] 
MaxSubdivisions=7;//[2:1:10] 

// Smaller number larger blob


Diagnostic=false
;
Diagnostic2=false;

Oversize=0.2;
// List Format [[x,y,z,r],[x,y,z,r]]
//MyBallList=[[0, 0, 0, 15]];//Threshold = 1.95
balls=60;

kernel=15;
Thresh1 = 0.5;
bulb=kernel/(Thresh1);

echo(Thresh1,bulb);
MyBallList=[ for(i=[0:balls-1])Lotto(bulb)];
//%cylinder(100,1,1,center=true);
//%rotate([90,0,0])cylinder(100,1,1,center=true);
//%rotate([0,90,0])cylinder(100,1,1,center=true);
palette=[[219,184,208]/256,	[206,156,171]/256
,[118,72,100]/256,[124,48,28]/256,
	[171,109,58]/256,
	[242,169,130]/256,
	[255,176,156]/256,
	[255,217,192]/256];


     ColorList = [ for(i=[0:balls])(prndc()) ];

DrawMetaballs(MyBallList,Thresh1);
//color(rndc())for(i=[0:8]){translate([rands(0, 125, 1)[0],rands(15, 30, 1)[0],rands(15, 35, 1)[0]])rotate([0,90,0])sphere(20,$fn=12);}


module DrawMetaballs(BallList,Threshold) {

  if (Diagnostic2){for(i=[0:len(BallList)-1]){

      
 color("Blue",0.1) % translate([BallList[i][0],BallList[i][1],BallList[i][2]])  sphere(BallList[i][3]);
     
//color("RED",0.5) # translate([BallList[i][0],BallList[i][1],BallList[i][2]])  sphere(BallList[i][3]*Thresh1);
     }} 
 
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
//   %translate([x+(mx-x)/2,y+(my-y)/2,z+(mz-z)/2])cube(size,center=true);
DrawSubMetaballs(BallList,ColorList,Threshold,sx,sy,sz,size); 
    


 }
module DrawSubMetaballs(BallList,ColorList,Threshold,x,y,z,Size,i=1) {    
  //  echo(i,Size);
 h=Size*0.5  ;

suma =  BallField3D(x, y, z, BallList, len(BallList) - 1) ;
sumb =  BallField3D(x + Size, y, z, BallList, len(BallList) - 1) ;
sumc =  BallField3D(x, y + Size, z, BallList, len(BallList) - 1) ;
sumd =  BallField3D(x + Size, y + Size, z, BallList, len(BallList) - 1) ;
sume =  BallField3D(x, y, z + Size, BallList, len(BallList) - 1) ;
sumf =  BallField3D(x + Size, y, z + Size, BallList, len(BallList) - 1) ;
sumg =  BallField3D(x, y + Size, z + Size, BallList, len(BallList) - 1) ;
sumh =  BallField3D(x + Size, y + Size, z + Size, BallList, len(BallList) - 1) ;
sumcolor =lim31(1, ColorField3D(x, y, z, BallList,len(BallList)));
//+[255,224,189]/256

summin=max(
    abs(suma-Threshold),
    abs(sumb-Threshold),
    abs(sumc-Threshold),
    abs(sumd-Threshold),
    abs(sume-Threshold),
    abs(sumf-Threshold),
    abs(sumg-Threshold),
    abs(sumh-Threshold));
    
    sumsig=(sign(suma-Threshold)+
    sign(sumb-Threshold)+
    sign(sumc-Threshold)+
    sign(sumd-Threshold)+
    sign(sume-Threshold)+
    sign(sumf-Threshold)+
    sign(sumg-Threshold)+
    sign(sumh-Threshold));

    




if (  sumsig==-8&&summin>(1.3)/sqrt(2+i)&&i>MinSubdivisions) {if (Diagnostic&&z<0){echo (i,sumsig,summin,(1.3)/sqrt(2+i));translate([x, y, z]) %cube(Size);}} 
else if (  sumsig==8&&i>MinSubdivisions){
translate([x, y, z])  color(sumcolor) cube(Size);} 


else if(i<MaxSubdivisions ){ 
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

function Lotto(i) =lim31(30, [rands(-100,35, 1)[0],rands(-175, 175, 1)[0],(SC3(rands(0,1, 1)[0])-0.5)*75,i]);

//Field function
     function ColorField3D(x, y, z, BallSack, i,s=0) = (i <= 1) ? Powercolor(x, y, z, BallSack[s])*ColorList[s]:  ColorField3D(x, y, z, BallSack,i/2, s)+ ColorField3D(x, y, z, BallSack,i/2, s+i/2);

function Powercolor(x, y, z, Ball) = max(

SC3((Ball[3]-( len3([x - Ball[0], y - Ball[1] , z - Ball[2]]))) /Ball[3]),
0,
((1/(      len3([x - Ball[0], y - Ball[1] , z - Ball[2]])/0.1 +1)))

)  ;
function Proxyball(x, y, z, Ball) = (abs(x - Ball[0])  + abs(y - Ball[1]) + abs(z - Ball[2]) );
     
function Powerball(x, y, z, Ball) =max(

SC3((Ball[3]-( len3([x - Ball[0], y - Ball[1] , z - Ball[2]]))) /Ball[3]),
0,
((1/(      len3([x - Ball[0], y - Ball[1] , z - Ball[2]])/0.1 +1)))

)  ;

 //function Powerball(x, y, z, Ball) = min(SC3(Ball[3]/abs(x - Ball[0])),SC3(Ball[3]/abs(y - Ball[1])),SC3(Ball[3]/abs(z - Ball[2]))) ;
//function Powerball(x, y, z, Ball) =Ball[3]/  ( (abs(x - Ball[0])  + abs(y - Ball[1])  + abs(z - Ball[2]))/2.5);
// Recursive Field Evaluation
function BallField3D(x, y, z, BallSack,i,s=0) = (i <= 1) ? Powerball(x, y, z, BallSack[s]):  BallField3D(x, y, z, BallSack, i/2,s)+BallField3D(x, y, z, BallSack, i/2,s+i/2);
  //   function BallField3D(x, y, z, BallSack, i) = (i == 0) ? Powerball(x, y, z, BallSack[0]): max(Powerball(x, y, z, BallSack[i]) , BallField3D(x, y, z, BallSack, i - 1));
     
     

function rndc() = [round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2, round(rands(0, 2, 1)[0])/2];
function brndc(rgb) = [(rands(255-50, 255, 1)[0])/256, rands(224-40, 224+30, 1)[0]/256, rands(198-35, 198+35, 1)[0]/256];
function prndc() = palette[rands(0,len(palette)-1, 1)[0]];
     //interpolate
function inter(t,r,Threshold)=(t==r)?1:(t>Threshold)?(r<Threshold)? abs(Threshold-t)/abs(t-r) :0 :(r>Threshold)? abs(Threshold-t)/abs(t-r) :1 ;
// Recursive find min/max extremes
function findMax(v, select, i = 0) = ((i + 1) < len(v)) ? max(v[i][select] + (v[i][3]) , findMax(v, select, i + 1)): v[i][select] + (v[i][3]) ;
function findMin(v, select, i = 0) = ((i + 1) < len(v)) ? min(v[i][select] - (v[i][3]) , findMin(v, select, i + 1)): v[i][select] - (v[i][3]);
function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));

function clamp (a,b=0,c=10)=min(max(a,b),c);

function mix(a,b,h)=a*h+b*(1-h);function smin( a, b, k=0.2 )
=let( h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 ))mix( b, a, h ) - k*h*(1.0-h);