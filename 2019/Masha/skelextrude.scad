 
 template =[
   [[ -55,0,25+rnd(-1,1)*20], [40+rnd(-1,1)*10,30+rnd(-1,1)*5,10]*sin(24)],
  [[ -35,0,30+rnd(-1,1)*20], [40+rnd(-1,1)*20,20+rnd(-1,1)*10,10]*sin(45)],
 [[ -20,0,20+rnd(-1,1)*10], [40+rnd(-1,1)*20,40+rnd(-1,1)*10,10]*sin(90)],
   
 [[20,0, 30+rnd(-1,1)*20], [40+rnd(-1,1)*20,20+rnd(-1,1)*10,10]*sin(135)],
  [[50+rnd(-1,1)*10,0,20+rnd(-1,1)*10], [40+rnd(-1,1)*10,30+rnd(-1,1)*10,10]*sin(150)],
 [[90+rnd(-1,1)*15,0,40+rnd(-1,1)*20], [20+rnd(-1,1)*10,10+rnd(-1,1)*10,10]*sin(170)],
 ];
 
 
 tom =[ for(t=[0:1/12:1]) smooth_animate_open(t,template)  ];
 
 
 
  bones1 =[ for(t=[1:len(tom)-1]) [tom[t-1][0],tom[t][0],tom[t-1][1]]  ];
legs=[
//  [smooth_animate_open(0.5,template)[0],[-10,30,20],[10,10,10]],
//  [[-10,30,20],[-10,40,10],[10,10,10]],
//    [[-10,40,10],[-10,40,0],[10,10,10]],
//  
//  [smooth_animate_open(0.5,template)[0],[-10,-30,20],[10,10,10]],
//  [[-10,-30,20],[-10,-40,10],[10,10,10]],
//    [[-10,-40,10],[-10,-40,0],[10,10,10]], 
// 
  
//  [smooth_animate_open(0.40,template)[0],[-20,-20,20],[10,10,5]],
//  [[-20,-20,20],[-20,-30,10],[10,10,5]],
//    [[-20,-30,10],[-20,-30,0],[10,10,5]], 
//    [smooth_animate_open(0.40,template)[0],[-20,20,20],[10,10,5]],
//  [[-20,20,20],[-20,30,10],[10,10,5]],
//    [[-20,30,10],[-20,30,0],[10,10,5]], 
  
  [smooth_animate_open(0.70,template)[0],[20,-30,20],[20,10,10]],
  [[20,-30,20],[20,-40,10],[16,13,10]],
    [[20,-40,10],[20,-40,0],[10,10,10]], 
    [smooth_animate_open(0.70,template)[0],[20,30,20],[20,10,10]],
  [[20,30,20],[20,40,10],[16,13,10]],
    [[20,40,10],[20,40,0],[10,10,10]], 
 
  ];
 

 bones = concat(bones1  ,legs);
//faces=[
//[[10,10,10],[10,-10,10],[-10,-10,10],[-10,10,10]],
//[[10,10,-10],[-10,10,-10],[-10,-10,-10],[10,-10,-10]],
//[[10,10,10],[10,10,-10],[10,-10,-10],[10,-10,10]],
//[[-10,10,10],[-10,-10, 10],[-10,-10,-10],[-10,10,-10]],
//[[10,10,10],[-10,10,10],[-10,10,-10],[10,10,-10]],
//[[10,-10,10],[10,-10,-10],[-10,-10,-10],[-10,-10,10]],
// ];

//polyline_open(tom);


res=skelextrude(bones,undef,b=0,p=0);
 for (i=res)  polyhedron([avrgp(i),i[0],i[1],i[2],i[3]],[[0,1,2],[0,2,3],[0,3,4],[0,4,1]]);
 //for (i=bones) line(i[0],i[1],1.26);


function skelextrude(bones,polys,b=0,p=0 )=


let (
 polys=is_undef(polys)? ignitePolys(bones[0]): polys,
 $bones=bones,
bone=bones[b],
face=polys[p],
hit= doesIntersect(face,bone),
//en=echo(str("hit ",hit)),
 noChange=!hit,
 npolys = hit? extrudeFace(polys, p, min(norm(bone[1]-bone[0]),bone[2].z) * un(bone[1]-bone[0]),bone[2] ):polys
//npolys = hit? extrudeFace(polys, p, 2*-faceNormal(face) ):polys
)

 hit?skelextrude(bones,npolys,0,p ):
