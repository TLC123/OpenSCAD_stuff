fork=["fork","forkdata"];
grove="grove";//[0.5,0.5,0.5];
ring="ring";//[[0,1,1],[0,-1,1],[0,-1,-1],[0,1,-1]];
tex="tex";//[["extparams"],["distmap -x,-y,-z,x,y,z"]];
function bna()=[
[1,[[10,5,5],[0,-135,intrnd(70,110)],[100,0,0],grove,ring,tex],fork],
[1,[[5,5,4],[0,45,0],[7,8,9],grove,ring,tex],fork],
[1,[[20,5,5],[0,35,0],[7,8,9],grove,ring,tex],fork],
[1,[[5,5,4],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[1,[[20,5,5],[0,-45,0],[7,8,9],grove,ring,tex],fork],
[1,[[10,5,4],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[3,[[5,3,3],[0,-7,0],[7,8,9],grove,ring,tex],fork]];
function bna2()=[
[1,[[0,1,1],[0,-135,intrnd(70,110)],[100,0,0],grove,ring,tex],fork],
[0,[[5,5,1],[0,15,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,35,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,5,1],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,-45,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,5,1],[0,-15,0],[7,8,9],grove,ring,tex],fork],
[0,[[0,1,1],[0,-7,0],[7,8,9],grove,ring,tex],fork]];
dna1=[
[1,[[1,4,1],[0,-90,0],[7,8,9],grove,ring,tex],bna2(),fork],
[2,[[30,5,8],[0,5,0],[7,8,9],grove,ring,tex],bna(),fork],
[3,[[30,8,18],[0,-10,0],[7,8,9],grove,ring,tex],bna(),fork],
[1,[[10,18,8],[0,-15,0],[7,8,9],grove,ring,tex],bna2(),fork],
[1,[[20,5,8],[0,15,0],[7,8,9],grove,ring,tex],lerp(bna2(),bna(),0),fork],
[10,[[12,5,2],[0,180,0],[7,8,9],grove,ring,tex],lerp(bna2(),bna(),0.1),fork],
[2,[[20,4,5],[0,25,0],[7,8,9],grove,ring,tex],lerp(bna2(),bna(),0.1),fork]];

base=[[10,4,1],[0,-90,0],[7,8,9],grove,ring,tex];
///////////////////////////////////////////////////////////
pop=populate(unfold(dna1));

T=populatelegs(pop);
for(i=[0:len(T)-2]){
line(T[i][1][2],T[i+1][1][2]);
translate(T[i][1][2])rotate([0,90+T[i][1][1][1],0])scale([1,T[i][1][0][1],T[i][1][0][2]])sphere(1,$fn=10);

L=T[i][2];

for(j=[0:max(0,len(L)-2)]){
color(rndc()){
translate(T[i][1][2])rotate([0,90+T[i][1][1][1],0])rotate([0,0,L[0][1][1][2]])
{line(L[j][1][2],L[j+1][1][2]);
translate(L[j][1][2])rotate([0,90+L[j][1][1][1],0])scale([1,L[j][1][0][1],L[j][1][0][2]])sphere(1,$fn=10);
}

translate(T[i][1][2])mirror([0,1,0])rotate([0,90+T[i][1][1][1],0])rotate([0,0,L[0][1][1][2]])
{line(L[j][1][2],L[j+1][1][2]);
translate(L[j][1][2])rotate([0,90+L[j][1][1][1]],0)scale([1,L[j][1][0][1],L[j][1][0][2]])sphere(1,$fn=10);
}

}
}


//echo(i,T[i][1]);
}


////////////////////////////////////////////////////////////

module line(p1, p2 ) {
  hull() {
    translate(p1) sphere(1);
    translate(p2) sphere(1);
  }
}

function populatelegs(f)=[for(i=[0:len(f)-1])f[i][2]!=[]?[f[i][0],f[i][1],populate(f[i][2]),f[i][3]]:[f[i][0],f[i][1],f[i][2],f[i][3]]];



function populate(fdna, state = [[0,0,0],[0,0,0],[0,0,0]], i = 0) =
let (l = len(fdna) - 1, nextstate=popadd(state,fdna[i]))(i == l) ? 

poppack(state, fdna[i])
 :
 concat(poppack(state, fdna[i])
 ,

 populate(fdna, nextstate, i + 1));

function popadd(state, fdna) =(len(fdna)==0)? state: let(x=fdna[1][0][0],newdir=state[1]+fdna[1][1])[fdna[1][0],newdir,state[2]+[sin(newdir[1])*x,0,cos(newdir[1])*x]];

function poppack(state, fdna)=let(nextstate=popadd(state,fdna))[[fdna[0],[nextstate[0],nextstate[1],nextstate[2],fdna[1][3],fdna[1][4],fdna[1][5]],fdna[2],fdna[3]]] ;




function unfold(fdna)=concat(repete(fdna, 0 ),repete(fdna, 1 ),repete(fdna, 2 ),repete(fdna, 3 ),repete(fdna, 4 ),repete(fdna, 5 ),repete(fdna, 6 ),repete(fdna, 7 ),repete(fdna, 8 ),repete(fdna, 9 ),repete(fdna, 10 ),repete(fdna, 11 ),repete(fdna, 12 ),repete(fdna, 13 ),repete(fdna, 14 ),repete(fdna, 15 ))   ;


function repete(v,i)=
let(c=round( v[i][0]))
 c>0? (
let(l=max(0,len(v)-1))
let(j=min(i+1,l)

)[for(n=[1:c])[ v[i][0],[ 
let(temp=lerp(v[i][1][0],v[j][1][0],n/c))
[v[i][1][0][0],temp[1],temp[2]], //lerp only y/z X will be same
v[i][1][1]/c, // ??possibly angle can be divided by no reps
v[i][1][2], // accumulator no need to lerp, will be reasssigned in poppulate
lerp(v[i][1][3],v[j][1][3],n/c), //grove
lerp(v[i][1][4],v[j][1][4],n/c), //ring 
lerp(v[i][1][5],v[j][1][5],n/c), // texture

],unfold( v[i][2]), v[i][3]]]):[];




function intrnd(a = 0, b = 1) = round( (rands(min(a, b), max(a, b), 1)[0]));
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
