/*
ToDo
convexhull


function inter(t,r,Threshold=0)=(t==r)?1:(t>Threshold)?(r<Threshold)? abs(Threshold-t)/abs(t-r) :0 :(r>Threshold)? abs(Threshold-t)/abs(t-r) :1 ;

distance of meta balls
Signed cube - check with R
Rotations - works but scaling breaks bounding
EvalNorm - done
Chamfer and round union - done
Hull
Extrude
Feature sensitive ext marchingcubes
sphere tracing
polyhederon Feature sensitive ext marchingcubes

P
File Load
Field Evaluate
Interacive Ray march/Sphere Trace  
Mesher
*/
 

opU=1;// 1 union
opI=2;// 1 intersection
opS=3;// 1 subtraction
opT=4;// M transformation 4X4 functional
opH=5;// 1 Convex hull
opE=6;// 3 Extrude 2d shape, simple Z extrude of a subtree of Z plane cut (Q collapsed to z=0)
opO=7;// 1 offset usually by distance but xyz surface normal or ambinet occlusion is possiblites
opD=8;// ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]
opX=9;// ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]

cR3=10;// unit radius cube
//named numbers
opc=0; params=1;subTree=2;x=0;y=1;z=2;null3=[0,0,0];tiny=0.01;far=10000;



//scenegraph=
//[opT,[ [ 0,  0, 0],[ 0, 0, 0],[ 1, 1,1]],
//    [[opO,0,
//        [[opX,   10,
//            [
//            [opT,[ [ 30,  20, 0],[ 0, 20, 10],[ 1, 1,1]],
//                [[cR3,[[20,20,80],00]]]],
//           // [opT,[ [  0,  0, 30],[ 10, 0, 30],[ 1, 1, 1]],
//             //   [[cR3,[[10,60,80],1]]]],  
//            [opT,[ [  -40,  10, 0],[ 10, 10, 30],[ 1, 1, 1]],
//                [[cR3,[[20,10,80],10]]]]
//            ]
//        ]]
//    ]]
//]
// ; 
//
//scenegraph=
//[opT,[ [ rnd(-30,30),  rnd(-30,30), 0],[ 0, 0,  0],[ 1,1,1]],
//    [[opT,[ [ 0, 0, 0],[ 0, 0, 0],[ 1, 1,1]],
//        [[opU, 1,
//            [
//                 
//                    [opT,[ [ rnd(-30,30),  rnd(-30,30), 0],[  0, 0,0],[ 1,1 , 1]],
//                        [[cR3,[[rnd(40,60),rnd(40,60),80], [35,15, 5]]]]]
//,
//                    [opT,[ [ rnd(-30,30),  rnd(-30,30), 0],[  0, 0, 0],[ 1 ,1 ,1]],
//                         [[cR3,[[rnd(10,60),rnd(10,60),40], [35,15, 5]]]]]
//,
//                    [opT,[ [ rnd(-30,30),  rnd(-30,30), 0],[  0, 0,0],[ 1 ,1 ,1]],
//                        [[cR3,[[rnd(10,60),rnd(10,60),80], [35,15, 5]]]]]
//
//            ]
//        ]]
//    ]]
//]
// ; 
scenegraph=[opT,[ [ 00,  0, 0],[  0, 0,0],[ 1, 1,1]],
          [[opO,0,
 
   [[cR3,[[rnd(10,80) , rnd(10,80),rnd(10,80)],1]] 

]]
]];

 bon=bound(scenegraph, 20);echo(bon);
//bon=[[-20,-20,-20],[20,20,20],1];echo(bon);
quickuglymarch(scenegraph,bon,4);
*showfield(scenegraph,bon,len3(bon[1]-bon[0])/100);
showbon(bon);
// echo(evalnorm([10 ,10,10],scenegraph));
*for(t=[0:200])  {
start= [rnd(-150,150),rnd(-150,150),0];
trace(start,start,scenegraph);
}
//cube([200,2,2],center=true);
//cube([2,200,2],center=true);
module trace(q,qp,vp,c=70)
{
nm=evalnorm(qp,vp);
n=un([nm[0],nm[1],nm[2]]);
m=max(0.1,abs(nm[3])) ;
*hull(){translate(qp)circle(1);translate(qp+n*m)circle(1);}

if(   len3(qp)<5000&&c>0){trace(q,qp+n*m ,vp,c-1);}else{
//echo( c,round(len3(qp-q)),round(m-len3(qp-q)));
if(len3(qp)>5000)translate([0,0,2])translate(qp) cylinder (1,m,m,center=true,$fn=100);

}


}

