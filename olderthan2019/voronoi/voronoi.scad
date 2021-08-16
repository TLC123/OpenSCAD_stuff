showfield([[0,0,0],[30,30,0]],1);
function Voronesque(   op )=let(
i  = [floor(op.x + dot(op, [1/3,1/3,1/3]) ),floor(op.y + dot(op, [1/3,1/3,1/3]) ),floor(op.z + dot(op, [1/3,1/3,1/3]) )],
doti= dot(i, [0.166666,0.166666,0.166666]),
p =[op.x- i.x-doti,op.y- i.y-doti,op.z- i.z-doti]  ,
m3=max3( p-[p.y,p.z,p.x],0),
i1 = [sign(m3.x),sign(m3.y),sign(m3.z)],
i2 = [max(1-i1.z,i1.z),max(1-i1.x,i1.x),max(1-i1.y,i1.y)],  
i1n =   [min(1-i1.z,i1.z),min(1-i1.x,i1.x),min(1-i1.y,i1.y)],    
p1 = p - i1n +  [0.166666,0.166666,0.166666], 
p2 = p - i2 + [1/3,1/3,1/3],
p3 = p -[1/2,1/2,1/2],
rnd = [7, 157, 113], // I use this combination to pay homage to Shadertoy.com. :)
v = max3([0.5 - dot(p, p),0.5 -  dot(p1, p1),0.5 -  dot(p2, p2),0.5 -  dot(p3, p3)],0),
di = [ 
dot(i, rnd), 
dot(i + i1, rnd), 
dot(i + i2, rnd), 
dot(i + [1,1,1], rnd) ], 
di2 = [((sin(di[0])*262144.) ),((sin(di[1])*262144.) ),((sin(di[2])*262144.) ),((sin(di[3])*262144.))],
d=[di2[0]%1,di2[1]%1,di2[2]%1,di2[3]%1]  ,
vx = max(d[0], d[1]), 
vy = d[2] ,
 vz = max(min(d.x, d.y), min(d.z, d[3])),
 vw = min(vx, vy))
 max(vx, vy); // Maximum, or regular value for the regular Voronoi aesthetic.  Range [0, 1].
//    return  max(v.x, v.y) - max(v.z, v.w); // Maximum minus second order, for that beveled Voronoi look. Range [0, 1].

function max3(v,l)=[for(i=[0:len(v)-1])max(l,v[i]) ];
function min3(v,l)=[for(i=[0:len(v)-1])min(l,v[i]) ];
function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
 function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];



module showfield(bon,s=2) {

S= len3(bon[1]-bon[0]);

for(
iy=[bon[0][1] -S*0.2  :s :bon[1][1]+S*0.2  ]){

for(ix=[bon[0][0]  -S*0.2 :s :bon[1][0] +S*0.2  ])
{
e=Voronesque([ix/20 ,iy/20,0]);
 r=e;
g=1/max(1,abs(e));
b=sin(e *20)*min(1,-min(0,e));
color([abs(r),abs(g),abs(b)])translate([ix,iy,-1])square(s,center=true);
}
}}