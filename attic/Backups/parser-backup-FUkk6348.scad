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
opc=0; params=1;subra=2;x=0;y=1;z=2;null3=[0,0,0];tiny=0.01;far=1000000;
 
 

//field=
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
field=
[opT,[ [ 0,  0, 0],[ 0, 0, 0],[ 1, 1,1]],
    [[opU,0,
        [[opH, 0,
            [
                 
                    [opT,[ [ 30,  0, 0],[  0, 0, 10],[ 1, 1,1]],
                        [[cR3,[[50,50,50], 1]]]],
                    [opT,[ [  30,  40,  0],[ 0, 0, 31],[ 1, 1, 1]],
                         [[cR3,[[10, 40,10],2]]]],
                    [opT,[ [  -30,  0, 0],[ 0, 0, 30],[ 1, 1, 1]],
                        [[cR3,[[20,20,20], 1]]]]

            ]
        ]]
    ]]
]
 ; 

bon=bound(field,60,20);
 *quickuglymarch(field,bon,5);
 showfield(field,bon,2);
showbon(bon);
echo(len3([0.5,0.5,0.5])); 
echo(evalnorm([10 ,10,10],field)); 
echo(roundp(far/eval([0,0,far],field)));
echo(field);





function opH(q,p,v)=let(vp=[opU,0,[for(i=[0:len(v)-1]) v[i]]], e=eval(q,vp)) 
 Hulltrace(q,q ,vp)
 ;

 function opE(q,p,v)=min([for(i=[0:len(v)-1]) max(eval([q.x,q.y,0],v[i]), max(0,abs(q.z))-p) ]);
function opX(q,p,v)=pow(addl([for(i=[0:len(v)-1]) pow(eval(q,v[i]),2) ]),1/2);
function opU(q,p,v)=minl([for(i=[0:len(v)-1]) eval(q,v[i])],p);
function opI(q,p,v)=maxl([for(i=[0:len(v)-1]) eval(q,v[i])],p);
function opS(q,p,v)=maxR(  -minl([for(i=[1:max(1,len(v)-1)]) eval(q,v[i])],p), eval(q,v[0]),p);
function opO(q,p,v)=Offs(min([for(i=[0:len(v)-1]) eval(q,v[i])]),p);
function opT(q,M,v)=min([for(i=[0:len(v)-1]) eval(Transf(q,M),v[i])]); 
function Transf(q,M)= invtransform(q,M[0],M[1],M[2]);
function Offs(v,M)=v-M; 
//function Clampz(q,p)=[q[x],q[y],0];



function cR3(q,r)=let(d = abs3(q) - (r[0] -[r[1],r[1],r[1]] ))min(max(d.x,d.y,d.z),0.0) + len3(max3(d,0.0)) -r[1]; 
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

function Hulltrace(q,qp,vp,c=7)=
let(nm=evalnorm(qp,vp),n=[nm.x,nm.y,nm.z],m=nm[3]  )
c>0?
Hulltrace(q,qp+n*m,vp,c-1):
eval(un(qp-q)*far,vp)-len3(q-(un(qp-q)*far)) 
//eval(q+n*far,vp)-len3(q-(un(qp-q)*far))

;
        

