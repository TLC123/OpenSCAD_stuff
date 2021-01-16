 points=([for(i=[0:120])[rnd(10),rnd(10),rnd(10)]]);
 

 a=quickhull(points);
 
color("Green") for (i=getpoints(a))translate(i)sphere(0.1);

 


for (i=[0:max(0,len(a)-1)]){
//echo(a[i]);
polyhedron(a[i],[[0,1,2]]);
} 
 function getpoints(v)=unique([for(i=v,j=i)j]);

function  uniquejoin(m,n) =  
    concat(m,[   for (i = n)    if (search([i],m,1)==[[]]) i  ]);

//function  unique(m) = [   for (i = [0: len(m) - 1])    if (search([m[i]],m,1)==[i]) m[i] ];

function  unique(m,first,last) = last==undef?unique(m,0,len(m)-1) :
last-first>1? let(mid=(first+last)/2)
uniquejoin(  unique(m,first,floor(mid)),         unique(m,ceil(mid),last) )
 :m[first]==undef? [m[last]]: m[last]==undef?[m[first]] :concat([m[first]],[if( m[last]!=m[first])m[last]] ) ;

 

function quickhull (v)=
len(v)<1? []:
 
 
let(
extremes = [[IofminX(v), IofmaxX(v)], [IofminY(v), IofmaxY(v)], [IofminZ(v), IofmaxZ(v)] ], 
// find extremes this works
extreme_distances = [
norm(v[extremes.x[0]] - v[extremes.x[1]])
, norm(v[extremes.y[0]] - v[extremes.y[1]])
, norm(v[extremes.z[0]] - v[extremes.z[1]])
], 
// find extreme axis this works

baseline = index_max(extreme_distances), 

p0i = extremes[baseline][0],
p1i = extremes[baseline][1], 

// this works

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
    for (i = [0:  len(v) - 1]) (distance_point2plane(
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
    
    v0=[for (i=[0:max(0,len(v)-1)]) 
        if(
            distance_point2plane(v[i], p3, n013)>0
        ||    distance_point2plane(v[i], p3, n123)>0
          ||  distance_point2plane(v[i], p3, n203)>0
            
        
        )v[i]],

v210=[for (i=[0:max(0,len(v0)-1)]) 
        if(distance_point2plane(v0[i], p0, n210)>0)v0[i]],
    v210r=[for (i=[0:max(0,len(v0)-1)]) 
            if(distance_point2plane(v0[i], p0, n210)<=0)v0[i]],
                
v013=[for (i=[0:max(0,len(v210r)-1)]) 
        if(distance_point2plane(v210r[i], p0, n013)>0)v210r[i]],
    v013r=[for (i=[0:max(0,len(v210r)-1)]) 
            if(distance_point2plane(v210r[i], p0, n013)<=0)v210r[i]],
                
v123=[for (i=[0:max(0,len(v013r)-1)]) 
        if(distance_point2plane(v013r[i], p3, n123)>0)v013r[i]],
    v123r=[for (i=[0:max(0,len(v013r)-1)]) 
            if(distance_point2plane(v013r[i], p3, n123)<=0)v013r[i]],
                
v203=[for (i=[0:max(0,len(v123r)-1)]) 
        if(distance_point2plane(v123r[i], p3, n203)>0)v123r[i]],


res=concat(
quickhull_prime (v203,p2,p0,p3),
quickhull_prime (v123,p1,p2,p3),
quickhull_prime (v013,p0,p1,p3),
quickhull_prime (v210,p2,p1,p0)
)     
        ) res
;

function quickhull_prime (v,p0,p1,p2,c=115)=
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


v0=[for (i=[0:max(0,len(v)-1)]) 
        if(
           distance_point2plane(v[i], p3, n013)>0
        ||    distance_point2plane(v[i], p3, n123)>0
          ||  distance_point2plane(v[i], p3, n203)>0
            
        
        )v[i]],

v1=[for (i=[0:max(0,len(v0)-1)]) 
        if(distance_point2plane(v0[i], p3, n013)>0)v0[i]],
            
v1r=[for (i=[0:max(0,len(v0)-1)]) 
            if(distance_point2plane(v0[i], p3, n013)<=0)v0[i]],
                
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
 
 
 function distance_point2plane(p,o,n) =   dot (p-o,n); 


function face_normal(point_a,point_b,point_c)=
let(u=point_a-point_b,v=point_a-point_c)
un(cross (u,v));

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
function dot(v1,v2) = v1[0]* v2[0]+ v1[1]* v2[1]+ v1[2]* v2[2];


function point_to_line(p,a,b)=
let(
pa = p - a, 
ba = b - a,
h = clamp( (pa*ba)/ (ba*ba)))
norm( pa - ba*h ) ;

function clamp(a, b = 0, c = 1) = min(max(a, b), c);







function dist_point2plane(p,o,n) =   dot (p-o,n); 
function is_vertex(v)= is_list(v) && len(v)==3 &&(is_num(v[0])&&is_num(v[1])&&is_num(v[2])) ;
function v3(p) = [p.x,p.y,p.z]; // vec3 formatter
function rev(v) = [for (i = [len(v) - 1: -1: 0]) v[i]];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;
function addlp(v,i=0,r=[0,0,0]) = i<len(v) ? addlp(v,i+1,r+v[i]) : r;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v)=assert (is_list(v)) v/max(norm(v),1e-64) ;
function rndc(a = 1,b = 0,s = [])=[rnd(a,b,s),rnd(a,b,s),rnd(a,b,s)];
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p) )]);}
module polyline_open(p) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1]);
} // polyline plotter
module line(p1,p2 ,width=2) 
{ // single line plotter
hull() {
translate(p1) sphere(width);
translate(p2) sphere(width);
}
}
