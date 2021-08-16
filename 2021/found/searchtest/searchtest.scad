t0=[for([1:1000]) rands(0,1,3) ];
t=concat(t0,[[0,0,0]],t0,t0);
h=[0,0,0];
 echo(h);
r=search([h],t,0);
 echo(r[0][0]);

echo(len(t));
echo(len(unique(t)));

function unique (v)=[for(i=[0:len(v)-1])let(n=v[i],r=search([n],v,0)) if(r[0][0]==i)n ];