b<len(bones)-1?skelextrude(bones,npolys,b+1,p ):
p<len(polys)-1?skelextrude(bones,npolys,0,p+1 ):

npolys

;

function ignitePolys(bone)=
 let(
 nc=lerp(bone[0],bone[1],0.0),
 initialUp= [0,0,1],

 w=un(v3(bone[1])-v3(bone[0])),
 u=cross(w,initialUp) ,
 v=cross(w,u) ,
 mv=v*bone[2].x*0.5,
 mu=u*bone[2].y*0.5,
 
 
 newFace=[
 nc+mu+mv,
 nc+mu-mv,
 nc-mu-mv,
 nc-mu+mv,
 ],
 backFace=[
newFace[3],newFace[2],newFace[1],newFace[0]
 ]
 )
[newFace,backFace]
;

function extrudeFace(p,s,n,scl)=

let(
 poly=[for ( i= [0:len(p)-1]) if (i!=s)p[i] ],
  oldFace=p[s],
 oc= (oldFace[0]+oldFace[1]+oldFace[2]+oldFace[3])/4,
 initialUp= un(((oldFace[1]+oldFace[2])/2)-oc),
 nc= (oc+n),
 l=norm(n),
 //nc= (oc+n),
 w=un(n),
 u=cross(w,initialUp) ,
 v=cross(w,u) ,
 mv=v*scl.x*0.5,
 mu=u*scl.y*0.5,
 
 
 newFace=[
 nc+mu+mv,
 nc+mu-mv,
 nc-mu-mv,
 nc-mu+mv,
 ],
 
//imFace= addTo( addTo( addTo(oldFace ,-oc)*1 ,oc) ,n),  nc=oc+n,
// l=((norm(imFace[0]-imFace[2])+norm(imFace[0]-imFace[2]))/4) ,
 
//rotFace=[
//nc+un(point2plane(imFace[0],nc,un(n))-nc )*l,
//nc+un(point2plane(imFace[1],nc,un(n))-nc )*l,
//nc+un(point2plane(imFace[2],nc,un(n))-nc )*l,
//nc+un(point2plane(imFace[3],nc,un(n))-nc )*l,
// 
//  ],
 

// newFace=  fit2field( imFace ),

// imc= (im2face[0]+im2face[1]+im2face[2]+im2face[3])/4,
//im3Face=  addTo( addTo(im2face ,-imc)  ,nc)  ,
//mp01=lerp(im3Face[0],im3Face[1],0.5),
//mp12=lerp(im3Face[1],im3Face[2],0.5),
//mp23=lerp(im3Face[2],im3Face[3],0.5),
//mp30=lerp(im3Face[3],im3Face[0],0.5),
// 
//l1=norm(mp01-mp23),
//l2=norm(mp12-mp30),
//sql=(max(l1,l2)-((l1+l2)/2))*0.5,
//un1=un(mp01-mp23)*sql,
//un2=un(mp12-mp30)*sql,
//
//
//
//newFace=[
//im3Face[0]+un1-un2,
//im3Face[1]+un1+un2,
//im3Face[2]-un1+un2,
//im3Face[3]-un1-un2,
//
//],

extrusion=     [newFace,
  [newFace[1],newFace[0],oldFace[0],oldFace[1]],
  [newFace[2],newFace[1],oldFace[1],oldFace[2]],
  [newFace[3],newFace[2],oldFace[2],oldFace[3]],
  [newFace[0],newFace[3],oldFace[3],oldFace[0]]

]




)
concat (poly,extrusion)
;
function addTo (p,a)= [for (i=p)i+a];
    

function fit2field(poly)=
 
[fitsinglepoint(poly[0]),fitsinglepoint(poly[1]),fitsinglepoint(poly[2]),fitsinglepoint(poly[3])]
;
function clamp(v,a,b)=min(max(min(a,b),v),max(a,b));


function fitsinglepoint(p ,c=15)= c>0? 
let(probe=evalnorm(p))
let(np= p- un( v3(probe))*probe[3] *0.75) fitsinglepoint(np ,c-1):p;  
    
