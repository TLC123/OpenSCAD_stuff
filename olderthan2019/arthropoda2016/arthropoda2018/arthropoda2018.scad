include<bez.scad>
r1=[
[0, 1, 1],
[0, -1,1],
[0,-1,-1],
[0, 1,-1],
 
];
r2=[
[2, 1, 1],
[2, -1,1],
[2,-1,-1],
[2, 1,-1],
 
];

pr=[[0,1],[0.3,1.5],[0.7,0.9],[1,1]];

core=[[0,0,0],[0.3,0,0.1],[1,0,-0.1],[2,0,0]];
 
patch(r1,r2,pr,core);
 module patch(r1,r2,profile, core)
{
steps=10;
for(i=[0:1/steps:1],j=[0:1/steps:1])
translate(patch(i,j,r1,r2,profile, core))sphere(0.02);
}



function patch(i,j,r1,r2,profile, core)=
let(
step=10,
 
ps=listlerp(close(r1),i*len(r1)),
pe=listlerp(close(r2),i*len(r1)),
 
c=bez2(j,core),
r=lerp(ps,pe,j),
m=bez2(j,pr),
 
n=un(r-c),
p=c+n*m.y)
p;
