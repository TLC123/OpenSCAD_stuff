RING=12;
fork = [1, 1,1];

//echo(str("   wings=",wing,";   "));
xgrove = [0.15,0.65,0.75]; //[0.5,0.5,0.5];
logrove = [0.25,1,0.75]; //[0.5,0.5,0.5];
grove = [0.15,0.95,0.75]; //[0.5,0.5,0.5];
nogrove = [0,1,1]; //[0.5,0.5,0.5];
ring = [
  [0, 1, 1],
  [0, 0, 1.5], [0, -1, 1],
  [0, -1, -1],
  [0, 1, -1]
];
tex = [1,2,3,4,5,6]; //[["extparams"],["distmap -x,-y,-z,x,y,z"]];

//DNA = [base(), head(), ThoraxAbdomen()];
DNA =deepmutate( [base(), head(), ThoraxAbdomen()],0.02);
for (x=[0:100:0]){
for (y=[0:100:0]){
translate([x*3.5,y*3.5,0])rotate([0,0,180+rnd(-0,0)])MakeBug(DNA);
}}
//echo(DNA);
//////////////////////MakeBug/////////////////////////////////////
module MakeBug(dna) {
    B = dna[0];
    Bm = flipring(B);
ufdna1=unfold(dna[1]);
ufdna2=unfold(dna[2]);
    H = populatelegs(populate(ufdna1));
    T = populatelegs(populate(ufdna2));
union(){
rotate( [0,0,180]) Ltrunk(Bm,H);
Ltrunk(B,T);}

  }
  ///////////////////End of MakeBug /////////////////////////////////////////
module Ltrunk (state,T){
Points=trunk2mesh(state,T,0);
*for(i=[0:len(Points)-1])   {
color("Black")translate(Points[i])text(str(i),size=1);
}

Faces=concat(

[for(ii=[0:len(Points)-3])[min(len(Points)-1,max(0,ii)),min(len(Points)-1,max(0,ii+1)),min(len(Points)-1,max(0,ii+RING))]],
[for(ii=[-(RING-2):max(-(RING-2),len(Points)-(RING+1))])[min(len(Points)-1,max(0,ii)),min(len(Points)-1,max(0,ii+RING)),min(len(Points)-1,max(0,ii+(RING-1)))]]);
trunk=  c([Points,Faces]);
//polyhedron(trunk[0],trunk[1]);
trender(trunk);
lT1=len(T)-1;
for(i=[0:max(0,lT1)]){

L=T[i][2];

wing=(T[i][4]);

if(wing!=undef){color([0.35,0.5/(i+1),0.15]+rndc()*(0.5/(i/10+1)))
translate(T[i][1][2])translate([0,0,T[i][1][0][2]*0.5]){
wingcv=sanitycheck(wing);
//echo(wingcv);
translate([0,-T[i][1][0][2]*0.5,0])Makewing(wingcv);

mirror([0,1,0])translate([0,-T[i][1][0][2]*0.5,0])Makewing(wing);
}
}
if(len(L)>1){
LPoints=trunk2mesh(ringscale(T[i][2][4],[0.5,0.5,0.5]),L,0);
LFaces=concat(
[for(ii=[0:max(0,len(LPoints)-3)])[min(len(LPoints)-1,max(0,ii)),min(len(LPoints)-1,max(0,ii+1)),min(len(LPoints)-1,max(0,ii+8))]],
[for(ii=[-6:max(-6,len(LPoints)-9)])[min(len(LPoints)-1,max(0,ii)),min(len(LPoints)-1,max(0,ii+8)),min(len(LPoints)-1,max(0,ii+7))]]);
append=i>len(T)-3? cc([LPoints,LFaces]): cc([LPoints,LFaces]);
 translate(T[i][1][2])rotate([0,90+T[i][1][1][1],0])rotate([L[0][1][1][0],0,L[0][1][1][2]])
trender(append);

polyhedron(append[0],append[1]);
;
mirror([0,10]) translate(T[i][1][2])rotate([0,90+T[i][1][1][1],0])rotate([L[0][1][1][0],0,L[0][1][1][2]])
trender(append);

//polyhedron(append[0],append[1])
;
;
}



//echo(i,T[i][1]);
}}

