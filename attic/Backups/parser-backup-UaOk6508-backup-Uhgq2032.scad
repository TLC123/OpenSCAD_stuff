/*
ToDo
Signed cube check with R
Rotations works but breaks bounding
EvalNorm
Hull
Extrude
Feature sensitive ext marchingcubes
sphere tracing
polyhederon Feature sensitive ext marchingcubes

type node
opc
par->
sub->
nxt->
 
float combineChamfer(float d1, float d2, float r) {
  float m = min(d1, d2);

  if (d1 < r && d2 < r) {
    return min(m, d1 + d2 - r);
  } else {
    return m;
  }
}

float combineSmooth(float d1, float d2, float r) {
6	  float m = min(d1, d2);
7	
8	  if (d1 < r && d2 < r) {
9	    return min(m, r - length(r - vec2(d1, d2)));
10	  } else {
11	    return m;
12	  }
13	}
*/


opU=1;// 1 union
opI=2;// 1 intersection
opS=3;// 1 subtraction
opT=4;// M transformation 4X4 functional
opH=5;// 1 Convex hull
opE=6;// 3 Extrude 2d shape, simple Z extrude of a subtree of Z plane cut (Q collapsed to z=0)
opO=7;// 1 offset usually by distance but xyz surface normal or ambinet occlusion is possiblites
opD=8;// ""not impleneted"" deformation modifyers [twist, bend, pinch, displace, taper]

cR3=10;// unit radius cube
//named numbers
opc=0; params=1;subra=2;x=0;y=1;z=2;null3=[0,0,0];tiny=0.1;far=10000;
 
 

field=
[opT,[[ 0, 0, 0],[ 0, 0, 0],[ 1, 1, 1]],
    [[opE,10,
        [[opO,40,
            [
            [opT,[ [ 0, 00, 0],[ 0, 0, 0],[ 1, 1,1]],
                [[cR3,[[10,10,1],5]]]],
            [opT,[ [ -0, -0, 0],[ 0, 0, 0],[ 1, 1, 1]],
                [[cR3,[[10,10,1],5]]]]
            ]
        ]]
    ]]
]
 ; 
 
span=20;steps=20;
 top=far-eval([0,0,far],field)* roundp(far/eval([0,0,far],field)) ;
 bottom=-(far-eval([0,0,-far],field)*roundp(far/eval([0,0, far],field)));
north=far-eval([0,far,0],field)*roundp(far/eval([0,far,0],field));
south=-(far-eval([0,-far,0],field)*roundp(far/eval([0,far,0],field))) ;
west=far-eval([far,0,0],field)*roundp(far/eval([far,0,0],field));
east=-(far-eval([-far,0,0],field)*roundp(far/eval([far,0,0],field)));

 bon =[ [east,south, bottom] ,[west,north,top] ,(((west-east)+ (north-south)+(top-bottom))/3)/steps];
//bon=[[-40,-40,-40],[40,40,40],5];
* uglymarch(field,bon);
 showfield(field,bon);

echo(bon); echo(roundp(far/eval([0,0,far],field)));
 echo(field);
   translate([bon[0][0],bon[0][1],bon[0][2]])cube(3);
   translate([bon[1][0],bon[0][1],bon[0][2]])cube(3);
   translate([bon[1][0],bon[1][1],bon[0][2]])cube(3);
   translate([bon[0][0],bon[1][1],bon[0][2]])cube(3);
   translate([bon[0][0],bon[0][1],bon[1][2]])cube(3);
   translate([bon[1][0],bon[0][1],bon[1][2]])cube(3);
   translate([bon[1][0],bon[1][1],bon[1][2]])cube(3);
   translate([bon[0][0],bon[1][1],bon[1][2]])cube(3);
 
 module showfield(field,bon)
 {
 
 
for(
iy=[bon[0][1]*2 :2 :bon[1][1]*2 ],
ix=[bon[0][0]*2 :2 :bon[1][0]*2 ])
{
c=sin(eval([ix ,iy,0],field)*50);
color([abs(c),max(0,c),max(0,c)])translate([ix,iy,0])square(2);
}
}
module uglymarch(field,bon)
{
step=bon[2];
 
for(
iz=[bon[0][2]:step:bon[1][2]],
iy=[bon[0][1]:step:bon[1][1]],
ix=[bon[0][0]:step:bon[1][0]])
{
 //translate([ix,iy,iz]) color("Red")sphere(tiny);
 hull (){
if (eval([ix ,iy,iz],field)<0)translate([ix,iy,iz])sphere(tiny);
if (eval([ix+step ,iy,iz],field)<0)translate([ix+step,iy,iz])sphere(tiny);
if (eval([ix+step ,iy+step,iz],field)<0)translate([ix+step,iy+step,iz])sphere(tiny);
if (eval([ix ,iy+step,iz],field)<0)translate([ix,iy+step,iz])sphere(tiny);
if (eval([ix ,iy,iz+step],field)<0)translate([ix,iy,iz+step])sphere(tiny);
if (eval([ix+step ,iy,iz+step],field)<0)translate([ix+step,iy,iz+step])sphere(tiny);
if (eval([ix+step ,iy+step,iz+step],field)<0)translate([ix+step,iy+step,iz+step])sphere(tiny);
if (eval([ix ,iy+step,iz+step],field)<0)translate([ix,iy+step,iz+step])sphere(tiny); 
}
}
}



