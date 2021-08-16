function flower(r1=100,r2,r3,v1,v2 ,steps=200)=
[ for(t=[0:1/steps:1])

let(
x =r1* sin(t*360) +r2* sin(t*v1*360)+r3* sin(t*v2*360),  
y =r1*cos(t*360) +r2*cos(t*v1*360)  +r3*cos(t*v2*360)   )
[x,y] ];
// function close adds a last point equal yo the first

function close(p)= concat(p,[p[0]]);



module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}
module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
  a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);
function un(v) = v / max(1e-15, norm(v));


for(i=[0:20],j=[0:20])
color(un([round(rnd(3)) ,round(rnd(3))  *0.75 ,round(rnd(3))  ]))translate([i*270,j*240]){


paramas=[70,rnd(30),rnd(15),round(rnd(3,17))*(round(rnd(-1,1))==1?1:-1),round(rnd(3,20)*(round(rnd(-1,1))==1?1:-1))  ,300];
echo(paramas);
p=close(flower(paramas[0],paramas[1],paramas[2],paramas[3],paramas[4],paramas[5],paramas[6]));
//polyline(p);
translate([200,00,0])polygon(p);
}