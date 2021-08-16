t=rands(1,3,10400);
v=[ for(i=t) rands(0,1,3)];
  
echo(sum(v)/len(v));
function sum(v) = is_num(v[0])?v*[for(v)1]:let(vv=rows_to_columns(v))[for(i=vv)sum(i)];
 
function rows_to_columns(l)= 
let(longest_row= max( [for(row=l)len(row)-1] ))
[for( i=[0:longest_row]) [ for( j=l) j[i]]];