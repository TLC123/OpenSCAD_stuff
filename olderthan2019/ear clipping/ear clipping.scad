b= [[.5,1,1],[0,1,1],[0,2,1],[1,2,1],[2,2,1],[2,1,1],[2,0,1],[1,0,1]]*10;
a=fp_triangulate(b );

echo(a);
polyhedron(b,[a]);

function fp_triangulate(points,a,n=[0,0,1] ,count=0)=
  is_undef(a)? fp_triangulate(points,[for(i=[0:len(points)-1])i]):

count>len(a)?
a
:
len(a)<=3?
[[a[0],a[1],a[2]]]:
sign(dot(p2n([points[a[0]],points[a[1]],points[a[2]]  ]),n))>0?
let(b=concat([for(i=[2:len(a)-1])a[i]],[a[0]] )) 
concat( [[a[0],a[1],a[2]]], fp_triangulate( points,shuffle(b,2),n )):fp_triangulate(points, shuffle(a,1),n,count+1 );







function shuffle(b,l=1)=let(
c=concat( [for(i=[1:len(b)-1])b[i]],[b[0]]))
l>0?shuffle(c,l-1):c
;
function dot(a,b)=a*b;
function p2n(p) =
let (pa=p[0], pb=p[1], pc=p[2],
u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] *
 v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);
function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal

function addl(l, c = 0) = c < len(l) - 1 ? l[c] + addl(l, c + 1) : l[
 c];
function len3(v) = len(v) > 1 ? sqrt(addl([
 for (i = [0: len(v) - 1]) pow(v[i], 2)
])) : len(v) == 1 ? v[0] : v;