p0=[0,0,0];
p1=[2,0,0];
p2=[2,1,0];
p3=[0,1,0];
ekoff=rnd(0.4,0.85);
etopkoff=rnd(0.4,0.85);
S=rnd(0.1,1);
E=rnd(0.1,2);
C0=un(rndc());
C1=un(rndc());
C2=un(rndc());
quad(p0,p1,p2,p3,E,S);quad(p0,p1,p2,p3,0);
module quad(p0,p1,p2,p3,e=0.5,s=0.5,i=0){
    c=(p0+p1+p2+p3)/4;
    n=un(p2n(p0,p1,p3)+p2n(p3,p1,p2));
    
    if (i<6&&e>0.05 &&(polyarea(p0,p1,p3)+polyarea(p3,p1,p2))>0.1){
        ep0=lerp(c+n*e,(p0+n*e), s);
        ep1=lerp(c+n*e,(p1+n*e),s);
        ep2=lerp(c+n*e,(p2+n*e),s);
        ep3=lerp(c+n*e,(p3+n*e),s);
       quad (p0,p1,ep1,ep0,e*ekoff,s,i+1);
       quad (p1,p2,ep2,ep1,e0,s,i+1);
       quad (p2,p3,ep3,ep2,e*ekoff,s,i+1);
       quad (p3,p0,ep0,ep3,,s,i+1);
       quad (ep0,ep1,ep2,ep3,e*etopkoff*cos(i),s,i+1);
        }
    else
    color((C0*n[0]+C1*n[1]+[1,1,1]*n[2])/3){polyhedron([p0,p1,p3,p2],[[0,1,2],[2,1,3]]);}
    
    }




function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function p2n(pa,pb,pc)=let(u=pa-pb,v=pa-pc)un([u[1]*v[2] - u[2]*v[1], u[2]*v[0] - u[0]*v[2], u[0]*v[1] - u[1]*v[0]]);
    
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function un(v) = v / max(len3(v),0.000001) * 1;

function polyarea(p1 ,p2,p3)=heron ( len3(p1-p2),len3(p2-p3),len3(p2-p1));


function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);     
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];

function v3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;

function heron(a,b,c) =let(s = (a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)));
