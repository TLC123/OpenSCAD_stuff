
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
opc=0; params=1;subra=2;x=0;y=1;z=2;null3=[0,0,0];tiny=0.1;

 field=[opU,0,[
[opT,[-5,-5,-5],[[cR3,5]]],
[opT,[5,-5,-5],[[cR3,5]]],
[opT,[5,5,-5],[[cR3,5]]],
[opT,[-5,5,-5],[[cR3,5]]],
[opT,[-5,-5,5],[[cR3,5]]],
[opT,[5,-5,5],[[cR3,5]]],
[opT,[5,5,5],[[cR3,5]]],
[opT,[-5,5,5],[[cR3,5]]]

 ]] ; 
field=
[opT,[0,5,5],[[cR3,23]]] ;
//field=[opU,1,[for(i=[0:3])field()]];
function field(d=1)=d>0?
[opU,0,
[[opT,(rndc(-1,1))*50,[field(d-1)]],
[opT,(rndc(-1,1))*50,[field(d-1)]]]
]

:[cR3,round(rnd(3,7))];

span=20;steps=40;bon=[ [0,0,0],[span,span,span],(span)/steps];
 uglymarch(field,bon);
echo(bon[2]);
 echo(field);
 *#translate(bon[0])cube(bon[1]-bon[0]);


module uglymarch(field,bon)
{
step=bon[2];
val=

[for(iy=[bon[0][1]:step:bon[1][1]])
[for(iz=[bon[0][0]:step:bon[1][0]]) 
[for(ix=[bon[0][2]:step :bon[1][2]])
eval([ix ,iy,iz],field)
]]];
 //echo(val);
for(
iz=[bon[0][2]:step:bon[1][2]],
iy=[bon[0][1]:step:bon[1][1]],
ix=[bon[0][0]:step:bon[1][0]])
{
 hull(){
if (val[ix][iy][iz]<0)translate([ix,iy,iz])sphere(tiny);
if (val[ix+step][iy][iz]<0)translate([ix+step,iy,iz])sphere(tiny);
if (val[ix+step][iy+step][iz]<0)translate([ix+step,iy+step,iz])sphere(tiny);
if (val[ix][iy+step][iz]<0)translate([ix,iy+step,iz])sphere(tiny);

if (val[ix][iy][iz+step]<0)translate([ix,iy,iz+step])sphere(tiny);
if (val[ix+step][iy][iz+step]<0)translate([ix+step,iy,iz+step])sphere(tiny);
if (val[ix+step][iy+step][iz+step]<0)translate([ix+step,iy+step,iz+step])sphere(tiny);
if (val[ix][iy+step][iz+step]<0)translate([ix,iy+step,iz+step])sphere(tiny);
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
1
;

function opE(q,p,v)=min([for(i=[0:len(v)-1]) eval(Clampz(q,p),v[i])]);
function opU(q,p,v)=min([for(i=[0:len(v)-1]) eval(q,v[i])]);
function opI(q,p,v)=max([for(i=[0:len(v)-1]) eval(q,v[i])]);
function opS(q,p,v)=max( -eval(q,v[0]),len(v)-1>0?min([for(i=[1:len(v)-1]) eval(q,v[i])]):-eval(q,v[0]));
function opO(q,M,v)=min([for(i=[0:len(v)-1]) Offs(eval(q,v[i]),M)]);
function opT(q,M,v)=min([for(i=[0:len(v)-1]) eval(Transf(q,M),v[i])]);

function Transf(q,M)=q-M;
function Offs(v,M)=v-M;
function Clampz(q,p)=[q[x],q[y],q[z]<p[0]&&q[z]>0?0:q[z]>p[0]?q[z]-p[0]:q[z]];
function cR3(q,r)=len3(q)-r; 

 function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
 function rndc(a = 1, b = 0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
 function un(v) = v / max(len3(v), 0.000001) * 1;
 function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
 function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v;
//function avrg(l)=len(l)>1?addl(l)/(len(l)-1):l;
// function bound(v)=[[minls(v,0),minls(v,1),minls(v,2)], [maxls(v,0),maxls(v,1),maxls(v,2)]];
////function maxl(l,c=0)=c<len(l)-1?max(l[c],maxl(l,c+1)):l[c];
////function minl(l,c=0)=c<len(l)-1?min(l[c],minl(l,c+1)):l[c];
// function maxls(l,select=0,c=0)=c<len(l)-1?max(l[c][select],maxls(l,select,c+1)):l[c][select];
// function minls(l,select=0,c=0)=c<len(l)-1?min(l[c][select],minls(l,select,c+1)):l[c][select];