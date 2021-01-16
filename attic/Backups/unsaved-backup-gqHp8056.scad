echo(call());
 function call(d=18,p=1,r=[2,2,2],g=3)=d>0?let( 
a=call(d-1,p,r,g),
b=call(d-1,p,r,g),
c=call(d-1,p,r,g),
d=call(d-1,p,r,g)
)
a+b+c+d:1;