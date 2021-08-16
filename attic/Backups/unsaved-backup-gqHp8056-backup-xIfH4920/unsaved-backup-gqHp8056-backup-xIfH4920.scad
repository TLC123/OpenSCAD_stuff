echo(call());
 function call(d=18,p=1,r=[2,2,2])=d>0?let( 
a=call(d-1,p,r),
b=call(d-1,p,r),
c=call(d-1,p,r),
d=call(d-1,p,r),
e=call(d-1,p,r),
f=call(d-1,p,r),
g=call(d-1,p,r),
h=call(d-1,p,r)
)
concat(a,b,c,d,e,f,g,h):1;