function eval(p,scene)=parse(p,scene);

function parse(q,scene)=
let( opcode=scene[opc],p=scene[params])
//if code  then
opcode== opX ? parseopX(q,p,scene[subTree]): // 9 experimental
opcode== opU ? parseopU(q,p,scene[subTree]): // 1
opcode== opI ? parseopI(q,p,scene[subTree]): // 2
opcode== opS ? parseopS(q,p,scene[subTree]): // 3
opcode== opT ? parseopT(q,p,scene[subTree]):  //4
opcode== opH ? parseopH(q,p,scene[subTree]):  //5 hull behaves like union for now:
opcode== opE ? parseopE(q,p,scene[subTree]):  //6
opcode== opO ? parseopO(q,p,scene[subTree]):  //7
opcode== opD ? parseopT(q,null3,scene[subTree])://8 deform behaves like null trnasform for now
opcode== cR3 ? cR3(q,p): //10
0;

function parseopH(q,p,scene)=let(vp=[opU,0,[for(i=[0:len(scene)-1]) scene[i]]], e=eval(q,vp)) 
Hulltrace(q,q ,vp)
;

function parseopE(q,p,scene)=min([for(i=[0:len(scene)-1]) max(eval([q.x,q.y,0],scene[i]), max(0,abs(q.z))-p) ]);
function parseopX(q,p,scene)=pow(addl([for(i=[0:len(scene)-1]) pow(eval(q,scene[i]),2) ]),1/2);
function parseopU(q,p,scene)=minl([for(i=[0:len(scene)-1]) eval(q,scene[i])],p);
function parseopI(q,p,scene)=maxl([for(i=[0:len(scene)-1]) eval(q,scene[i])],p);
function parseopS(q,p,scene)=maxR(  -minl([for(i=[1:max(1,len(scene)-1)]) eval(q,scene[i])],p), eval(q,scene[0]),p);
function parseopO(q,p,scene)=Offs(min([for(i=[0:len(scene)-1]) eval(q,scene[i])]),p);
function parseopT(q,M,scene)=min([for(i=[0:len(scene)-1]) eval(Transf(q,M),scene[i])]); 
function  Transf(q,M)= invtransform(q,M[0],M[1],M[2]);
function  Offs(q,M)=q-M; 
//function Clampz(q,p)=[q[x],q[y],0];
function Hulltrace(q,qp,vp,c=8)=
let(nm=evalnorm(qp,vp),n=[nm[0],nm[1],nm[2]],m=nm[3]  )
c>0?
Hulltrace(q,qp+(n*max(1,abs(m))) ,vp,c-1): 
//eval(q+un(q)*far,vp)-len3(q-(un(qp-q)*far))
len3(qp-q)-m 

;


function cR3(op,params)= 
let(ch=min(params[1],min(params[0].x ,params[0].y ,params[0].z )),p=max3(abs3(op) -(params[0])+[ch,ch,ch]  ,0),
 
q=
p.x -ch>  (p.y+p.z)?len3(p-[ch,0,0]):    
p.y-ch>  (p.x+p.z)?len3(p-[0,ch,0]):  
p.z-ch>  (p.y+p.x)?len3(p-[0,0,ch]):
max( 
dot( un([1,1,1]),(p) ) /0.7967329 -ch*0.7967329,
dot( un([0,1,1]),(p) )   -ch*0.7967329,
dot( un([1,0,1]),(p) )   -ch*0.7967329,
dot( un([1,1,0]),(p) )   -ch*0.7967329
)
)
q
; 
function p2p(p,b=un([1,1,1]),a=[0,0,0])=
    let( 
    ap = p-a,
    ab = b-a
    )a + dot(ap,ab)/dot(ab,ab) * ab 
    ;
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////


    
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function rndc(a = 1, b = 0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function un(v) = v / max(len3(v), 0.000001) * 1;
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
//function len3q(v,q=3) =len(v)>1?pow(addl([for(i=[0:len(v)-1])pow(v[i], q)]),1/q):len(v)==1?v[0]:v; 
function invtransform(q,T,R,S)=
let(p= q )
Vdiv(t([p.x, p.y, p.z, 1]*m_translate(T*-1)*m_rotate(R*-1)),S)  ; 
function abs3(v)=[abs(v[0]),abs(v[1]),abs(v[2])];
function max3(a,b)=[max(a[0],b),max(a[1],b),max(a[2],b)];
function min3(a,b)=[min(a[0],b),min(a[1],b),min(a[2],b)];
function Vmul(v1,v2)=[v1[0]*v2[0],v1[1]*v2[1],v1[2]*v2[2]];
function Vdiv (v1,v2)=[v1[0]/v2[0],v1[1]/v2[1],v1[2]/v2[2]];
function roundp(a,p=0.01)=a-(a%p); 
function t(v) = [v.x, v.y, v.z];
 function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];

