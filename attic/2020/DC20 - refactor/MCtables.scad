//#  BorisTheBrave convention for vertices is:
sliverelimination=false;
  scene   = function(p) min(
  max(abs(p.x)-6.5,abs(p.y+3)-4.5,abs(p.z*.7-p.x*.7)-0.5)  ,
  max(abs(p.x)-6.5,abs(p.y-3)-4.5,abs(p.z*.7+p.x*.7)-0.5)  ,
  norm(p-[1,0,4])-5.5 );
 sdMC(scene  ,fn=4);

 module sdMC(scene, cell=[],fn=5 ){
 if (cell==[]) sdMC(scene,autobound(scene,cubic=true,pad=0.5 ),fn);
  else{
     //ff flipfield
O = cell[0];
S = cell[1]; 
C = (O + S) / 2;
D = S - O;
maxD = max( abs (D.x),abs (D.y),abs (D.z));
St=D/fn  ;
 



    if (abs(scene(C))<=maxD *1.5)
    {   verts=vertFromCell  (cell) ;
 
            evals=[for(p=verts)eval(p,scene)]; 
            case=bitMaskToValue(evals);
          if (fn>0){        
//                if (case==153||case==102)
//                    {
//                    sdMC(scene,([O,[C.x,S.y,S.z]]),fn-1.0 );
//                    sdMC(scene,([[C.x,O.y,O.z],S]),fn-1.0 );
//                     }
//                else if (case==204||case==51)
//                    {
//                    sdMC(scene,([O,[S.x,C.y,S.z]]),fn-1.0 );
//                    sdMC(scene,([[O.x,C.y,O.z],S]),fn -1.0);
//                     }
//                else if (case==15||case==240)
//                    {
//                    sdMC(scene,([O,[S.x,S.y,C.z]]),fn -1 );
//                    sdMC(scene,([[O.x,O.y,C.z],S]),fn -1 );
//                    }
//                else        
                    {      
                    pxxx=[ (O+[0,0,0]),(O+[D.x,0,0]),(O+[0,D.y,0]),(O+[0,D.y,D.z]),
                    (O+[0,0,D.z]),(O+[D.x,D.y,0]),(O+[D.x,0,D.z]),(O+[D.x,D.y,D.z])];
                    for(i=[0:7]){    sdMC(scene,([C,pxxx[i]]),fn-1 );           } 
                } 
           } 
         
        else
        {
            faces=(CASES()[ (case)]);
            p=verts;
            edgepoints=[for(e=EDGES())
                let(bias=findzero(evals[e[0]],evals[e[1]]))
                lerp(p[e[0]],p[e[1]],
                sliverelimination?sliver(bias,1):bias
            )];
//            fitpoints=[for(p=edgepoints)fitsinglepoint(p,scene)];
             polyhedron(edgepoints,faces);
        }
        
        }
  }
}
 
 
 
 
////echo(bm);
//faces=(CASES()[ (case)]);
////echo(case);
//p=VERTICES();
//edgepoints=[for(e=EDGES())lerp(p[e[0]],p[e[1]],findzero(evals[e[0]],evals[e[1]]))];
//    
//sliverpoints=sliverelimination?sliver(edgepoints):edgepoints;
////echo(edgepoints);
//polyhedron(sliverpoints,faces);
//color("blue")polyhedron(edgepoints,faces);

function fitsinglepoint(p,scene,c=5)= c>0? 
let(probe=evalnorm(p,scene))
let(np= p- un(v3(probe))*probe[3]*0.95 ) fitsinglepoint(np,scene,c-1):p;  

function  vertFromCell  (cell)= [for(c=VERTICES ())
    [cell[c.x].x,cell[c.y].y,cell[c.z].z ] 
];
// tiny utils fuctions
function sliver(c,d)= c<.1*d||c>.9*d?round(c):c ;
function findzero(e1,e2)=sign(e1)==sign(e2)?0.5: snapclamp(abs(e1)/(abs(e1)+abs(e2)) );
function snapclamp(a)=a==clamp(a)?a:0.5;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal
function dot(v1,v2) = v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
function v3(p) = [p.x,p.y,p.z]; // vec3 formatter
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function abs3(v) = [abs(v[0]),abs(v[1]),abs(v[2])];
function max3(v,b) = [max(v[0],b),max(v[1],b),max(v[2],b)];
function min3(v,b) = [min(v[0],b),min(v[1],b),min(v[2],b)];
 

