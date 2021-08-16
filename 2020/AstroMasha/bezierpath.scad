   slices=15;
   testi=$t;
I=testi*slices;
BEF=floor(I);
AFT=ceil(I+0.0001); 
BIA=1-(AFT-I);
bef=BEF/slices;
aft=AFT/slices;   
//bef2=lerp(bef,aft,0.5);
bef0=lerp(bef,aft,0.01);
aft2=lerp(bef,aft,0.99);

stone=[80,-20,0,60];
translate(v3(stone))circle(stone[3]);



nbef=path(bef)+(path(bef0)-path(bef))/max(0.001,norm(path(bef)-path(bef0)))*(norm(path(bef)-path(aft))*0.7);
naft=path(aft)+(path(aft2)-path(aft))/max(0.001,norm(path(aft)-path(aft2)))*(norm(path(bef)-path(aft))*0.7);

beaf=lerp(nbef,naft,0.5);

cpbef=collide(path(bef),stone); 
cpaft=collide(path(aft),stone);


//coll=path(bef2)==collide(path(bef2),stone)?0:1;

//cpbef2=collide(lerp(path(bef2),collide(lerp(cpbef,cpaft,0.5),stone),coll),stone);
cpbef2=collide(beaf,stone);


//echo(path(bef2),collide(path(bef2),stone));
//    translate(beaf)cube(4);


//    echo(bef,aft,coll );
    translate(cpbef) cube(3);
    translate(cpbef2) cube(3);
     translate(cpaft) cube(3);
     
     translate( (bez(BIA,[cpbef,cpbef2, cpaft])) )color("blue") cube(3);
        
for(i=[0:.1:1]){
    p=bez(i,[cpbef,cpbef2, cpaft]);
        translate(p)color("red") cube(2);
      

    }
 
for(i=[0:.0051:.99]){
 
    
    translate(path(i)) cube(1);

}


function collide(p,v)=
let(dist=max(1e-32,norm(v3(v )-p) ))
dist<v[3]*1.1?
v3(v) +( (p-v3(v))/dist)*v[3]*1.1
:p  ;


function v3(v)=[v.x,v.y,v.z];

 
function pathlength(i,j,p=.5)=
let(p1=subpath(i))
let(p2=subpath(j))
let(k=lerp(i,j,0.5))
let(pm=subpath(k))
let(pp=lerp(p1,p2,0.5))
let(err=norm(pm-pp))
err<p?norm(p1-p2):
pathlength(i,k)+pathlength(k,j)

;

function pat3h(i)= 
let(d=pathlength(0,ceil(i)))
let(p= pathpart(0,ceil(i),i,d))
subpath(p )
;

function pathpart(l,u,i,d)=
abs(u-l)<0.001?l:
let(m=lerp(l,u,0.5))
let(v=pathlength(0,m,0.1) )
 

v<d*i?
pathpart(m,u,i,d)
:
pathpart(l,m,i,d)
;


function   path(i)=   (
[sin(100+i*360),cos(150+i*360)]*45*(1+sin(i*360*5)*0.5)
+[-sin(i*360*2),cos(i*360*2)]*35*(2.1+sin(160+i*360*9)*0.5)
 +[sin(i*360*2),cos(i*360*5)]*15
 +[-sin(45+i*360*3),cos(39+i*360*2)]*21*(1+sin(135+i*360*4)*0.5)
 )   ;

function bez(t,v)= let (
a=lerp(v[0],v[1],t),
b=lerp(v[1],v[2],t),
ab=lerp(a,b,t)
 )ab ;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
