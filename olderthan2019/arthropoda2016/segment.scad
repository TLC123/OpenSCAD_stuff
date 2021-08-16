grove=[rnd(),rnd(-0.5,1),rnd(-0.5,1)];
r=rnd(80,100);
l=rnd(40,50);
start=[[0,0,0],r,grove,xring(8)];
end=[[sin(r)*l,0 ,cos(r)*l],-r,grove,xring(8)];

 seg (start,end,2);
module seg(p1,p2,div)
{
m1=lerp(p1,p2,    min(p1[2][2],1-p2[2][1]));
m2=lerp(p1,p2,    max(1-p2[2][1],p1[2][2])); 

*line(p1,p2,div);
*color("Red") point(m1);
    
*color("green") point(m2);

*color("Red") point(p1);
*color("green") point(p2);
    cap(p1[2][0],p1);
    bridge(p1[2][0],p1,m1,1);
    bridge(1,m1,m2,1);
    bridge(1,m2,p2,p2[2][0]);
    cap(p2[2][0],p2);

    }
 module  cap(s1,ip1){
     r1=ringtrans(ringscale(ip1[3],s1*5 ),ip1[0]);
     c1=avrg(r1);
     ring1=concat(r1);
     last1=len(ring1);
    color(rndc())  for(i=[0:last1-1]){  
         
polyhedron([ring1[i],ring1[(i+1)%last1],c1],[[0,1,2]]);
     }}
 module bridge(s1,ip1,ip2,s2){
     r1=ringtrans(ringscale(ip1[3],s1*5 ),ip1[0]);
     r2=ringtrans(ringscale(ip2[3],s2 *5),ip2[0]);
     c1=avrg(r1);
     c2=avrg(r2);
     ring1=concat(r1);
     ring2=concat(r2);
     last1=len(ring1);
     last2=len(ring2);
        
 ringbridge(ring1,ring2);
     
 *for(i=[0:last1-1]){  
   
       
  color(rndc())     *hull(){
polyhedron([ring1[i],ring1[(i+1)%last1],c1],[[0,1,2]]);   
//translate(ring1[i])sphere(1);
//translate(ring1[(i+1)%(last1)])sphere(1);
//translate(c1)sphere(1);          
 polyhedron([ring2[i],ring2[(i+1)%(last2)],c2],[[0,1,2]]);
//translate(ring2[i])sphere(1);
//translate(ring2[(i+1)%last2])sphere(1);
//translate(c2)sphere(1);          
         
         
         
           };
           }
 }
     
     
    module ringbridge(r1,r2){
     n=len(r1);
     cbr=   concat(r1,r2);
     for(i=[0:n]){
quad (
         [cbr[n+i], cbr[n+(i+1)%n],cbr[(i+1)%n],cbr [i]],[rnd(0,3),rnd(-0.1,0.1),rnd(-0.1,0.1),rnd(0.1,1.4)]
         );
         }
        
        //l=[for(i=[0:n])[i, (i+1)%n,n+(i+1)%n,n+i]];
     
     //polyhedron(     concat(r1,r2),l);
     
 }; 
    
    
  module point(p1,p2,div){
      
        translate(p1[0]) sphere(2);
  }
      
    module line(p1,p2,div){
      hull(){
        translate(p1[0]) sphere(1);
      translate(p2[0]) sphere(1);}
      }
function ringrot(r=[[0,0,0]],v)=[for(i=[0:len(r)-1])let(inx=r[i][0],iny=r[i][1],inz=r[i][2])    
[
inx*sin(v)+inz*cos(v),
iny,
inx*cos(v)-inz*sin(v)
]];
        
function  ringscale(v,scale)=[for(i=[0:len(v)-1])
        [
        v[i][0]*scale,
        v[i][1]*scale,
        v[i][2]*scale
        ]];
        
