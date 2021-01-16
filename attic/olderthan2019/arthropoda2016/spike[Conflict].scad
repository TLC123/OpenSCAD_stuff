//**********************************************************************
//**********************************************************************
//**********************************************************************
t=rnd(1,30);
etopkoff=1;
p=[
[-t,-t,1]
,[t,-t,1]
,[t,t,1]
,[-t,t,1]
];

p2=[
[1,-1,-1]
,[1,1,-1]
,[1,1,1]
,[1,-1,1]
];



C0=(un(rndc())+[2,0,0]);
C1=(un(rndc())+[2,2,0]);
C2=(un(rndc())+[0,2,2]);

quad(p,[rnd(0,20),rnd(-0.2,0.2),rnd(-0.2,0.2)]);
*quad(p2,[8,rnd(-0.5,0.5),rnd(-0.5,0.5)]);

module quad(ring,modifyer,i=0){
    c=avrg(ring);

    n=un(p2n(ring[0],ring[1],ring[3])+p2n(ring[3],ring[1],ring[2]));
    area=(polyarea(ring[0],ring[1],ring[3])+polyarea(ring[3],ring[1],ring[2]));
    ex=modifyer[0];
    sc=0.7*(3-i)/(3-ex/20);
    sn=([modifyer[1],modifyer[2]]);
    ns=sn[0]*n*ex;
    ew=sn[1]*n*ex; 
    nsc=sn[0];
    ewc=sn[1];

    if (i<3&&area>1){
        ep0=lerp(c+n*ex,((ring[0]+n*ex)+ns-ew),sc-ewc*0.2+nsc*0.2);
        ep1=lerp(c+n*ex,((ring[1]+n*ex)-ns-ew),sc-ewc*0.2-nsc*0.2);
        ep2=lerp(c+n*ex,((ring[2]+n*ex)-ns+ew),sc+ewc*0.2-nsc*0.2);
        ep3=lerp(c+n*ex,((ring[3]+n*ex)+ns+ew),sc+ewc*0.2+nsc*0.2);
    //    echo(ep0,ep1,ep2,ep3);
color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4)) {
    hull(){
quad([ring[0],ring[1],ep1,ep0],modifyer,100);
quad([ring[1],ring[2],ep2,ep1],modifyer,100);
quad([ring[2],ring[3],ep3,ep2],modifyer,100);
quad([ring[3],ring[0],ep0,ep3],modifyer,100);
    }
       quad ([ep0,ep1,ep2,ep3],modifyer,i+1);
        }}
    else if (i==100){
    color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4)) 
        polyhedron([ring[0],ring[1],ring[2],ring[3],c],[[0,1,2],[2,3,0]]);
       } 
       else {
    color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4)) 
        polyhedron([ring[0],ring[1],ring[2],ring[3],c+n*ex],[[0,1,4],[1,2,4],[2,3,4],[3,0,4]]);
       }

    
    }



//**********************************************************************
//**********************************************************************
//**********************************************************************

function avrg(v)=sumv(v,len(v)-1)/len(v);
function sumv(v,i,s=0) = (i==s ? v[i] : v[i] + sumv(v,i-1,s));    
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function p2n(pa,pb,pc)=let(u=pa-pb,v=pa-pc)un([u[1]*v[2] - u[2]*v[1], u[2]*v[0] - u[0]*v[2], u[0]*v[1] - u[1]*v[0]]);
    
function len3(v) = len(v)==2?sqrt(pow(v[0], 2) + pow(v[1], 2) ):sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function un(v) = v / max(len3(v),0.000001) * 1;

function polyarea(p1 ,p2,p3)=heron ( len3(p1-p2),len3(p2-p3),len3(p2-p1));


function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);     
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];

function v3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;

function heron(a,b,c) =let(s = (a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)));
