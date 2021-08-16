

// 2d poly offset for simple shapes
// 
// Build on code form
// Library: round-anything
// Version: 1.0
// Author: IrevDev
// Copyright: 2017
// License: GPL 3
 
   test();
 
callExamples();


module test()
{
//p=[for(i=[0:2])[rnd(40,80),rnd(-0,30),rnd(3,30)]];
 p=buildNIpolygon([  ],2);
 r=[for(i=[0:len(p)-1])03];
     
for(t=[-2:1:2]){
o=(polyOffset( (p ), t));

 translate([0,0,-1])polyline(getpoints( polyRound(o,4+t)));
// translate([0,0,-1])polyline( getpoints(o));
}

R =polyRound(zipxyr(p,r),7);
polygon(R ); 
%translate([0,0,-1])polygon(getpoints(p));
 
 
}

 
 

module callExamples(){
    //Example of how a parametric part might be designed with this tool 
    width=20;       height=25;
    slotW=8;        slotH=15;
    slotPosition=8;
    minR=1.5;       farcornerR=6;
    internalR=3;
    points=[[0,0],[0,height],[slotPosition,height],[slotPosition,height-slotH],
    [slotPosition+slotW,height-slotH],[slotPosition+slotW,height],[width,height],[width,0]];
    radiuses=[minR,minR,minR,internalR,internalR,minR,minR,farcornerR];
    translate([-30,0,0])polygon(polyRound(zipxyr(points,radiuses)));
    %translate([-30,0,0.2])polygon(points);
    
    //Example of features 2
    //   1     2     3      4      5       6     
   b=[[-5,0],[5,3],[0,7],[8,7],[20,20],[10,0]]; //points
    br=[rnd(0,rnd(0,5)),rnd(0,rnd(0,5)),rnd(0,rnd(0,rnd(0,5))),rnd(rnd(0,5),15),rnd(0,5),rnd(rnd(0,5),20)]; //radiuses
    polygon(polyRound(zipxyr(b,br),30));
    %translate([0,0,0.2])polygon(b);
    
    
    //Example of features 3
    //   1     2       3      4       5     6
    p=[[0,0],[0,20],[15,15],[3,10],[15,0],[6,2]];//points
    pr=[rnd(1,5),rnd(1,5),rnd(0,5),rnd(0,5),rnd(0,5),rnd(2,5)];//radiuses
    translate([25,0,0])polygon(polyRound(zipxyr(p,pr),3));
    %translate([25,0,0.2])polygon(p);
//echo(polyRound(zipxyr(b,br),30));
}

function polyOffset(p,o )=
o==0?p:
 let(Lp1=last(p),Lp=Lp1+1)
[for(i=[0:last(p)])
offset3points(
p[wrap(i-1,Lp,0)],
p[wrap(i  ,Lp,0)],
p[wrap(i+1,Lp,0)], o) ]


;

function offset3points(p0, p1, p2, o) =
// clearly bad code  that manage to ofsett correctli - thoug with self intersections 
o >= 0 ?
    let (
        n01 = un(p0 - p1),
        n12 = un(p1 - p2),
        n21 = un(p2 - p1),
        pp01 = sign(o) > 0 ? -[n01.y, -n01.x] : -[n01.x, n01.y],
        pp21 = sign(o) > 0 ? [n21.y, -n21.x] : -[n21.x, n21.y]
    )
let (
    midLineNormal = un(pp01 + pp21),
    angle = angle(n21, n01),
    tanD = abs(o / sin(angle / 2)),
    center = p1 - midLineNormal * tanD
)[center.x, center.y, sign(dot(n01, pp21)) == sign(o) ? o : 0]:
let (
    n01 = un(p0 - p1),
    n12 = un(p1 - p2),
    n21 = un(p2 - p1),
    pp01 = sign(-o) > 0 ? [n01.y, -n01.x] : -[n01.x, n01.y],
    pp21 = sign(-o) > 0 ? [n12.y, -n12.x] : -[n12.y, -n12.x]
)
let (
    midLineNormal = un(pp01 + pp21),
    angle = angle(n21, n01),
    tanD = abs(-o / sin(angle / 2)),
    center = p1 - midLineNormal * tanD
)[center.x, center.y, sign(dot(n01, pp21)) == sign(-o) ? -o : 0];

function polyRound(radiipoints,fn=5)=
// reworte most of it all here heavily use of wrap function
 let(p=getpoints(radiipoints)) 
 let(r=getradii(radiipoints))
 let(Lp1=last(p),Lp=Lp1+1)
 let(edge_lengths=
[for(i=[0:last(p)]) norm(p[i]-p[wrap(i+1,Lp)]) ])
 let(limR= fitR(p,r,edge_lengths)
)
 let(
temp=[for(i=[0:last(p)]) 
round3points(
p[wrap(i-1,Lp,0)],
p[wrap(i  ,Lp,0)],
p[wrap(i+1,Lp,0)],
limR[i],r[i],
fn)])   //common trick  to flatten a list of list
    [for (a = temp )        for (b = a) b];

 
