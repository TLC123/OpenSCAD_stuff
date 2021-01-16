// todo integrate parser
// fix feature thing
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
        opc=0; params=1;subra=2;x=0;y=1;z=2;null3=[0,0,0];tiny=0.01;far=10000;
        
        model=[opT,[ [ 00,  0, 0],[  0, 0,0],[ 1, 1,1]],
                  [[opO,0,
         
           [[cR3,[[rnd(10,80) , rnd(10,80),rnd(10,80)],1]] 

]]
]];
 
 
 

DualC(model);
 //////////////////////////////////////////////////////////////////////////////////////
module DualC(model){
v=octree([-40,-40,-40], 80 ,model,6);
 echo(find("X20Y30Z20",v));
 points=[for(i=[0:len(v)-1])if(v[i][1] !=undef) v[i][1]];
//on octrees 6 or deeper : bug faceworker leads to a ERROR: Recursion detected calling function 'len' 
 faces=faceworker(v);
//echo(len(v),len(points),len(faces));
 polyhedron(points,faces);
////trender([points,faces]);
// trender2([points,faces]);
 }
 
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////


function octree(p1,S,model,d=6)=let(s=S/2,e1=eval(p1))d>0?
 abs(e1) >S*1.71?[]:concat(
 octree([p1.x,p1.y,p1.z],s,model,d-1), octree([p1.x+s,p1.y,p1.z],s,model,d-1),
 octree([p1.x+s,p1.y+s,p1.z],s,model,d-1), octree([p1.x,p1.y+s,p1.z],s,model,d-1),
 octree([p1.x,p1.y,p1.z+s],s,model,d-1), octree([p1.x+s,p1.y,p1.z+s],s,model,d-1),
 octree([p1.x+s,p1.y+s,p1.z+s],s,model,d-1), octree([p1.x,p1.y+s,p1.z+s],s,model,d-1))
:
let(
p2=  (p1+[S,0,0]),p3=  (p1+[0,S,0]),p4=  (p1+[0,0,S]),p5=  (p1+[S,S,0]),
p6=  (p1+[S,0,S]),p7=  (p1+[0,S,S]),p8=  (p1+[S,S,S]),p9=p1+[s,s,s],
e2= eval(p2),e3= eval(p3),e4= eval(p4),e5= eval(p5),e6= eval(p6),e7= eval(p7),e8= eval(p8),
face1=[encode(p1),encode(p1+[0,-S,0]),encode(p1+[0,-S,-S]),encode(p1+[0,0,-S])],
face2=[encode(p1),encode(p1+[-S,0,0]),encode(p1+[-S,0,-S]),encode(p1+[0,0,-S])],
face3=[encode(p1),encode(p1+[0,-S,0]),encode(p1+[-S,-S,0]),encode(p1+[-S,0,0])],
pl2=makepl(e1,e2,e3,e4,e5,e6,e7,e8,p1, p2, p3, p4, p5, p6, p7, p8 ),
pl3=[for(i=[0:len(pl2)-1])if(pl2[i][1]!=[undef])pl2[i]], //filter
pl=len(pl3)<=0?concat(pl3,[[p9,un(v3(evalnorm(p9)))]]):pl3,// if plane list is short add p9
ping = push(p1+[s,s,s]), // Snap vertecies to nearst zero boundary 
 pong=normeq(pl)<=0.5?ping:findp2p(ping,pl,p1+[s,s,s]-[s,s,s]*5    ,p1+[s,s,s]+[s,s,s]*5 ) ,  // feature detector
 po = pong// push(pong)

)
abs(e1)<S*1.75?[ [encode(p1),po,[
sign(e1)==sign(e2)?[ ]:sign(e1)>0?face1:rev(face1),
sign(e1)==sign(e3)?[ ]:sign(e1)>0?rev(face2):(face2),
sign(e1)==sign(e4)?[ ]:sign(e1)>0?rev(face3):(face3),
]]]: [];
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
function normeq(pl)=let(sums = avrg( [for(i=[0:len(pl-1)] )for(j=[0:len(pl-1)] )(-1+dot(pl[i][1],pl[j][1]))]))abs(sums);
// feature detector
function  findp2p(inp,pl,mi,ma,f= 5)=
let(p=  mima3(inp,mi,ma))
f+len(pl)*2>0&&len(pl)>0?let(q = avrg([for(i=[0:len(pl)-1]) point2plane( p, pl[i][0] , pl[i][1] ) ]) ,df=q-p)findp2p( (p+(df*1  ) ),pl,mi,ma,f-1): p ;
function point2plane(p,o,n)=let(v=o-p)p+(n*(v.x*n.x + v.y*n.y + v.z*n.z)) ; //proj ap to a plane
 