function  ringtrans(v,t)=[for(i=[0:len(v)-1])
        [
        v[i][0]+t[0],
        v[i][1]+t[1],
        v[i][2]+t[2]
        ]];

 function xring(x=8,i=0.5)=mirring([for(i=[(360/x)*0.5:360/x:359])[0,sin(i),cos(i)]+rndV2(3)*0.1]);
 function basering(x=8)=mirring([for(i=[(360/x):360/x:359])[0,sin(i),cos(i)]+rndV2(3)]);
 function  mirring(ring)=
     let( n=floor((len(ring)-1 )/2))
     
     concat( 
     [for(i=[0:n])ring[i]],
     [for(i=[0:n])[ring[n-i][0],-ring[n-i][1],ring[n-i][2]]]
         );
 function rndV2(t=1)=[rands(-t,t,1)[0],rands(-t,t,1)[0],rands(-t,t,1)[0]];
//**********************************************************************
//**********************************************************************
//**********************************************************************
C0=(un(rndc())+[2,0,0]);
C1=(un(rndc())+[2,2,0]);
C2=(un(rndc())+[0,2,2]);

//quad(p,[rnd(0,20),rnd(-0.2,0.2),rnd(-0.2,0.2)]);
module quad(ring,modifyer,i=0){
    c=avrg(ring);
    //echo(ring,modifyer);
    n=un(p2n(ring[0],ring[1],ring[3])+p2n(ring[3],ring[1],ring[2]));
    area=(polyarea(ring[0],ring[1],ring[3])+polyarea(ring[3],ring[1],ring[2]));
    ex=modifyer[0];
    sc=0.7*(3-i)/(4-ex/area);
    sn=([modifyer[1],modifyer[2]]);
    ns=sn[0]*n*ex;
    ew=sn[1]*n*ex; 
    nsc=sn[0];
    ewc=sn[1];
   // echo(area);
nextmodifyer=[modifyer[0]*modifyer[3],modifyer[1],modifyer[2],modifyer[3]];
    if (i<3&&area>100){
        ep0=lerp(c+n*ex,((ring[0]+n*ex)+ns-ew),sc-ewc*0.2+nsc*0.2);
        ep1=lerp(c+n*ex,((ring[1]+n*ex)-ns-ew),sc-ewc*0.2-nsc*0.2);
        ep2=lerp(c+n*ex,((ring[2]+n*ex)-ns+ew),sc+ewc*0.2-nsc*0.2);
        ep3=lerp(c+n*ex,((ring[3]+n*ex)+ns+ew),sc+ewc*0.2+nsc*0.2);
        
    //    echo(ep0,ep1,ep2,ep3);
color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))
        {
quad([ring[0],ring[1],ep1,ep0],modifyer,100);
quad([ring[1],ring[2],ep2,ep1],modifyer,100);
quad([ring[2],ring[3],ep3,ep2],modifyer,100);
quad([ring[3],ring[0],ep0,ep3],modifyer,100);  }
       quad ([ep0,ep1,ep2,ep3],nextmodifyer,i+1);
if (i==0){
       * polyhedron([ring[0],ring[1],ring[2],ring[3],c],[[0,1,3],[1,2,3]]);

}
      }
else if (i==100){    color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))         polyhedron([ring[0],ring[1],ring[2],ring[3],c],[[0,1,3],[1,2,3]]);       } 
      else {   
      color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))
          polyhedron(
          [ring[0],ring[1],ring[2],ring[3],c+(n*ex)]
          ,[[0,1,4],[1,2,4],[2,3,4],[3,0,4]]
          )
          ; 
              echo(
          [ring[0],ring[1],ring[2],ring[3],c+(n*ex)]
          ,[[0,1,4],[1,2,4],[2,3,4],[3,0,4]]
          )
          ;
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


function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0])     ;
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];

function v3rnd(c)=[rands(-1,1,1)[0]*c,rands(-1,1,1)[0]*c,rands(-1,1,1)[0]]*c;

function heron(a,b,c) =let(s = (a+b+c)/2) sqrt(abs(s*(s-a)*(s-b)*(s-c)));
