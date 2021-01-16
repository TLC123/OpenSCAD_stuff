a=rands(0,100,5000);
echo(a);
echo(sort(a));

function sort(v,c=0) =

c<len(v)? sortodd(
[for(i=[0:len(v)-1]) i %  2==0? min(v[i],v[i+1]):max(v[i-1],v[i])],c+1):v;

function sortodd(v,c=0) =
 c<len(v)? sort(
concat([v[0]], [for(i=[1:len(v)-2]) i %  2==1? min(v[i],v[i+1]):max(v[i-1],v[i])],
[v[len(v)-1]]),c+1):v;