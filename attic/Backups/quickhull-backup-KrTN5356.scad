points=([for(i=[0:49])[rnd(10),rnd(10),rnd(10)]]);
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
for (i=[0:max(0,len(points)-1)])translate(points[i])sphere(0.1);
a=quickhull(points);
echo(len(points),len(a));
for (i=[0:max(0,len(a)-1)]){
echo(a[i]);
polyhedron(a[i],[[0,1,2]]);
}
function quickhull (v)=
let(p0=v[0],p1=v[1],p2=v[len(v)-1],
n=face_normal(p0,p1,p2),
a_side=[for (i=[0:max(0,len(v)-1)]) if(distance_point2plane(v[i], p0, n)>0)v[i]],
b_side=[for (i=[0:max(0,len(v)-1)]) if(distance_point2plane(v[i], p0, n)<0)v[i]]
)
concat(
quickhull_prime (b_side,p2,p1,p0),
quickhull_prime (a_side,p0,p1,p2)
)
;

function quickhull_prime (v,p0,p1,p2,c=50)=
len(v)>0&&c>0?
let(
n=face_normal(p0,p1,p2),
//v_side=[for (i=[0:max(0,len(v)-1)]) if(distance_point2plane(v[i], p0, n)>0)v[i]],
//p3=v_side[index_max([for (i=[0:max(0,len(v_side)-1)])  distance_point2plane(v_side[i], p0, n)])]
p3=v[index_max([for (i=[0:max(0,len(v)-1)])  distance_point2plane(v[i], p0, n)])]
)
concat(
quickhull_prime (v,p0,p1,p3,c-1),
quickhull_prime (v,p1,p2,p3,c-1),
quickhull_prime (v,p2,p0,p3,c-1))
:
[[p0,p1,p2]]
;


function index_min(l) = search(min(l), l)[0];
function index_max(l) = search(max(l), l)[0];

function distance_point2plane(point, planes_origin, planes_normal) =
let (v = point - planes_origin)   
(
v.x * planes_normal.x + 
v.y * planes_normal.y + 
v.z * planes_normal.z
); 

function face_normal(point_a,point_b,point_c)=
let(u=point_a-point_b,v=point_a-point_c)
un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);

function un(v)=v/max(len3(v),1e-64);
function len3(v) =len(v)>1?
sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)]))
:len(v)==1?v[0]:v; 
function addl(l,c=0)= len(l)-1 >c?l[c]+addl(l,c+1):l[c];