//points=([for(i=[0:120])[rnd(10),rnd(10),rnd(10)]]);
points=points();

color("Green") for (i=[0:max(0,len(points)-1)])translate(points[i])sphere(0.1);
 a=quickhull(points);
  color("red",0.5)for (i=[0:max(0,len(a)-1)]){
//echo(a[i]);
polyhedron(a[i],[[0,1,2]]);
} 



 

function quickhull (v)=
let(
extremes = [[IofminX(v), IofmaxX(v)], [IofminY(v), IofmaxY(v)], [IofminZ(v), IofmaxZ(v)] ], 
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
nbase = face_normal(    v[p0i], v[p1i], v[p2i]), 

distances_from_plane = [
    for (i = [0: max(0, len(v) - 1)]) (distance_point2plane(
      v[i], v[p0i], nbase))], 

p3i = index_max(distances_from_plane)
,
p0=points[p0i],
p1=points[p1i],
p2=points[p2i],
p3=points[p3i],
n210=face_normal(p2,p1,p0),
n013=face_normal(p0,p1,p3),
n123=face_normal(p1,p2,p3),
n203=face_normal(p2,p0,p3),

v210=[for (i=[0:max(0,len(v)-1)]) 
        if(distance_point2plane(v[i], p0, n210)>0)v[i]],
    v210r=[for (i=[0:max(0,len(v)-1)]) 
            if(distance_point2plane(v[i], p0, n210)<=0)v[i]],
v013=[for (i=[0:max(0,len(v210r)-1)]) 
        if(distance_point2plane(v210r[i], p0, n013)>0)v210r[i]],
    v013r=[for (i=[0:max(0,len(v210r)-1)]) 
            if(distance_point2plane(v210r[i], p0, n013)<=0)v210r[i]],
v123=[for (i=[0:max(0,len(v013r)-1)]) 
        if(distance_point2plane(v013r[i], p3, n123)>0)v013r[i]],
    v123r=[for (i=[0:max(0,len(v013r)-1)]) 
            if(distance_point2plane(v013r[i], p3, n123)<=0)v013r[i]],
v203=[for (i=[0:max(0,len(v123r)-1)]) 
        if(distance_point2plane(v123r[i], p3, n203)>0)v123r[i]]

)
concat(


quickhull_prime (v203,p2,p0,p3),
quickhull_prime (v123,p1,p2,p3),
quickhull_prime (v013,p0,p1,p3),
quickhull_prime (v210,p2,p1,p0)

)
;

