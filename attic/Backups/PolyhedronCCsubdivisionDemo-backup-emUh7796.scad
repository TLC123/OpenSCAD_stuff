Select="tet";//[tet,ico]
Sub1=0;//[0:1]
Sub2=2;//[0:2]
Sub3=2;//[0:5]
/* [Hidden] */
///////////////////////////////////////////////////////////////////////////////
//CC subdivision-ish in that regard this impl don't split edges
// subdivides any properly watertight manifold polyhedron : point-list and face-list
// [  [[10,10,10],[10,-10,-10],[-10,10,-10],[-10,-10,10]],    [[2,1,0],[3,2,0],[1,3,0],[2,3,1]]]
// usage cc([points,faces],iterations(0=off),curvebias)
///////////////////////////////////////////////////////////////////////////////
// Demo Code
Select=="tet"?S=tet():S=ico()
in=cc(cc(S,Sub1),Sub2,-0.5); //one regular and the two passes with negative bias for pointyness

t=cc(in,Sub3); // more passes

trender(t);  // pretty render
//polyhedron(t[0],t[1]); // fast
// End Of Demo Code

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
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
function sumv(v,i,s=0)=(i==s?v[i]:v[i]+sumv(v,i-1,s));
function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
function v3rnd(c=1)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;


//////////////////////Make geometry function///////////////////
function ico(a=10)=
let(r=a*1.61803)[[[0,-r,a],[0,r,a],[0,r,-a],[0,-r,-a],[a,0,r],[-a,0,r],[-a,0,-r],[a,0,-r],[r,a,0],[-r,a,0],[-r,-a,0],[r,-a,0]],[[0,5,4],[0,4,11],[11,4,8],[11,8,7],[4,5,1],[4,1,8],[8,1,2],[8,2,7],[1,5,9],[1,9,2],[2,9,6],[2,6,7],[9,5,10],[9,10,6],[6,10,3],[6,3,7],[10,5,0],[10,0,3],[3,0,11],[3,11,7]]];

function tet()= [  [[10,10,10],[10,-10,-10],[-10,10,-10],[-10,-10,10]],
[[2,1,0],[3,2,0],[1,3,0],[2,3,1]]];