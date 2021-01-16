fork=["fork","forkdata"];
grove="grove";//[0.5,0.5,0.5];
ring="ring";//[[0,1,1],[0,-1,1],[0,-1,-1],[0,1,-1]];
texture=[["extparams"],["distmap -x,-y,-z,x,y,z"]];
function bna()=[[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring,fork]],[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring,fork]],[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring,fork]]];
dna1=[[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring],bna(),fork],[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring],bna(),fork],[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring],bna(),fork],[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring],bna(),fork],[1,[[1,2,3],[4,5,6],[7,8,9],grove,ring],bna(),fork]];



echo(unfold(dna1));

function populate (fdna,state,i=0)=let(l=len(fdna),state=0) (i==l)?fdna[i]+state:concat(fdna[i]+state,populate (fdna,state,i+1));






function unfold(fdna)=concat(repete(fdna[0]),repete(fdna[1]),repete(fdna[2]),repete(fdna[3]),repete(fdna[4]),repete(fdna[5]),repete(fdna[6]),repete(fdna[7]),repete(fdna[8]),repete(fdna[9]),repete(fdna[10]),repete(fdna[11]),repete(fdna[12]),repete(fdna[13]),repete(fdna[14]),repete(fdna[15]))   ;
function repete(v)= v[0]>0? ([for(i=[1:v[0]])[v[0],v[1],unfold(v[2])]]):[];
function intrnd(a = 0, b = 1) = round( (rands(min(a, b), max(a, b), 1)[0]));
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
