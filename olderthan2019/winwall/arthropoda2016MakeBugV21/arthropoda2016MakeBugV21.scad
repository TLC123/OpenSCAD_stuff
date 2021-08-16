fork = [1, 1,1];
//wing = 1234;
wing=(sanitycheck(blur(lerp(wing1(),wing2(),rnd()),0)));

//echo(str("   wings=",wing,";   "));
grove = [0,0,0]; //[0.5,0.5,0.5];
ring = [
  [0, 1, 1],
  [0, -1, 1],
  [0, -1, -1],
  [0, 1, -1]
];
tex = [1,2,3,4,5,6]; //[["extparams"],["distmap -x,-y,-z,x,y,z"]];

DNA = [base(), head(), ThoraxAbdomen()];
for (x=[0:100:0]){
for (y=[0:100:0]){
translate([x*3.5,y*3.5,0])rotate([0,0,180+rnd(-60,60)])MakeBug([base(), head(), ThoraxAbdomen()]);
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

rotate( [0,0,180]) Ltrunk(Bm,H);
Ltrunk(B,T);

  }
  ///////////////////End of MakeBug /////////////////////////////////////////
module Ltrunk (state,T){
lT1=len(T)-1;
for(i=[0:max(0,lT1)]){
color([0.25,0.5/(i+1),0.15]+rndc()*(0.5))
line(T[i][1][2],T[min(i+1,lT1)][1][2],T[i][1][0]);
L=T[i][2];

wing=T[i][4];
//echo(i,wing);
if(wing!=undef){color([0.35,0.5/(i+1),0.15]+rndc()*(0.5/(i/10+1)))translate(T[i][1][2]){
Makewing(wing);
mirror([0,1,0])
Makewing(wing);}
}
for(j=[0:max(0,max(0,len(L)-2))]){
color([0.25,0.250/(i+1),0.15]+rndc()*(0.75/(i/3+1))){
translate(T[i][1][2])rotate([0,90+T[i][1][1][1],0])rotate([L[0][1][1][0],0,L[0][1][1][2]])
{line(L[j][1][2],L[j+1][1][2],L[j][1][0]);
}

translate(T[i][1][2])mirror([0,1,0])rotate([0,90+T[i][1][1][1],0])rotate([L[0][1][1][0],0,L[0][1][1][2]])
{line(L[j][1][2],L[j+1][1][2],L[j][1][0]);
}

}
}


//echo(i,T[i][1]);
}}

module line(p1, p2,d=[1,1,1]) {
  hull() {
   translate(p1)  rotate([0,90+atan2( p2[0]-p1[0],p2[2]-p1[2] ),0])scale([min(d[1]*0.5,d[2]),d[1],d[2]])rotate([0,90,0])sphere(1,$fn=8);
     translate(p2) rotate([0, atan2(p2[0]-p1[0]),0],p2[2]-p1[2])scale([min(d[1]*0.75,d[2]),d[1]*0.75,d[2]]*0.75)rotate([0,90,0])sphere(1,$fn=8);
  }
}




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
[1,[[2,1,1],[0,120, 120],[0,0,0],grove,ring,tex],fork],
[4,[   [0.1, 1, 1], [0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[ [3.03893, 7.97785, 7.97785] ,[0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[ [4.85528, 12.61057, 12.61057] ,[0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[ [4.85528, 12.61057, 12.61057] ,[0,0,0],[7,8,9],grove,ring,tex],fork], 
[1,[  [3.03893, 8.97785, 8.97785],[0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[  [0.1, 0.1, 0.1] ,[0,0,0],[7,8,9],grove,ring,tex], fork]];    
  function  eye2()=[
[1,[[2,1,1],[0,120, 120],[0,0,0],grove,ring,tex],fork],
[8,[   [4, 2, 2], [0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[ [3.03893, 7.97785*1.5, 7.97785*2] ,[0,30,0],[7,8,9],grove,ring,tex],fork],
[1,[ [4.85528, 12.61057*1.5, 12.61057*2] ,[0,30,0],[7,8,9],grove,ring,tex],fork],
[1,[ [4.85528, 12.61057*1.5, 12.61057*2] ,[0,30,0],[7,8,9],grove,ring,tex],fork], 
[1,[  [3.03893, 8.97785*1.5, 8.97785*2],[0,30,0],[7,8,9],grove,ring,tex],fork],
[1,[  [0.1, 0.1, 0.1] ,[0,0,0],[7,8,9],grove,ring,tex], fork]];  

function  ant1()=[
[1,[[5,5,5],[40,150, 110],[100,0,0],grove,ring,tex],fork],
[1,[[15,3,3], [0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[[16,2,2],[0,15,0],[7,8,9],grove,ring,tex],fork],
[1,[[15, 2,2],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[2,[[6,2,2],[0,-45,0],[7,8,9],grove,ring,tex],fork], 
[2,[[7,2,2],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[3,[[5,2,2],[0,-7,0],[7,8,9],grove,ring,tex], fork]]; 
 function  ant2()=[
[1,[[5,5,5],[20,150, 110],[100,0,0],grove,ring,tex],fork],
[1,[[25,5,3], [0,0,0],[7,8,9],grove,ring,tex],fork],
[1,[[26,5,2],[0,15,0],[7,8,9],grove,ring,tex],fork],
[1,[[25, 3,2],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[3,[[16,2,2],[0,-45,0],[7,8,9],grove,ring,tex],fork], 
[6,[[17,1,2],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[3,[[5,1,2],[0,-7,0],[7,8,9],grove,ring,tex], fork]];  
function  bna()=[
[1,[[10,5,5],[-10,-135,intrnd(70,110)],[100,0,0],grove,ring,tex],fork],
[1,[[5,5,4], [0,45,0],[7,8,9],grove,ring,tex],fork],
[1,[[20,5,5],[0,35,0],[7,8,9],grove,ring,tex],fork],
[1,[[5, 5,4],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[1,[[20,5,5],[0,-45,0],[7,8,9],grove,ring,tex],fork], 
[1,[[10,5,4],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[3,[[5,3,3],[0,-7,0],[7,8,9],grove,ring,tex], fork]];
function  mandible()=[
[1,[[0,0,0],[40,-170, 110],[100,0,0],grove,ring,tex],fork],
[1,[[5,10,4], [0,30,0],[7,8,9],grove,ring,tex],fork],
[1,[[5,10,3],[30,30,0],[7,8,9],grove,ring,tex],fork],
[0,[[5, 13,3],[0,-55,0],[7,8,9],grove,ring,tex],fork],
[1,[[10,11,3],[0,-55,0],[7,8,9],grove,ring,tex],fork], 
[1,[[10,9,3],[0,-35,0],[7,8,9],grove,ring,tex],fork],
[1,[[5,5,2 ],[0,-47,0],[7,8,9],grove,ring,tex], fork]];

function bna2()=[
[0,[[0,1,1],[-45,-135,intrnd(70,110)],[100,0,0],grove,ring,tex],fork],
[0,[[0,1, 1],[0,0,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],grove,ring,tex],fork], 
[0,[[0,1,1],[0,0,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,0,0],[7,8,9],grove,ring,tex], fork]];
function bna3()=[
[rnd(2),[[rnd(3,15),4,1],[rnd(-90,90),-135,intrnd(70,110)],[7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,15),5, 8],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,60),8,18],[0,rnd(-60,-30),0],[7,8,9],grove,ring,tex], fork],
[rnd(2),[[rnd(3,15),4,8],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,60),5,8],[0,rnd(30,60),0], [7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,15),5,2],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex], fork],
[rnd(8),[[rnd(3,14),4,5],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],fork]]; 

function ThoraxAbdomen()=lerp(rndTA(),[
[1,[[1,4,12],[0,-90,0],[7,8,9],grove,ring,tex],bna2(),fork ],
[1,[[2,5, 18],[0,5,0],[7,8,9],grove,ring,tex],bna(),fork,lerp(wing1(),wing3(),rnd())],
[1,[[20,20,30],[0,-10,0],[7,8,9],grove,ring,tex], bna(),fork,lerp(wing1(),wing2(),rnd())],
[1,[[20,24,28],[0,-15,0],[7,8,9],grove,ring,tex],bna(),fork ],
[1,[[20,19,19],[0,15,0], [7,8,9],grove,ring,tex],lerp(bna2(),bna(),0),fork ],
[3,[[17,18,8],[0,50,0],[7,8,9],grove,ring,tex], lerp(bna2(),bna(),0.1),fork ],
[3,[[20,4,8],[0,25,0],[7,8,9],grove,ring,tex],lerp(bna2(),bna(),0.1),fork ]],rnd(0,0.5));



function head()=lerp(hrndTA(),[
[1,[[1,14,12],[0,-90,0],[7,8,9],grove,ring,tex],bna2(),fork],
[1,[[10,15,18],[0,25,0],[7, 8,9],grove,ring,tex],bna2(),fork],
[1,[[10,18,18],[0,-20,0],[7,8,9],grove,ring,tex],lerp(mandible(),bna2(),rnd(0,0.5)),fork],
[1,[[5, 18,18],[0,35,0],[7,8,9],grove,ring,tex],lerp(mandible(),bna2(),rnd(0,0.5)),fork],
[1,[[5,15,18],[0,65,0],[7,8,9],grove,ring,tex], lerp(ant2(),ant1(),1),fork],
[1,[[5,15,18],[0,00,0],[7,8,9],grove,ring,tex],lerp(ant2(),eye1(),1),fork], 
[1,[[5,22,23],[0,20,0],[7,8,9],grove,ring,tex],lerp(eye1(),eye2(),rnd()),fork]],rnd(0,0.5)); 
function base()=[[10,4,1], [0,-90,0],[7,8,9],grove,ring,tex];


function rndTA()=[
[rnd(4),[[rnd(1,1),4,1],[0,-90,0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork,],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-3,3),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork,lerp(wing2(),wing3(),rnd())],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-3,3),0],[7,8,9],grove,ring,tex], lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork,lerp(wing2(),wing3(),rnd())],
[rnd(5),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(6),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0], [7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-200,60),0],[7,8,9],grove,ring,tex], lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(4),[[rnd(3,60),rnd(3,60), rnd(3,60)],[0,rnd(-60,60),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna3(),rnd()),rnd()),fork]];
 function hrndTA()=[
[rnd(1),[[rnd(1,1),4,1],[0,-90,0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(3),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],lerp(mandible(),bna2(),rnd()),fork],
[rnd(3),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],lerp(mandible(),bna2(),rnd()),fork],
[rnd(2),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(4),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-30,30),0], [7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(3),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-200,60),0],[7,8,9],grove,ring,tex], lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(2),[[rnd(3,30),rnd(3,60), rnd(3,60)],[0,rnd(-60,60),0],[7,8,9],grove,ring,tex],lerp(eye2(),eye1(),rnd()),fork]]; 

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
  rotate(wings[0][1]) scale(wings[0][0]) {union(){
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
function wing1()=([[[23.215,20.95,20.95],[30,-10,-160]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.1],[1,0.1,0]],[[0,0,0],[0.1,0.15,-0.032],[0.349,0.35,0.032],[0.65,0.3,0.03264],[1,0.1,0]]],[[[0,-0.2,0],[0,0.7,0],[-0.059375,1.5875,0],[-0.2125,2.50619,0],[-0.412438,3.44975,0],[-0.49975,4.40587,0.003125],[-0.384,5.38413,0.015625],[-0.1185,6.38744,0.034375],[0.2,7.4,0.05]],[[0.45,-0.2,0],[0.55,0.7,0],[1.69687,0.98125,0],[2.62188,1.55625,0],[3.16875,2.41875,0],[3.35625,3.43125,0],[3.22187,4.5875,0],[2.3375,5.93125,0],[0.5,7.4,0]]]]);
/*//definedefaultwing2*/
function wing2()=let(m=rnd(5,15))sanitycheck([[[rnd(6)*m,rnd(6)*m,rnd(6)*m],[40,-20,-200]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.05],[1,0.1,0]],[[0,0,0],[0.05,0.15,-0.02],[0.2049,0.35,0.05],[0.65,0.3,0.05],[1,0.05,0]]],[[[0,-0.089,0],[0,0.54,0],[-0.179,1.619,0],[-0.359,2.609,0],[-0.54,3.419,0],[-0.54,4.32,0],[-0.449,5.219,0],[-0.27,6.209,0],[0,7.199,0]],[[0.359,-0.089,0],[0.359,0.54,0],[0.719,1.709,0],[1.289,2.879,0],[1.349,3.509,0],[1.439,4.229,0],[1.349,5.219,0],[1.169,6.209,0],[0.809,7.199,0]]]]);
/*//definedefaultwing3*/
function wing3()=sanitycheck([[[0,0,0],[60,-20,-260]],[[[0,0,0],[0.1,0.15,0.1],[0.349,0.35,0.1],[0.65,0.3,0.05],[1,0.1,0]],[[0,0,0],[0.05,0.15,-0.02],[0.2049,0.35,0.05],[0.65,0.3,0.05],[1,0.05,0]]],[[[0,-0.089,0],[0,0.54,0],[-0.179,1.619,0],[-0.359,2.609,0],[-0.54,3.419,0],[-0.54,4.32,0],[-0.449,5.219,0],[-0.27,6.209,0],[0,7.199,0]],[[0.359,-0.089,0],[0.359,0.54,0],[0.719,1.709,0],[1.289,2.879,0],[1.349,3.509,0],[1.439,4.229,0],[1.349,5.219,0],[1.169,6.209,0],[0.809,7.199,0]]]]);
/*/blurlengthprofile*/
function blur(inwing,c=1)=c<=0?inwing:let(wing=blur(inwing,c-1))[wing[0],wing[1],[concat([wing[2][0][0]],[wing[2][0][1]],[for(i=[2:len(wing[2][0])-2])(wing[2][0][max(i-1,0)]*0.5+wing[2][0][i]+wing[2][0][min(i+1,len(wing[2][0])-1)]*0.5)/2],[wing[2][0][len(wing[2][0])-1]]),concat([wing[2][1][0]],[wing[2][1][1]],[for(i=[2:len(wing[2][1])-2])(wing[2][1][max(i-1,0)]*0.5+wing[2][1][i]+wing[2][1][min(i+1,len(wing[2][1])-1)]*0.5)/2],[wing[2][1][len(wing[2][1])-1]])]];
/*/randsvector*0.1inZ*/
function w3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c*0.1,rands(-1,1,1)[0]]*c;/*/checkcross-profilesounderskinislowerthaoverskin*/function sanitycheck(v)=[v[0],[v[1][0],[let(l=len(v[1][1])-1)for(i=[0:l])[i==0||i==l?v[1][0][i][0]:v[1][1][i][0],i==0||i==l?v[1][0][i][1]:v[1][1][i][1],i==0||i==l?v[1][0][i][2]:min(v[1][1][i][2],v[1][0][i][2])*0.8]]],v[2]];/*roundeveryiteminanestedlisttoselectedprecition*/function roundlist(v,r=1)=len(v)==undef?v-(v%r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];/*multiplyeveryiteminanestedlistbyselecteddeviance*/function deepmutate(v,r=0.01)=len(v)==undef?v*rnd(1-r,1+r):len(v)==0?[]:[for(i=[0:len(v)-1])roundlist(v[i],r)];

///////////////// Common functions //////////////////////////////

/////////////////////////////////////Common

function  intrnd(a = 0, b = 1) = round((rands(min(a, b), max(a, b), 1)[0]));
function  rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
