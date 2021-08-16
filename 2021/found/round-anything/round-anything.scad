// Library: round-anything
// Version: 1.0
// Author: IrevDev
// Copyright: 2017
// License: GPL 3

// Changes
// test module with random points
// reworte most of polyRound . heavily use of wrap function
// move Collinear check to top of round3points, 
// single point (p2) return of round3points in case of mostly collinear 
// less may cause problems with many succesive collinear points
// constrained tangD to the shortest leg p1-p2, or p2-p3
 test();
//callExamples();
 module test()
{
p=[for(i=[0:5])[rnd(0,100),rnd(0,100),rnd(0,100),5]];
 p=[for(i=[0:5])[rnd(0,100),rnd(0,100) ,5]];

//echo(p);
R =a3DpolyRound(p,7);
R = polyRound(p,7);
//polygon(R ); 
 color("red")translate([0,0,0])polyline(getpoints(p),0.2);
  translate([0,0,0])polyline( (R));

 
}
//a3Dround3points([rnd(0,15),rnd(0,15),rnd(0,15)],[rnd(0,15),rnd(0,15),rnd(0,15)],[rnd(0,15),rnd(0,15),rnd(0,15)],rnd(1,5),8);

 


function polyRound(radiipoints,fn=5)=
// reworte most of it all here heavily use of wrap function

 let(p=getpoints(radiipoints)) 
 let(r=getradii(radiipoints))

let(Lp1=last(p),Lp=Lp1+1)
let(temp=[for(i=[0:last(p)]) 
 
round3points(
p[wrap(i-1,Lp,0)],
p[wrap(i  ,Lp,0)],
p[wrap(i+1,Lp,0)],
r[wrap(i,Lp,0)],
fn)

]
 
) 

//common trick  to flatten a list of list
    [for (a = temp)
        for (b = a) b];

function a3DpolyRound(radiipoints,fn=5)=
// reworte most of it all here heavily use of wrap function

 let(p=get3points(radiipoints)) 
 let(r=get3radii(radiipoints))

let(Lp1=last(p),Lp=Lp1+1)
let(
temp=[for(i=[0:last(p)]) 
a3Dround3points(
p[wrap(i-1,Lp,0)],
p[wrap(i  ,Lp,0)],
p[wrap(i+1,Lp,0)],
r[wrap(i,Lp,0)],
fn)])
//common trick  to flatten a list of list
    [for (a = temp)
        for (b = a) b];


function angle (a,b)= (atan2(norm(cross(a,b)),a*b));
function a3Dround3points(p1,p2,p3,r,fn)=
 
let(
p12=p1-p2,
p32=p3-p2,
m12=norm(p12),
m32=norm(p32),
angle123=  (   angle( (p12), (p32))),

a=[m12,0],
b=[0,0],
c=[sin(angle123)*m32,cos(angle123)*m32],


temp= round3points(a,b,c,r,fn)
,e=echo(a,c,angle123,r)
 )
[
for (l = temp)
 p2  
 + (l.x *  c.y + l.y * -c.x )*(1/(a.x*c.y-c.x*a.y)) * (p12) 
 + (l.x * -a.y + l.y *  a.x )*(1/(a.x*c.y-c.x*a.y)) * (p32) 
 
 

 
]

;
function rot(p,a)=[
p.x*cos(a)-p.y*sin(a),
p.x*sin(a)+p.y*cos(a),0];

function round3points(p1,p2,p3,r,fn)=
// move check to top, single point reurn in case of collinear
      dot(un(p1-p2),(p2-p3))>0.98||r==0?[ p2 ]
    : 
    let(ang= (cosineRuleAngle(p1,p2,p3)) )//angle between the lines
// constrained tangD to the shortest leg p1-p2, or p2-p3
    let(tangD=min(norm(p1-p2)/2 ,norm(p2-p3)/2, r/tan(ang/2)))//distance to the tangent point from p2
    let(circD=r/sin(ang/2))//distance to the circle centre from p2
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



 module polyline(p) {for(i=[0:max(0,len(p)-1)]) color(rands(0,1,3) )line(p[i],p[wrap(i+1,len(p) )]);
} // polyline plotter

module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}
function zipxyr(a,b)=[for(i=[0:last(a)])[a[i].x,a[i].y,b[i]]];

function getpoints(p)=[for(i=[0:len(p)-1])[p[i].x,p[i].y ]];// gets [x,y]list of[x,y,r]list
function getradii(p)= [for(i=[0:len(p)-1])p[i][2]]; // gets [r]list of[x,y,r]list
function get3points(p)=[for(i=[0:len(p)-1])[p[i].x,p[i].y,p[i].z]];// gets [x,y,z]list of[x,y,z,r]list
function get3radii(p)= [for(i=[0:len(p)-1])p[i][3]]; // gets [r]list of[x,y,r]list

function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries
function dot (a,b)=a*b; // dotproduct is implied in * of vextoes
function last(i)=len(i)-1;// shorthand sugar for len(i)-1
function un(v)=v/max(norm(v),1e-16);// div by zero safe unit normal
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper
 