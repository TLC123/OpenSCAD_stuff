mx=10;
m= [for(i=[1:mx])r(mx) ] ;

 
n=rotateRows(m,1);
j=rotateRows(n,1);
e=  (gaussElimination(m));
 
//echo(e); 


function gaussElimination(m,i=0,j=1,r=0)=
echo(chr(13))
let(e=mecho(m,i,j,r))
i>=len(m)-1||r>=len(m)-1?m:
m[0][0]==0?echo("swap row 1")gaussElimination(rotateRows(m,i),i,j,r+1):
let(c=getcoff(m,i,j)) 
m[j][i]==0? gaussElimination(m,i,j+1,r=0):

abs(c)==1||c==0? echo("swap")gaussElimination(rotateRows(m,j),i,j,r+1):

let(m=[for(n=[0:len(m)-1])
n==i?saneRound(m[i]):
n>=j?saneRound(m[n]-m[i]*c):
m[n]])

j<len(m)-1? gaussElimination(m,i,j+1,r=0):echo(str("col ",i, " done"))echo(chr(13))
gaussElimination(m,i+1,j=i+2,r=0)
   
;

function saneRound(v)=[for(i=v) abs(i)<1e-14?round(i):i];// within precition zero



 function getcoff(m,i,j)=
echo(i,j,str(m[j][i],"/",m[i][i],"=" ))
 let(c= m[j][i] /m[i][i] )
 c;

function rotateRows(m,j)=j==len(m)-1?m:concat(
[if (j>0)for (i=[0:max(0,j-1)])m[i]],
    [m[len(m)-1]],
[for(i=[j:max(j,len(m)-2)])m[i] ]
    );
function r(n)=[for(n=[1:n])round(rands(-9,9,1)[0])];
   function mecho(m,v1="",v2="",v3="")=
[for (n=m)echo(str(n,chr(9),v1,v2,v3))
    
    
   ];   