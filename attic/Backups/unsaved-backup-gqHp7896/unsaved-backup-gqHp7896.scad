v=u([0,0,0],16);
key=code(5,5,5);
 echo(key, v[search(key,v)[0]][1]);
echo(len(v));
 //for(i=[0:len(v)-1])echo(v [i]);


function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function code(x,y,z)=floor(x)+floor(y)*pow(10,6)+floor(z)*pow(10,12);


function u(bon,S,d=16)=d>0?
let(s=S/2)concat(
u([bon.x,bon.y,bon.z],s,d-1),
u([bon.x+s,bon.y,bon.z],s,d-1),
u([bon.x+s,bon.y+s,bon.z],s,d-1),
u([bon.x,bon.y+s,bon.z],s,d-1),
u([bon.x,bon.y,bon.z+s],s,d-1),
u([bon.x+s,bon.y,bon.z+s],s,d-1),
u([bon.x+s,bon.y+s,bon.z+s],s,d-1),
u([bon.x,bon.y+s,bon.z+s],s,d-1))
:
let(x=rnd(bon.x,bon.x+S),y=rnd(bon.y,bon.y+S),z=rnd(bon.z,bon.z+S) )
[[code(bon.x,bon.y,bon.z),[x,y,z]]]
;