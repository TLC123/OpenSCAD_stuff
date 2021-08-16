sc=0.4 ;
deformsphere();
module deformsphere(){



istep=1/(120*sc);jstep=1/(240*sc);
for (i=[0:istep:1]){for (j=[-0.5:jstep:0.5 ]){
p1=basevec(i,j)*basemag(i,j);
p2=basevec(i+istep,j)*basemag(i+istep,j) ;
p3=basevec(i+istep,j+jstep)*basemag(i+istep,j+jstep) ;
p4=basevec(i,j+jstep)*basemag(i,j+jstep) ;
polyhedron([p1+[0,0,j*10],p2+[0,0,j*10],p3+[0,0,(j+jstep)*10],p4+[0,0,(j+jstep)*10]],[[0,1,3],[1,2,3]]);
// trender([[p1 ,p2 ,p3 ,p4 ],[[0,1,3],[1,2,3]]]);
  }}}
function basevec(i,j)=[sin(i*360) ,cos(i*360) ,0] ;

function basemag(theta,rho)=
let(n=basevec(theta,rho))

7+
(     sin(theta*360*6+rho*360*6) * 3  
    + sin((rho +0.075) *180*20)  * 3  ) 
  ;

function mod(p)=let(m=len3(p))[0,0,pow(m*0.1,2) ];

























function max3(v,l)=[for(i=[0:len(v)-1])max(l,v[i]) ];
function min3(v,l)=[for(i=[0:len(v)-1])min(l,v[i]) ];
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
 function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
function un(v)=v/max(len3(v),0.000001)*1;
function p2n(pa,pb,pc)=let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);

function rnd(a=0,b=1)=(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
module trender(t){C0=(un(rndc())+[2,0,0]);C1=(un(rndc())+[2,2,0]);C2=(un(rndc())+[0,2,2]);for(i=[0:max(0,len(t[1])-1)]){ n=un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))polyhedron(t[0],[t[1][i]]);}}