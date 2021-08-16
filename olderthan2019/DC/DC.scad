panel([0,0,0],[0,0,-10]);
module panel(p1,p2)
{
s=len3(p1-p2)/2;
mp=lerp(p1,p2,0.5);
x=abs(p1.x-p2.x);
y=abs(p1.y-p2.y);
z=abs(p1.z-p2.z);

 if(x>y&&x>z){
if(p1.x>p2.x)polyhedron([mp+[0,s,s],mp+[0,-s,s],mp+[0,-s,-s],mp+[0,s,-s]],[[0,1,2,3]]);
if(p1.x<=p2.x)polyhedron([mp+[0,s,s],mp+[0,-s,s],mp+[0,-s,-s],mp+[0,s,-s]],[[3,2,1,0]]);}

 if(y>x&&y>z){
if(p1.y>p2.y)polyhedron([mp+[s,0,s],mp+[-s,0,s],mp+[-s,0,-s],mp+[s,0,-s]],[[3,2,1,0]]);
if(p1.y<=p2.y)polyhedron([mp+[s,0,s],mp+[-s,0,s],mp+[-s,0,-s],mp+[s,0,-s]],[[0,1,2,3]]);}

 if(z>y&&z>x){
if(p1.z>p2.z)polyhedron([mp+[s,s,0],mp+[-s,s,0],mp+[-s,-s,0],mp+[s,-s,0]],[[0,1,2,3]]);
if(p1.z<=p2.z)polyhedron([mp+[s,s,0],mp+[-s,s,0],mp+[-s,-s,0],mp+[s,-s,0]],[[3,2,1,0]]);}


}




function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function un(v) = v / max(len3(v), 0.000001) * 1;
function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
