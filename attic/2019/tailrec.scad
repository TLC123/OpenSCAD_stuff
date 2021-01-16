echo(count(8));
function count(c=0,tally=0)= c>0? let (

v1=count(c-1,tally),
v2=count(c-1,v1[0]),
v3=count(c-1,v2[0]) 

)

[ count(c-1,v3[0])]
:[ tally+1];