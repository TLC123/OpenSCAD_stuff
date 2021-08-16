v=[1,1,1,1,2];
echo(Geometric_Mean(v));
function Geometric_Mean(v,n=-1)=
n==-1?pow(Geometric_Mean(v,n+1),1/len(v)):
n>len(v)-1?1:v[n]*Geometric_Mean(v,n+1);