function fromTo(/*vec3*/p,/*vec3*/q)=
 
 acos(dot(p,q));

 


function angle (a,b)=let(ath=atan2(a.y, a.x), bth= atan2(b.y, b.x) ) 
    max(  ath,bth )-  min(  ath,bth );
    
 

function round3points(p1,p2,p3,r,rorg,fn)=
// move check to top, single point reurn in case of collinear
      dot(un(p1-p2),un(p2-p3))>0.98||r==0?[p2]//[p2+un(p1-p2), p2,p2+un(p3-p2)  ]
    : 
    let(ang=cosineRuleAngle(p1,p2,p3))//angle between the lines
// constrained tangD to the shortest leg p1-p2, or p2-p3
   let(tangD=min(norm(p1-p2) ,norm(p2-p3) , r/tan(ang/2)))//distance to the tangent point from p2 
 
    let(circD=r /sin(ang/2))//distance to the circle centre from p2
    let(a12=abs(atan(getGradient(p1,p2))))//angle of line 1
    let(a23=abs(atan(getGradient(p2,p3))))//angle of line 2
    
    let(vec21=p1-p2)//vector from p2 to p1
    let(vec23=p3-p2)//vector from p2 to p3
    let(dir21x=vec21[0]==0?0:vec21[0]/abs(vec21[0]))//tangent along line p2 to p1 x polerisation. Returns 1,-1 or 0
    let(dir21y=vec21[1]==0?0:vec21[1]/abs(vec21[1]))//tangent along line p2 to p1 y polerisation. Returns 1,-1 or 0
    let(dir23x=vec23[0]==0?0:vec23[0]/abs(vec23[0]))//tangent along line p3 to p1 x polerisation. Returns 1,-1 or 0
    let(dir23y=vec23[1]==0?0:vec23[1]/abs(vec23[1]))//tangent along line p3 to p1 Y polerisation. Returns 1,-1 or 0
    
    let(t12=[p2[0]+dir21x*cos(a12)*tangD,p2[1]+dir21y*sin(a12)*tangD])//tangent point along line p2 to p2 by offseting from p2
    let(t23=[p2[0]+dir23x*cos(a23)*tangD,p2[1]+dir23y*sin(a23)*tangD])//tangent point along line p2 to p3 by offseting from p2
    
    let(vec_=getMidpoint(t12,t23)-p2)//vector from P1 to the midpoint of the two tangents
    let(dirx_=vec_[0]==0?0:vec_[0]/abs(vec_[0]))//circle center point x polerisation
    let(diry_=vec_[1]==0?0:vec_[1]/abs(vec_[1]))//circle center point y polerisation
    let(a_=abs(atan(getGradient(getMidpoint(t12,t23),p2))))//angle of line from tangent midpoints to p2
    let(cen=[p2[0]+dirx_*cos(a_)*circD,p2[1]+diry_*sin(a_)*circD])//circle center by offseting from p2
    
    let(e1=(p2[0]-p1[0])*(p2[1]+p1[1]))//edge 1
    let(e2=(p3[0]-p2[0])*(p3[1]+p2[1]))//edge 2
    let(e3=(p1[0]-p3[0])*(p1[1]+p3[1]))//edge 3
    let(CWorCCW=(e1+e2+e3)/abs(e1+e2+e3))//rotation of the three points cw or ccw?
   CentreN2PointsArc(t12,t23,cen,CWorCCW,fn);
 
        
function CentreN2PointsArc(p1,p2,cen,CWorCCW,fn)=
    let(r=pointDist(p1,cen))
    let(CircA1=invtan(p1[0]-cen[0],p1[1]-cen[1]))//angle of line 1
    let(CircA2=cosineRuleAngle(p2,cen,p1))//angle between the lines
    [for(i=[0:fn]) [cos(CircA1+(CircA2/fn)*-i*CWorCCW)*r+cen[0],sin(CircA1+(CircA2/fn)*-i*CWorCCW)*r+cen[1]]];
 
function invtan(run,rise)=
    let(a=abs(atan(rise/run)))
    rise==0&&run>0?0:rise>0&&run>0?a:rise>0&&run==0?90:rise>0&&run<0?180-a:rise==0&&run<0?180:rise<0&&run<0?a+180:rise<0&&run==0?270:rise<0&&run>0?360-a:"error";

function cosineRuleAngle(p1,p2,p3)=
    let(p12=abs(pointDist(p1,p2)))
    let(p13=abs(pointDist(p1,p3)))
    let(p23=abs(pointDist(p2,p3)))
    acos((sq(p23)+sq(p12)-sq(p13))/(2*p23*p12));
    
function getIntersect(m1,m2,k1,k2)=
    let(x=(k2-k1)/(m1-m2))
    let(y=m1*x+k1)
    [x,y];