module line(p1, p2,d=[1,1,1]) {
  hull() {
   translate(p1)  rotate([0,90+atan2( p2[0]-p1[0],p2[2]-p1[2] ),0])scale([min(d[1]*0.5,d[2]),d[1],d[2]])rotate([0,90,0])sphere(1,$fn=8);
     translate(p2) rotate([0, atan2(p2[0]-p1[0]),0],p2[2]-p1[2])scale([min(d[1]*0.75,d[2]),d[1]*0.75,d[2]]*0.75)rotate([0,90,0])sphere(1,$fn=8);
  }
}
function axflip(v)=[v[0],v[1],-v[2]];
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
function trunk2mesh(state,T,i=-1)=i==len(T)-1?
let (grove=T[i][1][3])
let(s=T[i][1][0])
let(r=lerp(T[min(len(T)-1,i+1)][1][1][1],T[i][1][1][1],0.5))
let(newring=ringtrans( ringrot(ringscale(T[i][1][4],s*grove[1]),r) ,T[i][1][2]),
points=concat( newring,[avrg(newring)]))
points
:
i==0? 
let(s=T[0][1][0])
let(newring=ringscale(T[0][1][4],axflip(s)),
points=concat([avrg(newring)+[1,0,0]],newring,trunk2mesh(state,T,i+1)))
points
:
let(s=T[i][1][0])
let (grove=T[i][1][3])
let(tr1=T[i][1][2])
let(tr2=lerp(T[i][1][2],T[min(len(T)-1,i+1)][1][2],0.2))
let(tr3=lerp(T[i][1][2],T[min(len(T)-1,i+1)][1][2],grove[2]))
let(r=lerp(T[min(len(T)-1,i+1)][1][1][1],T[i][1][1][1],0.5))
let(newring1=ringtrans( ringrot(ringscale(T[i][1][4],s*grove[1]),r) ,tr1))
let(newring=ringtrans( ringrot(ringscale(T[i][1][4],s),r) ,tr1))
let(newring2=ringtrans( ringrot(ringscale(T[i][1][4],s),r) ,tr2))
let(newring3=ringtrans( ringrot(ringscale(T[i][1][4],s),r) ,tr3),
points= grove[1]<0.7?concat( newring1,newring2,newring3,trunk2mesh(state,T,i+1)):concat( newring,trunk2mesh(state,T,i+1))
//concat( newring1,newring2,newring3,trunk2mesh(state,T,i+1))
)
points;



////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
///////////////////////////////// Unroll and Populate Full bodyMap
function flipring(B)= let(v=B[4])[B[0],B[1],B[2],B[3],[ for(i=[0:len(v)-1])[-v[i][0],v[i][1],v[i][2]] ],B[5]]; 
function populate(fdna,state=[ [0,0,0], [0,0,0], [0,0,0] ],i=0)=
let(l=len(fdna)-1,nextstate=popadd(state,fdna[i]))(i==l)?poppack(state,fdna[i]):concat(poppack(state,fdna[i]),populate(fdna,nextstate,i+1));
function populatelegs(f)=[
for(i=[0:len(f)-1])f[i][2]!=[]?[f[i][0],f[i][1],populate(f[i][2]),f[i][3],f[i][4]]:[f[i][0],f[i][1],f[i][2],f[i][3],f[i][4]] ]; 
function popadd(state,fdna)=(len(fdna)==0)?state:let(x=fdna[1][0][0],newdir=state[1]+fdna[1][1])[fdna[1][0],newdir,state[2]+[sin(newdir[1])*x,0,cos(newdir[1])*x]];

function poppack(state,fdna)= let(nextstate=popadd(state,fdna))[[fdna[0],
[nextstate[0],nextstate[1],nextstate[2],fdna[1][3],fdna[1][4],fdna[1][5]],fdna[2],fdna[3],fdna[4] ]]; 

function unfold(fdna)=concat(repete(fdna,0),repete(fdna,1),repete(fdna,2),repete(fdna,3),repete(fdna,4),repete(fdna,5),repete(fdna,6),repete(fdna,7),repete(fdna,8),repete(fdna,9),repete(fdna,10),repete(fdna,11),repete(fdna,12),repete(fdna,13),repete(fdna,14),repete(fdna,15));

