    p=[[1,1,0],[-1,1,0],[-1,-1,0],[1,-1,0],[0,0,1.57]];
for(t=f(p,p,3))translate(t)hull()polyhedron(p*pow(.52,3),[[0,1,2,3,4]]);
function f(p,pp,n=10)=n>0?f(p*.5,[for(i=pp,j=p) i+j*.52],n-1):pp;   