function eval(q,v)=
let( opcode=v[opc],p=v[params])
//if code  then
opcode== opU ? opU(q,p,v[subra]): // 1
opcode== opI ? opI(q,p,v[subra]): // 2
opcode== opS ? opS(q,p,v[subra]): // 3
opcode== opT ? opT(q,p,v[subra]):  //4
opcode== opH ? opU(q,p,v[subra]):  //5 hull behaves like union for now:
opcode== opE ? opE(q,p,v[subra]):  //6
opcode== opO ? opO(q,p,v[subra]):  //7
opcode== opD ? opT(q,null3,v[subra])://8 deform behaves like null trnasform for now
opcode== cR3 ? cR3(q,p): //10
0;

function opE(q,p,v)=min([for(i=[0:len(v)-1]) max(eval([q.x,q.y,0],v[i]), 
max(0,abs(q.z))-p) ]);
function opU(q,p,v)=min([for(i=[0:len(v)-1]) eval(q,v[i])]);
function opI(q,p,v)=max([for(i=[0:len(v)-1]) eval(q,v[i])]);
function opS(q,p,v)=max( eval(q,v[0]),len(v)-1>0?-min([for(i=[1:len(v)-1]) eval(q,v[i])]):-eval(q,v[0]));
function opO(q,p,v)=Offs(min([for(i=[0:len(v)-1]) eval(q,v[i])]),p);
function opT(q,M,v)=min([for(i=[0:len(v)-1]) eval(Transf(q,M),v[i])]);

function Transf(q,M)= invtransform(q,M[0],M[1],M[2]);
function Offs(v,M)=v-M;
 
//function Clampz(q,p)=[q[x],q[y],0];
function cR3(q,r)=
let(d = abs3(q) - (r[0] -[r[1],r[1],r[1]] ))
min(max(d.x,d.y,d.z),0.0) + len3(max3(d,0.0)) -r[1]; 

 function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
 function rndc(a = 1, b = 0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
 function un(v) = v / max(len3(v), 0.000001) * 1;
 function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
 function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v;

function invtransform(q,T,R,S)=
 let(p=Vdiv(q,S))
  t([p.x, p.y, p.z, 1]*m_rotate(R*-1)*m_translate(T*-1))  ;
 
 function abs3(v)=[abs(v[0]),abs(v[1]),abs(v[2])];
 function max3(a,b)=[max(a[0],b),max(a[1],b),max(a[2],b)];
 function min3(a,b)=[min(a[0],b),min(a[1],b),min(a[2],b)];
function x3(a)=[a,a,a];
function Vmul(v1,v2)=[v1[0]*v2[0],v1[1]*v2[1],v1[2]*v2[2]];
function Vdiv (v1,v2)=[v1[0]/v2[0],v1[1]/v2[1],v1[2]/v2[2]];
function roundp(a,p=0.01)=a-(a%p);
         
function t(v) = [v.x, v.y, v.z];
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


//function avrg(l)=len(l)>1?addl(l)/(len(l)-1):l;
// function bound(v)=[[minls(v,0),minls(v,1),minls(v,2)], [maxls(v,0),maxls(v,1),maxls(v,2)]];
////function maxl(l,c=0)=c<len(l)-1?max(l[c],maxl(l,c+1)):l[c];
////function minl(l,c=0)=c<len(l)-1?min(l[c],minl(l,c+1)):l[c];
// function maxls(l,select=0,c=0)=c<len(l)-1?max(l[c][select],maxls(l,select,c+1)):l[c][select];
// function minls(l,select=0,c=0)=c<len(l)-1?min(l[c][select],minls(l,select,c+1)):l[c][select];