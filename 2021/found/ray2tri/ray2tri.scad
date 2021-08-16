testmeshray();
module testmeshray(){
include <bodconv.scad>
include<polytools.scad>;
mesh=bodconv();
//echo( len(tri[1]));
 color("blue" )polyhedron(mesh[0],mesh[1]);
 rayo=[rnd(-20,20),-40,rnd(50,100)];
for(m=[0:128 ]){
ray=[rayo ,un(  [rnd(-1,1),rnd(0.5,1),rnd(-1,1)]) ] ;
e=meshraytest(mesh,ray);
echo(e);
if (e)color("red")line(ray[0],ray[0]+ray[1]*160);
else color("yellow")line(ray[0],ray[0]+ray[1]*60,0.1);
}
}





//mesh=[points,faces] ray?[origin,vector]
 function meshraytest(mesh,ray)=
let(bboxhit=raymesh(meshbox(mesh),ray ))
//very important part hits take 0.001s misses 10h for half a milion faces

 (bboxhit)?
(raymesh(mesh,ray ))
:false;
 
 module line(a,b,w=1)
{ hull(){translate(a)sphere(w);translate(b)sphere(w);}}

 function meshbox(mesh)=
let(p=mesh[0],xl=[for(i=p)i.x],
yl=[for(i=p)i.y],zl=[for(i=p)i.z],
pminX = min(xl) ,pmaxX = max(xl) ,pminY = min(yl) ,
pmaxY = max(yl) ,pminZ = min(zl) ,pmaxZ = max(zl) )
  [ [[pminX,pminY,pminZ], [pminX,pmaxY,pminZ], [pmaxX,pmaxY,pminZ], [pmaxX,pminY,pminZ], 
 [pminX,pminY,pmaxZ],[pminX,pmaxY,pmaxZ],[pmaxX,pmaxY,pmaxZ],[pmaxX,pminY,pmaxZ]],    
   , [ [0,4,7],[3,0,7],     [0,1,5],[4,0,5],    [3,7,6],[2,3,6],   
 [5,1,6],[1,2,6],   [1,0,2],[0,3,2],   [4,5,6],[7,4,6]]  ] ;


function raymesh(mesh,ray,s=0,e=undef )=
e==undef?raymesh(mesh,ray,s,len(mesh[1])-1 ):
 
        abs(e-s)==1?
let(p=mesh[0],f=mesh[1] )

let(face1= [for(i=f[s]) p[i]],out1= RayIntersectsTriangle(ray[0], ray[1], face1))
out1?out1:
let(face2= [for(i=f[e]) p[i]],out2= RayIntersectsTriangle(ray[0], ray[1],face2))
out2
:
let( mid=floor((s+e)/2))
let(fork1=raymesh(mesh,ray,s,mid))
fork1?fork1:
let(fork2=raymesh(mesh,ray,mid,e))
 fork2 
 ;

 
//Möller–Trumbore intersection algorithm
//https://en.wikipedia.org/wiki/M%C3%B6ller%E2%80%93Trumbore_intersection_algorithm
function RayIntersectsTriangle( rayOrigin, rayVector,  inTriangle )=
len(inTriangle)>3? 
RayIntersectsTriangle( rayOrigin, rayVector,  [inTriangle[0], inTriangle[1], inTriangle[2]])||
RayIntersectsTriangle( rayOrigin, rayVector,  [inTriangle[0], inTriangle[2], inTriangle[3]]):
let(  
 EPSILON = 0.0000001
    ,vertex0 = inTriangle[0],  vertex1 = inTriangle[1],  vertex2 = inTriangle[2] 
    ,edge1 = vertex1 - vertex0,  edge2 = vertex2 - vertex0
    ,h = cross(rayVector,edge2), a =  (edge1*h)   )
      (abs(a) < EPSILON)?               false:
let(
    f = 1/a ,   s = rayOrigin - vertex0 ,   u = f * ( (s*h))   )
      (u < 0.0 || u > 1.0)?             false:
let(
    q = cross(s,edge1)    ,v = f *  (rayVector*q)     )
      (v < 0.0 || u + v > 1.0)?         false:
    // At this stage we can compute t to find out where the intersection point is on the line.
     let(  t = f * (edge2*q)      )
      (t > EPSILON) ?                   true
    : // This means that there is a line intersection but not a ray intersection.
                                        false   ;


function bounbb(mesh,ray)=
let(
pminX = minX(mesh[0]) ,
pmaxX = maxX(mesh[0]) ,
pminY = minY(mesh[0]) ,
pmaxY = maxY(mesh[0]) ,
pminZ = minZ(mesh[0]) ,
pmaxZ = maxZ(mesh[0]) )
raymesh
(  [ [[pminX,pminY,pminZ], [pminX,pmaxY,pminZ], [pmaxX,pmaxY,pminZ], [pmaxX,pminY,pminZ], 
 [pminX,pminY,pmaxZ],[pminX,pmaxY,pmaxZ],[pmaxX,pmaxY,pmaxZ],[pmaxX,pminY,pmaxZ]],    

    ,
 [
 [0,4,7],[3,0,7],    
 [0,1,5],[4,0,5],   
 [3,7,6],[2,3,6],   
 [5,1,6],[1,2,6],  
 [1,0,2],[0,3,2],  
 [4,5,6],[7,4,6]]  
],ray)
;





function minX(p)=min([for(i=p)i.x]);
function maxX(p)=max([for(i=p)i.x]);
function minY(p)=min([for(i=p)i.y]);
function maxY(p)=max([for(i=p)i.y]);
function minZ(p)=min([for(i=p)i.z]);
function maxZ(p)=max([for(i=p)i.z]); 