// push point along gradient to zero boundary 
function push(p,c=4)=let(q=evalnorm(p),np= p+un([q.x,q.y,q.z])*  (-q[3] )*0.5) c>0?push(np,c-1):abs(q[3]<0.1)?p:np ; 
function inter(t,r )=(sign(t)==sign(r))?undef:abs(0-t)/max(abs(t-r),0.0000001); //find zero point

// build list of planes at intersected edges
function makepl(e1,e2,e3,e4,e5,e6,e7,e8,p1, p2, p3, p4, p5, p6, p7, p8 )=let(
s12=inter(e1,e2),s13=inter(e1,e3),s14=inter(e1,e4),s52=inter(e5,e2),
s53=inter(e5,e3),s58=inter(e5,e8),s64=inter(e6,e4),s62=inter(e6,e2),
s68=inter(e6,e8),s74=inter(e7,e4),s73=inter(e7,e3),s78=inter(e7,e8),

p12=(s12==undef)?[lerp(p1,p2,0.5),[undef]]:let(mp1=lerp(p1,p2,s12))[mp1,un(v3(evalnorm(mp1)))],
p13=(s13==undef)?[lerp(p1,p3,0.5),[undef]]:let(mp2=lerp(p1,p3,s13))[mp2,un(v3(evalnorm(mp2)))],
p14=(s14==undef)?[lerp(p1,p4,0.5),[undef]]:let(mp3=lerp(p1,p4,s14))[mp3,un(v3(evalnorm(mp3)))],
p52=(s52==undef)?[lerp(p5,p2,0.5),[undef]]:let(mp4=lerp(p5,p2,s52))[mp4,un(v3(evalnorm(mp4)))],
p53=(s53==undef)?[lerp(p5,p3,0.5),[undef]]:let(mp5=lerp(p5,p3,s53))[mp5,un(v3(evalnorm(mp5)))],
p58=(s58==undef)?[lerp(p5,p8,0.5),[undef]]:let(mp6=lerp(p5,p8,s58))[mp6,un(v3(evalnorm(mp6)))],
p64=(s64==undef)?[lerp(p6,p4,0.5),[undef]]:let(mp7=lerp(p6,p4,s64))[mp7,un(v3(evalnorm(mp7)))],
p62=(s62==undef)?[lerp(p6,p2,0.5),[undef]]:let(mp8=lerp(p6,p2,s62))[mp8,un(v3(evalnorm(mp8)))],
p68=(s68==undef)?[lerp(p6,p8,0.5),[undef]]:let(mp9=lerp(p6,p8,s68))[mp9,un(v3(evalnorm(mp9)))],
p74=(s74==undef)?[lerp(p7,p4,0.5),[undef]]:let(mp10=lerp(p7,p4,s74))[mp10,un(v3(evalnorm(mp10)))],
p73=(s73==undef)?[lerp(p7,p3,0.5),[undef]]:let(mp11=lerp(p7,p3,s73))[mp11,un(v3(evalnorm(mp11)))],
p78=(s78==undef)?[lerp(p7,p8,0.5),[undef]]:let(mp12=lerp(p7,p8,s78))[mp12,un(v3(evalnorm(mp12)))] 
)[p12,p13,p14,p52,p53,p58,p64,p62,p68,p74,p73,p78];
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
 
function encode(p)=str("X", (p.x),"Y", (p.y),"Z", (p.z));// build search key from xyz
//find and  connect surrounding points to faces



function faceworker(v)=
let(

a=[for(i=[0:len(v)-1]) if(v[i][2][0]!=[ ]) [
find(v[i][2][0][0],v),find(v[i][2][0][1],v),find(v[i][2][0][2],v),find(v[i][2][0][3],v) ] ],

b=[for(i=[0:len(v)-1]) if(v[i][2][1]!=[ ]) [
find(v[i][2][1][0],v),find(v[i][2][1][1],v),find(v[i][2][1][2],v),find(v[i][2][1][3],v) ] ],

c=[for(i=[0:len(v)-1]) if(v[i][2][2]!=[ ]) [
find(v[i][2][2][0],v),find(v[i][2][2][1],v),find(v[i][2][2][2],v),find(v[i][2][2][3],v) ] ] 
)
concat(a,b,c); 

//reverse list(face)
function rev(v)=[for(i=[len(v)-1:-1:0])v[i]]; 
 