function sq(x)=x*x;
function getGradient(p1,p2)=(p2[1]-p1[1])/(p2[0]-p1[0]);
function getConstant(p,m)=p[1]-m*p[0];
function getMidpoint(p1,p2)=[(p1[0]+p2[0])/2,(p1[1]+p2[1])/2];
function pointDist(p1,p2)=sqrt(abs(sq(p1[0]-p2[0])+sq(p1[1]-p2[1])));



 module polyline(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[wrap(i+1,len(p) )]);
} // polyline plotter

module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}


function fitR(p, r, edge_lengths, c =100) = 
  true?r:
  c <= 0 ?let(er=echo(c))
   r :
let (tangDs = [
for (i = [0: last(p)])
  tangDround3points(
p[wrap(i - 1, last(p) + 1, 0)], 
p[wrap(i, last(p) + 1, 0)], 
p[wrap(i + 1, last(p) + 1, 0)], 
r[i])])

let (limr = 
[for (i = [0: last(r)]) 
    let (
    next = wrap(i + 1, len(r)),
    prev = wrap(i - 1, len(r)),
    tangD1=( tangDs[i] + tangDs[prev]),
    tangD2= (tangDs[i] + tangDs[next]),
    tanga=max(tangD1,tangD2)
    ) 

tangD1 > edge_lengths[prev]|| tangD2 > edge_lengths[1] 
 && 
 !(( tangDs[i] < tangDs[prev])&& (tangDs[i] < tangDs[next]))// be gentetle with the smallest
?

let(
factor1=(edge_lengths[prev] / tangD1 ), 
factor2=(edge_lengths[ i  ] / tangD2 )   
)
 
roundr(r[i] * min(factor1,factor2)  ):r[i]

])
limr == r ?let(er=echo(c)) limr :  fitR(p, limr, edge_lengths, c - 1);


 



function tangDround3points(p1, p2, p3, r) =
  r == 0 ? 0 //[p2+un(p1-p2), p2,p2+un(p3-p2)  ]
  : let (ang = cosineRuleAngle(p1, p2, p3)) //angle between the lines
let (tangD = min(r / tan(ang / 2))) //distance to the tangent point from p2 
tangD;
function a3DtangDround3points(p1, p2, p3, r) =
  r == 0 ? 0 //[p2+un(p1-p2), p2,p2+un(p3-p2)  ]
  : let (ang = -abs(angle(p1-p2, p3-p3))) //angle between the lines
let (tangD = min(r / tan(ang / 2))) //distance to the tangent point from p2 
tangD;
function roundr(a, base = 0.01) = a - (a % base);

function buildNIpolygon(pi,c=6,smooth=0.74)=
let(p=pi==[]?[[rnd(40,80),rnd(-0,30)],[rnd(40,80),rnd(-0,30)],[rnd(40,80),rnd(-0,30)]]:pi)
c<=0? (is_clockwise(p)?p:reverse(p)):
let(np=concat([newpoint(p[0],p[last(p)])],p))
selfintesect(np)?buildNIpolygon(cycle(p,rnd(last(p))),c):buildNIpolygon(cycle(np,rnd(last(np))),c-1 );

function newpoint(a,b)=
//let(bi=rnd(),m=lerp(a,b,bi),mag=norm(a-b),n=ortho(un(a-b)) )m+n*(mag*min(bi,1-bi)*rnd(-1,1)*2)
[rnd(40,80),rnd(-0,26)];

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


 function is_clockwise(p,o )=
 let(Lp1=last(p),Lp=Lp1+1,
sum= sum_vectors([for(i=[0:last(p)])
 let(
n1=p[wrap(i  ,Lp,0)],
n2=p[wrap(i+1,Lp,0)] )
(n2.x-n1.x)*(n2.y+n1.y)])
)
sum>0

;

    function sum_vectors(l) = len(l) > 0 ? [ for(li=l) 1 ] * l : undef;
function zipxyr(a,b)=[for(i=[0:last(a)])[a[i].x,a[i].y,b[i]]];
function getpoints(p)=[for(i=[0:len(p)-1])[p[i].x,p[i].y]];// gets [x,y]list of[x,y,r]list
function getradii(p)= [for(i=[0:len(p)-1])is_num(p[i][2])? p[i][2]: 0 ]; // gets [r]list of[x,y,r]list
function get3points(p)=[for(i=[0:len(p)-1])[p[i].x,p[i].y,p[i].z]];// gets [x,y]list of[x,y,r]list
function get3radii(p)= [for(i=[0:len(p)-1])p[i][3]]; // gets [r]list of[x,y,r]list
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries
function dot (a,b)=a*b; // dotproduct is implied in * of vextoes
function last(i)=len(i)-1;// shorthand sugar for len(i)-1
function reverse(v)=[for (i=[len(v)-1:-1:0])v[i]];
function un(v)=v/max(norm(v),1e-16);// div by zero safe unit normal
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper
function alltrue(a) =
let (b = [
  for (i = a) true]) a == b;
function allfalse(a) =
let (b = [
  for (i = a) false]) a == b;