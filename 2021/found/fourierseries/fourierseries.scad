 


function FlowerF(r=100,isteps=5,w,a,h=2,h2)=
let(steps=min(isteps*w,300))
[  for(t=[0:1/steps:1])
let( r2= r*1.05+vsum([
for (k = [h2:h:max(9,22-w)])     a[k]*(sin(k*t*w*360)/k)*r] ),
  x =r2* sin(t*360), 
 y =r2* cos(t*360)  )
[x,y] ];




module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}
module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}

a=concat([rnd(0.5),rnd(0.75)],[for (k = [0:1:30])rnd(1)]);
p= (FlowerF(100,200,round(rnd(0,3))*2+1,a,min(2,round(rnd(1,3))),min(2,round(rnd(1,3)))));
 
//polygon(p); 
polyline(p); 
 
// function close adds a last point equal yo the first


function close(p)= concat(p,[p[0]]); 
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
  a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);
function vsum(l) = len(l) > 0 ? [ for(li=l) 1 ] * l : undef;
 