//like  search() but works with string key used to build polyhedron 
function find(key,list)=[for(i=[0:len(list)-1])if(key==list[i][0])i][0];

//   return vec4 of normal and distance at point q
function evalnorm(q,model)=let(tiny=0.00001,e=eval(q,model))[e-eval([q.x-tiny,q.y,q.z],model),e-eval([q.x,q.y-tiny,q.z],model),e-eval([q.x,q.y,q.z-tiny],model),e];
//Main evaluator
function eval(p,model )= min(sphere(invtransform(p,[0,-10,10]),8),-min(
minR(
sphere(invtransform(p,[0,0,10]),13),
cube(invtransform(p,[-20,0,0],[14,65,210],[1,1,1]),10),7),
-min(sphere(invtransform(p,[20,0,0],[-40,0,0],[1,6,1]),4),-cube(invtransform(p,[20,0,0],[7,173,317],[1,1,1]),10))
))
;
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// testing primitives
function cR3(q,r)=max(
maxCH(abs(q.x)-3,abs(q.y)-3,1) ,
maxCH(abs(q.x)-3,abs(q.z)-3,1) ,
maxCH(abs(q.y)-3,abs(q.z)-3,1) )
 
; 


function cube(p,b=1)= maxl(abs3(p) - [b,b,b]) ; 
function sphere(p,b=1)= len3(p)-b;
function torus(p,tx=2.9,ty= 0.61)= let(q = [len3([p.x,p.z])-tx,p.y]) len3(q)-ty;
function box(p1,b=0.71) = let(p=p1+[0.1,0.6,1.5])len3(p)-b;
function minl(l,r,c=0)=c<len(l)-1?minR(l[c],minl(l,r,c+1),r):l[c];
 function maxl(l,r,c=0)=c<len(l)-1?maxR(l[c],maxl(l,r,c+1),r):l[c];

function  minR(  d1,   d2,   r=5) =r>0? let( m = min(d1, d2))(abs(d1) < abs(r) &&  abs(d2)< abs(r)) ||(d1 < r &&  d2 < r) ?min (m, r-len3([ r - d1,r -  d2]) ) :m:let( m = min(d1, d2),rr=-r)(d1 < rr &&  d2 < rr) ?min (m, len3([ d1, d2]) -rr):m;   
 
function  maxR(  d1,   d2,   r) = let( m = max(d1, d2))  (d1 > -r &&  d2> -r)   ? max(m,-r+len3([ -r-d1, -r-d2])) :m ;
function  maxCH(  d1,   d2,   r) = let( m = min(-d1, -d2))  (-d1 <r &&  -d2<r)   ? -min(m, -d1 + -d2 - r) :-m ;
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
module trender(t){C0=(un(rndc())+[2,0,0]);C1=(un(rndc())+[2,2,0]);C2=(un(rndc())+[0,2,2]);for(i=[0:max(0,len(t[1])-1)]){ n=un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))polyhedron(t[0],[t[1][i]]);}}
module trender2(t){C0=(un(rndc())+[2,0,0]);C1=(un(rndc())+[2,2,0]);C2=(un(rndc())+[0,2,2]);for(i=[0:max(0,len(t[1])-1)]){ n=un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));color((rndc()+[1,1,1])/2)polyhedron(t[0],[t[1][i]]);}}
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
function p2n(pa,pb,pc)=
let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
function avrg(l)=len(l)>1?addl(l)/(len(l)):l;
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(len3(v), 0.000001) * 1;// div by zero safe unit normal
function dot(v1,v2) = v1[0]*v2[0]+v1[1]*v2[1]+v1[2]*v2[2];
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function rndc(a = 1, b = 0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function v3(p)=[p.x,p.y,p.z]; // vec3 formatter
function abs3(v)=[abs(v[0]),abs(v[1]),abs(v[2])];
function max3(a,b)=[max(a[0],b),max(a[1],b),max(a[2],b)];
function mima3(a,b,c)=[min(max(a[0],b[0]),c[0]),
min(max(a[1],b[1]),c[1]),min(max(a[2],b[2]),c[2])];

function invtransform(q,T=[0,0,0],R=[30,30,30],S=[1,1,1])=
let(p= q )
Vdiv(t([p.x, p.y, p.z, 1]*m_translate(T*-1)*m_rotate(R*-1)),S)  ; 
function Vdiv (v1,v2)=[v1[0]/v2[0],v1[1]/v2[1],v1[2]/v2[2]];
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