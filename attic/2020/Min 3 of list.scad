pa=rands(0,100,20);
a=[for(a=pa)round(a)];
echo(a);
echo(2min(a));
function 2min(a,2min=[10e64,10e64,10e64],c=0)=c<len(a)?

2min(a,
[min(a),

a[c]>min(a)&&
a[c]<2min[1]?a[c]:2min[1]
,
a[c]>min(a)&&a[c]>2min[1]&&
a[c]<2min[2]?a[c]:2min[2]


]


,c+1):2min;