list=[[1,6],[3,5],[5,3],[1,2],[0,6]];

for(x=[0.01:0.05:4]){
echo(
listlerp (list,x)
);
translate(listlerp (list,x))sphere(0.1);}

function listlerp (l,I)=let(f=len(l)-1,start=max(0,min(f,floor(I))),end=max(0,min(f,ceil(I))),bias=I%1) (l[end]* bias + l[start] * (1 - bias));