function avrg(l)=len(l)>1?addl(l)/(len(l)-1):l;
// function bound(v)=[[minls(v,0),minls(v,1),minls(v,2)], [maxls(v,0),maxls(v,1),maxls(v,2)]];
function minl(l,r,c=0)=c<len(l)-1?minR(l[c],minl(l,r,c+1),r):l[c];
function maxl(l,r,c=0)=c<len(l)-1?maxR(l[c],maxl(l,r,c+1),r):l[c];

function  minR(  d1,   d2,   r) =r>0? let( m = min(d1, d2))(abs(d1) < abs(r) &&  abs(d2)< abs(r)) ||(d1 < r &&  d2 < r) ?min (m, r-len3([ r - d1,r -  d2]) ) :m:let( m = min(d1, d2),rr=-r)(d1 < rr &&  d2 < rr) ?min (m, len3([ d1, d2]) -rr):m;   




function  maxR(  d1,   d2,   r) = let( m = max(d1, d2))  (d1 > -r &&  d2> -r)   ? max(m,-r+len3([ -r-d1, -r-d2])) :m ;

function  maxCH(  d1,   d2,   r) = -minCH(-d1,-d2,r)   ;

function  minCH(  d1,   d2,   r) = let( m = min( d1,  d2))  ( d1 <r &&  d2<r )   ?  min(m,  d1 +  d2 - r) : m ;

function m_rotate(v) =  [ [1,  0,         0,        0],
                      [0,  cos(v.x),  sin(v.x), 0],
                      [0, -sin(v.x),  cos(v.x), 0],
                      [0,  0,         0,        1] ]
                  * [ [ cos(v.y), 0,  -sin(v.y), 0],
                      [0,         1,  0,        0],
                      [ sin(v.y), 0,  cos(v.y), 0],
                      [0,         0,  0,        1] ]
                  * [ [ cos(v.z),  sin(v.z), 0, 0],
                      [-sin(v.z),  cos(v.z), 0, 0],
                      [ 0,         0,        1, 0],
                      [ 0,         0,        0, 1] ];

function m_translate(v) = [ [1, 0, 0, 0],
                        [0, 1, 0, 0],
                        [0, 0, 1, 0],
                        [v.x, v.y, v.z, 1  ] ];

function m_scale(v) =    [ [v.x, 0, 0, 0],
                        [0, v.y, 0, 0],
                        [0, 0, v.z, 0],
                        [0, 0, 0, 1 ] ];

function evalnorm(q,v)=
let(e=eval(q,v))
[
e-eval([q.x-tiny,q.y,q.z],v),
e-eval([q.x,q.y-tiny,q.z],v),
e-eval([q.x,q.y,q.z-tiny],v),
e
];
        function bound(scene, steps=20)  = let(
        up= findbound([0,0,1],scene),
        down= -findbound([0,0,-1],scene),
        north= findbound([0,1,0],scene),
        south=  -findbound([0,-1,0],scene),
        west= findbound([1,0,0],scene),
        east=  -findbound([-1,0,0],scene)
        )
        [[east,south, down] ,
        [west,north,up],steps ]
        ;
        function findbound (v,scene=scenegraph)=
        let(
        VeryFar=9999999,
        p1=un(v)* VeryFar,
        p2=p1+un(v) *100,
        e1=eval(p1,scene),
        e2=eval(p2,scene),
        scale= abs(e2-e1)/100 ,
        corrected=(e1/scale),
        distance=(VeryFar)-corrected
        )
        //[p1,p2,e1,e2,scale,corrected,distance ]
        distance;

// function maxls(l,select=0,c=0)=c<len(l)-1?max(l[c][select],maxls(l,select,c+1)):l[c][select];
// function minls(l,select=0,c=0)=c<len(l)-1?min(l[c][select],minls(l,select,c+1)):l[c][select];


