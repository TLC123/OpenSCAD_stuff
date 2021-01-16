step=20;
end=360*1-1;
//
//for(r1=[0:360/4:360*1]){
//for(r2=[0:360/4:360*1]){
 
plotxy(1,1,(sin($t*350)+1)*10); 
//color("red")plotxy(20,2);
//color("blue")plotxy(2,20);
//}}

module plotxy(r1,r2,w){

p=[for(x=[0:step:end])for(y=[0:step:end])[x,y,f(x,y,r1,r2,w)] ];
 f=[for(x=[0:(end/step)-1])for(y=[0: (end/step)-1])[
(x+0)+(y+0)*(end+1)/step
,(x+1)+(y+0)*(end+1)/step
,(x+1)+(y+1)*(end+1)/step
,(x+0)+(y+1)*(end+1)/step
] ];
 polyhedron(p,f);
 
 }


function f(v1,v2,r1,r2,w)=
let( l=[[0,0,0],[sin(v1)*r1,0,cos(v1)* r1*0],[w+sin(-v2)*r2,0,cos(-v2)*r2*0],[w,0,0]])
 (
 len3bz(l)-w  
 )*100
//
;

function len3ct(p) =
  let( l = [for(i=[1:len(p)-1]) norm(p[i]-p[i-1]) ] )
  l*[for(i=[0:len(l)-1]) 1];
function len3bz(v, precision = 0.05, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + norm(bez2(t, v) - bez2(t + precision, v)));

function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for (i = [0: len(v) - 2]) v[i]* (t)  + v[i + 1] * (1 - t)
]): v[0]* (t)  + v[1]* (1 - t) ;

function un (v)=v/max(norm(v),1e-32);// div by zero safe
