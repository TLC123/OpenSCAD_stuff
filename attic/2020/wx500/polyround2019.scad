//p=mirrorPolyline([[-1,-4,11,4],[-10,0,14,4],[-12,20,20,4],[-20,50,40,4],[-20,80,40,4],[-20,110,30,4],[-10,100,0,4],[-10,0,0,5],[-20,5,5,4],[-20,5,16,2],[-10,4,12,4] ]);

//polyline(p);
// 
//
// color ("yellow")polyline (polyRound(let(ip=([for (i=[0:3])[rnd(0,30),rnd(0,100),rnd(0,30),2+rnd(2)] ]))
//     mirrorPolyline([for(i=[0:0.5:len(ip)-1]) i==floor(i)?ip[i]: ip[i]+
//     [
// floor(rnd(2))==0? 0:max(0,rnd(10,20)*sign(rnd(-1,1))),
// floor(rnd(6))==0? 0:rnd(10,20)*sign(rnd(-1,1)),
// floor(rnd(2))==0? 0.01:rnd(10,20)*sign(rnd(-1,1)),
// 0(0,30),2+rnd(2)] ]))
//     mirrorPolyline([for(i=[0:0.5:len(ip)-1]) i==floor(i)?ip[i]: ip[i]+
//     [
// floor(rnd(2))==0? 0:max(0,rnd(10,20)*sign(rnd(-1,1))),
// floor(rnd(6))==0? 0:rnd(10,20)*sign(rnd(-1,1)),
// floor(rnd(2))==0? 0.01:rnd(10,20)*sign(rnd(-1,1)),
// 0
// ]  ])) ,2.5);
// ]  ])) ,1.5);
// 
// color ("darkgrey")polyline (polyRound(let(ip=([for (i=[0:2])[rnd(0,30),rnd(0,100),rnd


function polyRound(radiipoints,fn=5)=
// reworte most of it all here heavily use of wrap function
let(p=getpoints(radiipoints)) 
let(r=getradii(radiipoints))
let(Lp1=last(p),Lp=Lp1+1) 
let(
temp=[for(i=[0:last(p)]) 
round3points(
[ p[wrap(i-1,Lp,0)], p[wrap(i  ,Lp,0)], p[wrap(i+1,Lp,0)]],
r[i],
fn)])   //common trick  to flatten a list of list
[for (a = temp )        for (b = a) b];






 
 


function round3points(v,r,fn=6)=let(
p0=v[0],p1=v[1],p2=v[2],
n01=un(p0-p1),
n21=un(p2-p1),
planeNormal=un(cross(n21,n01)),
 

midLineNormal=un(n01 +n21),
 
angle=angle(n21,n01),
tanD=r /sin(angle/2),
 
center=p1+  midLineNormal*( tanD)
 

)
concat(
 [ for(i=[-.5:1/fn:.5])
    
center+ rotateAxis(   -midLineNormal*r ,planeNormal,(-i)*angle +180*i )    
] );

 
function angle (a,b)=atan2(sqrt((cross(a,b)*cross(a,b))),(a* b));
function dot(v1,v2) = v1[0]* v2[0]+ v1[1]* v2[1]+ v1[2]* v2[2];
function dot4(v1,v2) = v1[0]* v2[0]+ v1[1]* v2[1]+ v1[2]* v2[2]+ v1[3]* v2[3];

function point2plane(p,o,n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane
function dist_point2plane(p,o,n) =
let (v = p-o) ( (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane
function mirrorPolyline(v)= [each v, each rev([for (i=v)[-i.x,i.y,i.z,i[3]]])] ;

function v3(p) = [p.x,p.y,p.z]; // vec3 formatter
function rev(v) = [for (i = [len(v) - 1: -1: 0]) v[i]];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;
function addlp(v,i=0,r=[0,0,0]) = i<len(v) ? addlp(v,i+1,r+v[i]) : r;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v)=assert (is_list(v)) v/max(norm(v),1e-64) ;
function rndc(a = 1,b = 0,s = [])=[rnd(a,b,s),rnd(a,b,s),rnd(a,b,s)];
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
function getpoints(p)=[for(i=p)[i.x,i.y,i.z]];// gets [x,y]list of[x,y,r]list
function getradii(p)= [for(i=p)is_num(i[3])? i[3]: 0 ]; // gets [r]list of[x,y,r]list
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries
function last(i)=len(i)-1;// shorthand sugar for len(i)-1

module polyline(p,r=1) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p) )],r);}

module polyline_open(p,r=1) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1],r);
} // polyline plotter

module line(p1,p2 ,width=1) 
{ // single line plotter
hull() {
translate(v3(p1)) sphere(width);
translate(v3(p2)) sphere(width);
}
}

module 3dcircle(r,n)
{
axis=cross([0,0,1],n);
theta=angle ([0,0,1],n);
rotate (theta,axis) circle(r);
}


 function rotateAxis(point,axis,angle)=RotateQuat(BuildQuat(axis,angle), point);

function  /*vec4*/  NormQuat(/*vec4*/q)=
 let(     lenSQ =  dot4(q, q),     invLenSQ = 1./lenSQ)     q*invLenSQ;
 

function /*vec4*/ BuildQuat(/*vec3*/  axis,   angle)= 
     NormQuat(concat(axis *sin(angle*0.5),[ cos(angle*0.5)]));


 function /*vec3*/RotateQuat(/*vec4*/q, /*vec3*/v)=
let(    /*vec3*/ t = 2.*cross([q.x,q.y,q.z], v)     )    v + q[3]*t + cross([q.x,q.y,q.z], t);




//
// function /*vec4*/MulQuat(/*vec4*/q1, /*vec4*/q2)=
//{
//    /*vec4*/res = vec4(0.);
//    res.w   = q1.w*q2.w - dot(q1.xyz, q2.xyz);
//    res.xyz = q1.w*q2.xyz + q2.w*q1.xyz + cross(q1.xyz, q2.xyz);
//     NormQuat(res);
//}
//
// 
//    
//
//
function fromTo(/*vec3*/p,/*vec3*/q)=
 
 acos(dot(p,q));

 
// function /*vec4*/quatLookAt(/*vec3*/forward,/*vec3*/up){
//    forward=normalize(forward);
//    up=normalize(up);
//  (BuildQuat(cross(forward,up),fromTo(forward,up)));
//}
//
//
// function /*vec4*/quatInv(in /*vec4*/q)=
//{
//     vec4(-q.xyz, q.w);
//}