function eval(p,scene)=scene(p);// For legacy 
function evalnorm(q,scene) =
let (tiny = 0.000001, e = eval(q,scene))
[
eval([q.x + tiny,q.y,q.z],scene) - eval([q.x - tiny,q.y,q.z],scene),
eval([q.x,q.y + tiny,q.z],scene) - eval([q.x,q.y - tiny,q.z],scene),
eval([q.x,q.y,q.z + tiny],scene) - eval([q.x,q.y,q.z - tiny],scene),
e];


//////////////////////////////////////////////////////////////////////////////////////
// arrange bundary box from sloppy to proper orientation of minor corner and major corner
function bflip(a,b) = is_undef(b)&&len(a)==2?bflip(a[0],a[1]):[
 [min(a.x,b.x),min(a.y,b.y),min(a.z,b.z)],
 [max(a.x,b.x),max(a.y,b.y),max(a.z,b.z)] ];
 
function autobound(scene,cubic = (false),pad = 1) =    let (
    up = findbound([0,0,1],scene),
    down = -findbound([0,0,-1],scene),
    north = findbound([0,1,0],scene),
    south = -findbound([ 0,-1,0],scene),
    west = findbound([1,0,0],scene),
    east = -findbound([- 1,0,0],scene),
    esd = min(east,south,down),wnu = max(west,north,up)    )
cubic == true ?
let (
    scenecenter=[(east+west)/2,(south+north)/2,(up+down)/2],
    scenemax=max(abs(east-west),abs(south-north),abs(up+down))/2,
    d = [scenemax,scenemax,scenemax]   )
    [scenecenter - (d * (1+pad)),scenecenter + d * (1+pad)] 
:
    let (d = [west,north,up ] - [east,south,down])
    [[east,south,down ] - d * pad,[west,north,up] + d * pad];

function findbound(vec,scene) =
let (VeryFar = 10e6,
 p1 = vec * VeryFar,
p2 = p1 + un(vec  ),
e1 = abs(eval(p1,scene)),
 e2 = abs(eval(p2,scene)),
scale = abs(e2 - e1),// Account for non unit_for_unit field.
corrected = (e1 / scale),
distance = VeryFar - e1/scale //distance= VeryFar-corrected
)
//[p1,p2,e1,e2,scale,corrected,distance ]
distance ;


function  VERTICES ()= [
    [0,0,0],
    [1,0,0],
    [1,1,0],
    [0,1,0],
    [0,0,1],
    [1,0,1],
    [1,1,1],
    [0,1,1],
];


//# BorisTheBrave convention for the edges

function EDGES() = [
    [0,1],
    [1,2],
    [2,3],
    [3,0],
    [4,5],
    [5,6],
    [6,7],
    [7,4],
    [0,4],
    [1,5],
    [2,6],
    [3,7]
];

// Takes a vector. Any number >0 is 1 rest 0. use binary to build a number 
function bitMaskToValue(v=[0])= is_undef(v[0])?0:
 [for(j=v)1]* [for (i=[0:max(0,len(v)-1)]) max(0,sign(v[i]))*pow(2,i)] ;
     
 
