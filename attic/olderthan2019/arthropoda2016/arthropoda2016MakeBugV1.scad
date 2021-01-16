fork = ["fork", "forkdata"];
wing = ["wingdata"];
grove = "grove"; //[0.5,0.5,0.5];
ring = [
  [0, 1, 1],
  [0, -1, 1],
  [0, -1, -1],
  [0, 1, -1]
];
tex = "tex"; //[["extparams"],["distmap -x,-y,-z,x,y,z"]];

DNA = [base(), head(), ThoraxAbdomen()];
MakeBug(DNA);
//////////////////////MakeBug/////////////////////////////////////
module MakeBug(dna) {
    B = dna[0];
    Bm = flipring(B);
    H = populatelegs(populate(unfold(dna[1])));
    T = populatelegs(populate(unfold(dna[2])));
rotate( [0,0,180]) Ltrunk(Bm,H);
Ltrunk(B,T);

  }
  ///////////////////End of MakeBug /////////////////////////////////////////
module Ltrunk (state,T){
for(i=[0:len(T)-2]){
line(T[i][1][2],T[i+1][1][2]);
L=T[i][2];

for(j=[0:max(0,len(L)-2)]){
color(rndc()){
translate(T[i][1][2])rotate([0,90+T[i][1][1][1],0])rotate([L[0][1][1][0],0,L[0][1][1][2]])
{line(L[j][1][2],L[j+1][1][2]);
}

translate(T[i][1][2])mirror([0,1,0])rotate([0,90+T[i][1][1][1],0])rotate([L[0][1][1][0],0,L[0][1][1][2]])
{line(L[j][1][2],L[j+1][1][2]);
}

}
}


//echo(i,T[i][1]);
}}

module line(p1, p2) {
  hull() {
    translate(p1) sphere(1);
    translate(p2) sphere(1);
  }
}




///////////////////////////////// Unroll and Populate Full bodyMap
function flipring(B)= let(v=B[4])[B[0],B[1],B[2],B[3],[ for(i=[0:len(v)-1])[-v[i][0],v[i][1],v[i][2]] ],B[5]]; function
populate(fdna,state=[ [0,0,0], [0,0,0], [0,0,0] ],i=0)=
let(l=len(fdna)-1,nextstate=popadd(state,fdna[i]))(i==l)?poppack(state,fdna[i]):concat(poppack(state,fdna[i]),populate(fdna,nextstate,i+1));
function populatelegs(f)=[
for(i=[0:len(f)-1])f[i][2]!=[]?[f[i][0],f[i][1],populate(f[i][2]),f[i][3]]:[f[i][0],f[i][1],f[i][2],f[i][3]] ]; function
popadd(state,fdna)=(len(fdna)==0)?state:let(x=fdna[1][0][0],newdir=state[1]+fdna[1][1])[fdna[1][0],newdir,state[2]+[sin(newdir[1])*x,0,cos(newdir[1])*x]];
function poppack(state,fdna)= let(nextstate=popadd(state,fdna))[[fdna[0],
[nextstate[0],nextstate[1],nextstate[2],fdna[1][3],fdna[1][4],fdna[1][5]],fdna[2],fdna[3] ]]; function
unfold(fdna)=concat(repete(fdna,0),repete(fdna,1),repete(fdna,2),repete(fdna,3),repete(fdna,4),repete(fdna,5),repete(fdna,6),repete(fdna,7),repete(fdna,8),repete(fdna,9),repete(fdna,10),repete(fdna,11),repete(fdna,12),repete(fdna,13),repete(fdna,14),repete(fdna,15));
function repete(v,i)= let(c=round(v[i][0])) c>0?(let(l=max(0,len(v)-1))let(j=min(i+1,l))[ for(n=[1:c])[v[i][0],[
let(temp=lerp(v[i][1][0],v[j][1][0],n/c))[v[i][1][0][0],temp[1],temp[2]], v[i][1][1]/c,
v[i][1][2],lerp(v[i][1][3],v[j][1][3],n/c),lerp(v[i][1][4],v[j][1][4],n/c),//ring lerp(v[i][1][5],v[j][1][5],n/c),
],unfold(v[i][2]),v[i][3]]]):[];


/////////////////////// Defining Default Body Parts Function s
  function  bna()=[[1,[[10,5,5],[-10,-135,intrnd(70,110)],[100,0,0],grove,ring,tex],fork],[1,[[5,5,4], [0,45,0],[7,8,9],grove,ring,tex],fork],[1,[[20,5,5],[0,35,0],[7,8,9],grove,ring,tex],fork],[1,[[5, 5,4],[0,-15,0],[7,8,9],grove,ring,tex],fork],[1,[[20,5,5],[0,-45,0],[7,8,9],grove,ring,tex],fork], [1,[[10,5,4],[0,-15,0],[7,8,9],grove,ring,tex],fork],[3,[[5,3,3],[0,-7,0],[7,8,9],grove,ring,tex], fork]];

