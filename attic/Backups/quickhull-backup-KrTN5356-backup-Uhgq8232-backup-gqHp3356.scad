points=([for(i=[0:120])[rnd(10),rnd(10),rnd(10)]]);
color("Green") for (i=[0:max(0,len(points)-1)])translate(points[i])sphere(0.1);
a=quickhull(points);
  color("red",0.125)for (i=[0:max(0,len(a)-1)]){
//echo(a[i]);
polyhedron(a[i],[[0,1,2]]);
}
function quickhull (v)=
let(
xv=[for (i=[0:max(0,len(v)-1)]) v[i].x],
yv=[for (i=[0:max(0,len(v)-1)]) v[i].y],
p0=v[index_max(xv)],p1=v[index_min(xv)],p2=v[index_min(yv)],
n=face_normal(p0,p1,p2),
a_side=[for (i=[0:max(0,len(v)-1)]) if(distance_point2plane(v[i], p0, n)>=0)v[i]],
b_side=[for (i=[0:max(0,len(v)-1)]) if(distance_point2plane(v[i], p0, n)<=0)v[i]]
)
concat(
quickhull_prime (v,p2,p1,p0),
quickhull_prime (v,p0,p1,p2)
)
;

function quickhull_prime (v,p0,p1,p2,c=6)=
 
let(
n=face_normal(p0,p1,p2),
 
p3d= [for (i=[0:max(0,len(v)-1)])  distance_point2plane(v[i], p0, n)] ,
lim= len([for (i=[0:max(0,len(p3d)-1)]) if(p3d[i]>=0) p3d[i]]) ,
p3max = max(p3d),
p3min = min(p3d),
p3i= search(p3max, p3d)[0],
p3=v[p3i]
 ) 
lim>0&&p3!=undef&& p3max>0?
concat(
quickhull_prime (v,p0,p1,p3,c-1),
quickhull_prime (v,p1,p2,p3,c-1),
quickhull_prime (v,p2,p0,p3,c-1))
:
[[p2,p1,p0]]
 
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
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 