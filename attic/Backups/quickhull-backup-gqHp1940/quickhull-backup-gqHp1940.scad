points=([for(i=[0:120])[rnd(10),rnd(10),rnd(10)]]);
color("Green") for (i=[0:max(0,len(points)-1)])translate(points[i])sphere(0.1);
 a=quickhull(points);
  color("red",0.25)for (i=[0:max(0,len(a)-1)]){
//echo(a[i]);
polyhedron(a[i],[[0,1,2]]);
} 



 

function quickhull (v)=
let(
extremes = [[IofminX(v), IofmaxX(v)]
, [IofminY(v), IofmaxY(v)]
, [IofminZ(v), IofmaxZ(v)] ], 
extreme_distances = [
norm(v[extremes.x[0]] - v[extremes.x[1]])
, norm(v[extremes.y[0]] - v[extremes.y[1]])
, norm(v[extremes.z[0]] - v[extremes.z[1]])
], 
baseline = index_max(extreme_distances), 
p0i = extremes[baseline][0],
p1i = extremes[baseline][1], 
extremes2 = [
IofminX(v), IofmaxX(v), IofminY(v),
IofmaxY(v), IofminZ(v), IofmaxZ(v)],

extreme_distances2 = [
    for (i = [0: 5]) point_to_line(v[extremes2[i]], v[p0i],
      v[p1i])
],
p2i = extremes2[index_max(extreme_distances2)], 
n = face_normal(    v[p0i], v[p1i], v[p2i]), 

distances_from_plane = [
    for (i = [0: max(0, len(v) - 1)]) distance_point2plane(
      v[i], v[p0i], n)], 

p3i = index_max(distances_from_plane)
,
p0=points[p0i],
p1=points[p1i],
p2=points[p2i],
p3=points[p3i],
n012=face_normal(p0,p1,p2),
n023=face_normal(p0,p2,p3),
n031=face_normal(p0,p3,p1),
n123=face_normal(p1,p2,p3),

v012=[for (i=[0:max(0,len(v)-1)]) 
        if(distance_point2plane(v[i], p0, n012)>0)v[i]],
v023=[for (i=[0:max(0,len(v012)-1)]) 
        if(distance_point2plane(v012[i], p0, n023)>0)v012[i]],
v031=[for (i=[0:max(0,len(v023)-1)]) 
        if(distance_point2plane(v023[i], p0, n031)>0)v023[i]],
v123=[for (i=[0:max(0,len(v031)-1)]) 
        if(distance_point2plane(v031[i], p0, n123)>0)v031[i]]

)
concat(

quickhull_prime (v012,p0,p1,p2)
,quickhull_prime (v023,p0,p2,p3)
,quickhull_prime (v031,p0,p3,p1)
,quickhull_prime (v123,p1,p2,p3)
)
;

function quickhull_prime (v,p0,p1,p2,c=7)=
 len(v)>0  ?
let(
n=face_normal(p0,p1,p2),
 
p3d= [for (i=[0:max(0,len(v)-1)])  distance_point2plane(v[i], p0, n)] ,
p3max = max(p3d),
p3i= search(p3max, p3d)[0],
p3=v[p3i],
n013=-face_normal(p0,p1,p3),
n123=face_normal(p1,p2,p3),
n203=face_normal(p2,p0,p3),
v1=[for (i=[0:max(0,len(v)-1)]) if(distance_point2plane(v[i], p3, n013)>0)v[i]],
v2=[for (i=[0:max(0,len(v1)-1)]) if(distance_point2plane(v1[i], p3, n123)>0)v1[i]],
v3=[for (i=[0:max(0,len(v2)-1)]) if(distance_point2plane(v2[i], p3, n203)>0)v2[i]]

 ) 

concat(

quickhull_prime (v1,p0,p1,p3,c-1),
quickhull_prime (v2,p1,p2,p3,c-1),
quickhull_prime (v3,p2,p0,p3,c-1))
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
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

function IofminX(p)=let(m=min([for(i=p)i.x]))search(m,p,0, 0)[0];
function IofmaxX(p)=let(m=max([for(i=p)i.x]))search(m,p,0, 0)[0];
function IofminY(p)=let(m=min([for(i=p)i.y]))search(m,p,0, 1)[0];
function IofmaxY(p)=let(m=max([for(i=p)i.y]))search(m,p,0, 1)[0];
function IofminZ(p)=let(m=min([for(i=p)i.z]))search(m,p,0, 2)[0];
function IofmaxZ(p)=let(m=max([for(i=p)i.z]))search(m,p,0, 2)[0];
function minX(p)=min([for(i=p)i.x]);
function maxX(p)=max([for(i=p)i.x]);
function minY(p)=min([for(i=p)i.y]);
function maxY(p)=max([for(i=p)i.y]);
function minZ(p)=min([for(i=p)i.z]);
function maxZ(p)=max([for(i=p)i.z]);


function point_to_line(p,a,b)=
let(
pa = p - a, 
ba = b - a,
h = clamp( (pa*ba)/ (ba*ba)))
norm( pa - ba*h ) ;

function clamp(a, b = 0, c = 1) = min(max(a, b), c);
