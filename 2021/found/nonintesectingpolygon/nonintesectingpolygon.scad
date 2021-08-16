p1=[0,0];
p2=[0, 100];
p3=[rnd(0,100),rnd(0,100)];
p4=[rnd(0,100),rnd(0,100)];
p6=[rnd(0,100),rnd(0,100)];
p7=[rnd(0,100),rnd(0,100)];
p8=[rnd(0,100),rnd(0,100)];
p5=[rnd(0,100),rnd(0,100)];
 
//
p=buildNIpolygon([  ],12);
r=[for(i=[0:len(p)-1])rnd(10)];
//p=brutebuild(12);
 polyline(p);

echo( p);
echo( r);

function brutebuild (c=10)= let (p=[for(i=[1:c] )[rnd(0,100),rnd(0,100)]])
selfintesect(p)?brutebuild(c):p;


function buildNIpolygon(pi,c=6,smooth=0.74)=
let(p=pi==[]?[[rnd(100),rnd(100)],[rnd(100),rnd(100)],[rnd(100),rnd(100)]]:pi)
c<=0?p:
let(np=concat([newpoint(p[0],p[last(p)])],p))
selfintesect(np)?buildNIpolygon(cycle(p,rnd(last(p))),c):buildNIpolygon(cycle(np,rnd(last(np))),c-1 );

function newpoint(a,b)=
//let(bi=rnd(),m=lerp(a,b,bi),mag=norm(a-b),n=ortho(un(a-b)) )m+n*(mag*min(bi,1-bi)*rnd(-1,1)*2)
[rnd(0,100),rnd(0,100)];

function ortho(v)=[v.y,-v.x];
function cycle(p,n=1)=[for(i=[0:len(p)-1]) p[wrap(i+n,len(p))]];

function selfintesect(p)=
let(lp1=len(p)-1,lp=lp1+1)
let(allp=
[for(i=[0:lp1])
let(allpi=[for(j=[i:i+lp1-1])
 
let(A=p[wrap(i,lp)])
let(B=p[wrap(i+1,lp)])
let(C=p[wrap(j,lp)])
let(D=p[wrap(j+1,lp)])
intersect(A,B,C,D)
 ]
//,err=echo(allpi)
)
allfalse(allpi)]

//,err=echo(allp)
)
 !alltrue(allp);
;


function  ccw(A,B,C)=
    (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x);

function intersect(A,B,C,D)=
A==B||
C==D||
B==C||
B==D||
A==C||
A==D?false:
      ccw(A,C,D) != ccw(B,C,D) && ccw(A,B,C) != ccw(A,B,D);
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min;



function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function AvgThree(v1, v2, v3) = (v1 + v2 + v3) / 3;
function alltrue(a) =
let (b = [
  for (i = a) true]) a == b;
function allfalse(a) =
let (b = [
  for (i = a) false]) a == b;
 module polyline(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[wrap(i+1,len(p) )]);
}

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}
 function last(i)=len(i)-1;
function un(v)=v/max(norm(v),1e-16);
