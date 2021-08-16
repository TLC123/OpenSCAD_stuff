echo(un([1,1,0])); 
x=rnd(30,30);
y=rnd(x,30);
z=rnd(y,30);
 
cx=rnd(5,5);
cy=rnd(5,5);
cz=rnd(5,5); 
rx=5;
ry=5;//rnd(1,cy);
rz=5;//rnd(1,cz);
$fn=40;
color ("Wheat")scale([1,2,1.5])chamferroundbox(x,y,z,cx,cy,cz,rx,ry,rz);
echo(x,y,z,cx,cy,cz,rx,ry,rz);



module chamferroundbox(x,y,z,cx,cy,cz,rx,ry,rz,)
{hull(){
translate ([0,cy,cz]) roundbox(x,y-cy*2,z-cz*2,rx,ry,rz);
translate ([cx,0,cz]) roundbox(x-cx*2,y,z-cz*2,rx,ry,rz);
translate ([cx,cy,0]) roundbox(x-cx*2,y-cy*2,z,rx,ry,rz);
 
}}
module roundbox(x,y,z,rx,ry,rz)
{hull(){
translate ([rx,y-ry,rz])scale([rx,ry,rz])sphere(1);
translate ([rx,ry,rz])scale([rx,ry,rz])sphere(1);
translate ([x-rx,ry,rz])scale([rx,ry,rz])sphere(1);
translate ([x-rx,y-ry,rz])scale([rx,ry,rz])sphere(1);
translate ([0+rx,y-ry,z-rz])scale([rx,ry,rz])sphere(1);
translate ([0+rx,0+ry,z-rz])scale([rx,ry,rz])sphere(1);
translate ([x-rx,0+ry,z-rz])scale([rx,ry,rz])sphere(1);
translate ([x-rx,y-ry,z-rz])scale([rx,ry,rz])sphere(1);
}}



function max3(v,l)=[for(i=[0:len(v)-1])max(l,v[i]) ];
function min3(v,l)=[for(i=[0:len(v)-1])min(l,v[i]) ];
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
 function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
function un(v)=v/max(len3(v),0.000001)*1;
function p2n(pa,pb,pc)=let(u=pa-pb,v=pa-pc)un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);

function rnd(a=0,b=1)=round(rands(min(a,b),max(a,b),1)[0]);
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];
module trender(t){C0=(un(rndc())+[2,0,0]);C1=(un(rndc())+[2,2,0]);C2=(un(rndc())+[0,2,2]);for(i=[0:max(0,len(t[1])-1)]){ n=un(p2n(t[0][t[1][i][0]],t[0][t[1][i][1]],t[0][t[1][i][2]]));color(un((C0*abs(n[0])+C1*abs(n[1])+C2*abs(n[2])+[1,1,1]*abs(n[2]))/4))polyhedron(t[0],[t[1][i]]);}}