module showbon(bon){
translate([bon[0][0],bon[0][1],bon[0][2]])cube(5);
translate([bon[1][0],bon[0][1],bon[0][2]])cube(5);
translate([bon[1][0],bon[1][1],bon[0][2]])cube(5);
translate([bon[0][0],bon[1][1],bon[0][2]])cube(5);
translate([bon[0][0],bon[0][1],bon[1][2]])cube(5);
translate([bon[1][0],bon[0][1],bon[1][2]])cube(5);
translate([bon[1][0],bon[1][1],bon[1][2]])cube(5);
translate([bon[0][0],bon[1][1],bon[1][2]])cube(5);
}
module showfield(scene,bon,s=2) {

S= len3(bon[1]-bon[0]);

for(
iy=[bon[0][1] -S*0.2  :s :bon[1][1]+S*0.2  ]){

for(ix=[bon[0][0]  -S*0.2 :s :bon[1][0] +S*0.2  ])
{
e=eval([ix ,iy,0],scene);
r=min(0,sign(-e))*sin(e *20);
g=1/max(1,abs(e));
b=sin(e *20)*min(1,-min(0,e));
color([abs(r),abs(g),abs(b)])translate([ix,iy,-1])square(s,center=true);
}
}}
module quickuglymarch(scene,bon,d=5){
*showbon(bon);
S=len3(bon[1]-bon[0]);
ixmin=bon[0][0];iymin=bon[0][1];izmin=bon[0][2];ixmax=bon[1][0];iymax=bon[1][1];izmax=bon[1][2];
e1=eval([ixmin ,iymin,izmin],scene); 
if(e1<S*1.1){
e2=eval([ixmax ,iymin,izmin],scene);
e3=eval([ixmax ,iymax,izmin],scene);
e4=eval([ixmin,iymax,izmin],scene);
e5=eval([ixmin,iymin,izmax],scene);
e6=eval([ixmax ,iymin,izmax],scene);
e7=eval([ixmax ,iymax,izmax],scene);
e8=eval([ixmin,iymax,izmax],scene);
S=(bon[1]-bon[0])*0.5;step=bon[2];
sl=len3(S)* 0.866025 ;
if(d==0||(e1>sl&& e2>sl&& e3>sl&& e4>sl&& e5>sl&& e6>sl&& e7>sl&& e8>sl)

||(
-e1>sl&&
-e2>sl&&
-e3>sl&& 
-e4>sl&& 
-e5>sl&& 
-e6>sl&& 
-e7>sl&& 
-e8>sl)
)
{

hull (){
if (e1<0)translate([ixmin,iymin,izmin])sphere(tiny);
if (e2<0)translate([ixmax,iymin,izmin])sphere(tiny);
if (e3<0)translate([ixmax,iymax,izmin])sphere(tiny);
if (e4<0)translate([ixmin,iymax,izmin])sphere(tiny);
if (e5<0)translate([ixmin,iymin,izmax])sphere(tiny);
if (e6<0)translate([ixmax,iymin,izmax])sphere(tiny);
if (e7<0)translate([ixmax,iymax,izmax])sphere(tiny);
if (e8<0)translate([ixmin,iymax,izmax])sphere(tiny); 
}}

else
{
T1=[ixmin ,iymin,izmin] ; quickuglymarch( scene,[T1,T1+S,step],d-1);
T2=[ixmin +S.x,iymin,izmin] ; quickuglymarch( scene,[T2,T2+S,step],d-1);
T3=[ixmin +S.x,iymin+S.y,izmin] ; quickuglymarch( scene,[T3,T3+S,step],d-1);
T4=[ixmin ,iymin+S.y,izmin] ; quickuglymarch( scene,[T4,T4+S,step],d-1);

T5=[ixmin ,iymin,izmin +S.z] ; quickuglymarch( scene,[T5,T5+S,step],d-1);
T6=[ixmin +S.x,iymin,izmin+S.z] ; quickuglymarch( scene,[T6,T6+S,step],d-1);
T7=[ixmin +S.x,iymin+S.y,izmin+S.z] ; quickuglymarch( scene,[T7,T7+S,step],d-1);
T8=[ixmin ,iymin+S.y,izmin+S.z] ; quickuglymarch( scene,[T8,T8+S,step],d-1);
}

}
}
function push(p,model,c=5)=let(q=evalnorm(p,model)) p+un([q.x,q.y,q.z])*  (-q[3] )  ; 