function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function rndc(a = 1, b = 0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function un(v) = v / max(len3(v), 0.000001) * 1;
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
//function len3q(v,q=3) =len(v)>1?pow(addl([for(i=[0:len(v)-1])pow(v[i], q)]),1/q):len(v)==1?v[0]:v; 
function invtransform(q,T,R,S)=let(p=q)Vdiv(t([p.x, p.y, p.z, 1]*m_translate(T*-1)*m_rotate(R*-1)),S)  ; 
function abs3(v)=[abs(v[0]),abs(v[1]),abs(v[2])];
function max3(a,b)=[max(a[0],b),max(a[1],b),max(a[2],b)];
function min3(a,b)=[min(a[0],b),min(a[1],b),min(a[2],b)];
function Vmul(v1,v2)=[v1[0]*v2[0],v1[1]*v2[1],v1[2]*v2[2]];
function Vdiv (v1,v2)=[v1[0]/v2[0],v1[1]/v2[1],v1[2]/v2[2]];
function roundp(a,p=0.01)=a-(a%p); 
function t(v) = [v.x, v.y, v.z];

function avrg(l)=len(l)>1?addl(l)/(len(l)-1):l;
// function bound(v)=[[minls(v,0),minls(v,1),minls(v,2)], [maxls(v,0),maxls(v,1),maxls(v,2)]];
function minl(l,r,c=0)=c<len(l)-1?minR(l[c],minl(l,r,c+1),r):l[c];
 function maxl(l,r,c=0)=c<len(l)-1?maxR(l[c],maxl(l,r,c+1),r):l[c];

function  minR(  d1,   d2,   r) =r>0? let( m = min(d1, d2))(abs(d1) < abs(r) &&  abs(d2)< abs(r)) ||(d1 < r &&  d2 < r) ?min (m, r-len3([ r - d1,r -  d2]) ) :m:let( m = min(d1, d2),rr=-r)(d1 < rr &&  d2 < rr) ?min (m, len3([ d1, d2]) -rr):m;   



 
function  maxR(  d1,   d2,   r) = let( m = max(d1, d2))  (d1 > -r &&  d2> -r)   ? max(m,-r+len3([ -r-d1, -r-d2])) :m ;

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

function eval(q,v)=
let( opcode=v[opc],p=v[params])
//if code  then
opcode== opX ? opX(q,p,v[subra]): // 9 experimental
opcode== opU ? opU(q,p,v[subra]): // 1
opcode== opI ? opI(q,p,v[subra]): // 2
opcode== opS ? opS(q,p,v[subra]): // 3
opcode== opT ? opT(q,p,v[subra]):  //4
opcode== opH ? opH(q,p,v[subra]):  //5 hull behaves like union for now:
opcode== opE ? opE(q,p,v[subra]):  //6
opcode== opO ? opO(q,p,v[subra]):  //7
opcode== opD ? opT(q,null3,v[subra])://8 deform behaves like null trnasform for now
opcode== cR3 ? cR3(q,p): //10
0;
function evalnorm(q,v)=
let(e=eval(q,v))
un([
e-eval([q.x-tiny,q.y,q.z],v),
e-eval([q.x,q.y-tiny,q.z],v),
e-eval([q.x,q.y,q.z-tiny],v),
e
]);
function bound(field,maxspan=50,steps=20)  = let(
top=far-eval([0,0,far],field), //* roundp(far/eval([0,0,far],field)) ,
bottom=-(far-eval([0,0,-far],field)), //*roundp(far/eval([0,0, far],field))),
north=far-eval([0,far,0],field),//*roundp(far/eval([0,far,0],field)),
south=-(far-eval([0,-far,0],field)),//*roundp(far/eval([0,far,0],field))) ,
west=far-eval([far,0,0],field),//*roundp(far/eval([far,0,0],field)),
east=-(far-eval([-far,0,0],field))//*roundp(far/eval([far,0,0],field))) 
)
//[[max(-maxspan,east),max(-maxspan,south),max(-maxspan,bottom)] ,
// [min( maxspan,west),min( maxspan,north),min( maxspan,top)] ,
[[max(-maxspan),max(-maxspan),max(-maxspan)] ,
 [min( maxspan),min( maxspan),min( maxspan)] ,
(((west-east)+ (north-south)+(top-bottom))/3)/steps    ] ;


// function maxls(l,select=0,c=0)=c<len(l)-1?max(l[c][select],maxls(l,select,c+1)):l[c][select];
 // function minls(l,select=0,c=0)=c<len(l)-1?min(l[c][select],minls(l,select,c+1)):l[c][select];


module showbon(bon){
   translate([bon[0][0],bon[0][1],bon[0][2]])cube(3);
   translate([bon[1][0],bon[0][1],bon[0][2]])cube(3);
   translate([bon[1][0],bon[1][1],bon[0][2]])cube(3);
   translate([bon[0][0],bon[1][1],bon[0][2]])cube(3);
   translate([bon[0][0],bon[0][1],bon[1][2]])cube(3);
   translate([bon[1][0],bon[0][1],bon[1][2]])cube(3);
   translate([bon[1][0],bon[1][1],bon[1][2]])cube(3);
   translate([bon[0][0],bon[1][1],bon[1][2]])cube(3);
 }
module showfield(field,bon,s=2) {
 
 
for(
iy=[bon[0][1]*2 :s :bon[1][1]*2 ]){
 
for(ix=[bon[0][0]*2 :s :bon[1][0]*2 ])
{
e=eval([ix ,iy,0],field);
r=min(0,sign(-e))*sin(e *20);
g=1/max(1,abs(e));
b=sin(e *20)*min(1,-min(0,e));
color([abs(r),abs(g),abs(b)])translate([ix,iy,0])square(s,center=true);
}
}}
module quickuglymarch(field,bon,d=5){
*showbon(bon);

ixmin=bon[0][0];iymin=bon[0][1];izmin=bon[0][2];ixmax=bon[1][0];iymax=bon[1][1];izmax=bon[1][2];
e1=eval([ixmin ,iymin,izmin],field); 
e2=eval([ixmax ,iymin,izmin],field);
e3=eval([ixmax ,iymax,izmin],field);
e4=eval([ixmin,iymax,izmin],field);
e5=eval([ixmin,iymin,izmax],field);
e6=eval([ixmax ,iymin,izmax],field);
e7=eval([ixmax ,iymax,izmax],field);
e8=eval([ixmin,iymax,izmax],field);
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
 T1=[ixmin ,iymin,izmin] ; quickuglymarch( field,[T1,T1+S,step],d-1);
T2=[ixmin +S.x,iymin,izmin] ; quickuglymarch( field,[T2,T2+S,step],d-1);
T3=[ixmin +S.x,iymin+S.y,izmin] ; quickuglymarch( field,[T3,T3+S,step],d-1);
T4=[ixmin ,iymin+S.y,izmin] ; quickuglymarch( field,[T4,T4+S,step],d-1);

T5=[ixmin ,iymin,izmin +S.z] ; quickuglymarch( field,[T5,T5+S,step],d-1);
T6=[ixmin +S.x,iymin,izmin+S.z] ; quickuglymarch( field,[T6,T6+S,step],d-1);
T7=[ixmin +S.x,iymin+S.y,izmin+S.z] ; quickuglymarch( field,[T7,T7+S,step],d-1);
T8=[ixmin ,iymin+S.y,izmin+S.z] ; quickuglymarch( field,[T8,T8+S,step],d-1);
}


}