include <BOSL2/std.scad >
include <BOSL2/polyhedra.scad >
include <BOSL2/vnf.scad >
include <BOSL2/triangulation.scad>

 s = triangulate_vnf(move([4, 0, 2.5], sphere(6, $fn = 12 )));
// polyhedronMesh(s);
 
 ref=refine(s,1);
// echo(ref);
 echo(ref==s);
  polyhedronMesh(ref);

 
function refine(m,limit,thisCut)=
is_undef(thisCut)?refine(m,limit,getFirstCut(m,limit)) :
thisCut<=limit? m:
echo(thisCut)
let(p=m[0])
   let( meshlets= [for(f=m[1]) split([for(i=f)p[i]],thisCut) ])
   let(newmesh=mergeMeshlets(meshlets))
    
    refine(newmesh,limit,thisCut/2)
 ;


function mergeMeshlets(l)=
   let(points=[for(pl=l,p=pl[0])p])
  let(hcfaces=[for(pl=l,f=pl[1]) [for(p=f) pl[0][p] ]])
      let(faces=[for(f=hcfaces)[for(p=f)search([p],points,1)[0]]])
   [points, faces];
      
function getFirstCut(m,limit)=let(p=m[0])let(ceiling=sqrt(3)*max(maxX(p)-minX(p),maxY(p)-minY(p),maxZ(p)-minZ(p))) max2PowerOfBLessThanA(ceiling,limit);
 function all(v,bool=true)=len(search([bool] ,v,0)[0])==len(v);
function triangulate_vnf(m) = [m[0], triangulate_faces(m[0], m[1])];
function clamp(a, b = 0, c = 1) = min(max(a, min(b, c)), max(b, c));
function dotself(v) = v * v;
function dot(a, b) = a * b;
 function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) = min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);
function max2PowerOfBLessThanA(a,b)=(pow(2,floor(log(2,a/b)))*b);
function minX(p)=min([for(i=p)i.x]);
function maxX(p)=max([for(i=p)i.x]);
function minY(p)=min([for(i=p)i.y]);
function maxY(p)=max([for(i=p)i.y]);
function minZ(p)=min([for(i=p)i.z]);
function maxZ(p)=max([for(i=p)i.z]);

function split(vs, egdelimit) =
let (e01 = dotself(vs[0] - vs[1]))
let (e12 = dotself(vs[1] - vs[2]))
let (e20 = dotself(vs[2] - vs[0]))
let (sqEdgeLimit = egdelimit * egdelimit)
 let (truth = [e01 > sqEdgeLimit, e12 > sqEdgeLimit, e20 > sqEdgeLimit])
let (nvs = [vs[0], (vs[0] + vs[1]) / 2, vs[1], (vs[1] + vs[2]) / 2, vs[2], (vs[2] + vs[0]) / 2])
truth == [true, true, true] ?  [nvs, [[0, 1, 5],[1, 2, 3],[3, 4, 5],[1, 3, 5]]] : 

truth == [true, false, false] ?  [nvs, [[0, 1, 4],[1, 2, 4]]] : 
truth == [false, true, false] ?  [nvs, [[0, 2, 3],[0, 3, 4]]] : 
truth == [false, false, true] ?  [nvs, [[0, 2, 5],[2, 4, 5]]] : 
truth == [false, true, true] ?  
dotself(nvs[3] - nvs[0]) < dotself(nvs[2] - nvs[5]) ? [nvs, [[0, 3, 5],[0, 2, 3],[3, 4, 5]]] : 
[nvs, [[0, 2, 5],[2, 3, 5],[3, 4, 5]]]: 
truth == [true, false, true] ?  
dotself(nvs[1] - nvs[4]) < dotself(nvs[2] - nvs[5]) ? [nvs, [[0, 1, 5],[1, 2, 4],[1, 4, 5]]] : 
[nvs, [[0, 1, 5],[1, 2, 5],[2, 4, 5]]]: 
truth == [true, true, false] ?  
dotself(nvs[1] - nvs[4]) < dotself(nvs[0] - nvs[3]) ? [nvs, [[0, 1, 4],[1, 3, 4],[1, 2, 3]]] : 
[nvs, [[0, 1, 3],[0, 3, 4],[1, 2, 3]]]: 
[vs, [[0, 1, 2]]];

module polyhedronMesh(mesh){polyhedron(mesh[0],mesh[1]);}