include<DCgeometry.scad>
include<DCparser_eval.scad>
include<DCbb.scad>
include<DCmath.scad>

//scenegraph1 = [opT, [ [0,0, 0], [0, 0, 0], [1, 1, 1] ],
// [  
//       
//               [f_sphere, 1] 
//    
// 
//
//
// 
// ]
// ]
//;


// scenegraph=[opT,[ [ 00, 0, 0],[ 0, 0,0],[ 1, 1,1]],
//  [[opO,0,
// 
// [ [cR3,[5]] ,[cR3,[3]] 
// 
// ]]
// ]];
scenegraph =  
    union(0,[
    rotate([0,30,30],[cube(15)]),
    translate([1,39,1],[ sphere(15)])
     ] 
     )
   
;
echo(scenegraph);
 

scenecell=autobound(scenegraph,cubic=true,pad=0.05);
showcell(scenecell);
scenecache=octree(scenecell,  scenegraph, subdivision = 8);
s=abs(max(scenecell[0]-scenecell[1]));
echo(scenecell);
//recho(scenecache,s/15);

module recho (n,s,d=0)
{
if(n[0][2]==true)   translate(n[0][0])cube(s/d,center=true);
if(n[1]!=undef){
 recho (n[1][0],s,d+1);
 recho (n[1][1],s,d+1);
 recho (n[1][2],s,d+1);
 recho (n[1][3],s,d+1);
 recho (n[1][4],s,d+1);
 recho (n[1][5],s,d+1);
 recho (n[1][6],s,d+1);
 recho (n[1][7],s,d+1);
}
}

function octree(cell,  scene, subdivision ) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
//eO = eval(O, scene), 
eC = eval(C, scene), 
p1 = ([O.x, O.y, O.z]),   
p2 = ([S.x, O.y, O.z]),           
p3 = ([S.x, S.y, O.z]), 
p4 = ([O.x, S.y, O.z]),           
p5 = ([O.x, O.y, S.z]), 
p6 = ([S.x, O.y, S.z]),            
p7 = ([S.x, S.y, S.z]),
p8 = ([O.x, S.y, S.z]),            
p9 = C
)
// if 
subdivision > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ?let(tril=tril([O,S],scene)) [[C,eC,false,tril]] :  [[C,eC,false,undef],[
 // else split cell in 8 new cells constructed by corners and center point
octree(bflip(p1, C), scene,   subdivision - 1), octree(bflip(p2, C),  scene,  subdivision - 1), 
octree(bflip(p3, C), scene,   subdivision - 1), octree(bflip(p4, C), scene,   subdivision - 1), 
octree(bflip(p5, C),  scene,  subdivision - 1), octree(bflip(p6, C),  scene,  subdivision - 1), 
octree(bflip(p7, C),  scene,  subdivision - 1), octree(bflip(p8, C), scene,  subdivision - 1) ]]:let(tril=tril([O,S],scene))
[[C,eC,true,tril]];


function tril(cell,scene)=undef;/*
let(O=cell[0],S=cell[1])
[
eval([O.x,O.y,O.Z], scene),
eval([S.x,O.y,O.Z], scene),
eval([S.x,S.y,O.Z], scene),
eval([O.x,S.y,O.Z], scene),
eval([O.x,O.y,S.Z], scene),
eval([S.x,O.y,S.Z], scene),
eval([S.x,S.y,S.Z], scene),
eval([O.x,S.y,S.Z], scene)
];
*/
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];

