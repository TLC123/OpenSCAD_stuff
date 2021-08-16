function pascalTriangle(a, b,result=1,i=0)=
 
    i<b?  pascalTriangle(a, b,(result * (a-i)/(i+1)),i+1 ) : result;
 
for(a=[0:10])
echo( [for(b=[0:a])pascalTriangle(a,b)] );