function quickhull_prime (v,p0,p1,p2,c=5)=
c>0&& len(v)>0  ?
let(
n=face_normal(p0,p1,p2),
 
p3d= [for (i=[0:max(0,len(v)-1)])  distance_point2plane(v[i], p0, n)] ,
p3max = max(p3d),
p3i= search(p3max, p3d)[0],
p3=v[p3i],
n013=face_normal(p0,p1,p3),
n123=face_normal(p1,p2,p3),
n203=face_normal(p2,p0,p3),

v1=[for (i=[0:max(0,len(v)-1)]) 
        if(distance_point2plane(v[i], p3, n013)>0)v[i]],
    v1r=[for (i=[0:max(0,len(v)-1)]) 
            if(distance_point2plane(v[i], p3, n013)<=0)v[i]],
v2=[for (i=[0:max(0,len(v1r)-1)]) 
        if(distance_point2plane(v1r[i], p3, n123)>0)v1r[i]],
    v2r=[for (i=[0:max(0,len(v1r)-1)]) 
            if(distance_point2plane(v1r[i], p3, n123)<=0)v1r[i]],
v3=[for (i=[0:max(0,len(v2r)-1)]) 
        if(distance_point2plane(v2r[i], p3, n203)>0)v2r[i]]

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





function points()=
 [[8.66284, 7.57113, 6.02943], [7.54853, 9.89475, 2.53926], [4.45378, 3.97088, 4.43925], [3.20075, 5.45121, 1.15953], [9.8291, 4.7029, 0.844064], [1.14336, 1.06081, 5.47912], [8.92572, 9.93802, 7.41213], [5.27801, 7.00089, 3.76124], [0.274587, 3.97821, 6.02657], [8.05191, 2.07656, 0.497619], [3.93979, 5.82762, 4.26814], [0.807673, 7.03036, 5.95214], [3.52349, 6.38893, 3.02898], [9.25437, 1.47221, 4.01741], [5.51801, 9.8108, 7.28321], [3.96347, 0.895528, 1.57022], [6.74914, 0.610403, 5.86096], [9.02737, 8.19909, 3.44265], [7.48481, 4.39232, 9.14238], [8.23232, 7.10167, 9.14083], [4.87366, 3.10528, 9.34834], [4.05016, 6.6183, 7.9485], [7.1104, 7.05242, 9.77337], [4.38544, 4.36384, 4.94469], [9.12255, 2.13902, 4.93907], [6.86316, 7.29463, 6.91293], [9.39575, 1.87959, 4.03663], [3.73323, 7.35321, 2.61143], [4.67625, 4.62715, 5.89978], [4.37704, 7.55302, 3.80363], [5.0156, 3.15072, 7.33508], [7.41291, 2.72912, 5.55133], [4.5076, 1.00201, 4.02878], [1.14997, 6.53024, 4.90469], [5.9163, 7.06201, 4.5242], [2.026, 7.88131, 3.51831], [1.59242, 1.6044, 4.07244], [3.1135, 4.88856, 9.00119], [0.645493, 1.56971, 2.33334], [5.54447, 2.05271, 7.19243], [3.55042, 4.6686, 4.06986], [9.53297, 3.53499, 1.46924], [1.8508, 3.86907, 1.89183], [7.01001, 5.07266, 2.30244], [1.88442, 5.31467, 8.81521], [9.89533, 3.43546, 9.32049], [9.67698, 3.46684, 5.43598], [7.72474, 3.94379, 9.58544], [4.48953, 8.654, 0.787031], [3.30931, 5.91684, 1.48759], [7.37598, 7.30414, 5.5179], [7.00844, 3.04798, 8.89182], [2.79216, 7.02834, 8.33465], [4.17344, 8.59695, 0.193779], [1.42312, 0.281568, 6.20238], [6.15673, 5.2035, 8.43568], [9.90377, 6.6632, 7.13089], [4.29233, 2.27658, 4.05507], [7.06766, 0.102692, 5.7473], [2.04108, 3.44164, 0.822343], [1.22771, 6.13132, 1.72138], [3.41505, 4.70382, 9.94483], [6.10655, 0.532941, 6.24169], [0.0741336, 8.1233, 7.09386], [6.98399, 2.31494, 2.12171], [6.00904, 8.02667, 2.39275], [7.60967, 2.54862, 4.50968], [2.96273, 6.48726, 3.92039], [9.36447, 0.318828, 6.03134], [3.77739, 3.66508, 5.67641], [6.2962, 2.15019, 1.84223], [9.77052, 9.76062, 2.36318], [3.55162, 1.12055, 7.05543], [1.58525, 5.20631, 9.7671], [0.0549174, 4.1467, 2.15662], [2.99515, 6.91932, 4.32899], [6.04357, 7.63453, 0.036512], [1.76115, 3.77612, 4.07604], [7.95112, 5.76501, 0.786589], [9.67653, 8.27875, 3.97525], [6.42563, 7.64312, 2.7858], [6.14659, 9.21739, 3.03129], [9.36884, 2.65277, 3.94243], [3.38375, 3.08564, 4.96498], [3.47132, 4.57201, 6.75604], [3.249, 0.410193, 4.40841], [0.452888, 0.243828, 3.70122], [1.94196, 4.0763, 2.36372], [6.40729, 7.20892, 9.47424], [6.48757, 1.52956, 3.82099], [1.8492, 8.95695, 8.22999], [0.921359, 3.09825, 3.95689], [5.6504, 5.05575, 1.89302], [8.21099, 6.05932, 2.26385], [8.40026, 6.61109, 5.67797], [2.06238, 4.38918, 7.15556], [4.28709, 6.93272, 0.414361], [6.29901, 4.1147, 9.81029], [8.65528, 4.03935, 1.23889], [5.73905, 3.10621, 7.76175], [0.135272, 8.8506, 0.0139004], [4.39901, 4.44907, 8.31726], [2.03784, 5.85446, 0.514675], [1.26926, 9.60041, 6.38436], [4.35191, 1.29379, 2.80479], [8.96844, 9.94221, 2.89047], [2.14457, 0.341192, 0.0531066], [4.54878, 3.18232, 9.15582], [3.00917, 9.94405, 2.49774], [9.98484, 3.86942, 0.212525], [7.7847, 9.8099, 7.1384], [0.466254, 9.05298, 7.13202], [8.91343, 4.78367, 5.59077], [1.34385, 7.0915, 8.86103], [8.59965, 3.26238, 3.04635], [5.1141, 3.51645, 4.55278], [7.57479, 3.8386, 5.60391], [1.83781, 6.92743, 9.5297], [5.77106, 6.69254, 4.76688], [9.75979, 1.30636, 1.42069], [3.70155, 5.35966, 3.40251]];