//BorisTheBrave # Table driven approach to the 256 combinations. Pro-tip,don't write this by hand,copy mine!
//BorisTheBrave# See marching_cubes_gen.py for how I generated these.
//BorisTheBrave# Each index is the bitwise representation of what is solid.
//BorisTheBrave# Each value is a list of triples indicating what edges are used for that triangle
//BorisTheBrave# (Recall each edge of the cell may become a vertex in the output boundary)
function CASES() = [[],
 [[8,0,3]],[[1,0,9]],[[8,1,3],[8,9,1]],
 [[10,2,1]],[[8,0,3],[1,10,2]],
 [[9,2,0],[9,10,2]],[[3,8,2],[2,8,10],[10,8,9]],
 [[3,2,11]],[[0,2,8],[2,11,8]],
 [[1,0,9],[2,11,3]],[[2,9,1],[11,9,2],[8,9,11]],
 [[3,10,11],[3,1,10]],[[1,10,0],[0,10,8],[8,10,11]],
 [[0,11,3],[9,11,0],[10,11,9]],[[8,9,11],[11,9,10]],
 [[7,4,8]],[[3,7,0],[7,4,0]],[[7,4,8],[9,1,0]],
 [[9,1,4],[4,1,7],[7,1,3]],[[7,4,8],[2,1,10]],
 [[4,3,7],[4,0,3],[2,1,10]],[[2,0,10],[0,9,10],[7,4,8]],
 [[9,10,4],[4,10,3],[3,10,2],[4,3,7]],[[4,8,7],[3,2,11]],
 [[7,4,11],[11,4,2],[2,4,0]],[[1,0,9],[2,11,3],[8,7,4]],
 [[2,11,1],[1,11,9],[9,11,7],[9,7,4]],[[10,11,1],[11,3,1],[4,8,7]],
 [[4,0,7],[7,0,10],[0,1,10],[7,10,11]],[[7,4,8],[0,11,3],[9,11,0],[10,11,9]],
 [[4,11,7],[9,11,4],[10,11,9]],[[9,4,5]],[[9,4,5],[0,3,8]],[[0,5,1],[0,4,5]],
 [[4,3,8],[5,3,4],[1,3,5]],[[5,9,4],[10,2,1]],
 [[8,0,3],[1,10,2],[4,5,9]],[[10,4,5],[2,4,10],[0,4,2]],
 [[3,10,2],[8,10,3],[5,10,8],[4,5,8]],[[9,4,5],[11,3,2]],
 [[11,0,2],[11,8,0],[9,4,5]],[[5,1,4],[1,0,4],[11,3,2]],
 [[5,1,4],[4,1,11],[1,2,11],[4,11,8]],[[3,10,11],[3,1,10],[5,9,4]],
 [[9,4,5],[1,10,0],[0,10,8],[8,10,11]],[[5,0,4],[11,0,5],[11,3,0],[10,11,5]],
 [[5,10,4],[4,10,8],[8,10,11]],[[9,7,5],[9,8,7]],
 [[0,5,9],[3,5,0],[7,5,3]],[[8,7,0],[0,7,1],[1,7,5]],
 [[7,5,3],[3,5,1]],[[7,5,8],[5,9,8],[2,1,10]],[[10,2,1],[0,5,9],[3,5,0],[7,5,3]],
 [[8,2,0],[5,2,8],[10,2,5],[7,5,8]],[[2,3,10],[10,3,5],[5,3,7]],
 [[9,7,5],[9,8,7],[11,3,2]],[[0,2,9],[9,2,7],[7,2,11],[9,7,5]],
 [[3,2,11],[8,7,0],[0,7,1],[1,7,5]],[[11,1,2],[7,1,11],[5,1,7]],
 [[3,1,11],[11,1,10],[8,7,9],[9,7,5]],[[11,7,0],[7,5,0],[5,9,0],[10,11,0],[1,10,0]],
 [[0,5,10],[0,7,5],[0,8,7],[0,10,11],[0,11,3]],[[10,11,5],[11,7,5]],
 [[5,6,10]],[[8,0,3],[10,5,6]],[[0,9,1],[5,6,10]],[[8,1,3],[8,9,1],[10,5,6]],
 [[1,6,2],[1,5,6]],[[6,2,5],[2,1,5],[8,0,3]],[[5,6,9],[9,6,0],[0,6,2]],
 [[5,8,9],[2,8,5],[3,8,2],[6,2,5]],[[3,2,11],[10,5,6]],[[0,2,8],[2,11,8],[5,6,10]],
 [[3,2,11],[0,9,1],[10,5,6]],[[5,6,10],[2,9,1],[11,9,2],[8,9,11]],
 [[11,3,6],[6,3,5],[5,3,1]],[[11,8,6],[6,8,1],[1,8,0],[6,1,5]],
 [[5,0,9],[6,0,5],[3,0,6],[11,3,6]],[[6,9,5],[11,9,6],[8,9,11]],
 [[7,4,8],[6,10,5]],[[3,7,0],[7,4,0],[10,5,6]],
 [[7,4,8],[6,10,5],[9,1,0]],[[5,6,10],[9,1,4],[4,1,7],[7,1,3]],
 [[1,6,2],[1,5,6],[7,4,8]],[[6,1,5],[2,1,6],[0,7,4],[3,7,0]],
 [[4,8,7],[5,6,9],[9,6,0],[0,6,2]],[[2,3,9],[3,7,9],[7,4,9],[6,2,9],[5,6,9]],
 [[2,11,3],[7,4,8],[10,5,6]],[[6,10,5],[7,4,11],[11,4,2],[2,4,0]],
 [[1,0,9],[8,7,4],[3,2,11],[5,6,10]],[[1,2,9],[9,2,11],[9,11,4],[4,11,7],[5,6,10]],
 [[7,4,8],[11,3,6],[6,3,5],[5,3,1]],[[11,0,1],[11,4,0],[11,7,4],[11,1,5],[11,5,6]],
 [[6,9,5],[0,9,6],[11,0,6],[3,0,11],[4,8,7]],[[5,6,9],[9,6,11],[9,11,7],[9,7,4]],
 [[4,10,9],[4,6,10]],[[10,4,6],[10,9,4],[8,0,3]],[[1,0,10],[10,0,6],[6,0,4]],
 [[8,1,3],[6,1,8],[6,10,1],[4,6,8]],[[9,2,1],[4,2,9],[6,2,4]],
 [[3,8,0],[9,2,1],[4,2,9],[6,2,4]],[[0,4,2],[2,4,6]],
 [[8,2,3],[4,2,8],[6,2,4]],[[4,10,9],[4,6,10],[2,11,3]],
 [[11,8,2],[2,8,0],[6,10,4],[4,10,9]],[[2,11,3],[1,0,10],[10,0,6],[6,0,4]],
 [[8,4,1],[4,6,1],[6,10,1],[11,8,1],[2,11,1]],[[3,1,11],[11,1,4],[1,9,4],[11,4,6]],
 [[6,11,1],[11,8,1],[8,0,1],[4,6,1],[9,4,1]],[[3,0,11],[11,0,6],[6,0,4]],
 [[4,11,8],[4,6,11]],[[6,8,7],[10,8,6],[9,8,10]],[[3,7,0],[0,7,10],[7,6,10],[0,10,9]],
 [[1,6,10],[0,6,1],[7,6,0],[8,7,0]],[[10,1,6],[6,1,7],[7,1,3]],
 [[9,8,1],[1,8,6],[6,8,7],[1,6,2]],[[9,7,6],[9,3,7],[9,0,3],[9,6,2],[9,2,1]],
 [[7,6,8],[8,6,0],[0,6,2]],[[3,6,2],[3,7,6]],[[3,2,11],[6,8,7],[10,8,6],[9,8,10]],
 [[7,9,0],[7,10,9],[7,6,10],[7,0,2],[7,2,11]],
 [[0,10,1],[6,10,0],[8,6,0],[7,6,8],[2,11,3]],
 [[1,6,10],[7,6,1],[11,7,1],[2,11,1]],[[1,9,6],[9,8,6],[8,7,6],[3,1,6],[11,3,6]],
 [[9,0,1],[11,7,6]],[[0,11,3],[6,11,0],[7,6,0],[8,7,0]],
 [[7,6,11]],[[11,6,7]],[[3,8,0],[11,6,7]],[[1,0,9],[6,7,11]],
 [[1,3,9],[3,8,9],[6,7,11]],[[10,2,1],[6,7,11]],[[10,2,1],[3,8,0],[6,7,11]],
 [[9,2,0],[9,10,2],[11,6,7]],[[11,6,7],[3,8,2],[2,8,10],[10,8,9]],
 [[2,6,3],[6,7,3]],[[8,6,7],[0,6,8],[2,6,0]],[[7,2,6],[7,3,2],[1,0,9]],
 [[8,9,7],[7,9,2],[2,9,1],[7,2,6]],[[6,1,10],[7,1,6],[3,1,7]],
 [[8,0,7],[7,0,6],[6,0,1],[6,1,10]],[[7,3,6],[6,3,9],[3,0,9],[6,9,10]],
 [[7,8,6],[6,8,10],[10,8,9]],[[8,11,4],[11,6,4]],[[11,0,3],[6,0,11],[4,0,6]],
 [[6,4,11],[4,8,11],[1,0,9]],[[1,3,9],[9,3,6],[3,11,6],[9,6,4]],
 [[8,11,4],[11,6,4],[1,10,2]],[[1,10,2],[11,0,3],[6,0,11],[4,0,6]],
 [[2,9,10],[0,9,2],[4,11,6],[8,11,4]],[[3,4,9],[3,6,4],[3,11,6],[3,9,10],[3,10,2]],
 [[3,2,8],[8,2,4],[4,2,6]],[[2,4,0],[6,4,2]],[[0,9,1],[3,2,8],[8,2,4],[4,2,6]],
 [[1,2,9],[9,2,4],[4,2,6]],[[10,3,1],[4,3,10],[4,8,3],[6,4,10]],
 [[10,0,1],[6,0,10],[4,0,6]],[[3,10,6],[3,9,10],[3,0,9],[3,6,4],[3,4,8]],
 [[9,10,4],[10,6,4]],[[9,4,5],[7,11,6]],[[9,4,5],[7,11,6],[0,3,8]],
 [[0,5,1],[0,4,5],[6,7,11]],[[11,6,7],[4,3,8],[5,3,4],[1,3,5]],
 [[1,10,2],[9,4,5],[6,7,11]],[[8,0,3],[4,5,9],[10,2,1],[11,6,7]],
 [[7,11,6],[10,4,5],[2,4,10],[0,4,2]],[[8,2,3],[10,2,8],[4,10,8],[5,10,4],[11,6,7]],
 [[2,6,3],[6,7,3],[9,4,5]],[[5,9,4],[8,6,7],[0,6,8],[2,6,0]],
 [[7,3,6],[6,3,2],[4,5,0],[0,5,1]],[[8,1,2],[8,5,1],[8,4,5],[8,2,6],[8,6,7]],
 [[9,4,5],[6,1,10],[7,1,6],[3,1,7]],[[7,8,6],[6,8,0],[6,0,10],[10,0,1],[5,9,4]],
 [[3,0,10],[0,4,10],[4,5,10],[7,3,10],[6,7,10]],[[8,6,7],[10,6,8],[5,10,8],[4,5,8]],
 [[5,9,6],[6,9,11],[11,9,8]],[[11,6,3],[3,6,0],[0,6,5],[0,5,9]],
 [[8,11,0],[0,11,5],[5,11,6],[0,5,1]],[[6,3,11],[5,3,6],[1,3,5]],
 [[10,2,1],[5,9,6],[6,9,11],[11,9,8]],[[3,11,0],[0,11,6],[0,6,9],[9,6,5],[1,10,2]],
 [[0,8,5],[8,11,5],[11,6,5],[2,0,5],[10,2,5]],[[11,6,3],[3,6,5],[3,5,10],[3,10,2]],
 [[3,9,8],[6,9,3],[5,9,6],[2,6,3]],[[9,6,5],[0,6,9],[2,6,0]],
 [[6,5,8],[5,1,8],[1,0,8],[2,6,8],[3,2,8]],[[2,6,1],[6,5,1]],
 [[6,8,3],[6,9,8],[6,5,9],[6,3,1],[6,1,10]],[[1,10,0],[0,10,6],[0,6,5],[0,5,9]],
 [[3,0,8],[6,5,10]],[[10,6,5]],[[5,11,10],[5,7,11]],[[5,11,10],[5,7,11],[3,8,0]],
 [[11,10,7],[10,5,7],[0,9,1]],[[5,7,10],[10,7,11],[9,1,8],[8,1,3]],
 [[2,1,11],[11,1,7],[7,1,5]],[[3,8,0],[2,1,11],[11,1,7],[7,1,5]],
 [[2,0,11],[11,0,5],[5,0,9],[11,5,7]],[[2,9,5],[2,8,9],[2,3,8],[2,5,7],[2,7,11]],
 [[10,3,2],[5,3,10],[7,3,5]],[[10,0,2],[7,0,10],[8,0,7],[5,7,10]],
 [[0,9,1],[10,3,2],[5,3,10],[7,3,5]],[[7,8,2],[8,9,2],[9,1,2],[5,7,2],[10,5,2]],
 [[3,1,7],[7,1,5]],[[0,7,8],[1,7,0],[5,7,1]],[[9,5,0],[0,5,3],[3,5,7]],
 [[5,7,9],[7,8,9]],[[4,10,5],[8,10,4],[11,10,8]],
 [[3,4,0],[10,4,3],[10,5,4],[11,10,3]],
 [[1,0,9],[4,10,5],[8,10,4],[11,10,8]],[[4,3,11],[4,1,3],[4,9,1],[4,11,10],[4,10,5]],
 [[1,5,2],[2,5,8],[5,4,8],[2,8,11]],[[5,4,11],[4,0,11],[0,3,11],[1,5,11],[2,1,11]],
 [[5,11,2],[5,8,11],[5,4,8],[5,2,0],[5,0,9]],[[5,4,9],[2,3,11]],
 [[3,4,8],[2,4,3],[5,4,2],[10,5,2]],[[5,4,10],[10,4,2],[2,4,0]],
 [[2,8,3],[4,8,2],[10,4,2],[5,4,10],[0,9,1]],[[4,10,5],[2,10,4],[1,2,4],[9,1,4]],
 [[8,3,4],[4,3,5],[5,3,1]],[[1,5,0],[5,4,0]],
 [[5,0,9],[3,0,5],[8,3,5],[4,8,5]],[[5,4,9]],[[7,11,4],[4,11,9],[9,11,10]],
 [[8,0,3],[7,11,4],[4,11,9],[9,11,10]],[[0,4,1],[1,4,11],[4,7,11],[1,11,10]],
 [[10,1,4],[1,3,4],[3,8,4],[11,10,4],[7,11,4]],[[9,4,1],[1,4,2],[2,4,7],[2,7,11]],
 [[1,9,2],[2,9,4],[2,4,11],[11,4,7],[3,8,0]],[[11,4,7],[2,4,11],[0,4,2]],
 [[7,11,4],[4,11,2],[4,2,3],[4,3,8]],[[10,9,2],[2,9,7],[7,9,4],[2,7,3]],
 [[2,10,7],[10,9,7],[9,4,7],[0,2,7],[8,0,7]],
 [[10,4,7],[10,0,4],[10,1,0],[10,7,3],[10,3,2]],
 [[8,4,7],[10,1,2]],[[4,1,9],[7,1,4],[3,1,7]],
 [[8,0,7],[7,0,1],[7,1,9],[7,9,4]],[[0,7,3],[0,4,7]],
 [[8,4,7]],[[9,8,10],[10,8,11]],[[3,11,0],[0,11,9],[9,11,10]],
 [[0,10,1],[8,10,0],[11,10,8]],[[11,10,3],[10,1,3]],[[1,9,2],[2,9,11],[11,9,8]],
 [[9,2,1],[11,2,9],[3,11,9],[0,3,9]],
 [[8,2,0],[8,11,2]],[[11,2,3]],[[2,8,3],[10,8,2],[9,8,10]],
 [[0,2,9],[2,10,9]],[[3,2,8],[8,2,10],[8,10,1],[8,1,0]],
 [[1,2,10]],[[3,1,8],[1,9,8]],[[9,0,1]],[[3,0,8]],[]];