function bna2()=[[1,[[0,1,1],[-45,-135,intrnd(70,110)],[100,0,0],grove,ring,tex],fork],[0,[[5,5, 1],[0,15,0],[7,8,9],grove,ring,tex],fork],[0,[[0,1,1],[0,35,0],[7,8,9],grove,ring,tex],fork],[1,[ [0,5,1],[0,-15,0],[7,8,9],grove,ring,tex],fork],[1,[[0,1,1],[0,-45,0],[7,8,9],grove,ring,tex],fork], [0,[[0,5,1],[0,-15,0],[7,8,9],grove,ring,tex],fork],[0,[[0,1,1],[0,-7,0],[7,8,9],grove,ring,tex], fork]];
function bna3()=[
[rnd(2),[[rnd(3,5),4,1],[rnd(-90,90),-135,intrnd(70,110)],[7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,5),5, 8],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,30),8,18],[0,rnd(-60,-30),0],[7,8,9],grove,ring,tex], fork],
[rnd(2),[[rnd(3,5),18,8],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,30),5,8],[0,rnd(30,60),0], [7,8,9],grove,ring,tex],fork],
[rnd(2),[[rnd(3,10),5,2],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex], fork],
[rnd(8),[[rnd(3,4),4,5],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],fork]]; 

function ThoraxAbdomen()=lerp(rndTA(),[
[1,[[1,4,1],[0,-90,0],[7,8,9],grove,ring,tex],bna2(),fork],
[1,[[2,5, 8],[0,5,0],[7,8,9],grove,ring,tex],bna(),fork,wing],
[3,[[20,8,18],[0,-10,0],[7,8,9],grove,ring,tex], bna(),fork,wing],
[1,[[10,18,8],[0,-15,0],[7,8,9],grove,ring,tex],bna2(),fork],
[1,[[20,5,8],[0,15,0], [7,8,9],grove,ring,tex],lerp(bna2(),bna(),0),fork],
[3,[[17,5,2],[0,90,0],[7,8,9],grove,ring,tex], lerp(bna2(),bna(),0.1),fork],
[2,[[20,4,5],[0,25,0],[7,8,9],grove,ring,tex],lerp(bna2(),bna(),0.1),fork]],rnd(1,rnd(1,rnd()))); 

function rndTA()=[
[rnd(1),[[rnd(1,1),4,1],[0,-90,0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(8),[[rnd(3,30),5, 8],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork,wing],
[rnd(8),[[rnd(3,30),8,18],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex], lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork,wing],
[rnd(8),[[rnd(3,30),18,8],[0,rnd(-30,30),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(8),[[rnd(3,30),5,8],[0,rnd(-30,30),0], [7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(8),[[rnd(3,30),5,2],[0,rnd(-200,60),0],[7,8,9],grove,ring,tex], lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork],
[rnd(8),[[rnd(3,30),4,5],[0,rnd(-60,60),0],[7,8,9],grove,ring,tex],lerp(bna3(),lerp(bna2(),bna(),rnd()),rnd()),fork]]; 

function head()=lerp(rndTA(),[
[1,[[1,4,1],[0,-90,0],[7,8,9],grove,ring,tex],bna2(),fork],
[0,[[10,5,8],[0,25,0],[7, 8,9],grove,ring,tex],bna2(),fork],
[1,[[10,8,18],[0,-20,0],[7,8,9],grove,ring,tex],lerp(bna(),bna2(),0.5),,fork],
[1,[[5, 18,8],[0,35,0],[7,8,9],grove,ring,tex],lerp(bna(),bna2(),0.5),,fork],
[1,[[5,5,8],[0,65,0],[7,8,9],grove,ring,tex], lerp(bna(),bna2(),0),fork],
[1,[[5,5,2],[0,48,0],[7,8,9],grove,ring,tex],lerp(bna(),bna2(),0.55),fork], 
[1,[[3,4,5],[0,55,0],[7,8,9],grove,ring,tex],lerp(bna(),bna2(),0.55),fork]],rnd(1,rnd(1,rnd()))); 
function base()=[[10,4,1], [0,-90,0],[7,8,9],grove,ring,tex];


/////////////////////////////////////Common

function  intrnd(a = 0, b = 1) = round((rands(min(a, b), max(a, b), 1)[0]));
function  rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);