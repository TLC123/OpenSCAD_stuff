//**********************************************************************
//**********************************************************************
//**********************************************************************
MaxRecursion=4;//[1:8]
Extrude=0.67;//[0:0.01:3]

Scale=0.55;//[0:0.01:2]
ekoff=0.0;//[-0.5:0.01:2]
etopkoff=0.75;//[-0.5:0.01:2]

/* [Hidden] */
// test code
p0=[-5,-5,0];
p1=[5,-5,0];
p2=[5,5,0];
p3=[-5,5,0];



C0=(un(rndc())+[2,0,0])/2;
C1=(un(rndc())+[2,2,0])/2;
C2=(un(rndc())+[0,2,2])/2;
for (i=[10:10]){
translate([i*10,0,0]){quad(p0,p1,p2,p3,Extrude*15,Scale*i/10);
//quad(p3,p2,p1,p0,-0.64,Scale/2);
polyhedron([p3,p2,p1,p0],[[0,1,2],[0,2,3]]);};
};
//scale(4/(len3(p0)+len3(p1)+len3(p2)+len3(p3)))translate (-(p0+p1+p2+p3)/4){
////tri2quad(p0,p2,p1,E,S);
////tri2quad(p0,p1,p3,E,S);
////tri2quad(p1,p2,p3,E,S);
////tri2quad(p2,p0,p3,E,S);
//}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module quad(p0,p1,p2,p3,e=0.5,s=0.5,i=0){
    c=(p0+p1+p2+p3)/4;
    n=un(p2n(p0,p1,p3)+p2n(p3,p1,p2));
 ratio=min(min(len3(p0-p1),len3(p1-p2)),min(len3(p2-p3),len3(p3-p0)))/max(max(len3(p0-p1),len3(p1-p2)),max(len3(p2-p3),len3(p3-p0)))+1/(sqrt(i*3+1));
  
    if (ratio>0.5&&i<MaxRecursion&&abs(e)>0.015 &&(polyarea(p0,p1,p3)+polyarea(p3,p1,p2))>1){
        ep0=lerp(c+n*e,(p0+n*e), s)+n*0.67 ;
        ep1=lerp(c+n*e,(p1+n*e),s);
        ep2=lerp(c+n*e,(p2+n*e),s)-n*0.5;
        ep3=lerp(c+n*e,(p3+n*e),s)+n*0  ;
        quad (p1,ep1,ep0,p0,e*ekoff,s,i+1);
        quad (p2,ep2,ep1,p1,e*ekoff,s,i+1);
        quad (p3,ep3,ep2,p2,e*ekoff,s,i+1);
        quad (p0,ep0,ep3,p3,e*ekoff,s,i+1);
       quad (ep0,ep1,ep2,ep3,e*etopkoff,s,i+1);
        }
    else{
    color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))  polyhedron([p0,p1,p2,p3],[[0,1,2],[0,2,3]]);
       }
    
    }


module tri2quad(p0,p1,p2,p3,e=0.5,s=0.5,){
    p0p1=(p0+p1)/2   ;//edge
    p1p2=(p1+p2)/2   ;//edge
    p2p0=(p2+p0)/2   ;//edge
 n=un(p2n(p0,p1,p2));
    size=polyarea(p0,p1,p2);
c=((p0+p1+p2)/3)+n*sqrt(size*2)/2;
    
quad(p0,p0p1,c,p2p0,e,s);
 quad(p1,p1p2,c,p0p1,e,s);
 quad(p2,p2p0,c,p1p2,e,s);
}
//**********************************************************************
//**********************************************************************
//**********************************************************************
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function p2n(pa,pb,pc)=let(u=pa-pb,v=pa-pc)un([u[1]*v[2] - u[2]*v[1], u[2]*v[0] - u[0]*v[2], u[0]*v[1] - u[1]*v[0]]);
    
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function un(v) = v / max(len3(v),0.000001) * 1;

function polyarea(p1 ,p2,p3)=heron ( len3(p1-p2),len3(p2-p3),len3(p2-p1));


function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);     
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];

function v3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;

function heron(a,b,c) =let(s = (a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)));
