p=[rnd(),rnd()];
order=5;

step=0.003/3/3;
for(i=[0:step :1-step]){
t1=curve_to_cartesian_ini(i,order);t2=curve_to_cartesian_ini(i+step,order); 
color([i,sin(i*5000)*0.5+0.5,1-i]) 
hull(){translate (t1) sphere(0.005);translate (t2) sphere(0.005); }}

 
function curve_to_cartesian
(i,order=4,a=[0,0],b=[0,1],c=[1,1],d=[1,0],s=0,e=1)=let(
p1=lerp(s,e,1/4),p2=lerp(s,e,2/4),p3=lerp(s,e,3/4),
ab=(a+b)/2,bc=(b+c)/2,cd=(c+d)/2,da=(d+a)/2,
center=(a+b+c+d)/4     )
!(order>0)?let(
a2=lerp(a,center,0.5),b2=lerp(b,center,0.5),
c2=lerp(c,center,0.5),d2=lerp(d,center,0.5))
along([a2,b2,c2,d2],(i-s)/max(1e-16,abs(e-s)))
: i<p1?    curve_to_cartesian(i,order-1,a,da,center,ab,s,p1):
i>p1&&i<p2?curve_to_cartesian(i,order-1,ab,b,bc,center,p1,p2):
i>p2&&i<p3?curve_to_cartesian(i,order-1,center,bc,c,cd,p2,p3):
           curve_to_cartesian(i,order-1,cd,center,da,d,p3,e);

function curve_to_cartesian_ini
(i,order=4,a=[0,0],b=[0,1],c=[1,1],d=[1,0],s=0,e=1)=let(
p1=lerp(s,e,1/4),p2=lerp(s,e,2/4),p3=lerp(s,e,3/4),
ab=(a+b)/2,bc=(b+c)/2,cd=(c+d)/2,da=(d+a)/2,
center=(a+b+c+d)/4     )
!(order>0)?let(
a2=lerp(a,center,0.5),b2=lerp(b,center,0.5),
c2=lerp(c,center,0.5),d2=lerp(d,center,0.5))
along([a2,b2,c2,d2],(i-s)/max(1e-16,abs(e-s)))
: i<p1?    curve_to_cartesian(i,order-1,center,da,a,ab,s,p1):
i>p1&&i<p2?curve_to_cartesian(i,order-1,ab,b,bc,center,p1,p2):
i>p2&&i<p3?curve_to_cartesian(i,order-1,center,bc,c,cd,p2,p3):
           curve_to_cartesian(i,order-1,cd,d,da,center,p3,e);


function cartesian_to_curve
(i,order=28,a=[0,0],b=[0,1],c=[1,1],d=[1,0],s=0,e=1)=let(
p1=lerp(s,e,1/4),p2=lerp(s,e,2/4),p3=lerp(s,e,3/4),
ab=(a+b)/2,bc=(b+c)/2,cd=(c+d)/2,da=(d+a)/2,
center=(a+b+c+d)/4   )
!order>0? s : 
inbox(i,a,da,center,ab)==true?cartesian_to_curve(i,order-1,a,da,center,ab,s,p1):
inbox(i,ab,b,bc,center )==true?cartesian_to_curve(i,order-1,ab,b,bc,center,p1,p2):
inbox(i,center,bc,c,cd)==true?cartesian_to_curve(i,order-1,center,bc,c,cd,p2,p3):
           cartesian_to_curve(i,order-1,cd,center,da,d,p3,e);

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function len3v(v,acc=0,p=0)=p+1>len(v)-1?acc:len3v(v,acc+norm(v[p]-v[p+1]),p+1)  ;
function un(v)=v/max(1e-15,norm(v));
function along(v,i)=let(r=v2t(v,len3v(v)*i))[r.x,r.y,if(!is_undef(r.z))r.z];
function inbox (i,a,b,c,d)= 
i.x==max(i.x,a.x,b.x,c.x,d.x)||i.x==min(i.x,a.x,b.x,c.x,d.x)||
i.y==max(i.y,a.y,b.y,c.y,d.y)||i.y==min(i.y,a.y,b.y,c.y,d.y)? false:true;
function v2t(v,stop,p=0)=p+1>len(v)-1|| norm(v[p]-v[p+1])>stop?   v[p]+un(v[p+1]-v[p])*stop:  v2t(v,stop-norm(v[p]-v[p+1]),p+1);
function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);