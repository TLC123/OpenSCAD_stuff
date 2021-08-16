function flower(r1=100,r2,r3,v1,v2 ,steps=200)=
[ for(t=[0:1/steps:1])

let(
x =r1* sin(t*360) +r2* sin(t*v1*360)+r3* sin(t*v2*360),  
y =r1*cos(t*360) +r2*cos(t*v1*360)  +r3*cos(t*v2*360)   )
[x,y] ];
function flower2(t,r1=100,r2,r3,v1,v2 ,steps=200)=
[  

let(
x =r1* sin(t*360) +r2* sin(t*v1*360) ,  
y =r1*cos(t*360) +r2*cos(t*v1*360)     )
[x,y] ];

function flower1(t,r1=100,r2,r3,v1,v2 ,steps=200)=
[  

let(
x =r1* sin(t*360)   ,  
y =r1*cos(t*360)     )
[x,y] ];

function flower3(t,r1=100,r2,r3,v1,v2 ,steps=200)=
[  

let(
x =r1* sin(t*360) +r2* sin(t*v1*360)+r3* sin(t*v2*360),  
y =r1*cos(t*360) +r2*cos(t*v1*360)  +r3*cos(t*v2*360)   )
[x,y] ];
// function close adds a last point equal yo the first

function close(p)= concat(p,[p[0]]);



 
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
  a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);
function un(v) = v / max(1e-15, norm(v));

module polyline(p){for(i=[0:max(0,len(p)-2)])color([i%2])line(p[i],p[i+1]);}
module line(p1,p2,width=0.5){hull(){
    translate(p1)sphere(width);
    translate(p2)sphere(width);}}
module ring(d, i = 1) {
  linear_extrude(i)
  {
     difference() {
      circle(d, $fn = 60);
      circle(max(0,d- 1), $fn = 60);
    }
  }
}
paramas=[70,rnd(14,30),rnd(4,15),round(rnd(4,3))*(round(rnd(-1,1))==1?1:-1),round(rnd(3,2)*(round(rnd(-1,1))==1?1:-1))  ,300]; 
color(un([round(rnd(3)) ,round(rnd(3))  *0.75 ,round(rnd(13))  ])) {


echo(paramas);
p=close(flower(paramas[0],paramas[1],paramas[2],paramas[3],paramas[4],paramas[5],paramas[6]));
polyline(p);


}
ring(paramas[0]);
t=0.09;
p1=flower1(t,paramas[0],paramas[1],paramas[2],paramas[3],paramas[4],paramas[5],paramas[6]);
echo (p1);
translate(p1[0]){ring(paramas[1]);circle(2);}

p2=flower2(t,paramas[0],paramas[1],paramas[2],paramas[3],paramas[4],paramas[5],paramas[6]);
echo (p2);
translate(p2[0]){ring(paramas[2]);circle(2);}

p3=flower3(t,paramas[0],paramas[1],paramas[2],paramas[3],paramas[4],paramas[5],paramas[6]);
echo (p3);
translate(p3[0])color("red")circle(2);