function repete(v,i)= 
let(c=round(v[i][0])) 
c>0?
let(l=max(0,len(v)-1))
let(j=min(i+1,l))
[
 for(n=[1:c])[
v[i][0],
[
let(temp=lerp(v[i][1][0],v[j][1][0],n/c))

[v[i][1][0][0],temp[1],temp[2]], v[i][1][1]/c,
v[i][1][2],lerp(v[i][1][3],v[j][1][3],n/c),lerp(v[i][1][4],v[j][1][4],n/c),//ring lerp(v[i][1][5],v[j][1][5],n/c),
],
unfold(v[i][2]),//legs
v[i][3],
v[i][4]  //wings
]]:[];

/////////////////////// Defining Default Body Parts Function s
  function  eye1()=[
[1,[[1,0.1,0.1],[-65+rnd(-30,30),180+rnd(-30,30),rnd(10,30)],[0,0,0],nogrove,Xring(8,1,0),tex],fork],
[1,[   [1.1, 1, 1], [0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[1,[ [3.03893, 7.97785, 7.97785] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[1,[ [4.85528, 12.61057, 12.61057] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[1,[ [4.85528, 12.61057, 12.61057] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork], 
[1,[  [3.03893, 8.97785, 8.97785],[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[1,[  [0.1, 0.1, 0.1] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex], fork]];    
  function  eye2()=[
[1,[[1,0.11,0.11],[-65+rnd(-30,30),180+rnd(-30,30),rnd(10,30)],[0,0,0],nogrove,Xring(8,1,0),tex],fork],
[1,[   [1, 2, 2], [0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[1,[ [3.03893, 7.97785*1.5, 7.97785*2] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[0.5,[ [4.85528, 12.61057*1.5, 12.61057*2] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[0.5,[ [4.85528, 12.61057*1.5, 12.61057*2] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork], 
[1,[  [3.03893, 8.97785*1.5, 8.97785*2],[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex],fork],
[1,[  [0.1, 0.1, 0.1] ,[0,0,0],[7,8,9],nogrove,Xring(8,1,0),tex], fork]];  

function  ant1()=[
[1,[[5,5,5],[0+rnd(-10,50),180+rnd(10,50),rnd(50,150)],[100,0,0],xgrove,Xring(8),tex],fork],
[1,[[15,3,3], [0,30,0],[7,8,9],xgrove,Xring(8),tex],fork],
[1,[[16,2,2],[0,35,0],[7,8,9],xgrove,Xring(8),tex],fork],
[1,[[15, 2,2],[0,-15,0],[7,8,9],xgrove,Xring(8),tex],fork],
[2,[[6,2,2],[0,-45,0],[7,8,9],xgrove,Xring(8),tex],fork], 
[2,[[7,3,3],[0,-15,0],[7,8,9],xgrove,Xring(8),tex],fork],
[3,[[5,1,1],[0,-7,0],[7,8,9],xgrove,Xring(8),tex], fork]]; 
 function  ant2()=[
[1,[[5,5,5],[0+rnd(-10,50),rnd(170+rnd(10,50),190),rnd(50,150)],[100,0,0],xgrove,Xring(8),tex],fork],
[2,[[25,5,3], [0,30,0],[7,8,9],xgrove,Xring(8),tex],fork],
[2,[[26,5,2],[0,35,0],[7,8,9],xgrove,Xring(8),tex],fork],
[2,[[25, 3,2],[0,-15+rnd(-20,20),0],[7,8,9],xgrove,Xring(8),tex],fork],
[4,[[16,2,2],[0,-45+rnd(-20,20),0],[7,8,9],xgrove,Xring(8),tex],fork], 
[6,[[17,1,rnd(3,0.5)],[0,-15+rnd(-20,20),0],[7,8,9],xgrove,Xring(8),tex],fork],
[5,[[5,rnd(3,0.5),1],[0,-7,0],[7,8,9],xgrove,Xring(8),tex], fork]];  

function  mandible()=[
[1,[[10,5,0.1],[0+rnd(-20,20),180+45+rnd(-20,20),rnd(80,100)],[100,0,0],xgrove,Xring(8,1,0.5),tex],fork],
[1,[[10,7,4], [0,15,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[1,[[5,10,3],[0,-15,0],[7,8,9],logrove,Xring(8,1,0.5),tex],fork],
[1,[[7,5,3],[0,-55,0],[7,8,9],logrove,Xring(8,1,0.5),tex],fork],
[1,[[5,10,3],[0,-35,0],[7,8,9],logrove,Xring(8,1,0.5),tex],fork], 
[1,[[4,5,3],[0,-25,0],[7,8,9],logrove,Xring(8,1,0.5),tex],fork],
[1,[[1,3,0.5 ],[0,-17,0],[7,8,9],grove,Xring(8,1,0.5),tex], fork]];
function  bna(ii=1)=let(i=(ii-5)*-7)[
[1,[[10,5,2],[0+rnd(-20,20),220+rnd(-20,20),90+i+rnd(-20,20)],[100,0,0],xgrove,Xring(8,1,0.5),tex],fork],
[1,[[15,2,2], [0,55,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[1,[[60,2,2],[0,35,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[1,[[5, 2,2],[0,-35,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[1,[[60,2,2],[0,-45,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork], 
[rnd(2,5),[[10,rnd(5,8),1],[0,rnd(-30,55),0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[2,[[5,rnd(3,0.5),rnd(3,0.5)],[0,-17,0],[7,8,9],xgrove,Xring(8,1,0.5),tex], fork]];


function bna2(ii=1)=let(i=(ii-5)*-7)[
[0,[[0,1,1],[0+rnd(-20,20),220+i+rnd(-20,20),90+i+rnd(-20,20)],[100,0,0],xgrove,Xring(8,1,0.5),tex],fork],
[0,[[0,1, 1],[0,0,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork], 
[0,[[0,1,1],[0,0,0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[0,[[0,rnd(3,0.5),rnd(3,0.5)],[0,0,0],[7,8,9],xgrove,Xring(8,1,0.5),tex], fork]];
function bna3(ii=1)=let(i=(ii-5)*-7)[
[rnd(2),[[rnd(3,15),rnd(3,15),rnd(3,15)],[i+rnd(-20,20),220+rnd(-20,20),90+i+rnd(-20,20)],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[rnd(2),[[rnd(3,15),rnd(3,15),rnd(3,15)],[0,rnd(-30,30),0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[rnd(2),[[rnd(3,15),rnd(3,15),rnd(3,15)],[0,rnd(-60,-30),0],[7,8,9],xgrove,Xring(8,1,0.5),tex], fork],
[rnd(2),[[rnd(3,15),rnd(3,15),rnd(3,15)],[0,rnd(-30,30),0],[7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[rnd(2),[[rnd(3,15),rnd(3,15),rnd(3,15)],[0,rnd(30,60),0], [7,8,9],xgrove,Xring(8,1,0.5),tex],fork],
[rnd(2),[[rnd(3,15),rnd(3,15),rnd(3,15)],[0,rnd(-30,30),0],[7,8,9],xgrove,Xring(8,1,0.5),tex], fork],
[rnd(8),[[rnd(3,0.5),rnd(3,2),rnd(3,2)],[0,rnd(-30,30),0],[7,8,9],xgrove,Xring(8,1,0.5),Xring(8,1,0.5),tex],fork]]; 
function ThoraxAbdomen()=lerp(rndTA(),[
[1,[[5,6,6],[0,-90,0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna2(1),bna3(1),rnd()),fork ],
[1,[[2,5, 8],[0,5,0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna(2),bna3(2),rnd()),fork,wingmix(1)],
[1,[[20,20,30],[0,-10,0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex], lerp(bna(3),bna3(3),rnd()),fork,wingmix(1)],
[1,[[20,24,28],[0,-15,0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna(4),bna3(4),rnd()),fork ],
[1,[[20,19,19],[0,rnd(-15,15),0], [7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna2(5),bna3(5),rnd(0,0.1)),fork ],
[3,[[17,18,8],[0,rnd(-50,50),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex], lerp(bna2(6),bna3(6),rnd(0,0.1)),fork ],
[3,[[20,1,1],[0,rnd(-25,25),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna2(7),bna3(7),rnd(0,0.1)),fork ]],rnd());



function head()=lerp(hrndTA(),[
[1,[[1,6,6],[0,-90,0],[7,8,9],logrove,Xring(RING,1,0.3),tex],bna2(1),fork],
[1,[[4,8,8],[0,-15,0],[7, 8,9],logrove,Xring(RING,1,0.3),tex],bna2(1),fork],
[1,[[8,12,12],[0,35,0],[7,8,9],logrove,Xring(RING,1,0.3),tex],lerp(mandible(),bna2(1),rnd(0,0.5)),fork],
[1,[[10, 12,12],[0,35,0],[7,8,9],logrove,Xring(RING,1,0.3),tex],lerp(mandible(),bna2(1),rnd(0,0.5)),fork],
[1,[[10,12,13],[0,25,0],[7,8,9],logrove,Xring(RING,1,0.3),tex], lerp(ant2(),ant1(),rnd()),fork],
[1,[[3,15,15],[0,45,0],[7,8,9],logrove,Xring(RING,1,0.3),tex],lerp(eye2(),eye1(),1),fork], 
[1,[[3,2,2],[0,0,0],[7,8,9],xgrove,Xring(RING,1,0.3),tex],lerp(bna2(1),bna2(1),rnd()),fork]],rnd(0.2,0.9)); 


function base()=[[10,10,10], [0,-90,0],[0,0,0],grove,revXring(RING,1,0.3),tex];


function rndTA()=[
[rnd(4),[[rnd(1,1),6,6],[0,-90,0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna3(1),lerp(bna2(1),bna(1),rnd()),rnd()),fork,],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-3,3),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna3(),lerp(bna2(2),bna(2),rnd()),rnd()),fork,lerp(wing3(),wingmix(),rnd())],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-3,3),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex], lerp(bna3(3),lerp(bna2(3),bna(3),rnd()),rnd()),fork,lerp(wing3(),wingmix(),rnd())],
[rnd(5),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-10,10),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna3(4),lerp(bna2(4),bna(4),rnd()),rnd()),fork],
[rnd(6),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0], [7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna3(6),lerp(bna2(6),bna3(6),rnd(0.2)),rnd(0.8)),fork],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-200,60),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna3(6),lerp(bna2(6),bna3(6),rnd(0.2)),rnd(0.8)),fork],
[rnd(4),[[rnd(3,20),rnd(3,10), rnd(3,60)],[0,rnd(-60,60),0],[7,8,9],lerp(xgrove,logrove,rnd()),Xring(RING,1,0.5),tex],lerp(bna3(6),lerp(bna2(6),bna3(6),rnd(0.2)),rnd(0.8)),fork]];
 function hrndTA()=[
[rnd(1),[[rnd(1,1),6,6],[0,-90,0],[7,8,9],logrove,Xring(RING,1,0.5),tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(3),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],logrove,Xring(RING,1,0.5),tex],lerp(mandible(),bna2(),rnd()),fork],
[rnd(3),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],logrove,Xring(RING,1,0.5),tex],lerp(mandible(),bna2(),rnd()),fork],
[rnd(2),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],logrove,Xring(RING,1,0.5),tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(4),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0], [7,8,9],logrove,Xring(RING,1,0.5),tex],lerp(ant1(),lerp(ant2(),bna(),rnd()),rnd()),fork],
[rnd(3),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-200,60),0],[7,8,9],logrove,Xring(RING,1,0.5),tex], lerp(ant1(),lerp(eye1(),eye2(),0),1),fork],
[rnd(2),[[rnd(8,10),rnd(5,7), rnd(5,7)],[0,rnd(-60,60),0],[7,8,9],logrove,Xring(RING,1,0.5),tex],lerp(eye2(),eye1(),rnd()),fork]]; 
function wingmix(i)=(lerp(wing1(i),wing2(i),rnd()));


module Makewing(wings) {
  ////////////////////////////////module wing(wings) ///////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  overskin = concat([
      let (ws = wings[2], wp = wings[1], p1 = ws[0][0], p2 = ws[1][0], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1], wp[0][j][2] * d*4]]
    ],
[
      let (ws = wings[2], wp = wings[1], p1 = ws[0][1], p2 = ws[1][1], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1], wp[0][j][2] * d*4]]
    ],
    //mid
    [
      for (i = [2: len(wings[2][0]) - 2]) let (ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1] + wp[0][j][1] * d, lerp(p1, p2, wp[0][j][0])[2] + wp[0][j][2] * d]]
    ], [
      let (i = len(wings[2][0]) - 1, ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][0]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1] + wp[0][j][1] * d, lerp(p1, p2, wp[0][j][0])[2]]]
    ]);
 ////////////////////////////////module wing(wings) ///////////////////////////////////
 ///////////////////////////////////////////////////////////////////
  underskin = concat([
      let (ws = wings[2], wp = wings[1], p1 = ws[0][0], p2 = ws[1][0], d = len3(p1 - p2))[
        for (j = [0: len(wp[1]) - 1])[lerp(p1, p2, wp[1][j][0])[0], lerp(p1, p2, wp[1][j][0])[1], -wp[0][j][2] * d*4]]
    ],
[
      let (ws = wings[2], wp = wings[1], p1 = ws[0][1], p2 = ws[1][1], d = len3(p1 - p2))[
        for (j = [0: len(wp[1]) - 1])[lerp(p1, p2, wp[1][j][0])[0], lerp(p1, p2, wp[1][j][0])[1], -wp[0][j][2] * d*4]]
    ],

    //mid
    [
      for (i = [2: len(wings[2][0]) - 2]) let (ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wp[1]) - 1])[lerp(p1, p2, wp[1][j][0])[0], lerp(p1, p2, wp[1][j][0])[1] + wp[1][j][1] * d, lerp(p1, p2, wp[1][j][0])[2] + wp[1][j][2] * d]]
    ], [
      let (i = len(wings[2][0]) - 1, ws = wings[2], wp = wings[1], p1 = ws[0][i], p2 = ws[1][i], d = len3(p1 - p2))[
        for (j = [0: len(wings[1][1]) - 1])[lerp(p1, p2, wp[0][j][0])[0], lerp(p1, p2, wp[0][j][0])[1] + wp[0][j][1] * d, lerp(p1, p2, wp[0][j][0])[2]]]
    ]);
  ////////////////////////////////module wing(wings) ///////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  rotate([wings[0][1][0],0,0])rotate([0,wings[0][1][1],0])rotate([0,0,wings[0][1][2]]) rotate([0,0,180])scale(wings[0][0]) {union(){
    for (i = [0: len(overskin) - 2]) {
      wingringbridge(overskin[i], overskin[i + 1]);
   color("Red")   wingringbridge(underskin[i + 1],underskin[i]);
    }

    polyhedron(overskin[0], [
      [
        for (i = [0: len(overskin[0]) - 1]) i
      ]
    ]);
    polyhedron(underskin[0], [
      [
        for (i = [0: len(underskin[0]) - 1]) (len(underskin[0]) - 1)-i
      ]
    ]);}
  }
  module wingringbridge(r1, r2) {
    n = len(r1);
    
  for (i = [0: 1])
{ 
polyhedron([r1[i],r2[i],r2[i+1],r1[i+1] ],[[0,1,3],[1,2,3]]);
}
 for (i = [2: n - 2])
{ 
polyhedron([r1[i],r2[i],r2[i+1],r1[i+1] ],[[0,1,2],[0,2,3]]);
}
  };

  /////////////end of/module wing(wings)///////////////////////////////////
}


//////////////////////// Specilaty Wing Functions  /////////////////
/*definedefaultwing1*/
function wing1(i=0)=([[[23.215,20.95,20.95],[-60+rnd(-10,10),20+rnd(-10,10),120+rnd(-10,10)]],

[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.1],[1,0.1,0]],
[[0,0,0],[0.1,0.15,-0.032],[0.349,0.35,0.032],[0.65,0.3,0.03264],[1,0.1,0]]],

deepmutate([[[0,-0.2,0],[0,0.7,0],[-0.059375,1.5875,0],[-0.2125,2.50619,0],[-0.412438,3.44975,0],[-0.49975,4.40587,0.003125],[-0.384,5.38413,0.015625],[-0.1185,6.38744,0.034375],[0.2,7.4,0.05]],[[0.45,-0.2,0],[0.55,0.7,0],[1.69687,0.98125,0],[2.62188,1.55625,0],[3.16875,2.41875,0],[3.35625,3.43125,0],[3.22187,4.5875,0],[2.3375,5.93125,0],[0.5,7.4,0]]],0.3)]);
/*//definedefaultwing2*/
function wing2(i=0)=let(m=rnd(5,25))sanitycheck([[[rnd(1,6)*m,rnd(1,6)*m,6*m],[40 +rnd(-10,10),-20+rnd(-10,10),i+rnd(-10,10)]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.05],[1,0.1,0]],[[0,0,0],[0.05,0.15,-0.02],[0.2049,0.35,0.05],[0.65,0.3,0.05],[1,0.05,0]]],[[[0,-0.089,0],[0,0.54,0],[-0.179,1.619,0],[-0.359,2.609,0],[-0.54,3.419,0],[-0.54,4.32,0],[-0.449,5.219,0],[-0.27,6.209,0],[0,7.199,0]],[[0.359,-0.089,0],[0.359,0.54,0],[0.719,1.709,0],[1.289,2.879,0],[1.349,3.509,0],[1.439,4.229,0],[1.349,5.219,0],[1.169,6.209,0],[0.809,7.199,0]]]]);
/*//definedefaultwing3*/
function wing3(i=0)=let(m=40)sanitycheck([[[0.1,0.1,0.1],[0,0,-i]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.05],[1,0.1,0]],[[0,0,0],[0.05,0.15,-0.02],[0.2049,0.35,0.05],[0.65,0.3,0.05],[1,0.05,0]]],[[[0,-0.089,0],[0,0.54,0],[-0.179,1.619,0],[-0.359,2.609,0],[-0.54,3.419,0],[-0.54,4.32,0],[-0.449,5.219,0],[-0.27,6.209,0],[0,7.199,0]],[[0.359,-0.089,0],[0.359,0.54,0],[0.719,1.709,0],[1.289,2.879,0],[1.349,3.509,0],[1.439,4.229,0],[1.349,5.219,0],[1.169,6.209,0],[0.809,7.199,0]]]]);
/*/blurlengthprofile*/
function blur(inwing,c=1)=c<=0?inwing:let(wing=blur(inwing,c-1))[wing[0],wing[1],
[concat([wing[2][0][0]],[wing[2][0][1]],[for(i=[2:len(wing[2][0])-2])(wing[2][0][max(i-1,0)]*0.5+wing[2][0][i]+wing[2][0][min(i+1,len(wing[2][0])-1)]*0.5)/2],[wing[2][0][len(wing[2][0])-1]]),concat([wing[2][1][0]],[wing[2][1][1]],[for(i=[2:len(wing[2][1])-2])(wing[2][1][max(i-1,0)]*0.5+wing[2][1][i]+wing[2][1][min(i+1,len(wing[2][1])-1)]*0.5)/2],[wing[2][1][len(wing[2][1])-1]])]];
/*/randsvector*0.1inZ*/
function w3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c*0.1,rands(-1,1,1)[0]]*c;/*/checkcross-profilesounderskinislowerthaoverskin*/function 

sanitycheck(v)=[v[0],[v[1][0],[let(l=len(v[1][1])-1)

for(i=[0:l])

[i==0||i==l?v[1][0][i][0]:v[1][1][i][0],i==0||i==l?v[1][0][i][1]:

v[1][1][i][1],i==0||i==l?v[1][0][i][2]:min(v[1][1][i][2],v[1][0][i][2])*0.8]]],v[2]];/*roundeveryiteminanestedlisttoselectedprecition*/

function roundlist(v,r=1)=len(v)==undef?v-(v%r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];/*multiplyeveryiteminanestedlistbyselecteddeviance*/

function deepmutate(v,r=0.3)=len(v)==undef?v*rnd(1-r,1+r):len(v)==0?[]:[for(i=[0:len(v)-1])deepmutate(v[i],r)];

///////////////// Common functions //////////////////////////////

/////////////////////////////////////Common

function  intrnd(a = 0, b = 1) = round((rands(min(a, b), max(a, b), 1)[0]));
function  rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];

function ringtrans(v, t) = [
  for (i = [0: len(v) - 1])
    [
      v[i][0] + t[0],
      v[i][1] + t[1],
      v[i][2] + t[2]
    ]
];
function Xring(x = 8,r=0.7,kaos=0.05) = mirring([  for (i = [(360 / x) * 0.5: 360 / x: 359])[0, sin(i)*r,  cos(i)*r]+v3rnd(kaos)]);
function revXring(x = 8,r=1,) = [  for (i = [359: -360 / x: (360 / x) * 0.5])[0, sin(i)*r,  cos(i)*r]];
function ringrot(r = [
  [0, 0, 0]
], v) = [
  for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[
    inx * sin(v) - inz * cos(v),
    iny,
    inx * cos(v) + inz * sin(v)
  ]
];

function ringscale(v, s) = [
  for (i = [0: len(v) - 1])
    [
      v[i][0] * s[0],
      v[i][1] *s[1],
      v[i][2] * s[2]
    ]
];
function mirring(ring) =
let (n = floor((len(ring) - 1) / 2))

concat(
  [
    for (i = [0: n]) ring[i]
  ], [
    for (i = [0: n])[ring[n - i][0], -ring[n - i][1], ring[n - i][2]]
  ]
);
function avrg(v) = sumv(v, len(v) - 1) / len(v);

function sumv(v, i, s = 0) = (i == s ||i==undef? v[i] : v[i] + sumv(v, i - 1, s));




module trender(t){C0=(un(rndc())+[2,0,0]);C1=(un(rndc())+[2,2,0]);C2=(un(rndc())+[0,2,2]);for(i=[0:max(0,len(t[1])-1)]){ n=un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))polyhedron(t[0],[t[1][i]]);}}
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
function cc(V,n=1,curve=0.61803398875)=n<=0?V:n==1?let(w=V)let(ed=cccheck(ccQS (ccQS (ccQS (ccQS (ccde(w[1],len(w[0])-1),2),1),0),1)))let(nf=ccnf(ed))ccflip([ccnv(w,nf,curve),nf]):let(w=cc(V,n-1,curve))let(ed=cccheck(ccQS (ccQS (ccQS (ccQS (ccde(w[1],len(w[0])-1),2),1),0),1)))let(nf=ccnf(ed))ccflip([ccnv(w,nf,curve),nf]);
function ccnv(v,nf,curve)=let(nv=[for(i=[0:len(v[1])-1])(v[0][v[1][i][0]]+v[0][v[1][i][1]]+v[0][v[1][i][2]])/3])let(sfv=[for(i=[0:len(v[0])-1])avrg(ccfind(i,v[1],nv))])concat(lerp(v[0],sfv,curve),nv);
function ccnf(hf)=[for(i=[0:1:len(hf)-1])(i%2)==0?[hf[i][4],hf[(i+1)%len(hf)][2],hf[i][2]]:[hf[i][4],hf[(i-1)%len(hf)][2],hf[i][2]]];
function ccde(faces,points)=let(l=len(faces)-1) [for(i=[0:l])  let(f=faces[i])   for(j=[0:len(f)-1])     let(p=f[j],q=f[(j+1)%len(f)])       [min(p,q),max(p,q),i+points+1,p,q] //noduplicates 
];
function cccheck(ed)=concat([for(i=[0:len(ed)-1])if((ed[i][0]==ed[i-1][0]&&ed[i][1]==ed[i-1][1])||(ed[i][0]==ed[i+1][0]&&ed[i][1]==ed[i+1][1]))ed[i]]);
function ccfind(lookfor,faces,nv)=   [for(i=[0:len(faces)-1])if(faces[i][0]==lookfor||faces[i][1]==lookfor||faces[i][2]==lookfor)nv[i]];
function ccQS (arr,o)=!(len(arr)>0)?[]:let(  pivot =arr[floor(len(arr)/2)],  lesser =[for(y=arr)if(y[o] <pivot[o])y],  equal =[for(y=arr)if(y[o]==pivot[o])y],  greater=[for(y=arr)if(y[o] >pivot[o])y])concat(  ccQS (lesser,o),equal,ccQS (greater,o));
function wave(w,a=1,b=1)=[[for(i=[0:len(w[0])-1])let(x=w[0][i][0],y=w[0][i][1],z=w[0][i][2])w[0][i]+[sin((y+z)*b)*a,sin((z+x)*b)*a,sin((x+y)*b)*a]],w[1]];
function ccweld(v)=let(data=v[0])[v[0],[for(i=[0:len(v[1])-1])let(index1=v[1][i][0],index2=v[1][i][1],index3=v[1][i][2])concat(search(data[index1][0],data),search(data[index2][0],data),search(data[index3][0],data,1))]];
function ccflip(w)=[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]];
///////////////////////////commonfunction s/////////////////////////////
function un(v)=v/max(len3(v),0.000001)*1;
function p2n(pa,pb,pc)=
let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);
function avrg(v)=sumv(v,max(0,len(v)-1))/len(v);
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function len3(v)=len(v)==2?sqrt(pow(v[0],2)+pow(v[1],2)):sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
function v3rnd(c=1)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;
function roundlist(v,r=1)=len(v)==undef?v-(v%r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];
function limlist(v,r=1)= [for(i=[0:len(v)-1])[v[i][0],v[i][1],v[i][2]]];