//function fitCenterPoint(p ,c=15)= c>0? 
//let(probe=evalnorm(p))
//let(np= p + un( v3(probe))*abs(probe[3])  ) fitCenterPoint(np ,c-1):p;  
//    

function eval(p)=
 
min([for(i=$bones) dist2bone(p,i,10)])
;
function evalnorm(q  ) =
let (tiny = 0.000001, 
e = eval(q))
[
eval([q.x + tiny, q.y, q.z]  ) - eval([q.x - tiny, q.y, q.z]  ),
eval([q.x, q.y + tiny, q.z]  ) - eval([q.x, q.y - tiny, q.z]  ), 
eval([q.x, q.y, q.z + tiny]  ) - eval([q.x, q.y, q.z - tiny]  ),
e];

function dist2bone(p,bone,r)=
let ( 
a=bone[0], 
b=bone[1],
pa = p - a,
ba = b - a,
h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 ))
norm( pa - ba*h ) - r
;


function doesIntersect (poly,bone)=
!is_list(poly)||!is_list(bone)?false:
 len(poly) !=4|| len (bone)!=3?false:

let (
//e=echo(len(poly),len(bone)),
 
intersectPlane= sign(distanceFromPlane (poly,bone[0])) != sign(distanceFromPlane (poly,bone[1])) ,
insideAB=0>sign(distanceFromPlane ([bone[0],poly[0],poly[1]],bone[1])),
insideBC=0>sign(distanceFromPlane ([bone[0],poly[1],poly[2]],bone[1])),
insideCD=0>sign(distanceFromPlane ([bone[0],poly[2],poly[3]],bone[1])),
insideDA=0>sign(distanceFromPlane ([bone[0],poly[3],poly[0]],bone[1])))
intersectPlane&&insideAB&&insideBC&&insideCD&&insideDA
 
;

function distanceFromPlane (poly,vertex)=
let( N=faceNormal(poly), P= poly[0] )
dot (N,vertex-P)
;


function smooth_animate_open(t,v,sharp=0)=let(
ll=len(v) -1,        
  i=round(ll*t),    
  T= ((ll*t+0.5)%1) , 
  p1=    v[ i ], 
  
  
p00=     lerp(v[   i-1], p1,0.5),
p0=     lerp(v[   i-1], p1,0.5),
p2=    lerp( p1,v[  (i+1)],0.5),
p22=    lerp( p1,v[  (i+1)],0.5) ) 

i==0?lerp(p1-(p2-p1),p2,(T)):
i==ll?lerp(p0,p1-(p0-p1),(T)):

lerp(lerp( p0,p1,T),lerp(p1,p2,T),(T)) ;


 module polyline_open(p) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1]);
} // polyline plotter


module line(p1, p2 ,width=0.1) 
{ // single line plotter
 color(p1[4])   hull() {
        translate(v3(p1))scale(p1[3]) sphere(1);
        translate(v3(p2))scale(p2[3]) sphere(1);
    }
}




// polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
hull() {
translate(p1) sphere(width);
translate(p2) sphere(width);
}
}
function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
(rands(min(a, b), max(   a, b), 1)[0]) 
: 
(rands(min(a, b), max(a, b), 1, s)[0])
; 
function rndc(a=1,b=0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function dot(a,b)=a*b;
function heron(a, b, c) =
let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));
function polyarea(p1, p2, p3) = heron(norm(p1 - p2), norm(p2 - p3), len3(p2 - p1));
function un(v)=is_list(v)? v/max( is_undef(norm(v))?0:norm(v),1e-16):v;

//function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;

function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;

 function addlp(v, i=0, r=[0,0,0]) = i<len(v) ? addlp(v, i+1, r+v[i]) : r;

function faceNormal(v)= len(v)>3?un(faceNormal([v[0],v[1],v[2]])
+faceNormal(concat([v[0]],[for(i=[2:len(v)-1])v[i]]))):
    
let(u=v[0]-v[1],w=v[0]-v[2] 
)
un(  [u[1]*w[2]-u[2]*w[1],u[2]*w[0]-u[0]*w[2],u[0]*w[1]-u[1]*w[0]]
);

function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] *
v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);
function v3(p) = [p.x, p.y, p.z]; // vec3 formatter
