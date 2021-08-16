include<polytools.scad>
 r=un(sm([for(i=[0:7])rnd(-i*50,i*50)],0.4))*120;
  l=un([for(i=[0:7])rnd(1,6+i)])*10;


c1=sm(resample(r2c(r,l),40),0.5);
 
rotate([0,-( r[4]+  r[3]+ r[2]+r[1]+r[0]),0])translate(vecxz(-c1[4]))polyline(c1); 
 

echo(c1);
function resample(v,n)=
[for(i=[0:(len(v)-1)/n:len(v)-1])listlerp(v,i)];

function r2c(vr,vl,vv=[ ],n=0,r=90,c=[0,0,90,[0,0,0]])=
n<len(vr)?
let(
rr=r+vr[n],
cc=[c.x,rr+(vr[n]/2),c.z,[0,0,0]]+[sin(rr)*vl[n],0,cos(rr)*vl[n],
[rnd(vl[n]*0.25,vl[n]*0.1),
rnd(vl[n]*0.5 ,vl[n]*0.1),
vl[n]*0.15 ]*(n==0||n==len(vr)-1?rnd(0.37):1)
] ,
vvv=concat(vv,[cc])
)

r2c(vr,vl,vvv,n+1,rr,cc)
:vv;



 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p)  )]);
} // polyline plotter
module line(p1, p2 ,width1=0.5 ,width2=0.5) 
{ // single line plotter
    union() {
   translate(vecxz(p1))rotate([0,vecy(p1),0]) scale(i4(p1))rotate([0,0,0])sphere(1,$fn=15);
    translate(vecxz(p2))rotate([0,vecy(p2),0])scale(i4(p2)*1.2)rotate([0,0,0]) sphere(1,$fn=15);
 
}
}
function listlerp (l,I)=let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=I%1) (l[end]* bias + l[start] * (1 - bias));


   

 function sm(l,n=0.5)=
let(ll=len(l)-1
)
[for(i=[0:ll-1])
let(
 next=min(i+1, ll)
,prev=max(i-1,0 )
,bl=( l[next]+l[prev])/2)

lerp(l[i],bl,n)


];
function i4(i)=i[3];
function vec3(i)=[i.x,i.y,i.z];
function vecxz(i)=[i.x,0,i.z];
function vecy(i)=i.y;
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function lerp(start, end, bias) = (end * bias + start * (1 - bias));