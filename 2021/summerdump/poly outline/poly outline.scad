a=polychain();
echo(a);


function polychain(p,stop=5)=
stop==0?p:
is_undef(p)? polychain([ [newpoint(),newpoint(),newpoint()],[[0,1,2]]],stop-1):
let(
f=
norm(p[0][p[1][0][1]]-p[0][p[1][0][2]])+rnd(-5,5)
>
norm(p[0][p[1][0][2]]-p[0][p[1][0][0]])?

concat([[p[1][0][1],p[1][0][2],len(p[0])]],p[1]):
concat([[p[1][0][2],p[1][0][0],len(p[0])]],p[1])

,
mp=(p[0][p[1][0][1]]+p[0][p[1][0][0]] )/2,
cp=(p[0][f[0][1]]+p[0][f[0][0]] )/2,
np=cp+(cp-mp)*1.7+[rnd(-5,5),rnd(-5,5),0],
pt=concat(p[0],[np])
)
polychain([pt,f],stop-1)
;


polygo(a);

function newpoint(p)=is_undef(p)?[rnd(15),rnd(10),0]:

let(
a=p[1][0][0],
b=p[1][0][1],
c=p[1][0][2])
echo(a,b,c)
(p[0][a]+
p[0][b]+
p[0][c])/3
+newpoint()
;


;
function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
module polygo(a){polyhedron(a[0],a[1]);}