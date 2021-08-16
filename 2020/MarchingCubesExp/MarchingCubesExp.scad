// MarchingCubes for function literals v0.1 - Torleif Ceder 2020
// With function literals of bounded closed isosufaces 
// in the form f([x,y,z])
// Signed distans function can be output as polyhedron.
// Quality and problens is as expected with MarchingCubes
////////////// DEMO ////////////////////////////////////////////////////////////
scene_select=round(rands(0,3,1)[0]);

sdScene   =  
scene_select==0?
function(p) let(p=p-[0,5,10])smin(min(  max(abs(p.x +1 )-1.5,abs(p.y+3)-6.5,abs(p.z )-6.5)  ,   max(abs(p.x )-6.5,abs(p.y-3)-6.5,abs(p.z )-0.5) ) ,  norm(p -[2.1,0,0])-1.5,2 )
:scene_select==1?
 function(p)    -max( -(norm(p-[-1.15,0,0] )-2) ,norm(p-[1.15,0,0] )-2) 
:scene_select==2?
function(p)  sdRoundBox( [p.x,p.y*.7 -p.z*.7 , p.z*.7 +p.y*.7],  [2,1,2] , 0)
:
  function(p)     smin( (norm(p-[0,0,1])-2), (norm(p-[0,0,-1])-2),.3)-.3 
; 
  
  



function smin(a, b, k = .1) =
let (h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0)) mix(b, a, h) - k * h * (1.0 - h);
function smax(a, b, k = .1) =
let () - smin(-a, -b, k);
function mix(b, a, h) = lerp(b, a, h);

function sdRoundBox( p,  b, r )= 
let(q    = [for(i=p)abs(i)] - b)
   norm( [for(i=q)max(i,0)] ) + min(max(q.x,max(q.y,q.z)),0.0) - r;
  // function literal of our Signed distance function
  // learn more at https://iquilezles.org/www/articles/distfunctions/distfunctions.htm
$boundingBoxPadding=00.14+rands(0.,.1,1)[0];
$cubicBound=true;
sdDemo= true;
$fastBailout=0.87;
 

if(sdDemo){
    c=[[-1,0,1],[8 ,8,10]] ;
    echo("Demo: sdDemo= false; to turn of demo");
    echo(" sdMarchingCubes() Usage: sdMarchingCubes( sdScene = f ( [ x , y , z ] ) , sub = subdivisions ) ");sdMarchingCubes(sdScene   ,sub=4);
//
// c=autoBound(sdScene,cubic = $cubicBound,pad=$boundingBoxPadding);
//// echo(c);
// #translate(c[0])cube(c[1]-c[0]); 
    }

/////////////////////////////////////////////////////////////////////////////////////
//sdMC is a Octree subdivision MarchingCubes with direct gemoetry output
 module sdMarchingCubes(sdScene, cell=[],sub ){
     assert(!is_undef(sub)&&!is_undef(sdScene),
     " sdMarchingCubes() Usage: sdMarchingCubes( sdScene = f ( [ x , y , z ] ) , sub = subdivisions ) ")
if (cell==[]) sdMarchingCubes(sdScene,autoBound(sdScene,cubic=$cubicBound,pad=$boundingBoxPadding ),sub ); else{
    O = cell[0]; S = cell[1];  C = (O + S) / 2; D = S - O;
    maxD = max( abs (D.x),abs (D.y),abs (D.z));
     if (abs(sdScene(C))<=maxD*$fastBailout )//ignore completly empty or full cells
    {        p=vertFromCell  (cell) ;
             evals=[for(p=p)eval(p,sdScene)]; 
             case=bitMaskToValue(evals);
          if (sub>0){  // subdivide cell into eight  smaller if subdivisions left 
//                 c=findTrueZero(C,evalnorm(C,sdScene), sdScene );
              
                    pxxx=[O+[0,0,0],O+[D.x,0,0],O+[0,D.y,0],O+[0,D.y,D.z],
                    O+[0,0,D.z],O+[D.x,D.y,0],O+[D.x,0,D.z],O+[D.x,D.y,D.z]];
                    for(i=[0:7]){sdMarchingCubes(sdScene,bflip([C,pxxx[i]]),sub-1  );  }    } 
         
        else         { // Make polyhedron of this cell
            faces=(CASES()[ (case)]); // Use MC 256 table to find conectivity
            edgepoints=[for(e=EDGES())  // intersecion points along edges
                lerp(p[e[0]],p[e[1]], findZero(evals[e[0]],evals[e[1]]) )];
                nevals=[for(p=edgepoints)[p,evalnorm(p,sdScene)]];
 
/// 
                   n=[for(f=faces)
          let(
                   p0=nevals[ f[0]],
                   p1=nevals[ f[1]],
                   p2=nevals[ f[2] ])
                   [
                   p0[0],
                   
                    let(sharpedge= sharpSolve(p0, p1,sdScene),midp=lerp(p0,p1,.5))
                    midp==sharpedge?[0,0,0]:sharpedge==[0,0,0]?[0,0,0]:
                    !(is_num(sharpedge.x)&&is_num(sharpedge.y)&&is_num(sharpedge.z))?[0,0,0]:
                      (sharpedge )
                  
                   ,
                   p1[0],   
                   
                   let(sharpedge= sharpSolve(p1, p2,sdScene),midp=lerp(p1,p2,.5))
                    midp==sharpedge?[0,0,0]:sharpedge==[0,0,0]?[0,0,0]:
                   !(is_num(sharpedge.x)&&is_num(sharpedge.y)&&is_num(sharpedge.z))?[0,0,0]:
                    (sharpedge  ) ,                      
                  
                   p2[0],   
                   
                   let(sharpedge= sharpSolve(p2, p0,sdScene),midp=lerp(p2,p0,.5))
                    sharpedge==[0,0,0]?[0,0,0]:midp==sharpedge?[0,0,0]:
                   !(is_num(sharpedge.x)&&is_num(sharpedge.y)&&is_num(sharpedge.z))?[0,0,0]:
                    (sharpedge )
                   
                   
                   ,let(corner=(p0[0]+p1[0]+p2[0])/3                  )
                   let(sharpcorner= sharpSolve3(p0, p1,p2,sdScene) )  
                   corner==sharpcorner?[0,0,0]:sharpcorner==[0,0,0]?[0,0,0]:
                   !(is_num(sharpcorner.x)&&is_num(sharpcorner.y)&&is_num(sharpcorner.z))?[0,0,0]:cellClamp(sharpcorner,cell)
                   ]
                   ]; 
 
           for(f=n){
             color(rands(0,1,3)                )
               polyhedron(f,sharpTable([ 
               f[1]==[0,0,0] ?false:true, 
               f[3]==[0,0,0]?false:true,  
               f[5]==[0,0,0]?false:true,  
               f[6]==[0,0,0]||( abs(f[6][0])==1/0) ||(! is_num(f[6][0])) ?false:true ],f))
              
               ; }
 
            } } } } // Showtime
 
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// tiny utils fuctions
function vertFromCell(cell)= [for(c=VERTICES())[cell[c.x].x,cell[c.y].y,cell[c.z].z ]]; 
function findZero(e1,e2)=sign(e1)==sign(e2)||e1+e2==0?0.5:  (abs(e1)/(abs(e1)+abs(e2)) );
function findZerosh(e1,e2)= (abs(e1)+abs(e2))==0?0.5:  clamp(abs(e1)/(abs(e1)+abs(e2)) );
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v) = v / max(norm(v), 0.00000001) * 1; // div by zero safe unit normal
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function v3(v)=[v.x,v.y,v.z];
function Qaddl(v)=(len(v)>0)?[for(v)1]*v:1;
function  addl(v)=(len(v)>0)?[for(v)1]*v:0;
 function sum(v) = is_num(v[0])?v*[for(v)1]:let(vv=rows_to_columns(v))[for(i=vv)sum(i)];
function  unique(m) =  [for(i=[0:max(0,len(m)-1)])   if(search([m[i]],m,1)==[i])m[i]];
function flatten(l) = [ for (li = l, lij = li) lij ]; 
function dot(a,b)=a*b;
 function rows_to_columns(l)= let(longest_row= max( [for(row=l)len(row)-1] ))
[for( i=[0:longest_row]) [ for( j=l) j[i]]];
/////////////////////////////////////////////////////////////////////////////////////
function eval(p,sdScene)=let(p=(is_num(p.x)&&is_num(p.y)&&is_num(p.z))?p:[0,0,0]) sdScene(p);// For legacy 
//////////////////////////////////////////////////////////////////////////////////////
function evalnorm(q,sdScene) =
let (tiny = -0.000001, e = eval(q,sdScene))[
eval([q.x + tiny,q.y,q.z],sdScene) - eval([q.x - tiny,q.y,q.z],sdScene),
eval([q.x,q.y + tiny,q.z],sdScene) - eval([q.x,q.y - tiny,q.z],sdScene),
eval([q.x,q.y,q.z + tiny],sdScene) - eval([q.x,q.y,q.z - tiny],sdScene),    e];
//////////////////////////////////////////////////////////////////////////////////////

 


            function sharpSolve(pA,pB,sdScene)=// [vert,norm+e]
            pA==pB?[0,0,0] :
            
            let (p1=pA[0],n1=un(v3(pA[1])),e1=pA[1][3])
            let (p2=pB[0],n2=un(v3(pB[1])),e2=pB[1][3])
            let(pm=lerp(p1,p2,0.5))
            abs(dot(n1,n2))>0.8?[0,0,0]:
            let(sharp=  intersectPlanes([p1,n1], [p2,n2]))
            
            sharp==[0,0,0]?[0,0,0]:
            let(
            //res= lerp(pm,sharp, findZerosh(eval(pm,sdScene),eval(sharp,sdScene)))
            res= sharp//findTrueZero(pm,un(sharp-pm), sdScene)
            )
            
            (norm(res-pm))<norm(p1-p2)*0.0005?[0,0,0]:
            abs(eval(pm,sdScene))<norm(p1-p2)*0.0125?[0,0,0]:
            //  !is_num(res.x)||!is_num(res.y)||!is_num(res.z)?[0,0,0]:
            res+sdScene(res)*-v3(evalnorm(res,sdScene))

            ;


function sharpSolve3(pA,pB,pC,sdScene)=// [vert,norm+e]

let (p1=pA[0],n1=un(v3(pA[1])),e1=pA[1][3])
let (p2=pB[0],n2=un(v3(pB[1])),e2=pB[1][3])
let (p3=pC[0],n3=un(v3(pC[1])),e3=pC[1][3])
//
//(abs(dot(n3,n1))+abs(dot(n1,n2))+abs(dot(n2,n3))>2.9) ? [0,0,0] :
//
//let(pm= (p1+p2+p3)/3 )
//
//let(sharp=  intersect3Planes([p1,n1], [p2,n2],[p3,n3]))
//
//sharp==[0,0,0]?[0,0,0]:
//let(
//res=sharp// findTrueZero(pm,un(sharp-pm), sdScene)
//)
//
//(norm(res-pm))<norm(p1-p2)*0.005?[0,0,0]:
//abs(eval(pm,sdScene))<norm(p1-p2)*0.005?[0,0,0]:
////  !is_num(res.x)||!is_num(res.y)||!is_num(res.z)?[0,0,0]:
//res

let(centp=(p1+p2+p3)/3)

abs(sdScene(centp))<max([norm(p1-p2),norm(p2-p3),norm(p3-p1)])*.051?[0,0,0]:
let(avrgnormal=un(n1+n2+n3))
let (curvature=min(dot(n1,avrgnormal),dot(n2,avrgnormal),dot(n3,avrgnormal)))
curvature>.975?[0,0,0]:
let(np=findp2p(centp,[[p1,n1],[p2,n2],[p3,n3]]))

np+sdScene(centp)*-v3(evalnorm(centp,sdScene))

;

function intersectPlanes(p1,p2)=
let( 
np3=cross(p1[1],p2[1]),
bp1=baseform(p1),bp2=baseform(p2),
det= norm(np3)*norm(np3),
m=(p1[0]+p2[0])/2,
point=-(( cross(np3,bp2[0]) * bp1[1]) + (cross(bp1[0],np3) * bp2 [1])) / det,
line=[point,np3 ]
 )
  det==0?[0,0,0]: 
//  p1[0].x==p2[0].x?intersectXPlane(p1[0].x,line):
//  p1[0].y==p2[0].y?intersectYPlane(p1[0].y,line):
//  p1[0].z==p2[0].z?intersectZPlane(p1[0].z,line):
  lerp(
   point_to_line(p1[0],point,point+np3 ),
   point_to_line(p2[0],point,point+np3 ),
  0.5)
  
; 


function findp2p(p, pl,   f = 20) =
 f > 0 && len(pl) > 0   ?

 let (
//projected=[ for (i = [0: len(pl) - 1]) let (new_p=point2plane(p, pl[i][0], un(pl[i][1])))  new_p ],
projected=[ for (i = [0: len(pl) - 1]) let (new_p=point2plane(p, pl[i][0],  (pl[i][1])))  new_p-p ],
Qerror=  [for(i=projected)   pow(norm(i),2 ) ],
Qtotal=addl(Qerror))
Qtotal<0.001?p:
let(
Qnorm =  Qerror/ Qtotal,
Qprojected= [ for (i = [0: len(projected) - 1]) projected[i]*Qnorm[i]],

q=addl(Qprojected)

 
 ) 
 findp2p((p+q), pl,   f - 1) :p;

function intersect3Planes(p1,p2,p3)=
let( 
np3=cross(p1[1],p2[1]),
bp1=baseform(p1),bp2=baseform(p2),
det= norm(np3)*norm(np3))
   det==0?[0,0,0]: let(
m=(p1[0]+p2[0])/2,
point=-(( cross(np3,bp2[0]) * bp1[1]) + (cross(bp1[0],np3) * bp2 [1])) / det,
line=[point,np3 ]
 )


 intersectRayPlane(np3 ,  point ,  
                    p3[1]  , p3[0] )
 ;
 
 
 
 function  findTrueZero(pm,normaltosharp, sdScene,c=14)=
c<0?pm:
let(epm=eval(pm, sdScene)) 
abs(epm)<0.0001?pm:

let(epmn=eval(pm+normaltosharp, sdScene)) 
let(flip= epm<epmn?-1:1)
let( npm=pm+normaltosharp*epm*flip)
 
findTrueZero(npm,normaltosharp, sdScene,c-1)
;


function cellClamp(p,cell)=[
clamp(p.x,cell[0].x,cell[1].x),
clamp(p.y,cell[0].y,cell[1].y),
clamp(p.z,cell[0].z,cell[1].z)];

 function intersectRayPlane(rayvector   ,raypoint ,  
                    planenormal  , planepoint ) =
 let(
 diff = raypoint - planepoint,
  prod1 = dot(diff, planenormal),
  prod2 = dot(rayvector, planenormal)
)  raypoint - rayvector * (prod1 / prod2)
 
;
function intersectXPlane(planex,line=[[0,0,0],[1,0,0]])=[planex,line[0].y,line[0].z]+((planex-line[0].x))*[0,line[1].y,line[1].z]/max(1e-64,line[1].x);


function intersectYPlane(planey,line=[[0,0,0],[0,1,0]])=[line[0].x,planey,line[0].z]+((planey-line[0].y))*[line[1].x,0,line[1].z]/max(1e-64,line[1].y);


function intersectZPlane(planez,line=[[0,0,0],[0,0,1]])=[line[0].x,line[0].y,planez]+((planez-line[0].z))*[ line[1].x,line[1].y,0]/max(1e-64,line[1].z);

function baseform(pn)=[pn[1],distance_point2plane(pn[0],[0,0,0], pn[1]) ];
function point_to_line( p, a, b )=let(ap = p-a, ab = b-a) a + dot(ap,ab)/dot(ab,ab) * ab ;
function distance_point2plane(point, planes_origin, planes_normal) =
let (v = point - planes_origin) v.x * planes_normal.x + v.y * planes_normal.y + v.z * planes_normal.z ; 


 

 

function point2plane(p, o, n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane

// Takes a vector. Any number >0 is 1 rest 0. use binary to build a number 
function bitMaskToValue(v=[0])= is_undef(v[0])?0:
 [for(j=v)1]* [for (i=[0:max(0,len(v)-1)]) max(0,sign(v[i]))*pow(2,i)] ;
//////////////////////////////////////////////////////////////////////////////////////
// arrange bundary box from sloppy to proper orientation of minor corner and major corner
function bflip(a,b) = is_undef(b)&&len(a)==2?bflip(a[0],a[1]):[ [min(a.x,b.x),min(a.y,b.y),min(a.z,b.z)], [max(a.x,b.x),max(a.y,b.y),max(a.z,b.z)] ];

 //////////////////////////////////////////////////////////////////////////////////////
function absv(v)=[for(n=v)is_list(n)?absv(n):abs(n)];

module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=
let(
a=up,
b=p-o,
c=cross(a,b) ,
d=angle(a,b))
[d,c];

function angle (a,b)=
atan2(
sqrt((cross(a, b)*cross(a, b))), 
(a* b)
);
 //////////////////////////////////////////////////////////////////////////////////////
function autoBound(sdScene,cubic = true, pad  ) =    let (
 pad=is_undef(pad)?.2:pad,
    west = findBound([1,0,0],sdScene),    east = -findBound([-1,0,0],sdScene),
    north = findBound([0,1,0],sdScene),    south = -findBound([ 0,-1,0],sdScene),
    up = findBound([0,0,1],sdScene),    down = -findBound([0,0,-1],sdScene),
  cell= bflip([[west,north,up],[east,south,down]]),
      O = cell[0], S = cell[1],  C = (O + S) / 2, D = S - O, 
// ec=echo(cell,D),

    maxD = max(   D.x,  D.y,  D.z    )) 
 
cubic == true ?
    let(   d = ([maxD,maxD,maxD]/2)* (1+pad)   )
    [C - d  ,C + d ]  : 
    let(   d = (D /2)* (1+pad)   )
    [C - d  ,C + d ] ;
//////////////////////////////////////////////////////////////////////////////////////
function findBound(vec,sdScene) =
let (VeryFar = 1e7,  p1 = vec * VeryFar, p2 = p1 +  vec  ,
e1 = abs(eval(p1,sdScene)),  e2 = abs(eval(p2,sdScene)),
scale = abs(e2 - e1),// Account for non unit_for_unit field.
corrected = (e1 / scale), distance = VeryFar - e1/scale //distance= VeryFar-corrected
)/*[p1,p2,e1,e2,scale,corrected,distance ]*/ distance ;

//////////////////////////////////////////////////////////////////////////////////////
function  sharpTable(pvts,p)=
let(p0=p[0])
let(p01=p[1])
let(p1=p[2])
let(p12=p[3])
let(p2=p[4])
let(p20=p[5])
let(p012=p[6])
   pvts == [true, true, true,true]  ? [[6,0,1],[6,1,2],[6,2,3],[6,3,4],[6,4,5],[6,5,0]]:
   pvts == [false, false, false,true]  ? [[6,0,2],[6,2,4],[6,4,0]]:
  v3(pvts)== [false, false, false ] ? [[0,2,4],]://[1,3,5]
  v3(pvts)== [true, false, false ] ? [[0,1,4],[1,2,4]]://[1,3,5]
    v3(pvts)== [false, true, false ] ? [[2,3,0],[3,4,0]]:
  v3(pvts)== [false, false, true ] ?  [[2,5,0],[2,4,5]]:

   v3(pvts)==[true, true, false] ? 
//    [ 
 norm(p0-p12)<norm(p01-p2)
  ?[[0,1,3],[0,3,4],[1,2,3]]:
  [[1,3,4],[0,1,4],[1,2,3]]  :

   v3(pvts)==[ false,true, true ] ?
//    [ 
  norm(p0-p12)<norm(p1-p20)
   ?
[[0,2,3],[0,3,5],[3,4,5]]:
   [[5,2,3],[0,2,5],[3,4,5]]:

  v3(pvts)== [ true,false, true] ?
//    [ 
  norm(p1-p20)<norm(p01-p2)
   ?
 [[1,2,5],[2,4,5],[0,1,5]]:
  [[1,4,5],[1,2,4],[0,1,5]]:


// (pvt== v3([true,true,true ])) ? 
    [   [0,1,5],[1,2,3],[3,4,5],[1,3,5] ]  
    ;

////// MC Tables by BorisTheBrav /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
function  VERTICES ()= [
    [0,0,0],    [1,0,0],
    [1,1,0],    [0,1,0],
    [0,0,1],    [1,0,1],
    [1,1,1],    [0,1,1],    ];
//# BorisTheBrave convention for the edges
function EDGES() = [
    [0,1],    [1,2],    [2,3],
    [3,0],    [4,5],    [5,6],
    [6,7],    [7,4],    [0,4],
    [1,5],    [2,6],    [3,7]  ];
//BorisTheBrave # Table driven approach to the 256 combinations. Pro-tip,don't write this by hand,copy mine!
//BorisTheBrave# See marching_cubes_gen.py for how I generated these.
//BorisTheBrave# Each index is the bitwise representation of what is solid.
//BorisTheBrave# Each value is a list of triples indicating what edges are used for that triangle
//BorisTheBrave# (Recall each edge of the cell may become a vertex in the output boundary)
function CASES() = [[],[[8,0,3]],[[1,0,9]],[[8,1,3],[8,9,1]],[[10,2,1]],[[8,0,3],[1,10,2]],[[9,2,0],[9,10,2]],[[3,8,2],[2,8,10],[10,8,9]],[[3,2,11]],[[0,2,8],[2,11,8]],[[1,0,9],[2,11,3]],[[2,9,1],[11,9,2],[8,9,11]],[[3,10,11],[3,1,10]],[[1,10,0],[0,10,8],[8,10,11]],[[0,11,3],[9,11,0],[10,11,9]],[[8,9,11],[11,9,10]],[[7,4,8]],[[3,7,0],[7,4,0]],[[7,4,8],[9,1,0]],[[9,1,4],[4,1,7],[7,1,3]],[[7,4,8],[2,1,10]],[[4,3,7],[4,0,3],[2,1,10]],[[2,0,10],[0,9,10],[7,4,8]],[[9,10,4],[4,10,3],[3,10,2],[4,3,7]],[[4,8,7],[3,2,11]],[[7,4,11],[11,4,2],[2,4,0]],[[1,0,9],[2,11,3],[8,7,4]],[[2,11,1],[1,11,9],[9,11,7],[9,7,4]],[[10,11,1],[11,3,1],[4,8,7]],[[4,0,7],[7,0,10],[0,1,10],[7,10,11]],[[7,4,8],[0,11,3],[9,11,0],[10,11,9]],[[4,11,7],[9,11,4],[10,11,9]],[[9,4,5]],[[9,4,5],[0,3,8]],[[0,5,1],[0,4,5]],[[4,3,8],[5,3,4],[1,3,5]],[[5,9,4],[10,2,1]],[[8,0,3],[1,10,2],[4,5,9]],[[10,4,5],[2,4,10],[0,4,2]],[[3,10,2],[8,10,3],[5,10,8],[4,5,8]],[[9,4,5],[11,3,2]],[[11,0,2],[11,8,0],[9,4,5]],[[5,1,4],[1,0,4],[11,3,2]],[[5,1,4],[4,1,11],[1,2,11],[4,11,8]],[[3,10,11],[3,1,10],[5,9,4]],[[9,4,5],[1,10,0],[0,10,8],[8,10,11]],[[5,0,4],[11,0,5],[11,3,0],[10,11,5]],[[5,10,4],[4,10,8],[8,10,11]],[[9,7,5],[9,8,7]],[[0,5,9],[3,5,0],[7,5,3]],[[8,7,0],[0,7,1],[1,7,5]],[[7,5,3],[3,5,1]],[[7,5,8],[5,9,8],[2,1,10]],[[10,2,1],[0,5,9],[3,5,0],[7,5,3]],[[8,2,0],[5,2,8],[10,2,5],[7,5,8]],[[2,3,10],[10,3,5],[5,3,7]],[[9,7,5],[9,8,7],[11,3,2]],[[0,2,9],[9,2,7],[7,2,11],[9,7,5]],
[[3,2,11],[8,7,0],[0,7,1],[1,7,5]],[[11,1,2],[7,1,11],[5,1,7]],[[3,1,11],[11,1,10],[8,7,9],[9,7,5]],[[11,7,0],[7,5,0],[5,9,0],[10,11,0],[1,10,0]],[[0,5,10],[0,7,5],[0,8,7],[0,10,11],[0,11,3]],[[10,11,5],[11,7,5]],[[5,6,10]],[[8,0,3],[10,5,6]],[[0,9,1],[5,6,10]],[[8,1,3],[8,9,1],[10,5,6]],[[1,6,2],[1,5,6]],[[6,2,5],[2,1,5],[8,0,3]],[[5,6,9],[9,6,0],[0,6,2]],[[5,8,9],[2,8,5],[3,8,2],[6,2,5]],[[3,2,11],[10,5,6]],[[0,2,8],[2,11,8],[5,6,10]],[[3,2,11],[0,9,1],[10,5,6]],[[5,6,10],[2,9,1],[11,9,2],[8,9,11]],[[11,3,6],[6,3,5],[5,3,1]],[[11,8,6],[6,8,1],[1,8,0],[6,1,5]],[[5,0,9],[6,0,5],[3,0,6],[11,3,6]],[[6,9,5],[11,9,6],[8,9,11]],[[7,4,8],[6,10,5]],[[3,7,0],[7,4,0],[10,5,6]],[[7,4,8],[6,10,5],[9,1,0]],[[5,6,10],[9,1,4],[4,1,7],[7,1,3]],[[1,6,2],[1,5,6],[7,4,8]],[[6,1,5],[2,1,6],[0,7,4],[3,7,0]],[[4,8,7],[5,6,9],[9,6,0],[0,6,2]],[[2,3,9],[3,7,9],[7,4,9],[6,2,9],[5,6,9]],[[2,11,3],[7,4,8],[10,5,6]],[[6,10,5],[7,4,11],[11,4,2],[2,4,0]],[[1,0,9],[8,7,4],[3,2,11],[5,6,10]],[[1,2,9],[9,2,11],[9,11,4],[4,11,7],[5,6,10]],
[[7,4,8],[11,3,6],[6,3,5],[5,3,1]],[[11,0,1],[11,4,0],[11,7,4],[11,1,5],[11,5,6]],[[6,9,5],[0,9,6],[11,0,6],[3,0,11],[4,8,7]],[[5,6,9],[9,6,11],[9,11,7],[9,7,4]],[[4,10,9],[4,6,10]],[[10,4,6],[10,9,4],[8,0,3]],[[1,0,10],[10,0,6],[6,0,4]],[[8,1,3],[6,1,8],[6,10,1],[4,6,8]],[[9,2,1],[4,2,9],[6,2,4]],[[3,8,0],[9,2,1],[4,2,9],[6,2,4]],[[0,4,2],[2,4,6]],[[8,2,3],[4,2,8],[6,2,4]],[[4,10,9],[4,6,10],[2,11,3]],[[11,8,2],[2,8,0],[6,10,4],[4,10,9]],[[2,11,3],[1,0,10],[10,0,6],[6,0,4]],[[8,4,1],[4,6,1],[6,10,1],[11,8,1],[2,11,1]],[[3,1,11],[11,1,4],[1,9,4],[11,4,6]],[[6,11,1],[11,8,1],[8,0,1],[4,6,1],[9,4,1]],[[3,0,11],[11,0,6],[6,0,4]],[[4,11,8],[4,6,11]],[[6,8,7],[10,8,6],[9,8,10]],[[3,7,0],[0,7,10],[7,6,10],[0,10,9]],[[1,6,10],[0,6,1],[7,6,0],[8,7,0]],[[10,1,6],[6,1,7],[7,1,3]],[[9,8,1],[1,8,6],[6,8,7],[1,6,2]],[[9,7,6],[9,3,7],[9,0,3],[9,6,2],[9,2,1]],[[7,6,8],[8,6,0],[0,6,2]],[[3,6,2],[3,7,6]],[[3,2,11],[6,8,7],[10,8,6],[9,8,10]],[[7,9,0],[7,10,9],[7,6,10],[7,0,2],[7,2,11]],[[0,10,1],[6,10,0],[8,6,0],[7,6,8],[2,11,3]],[[1,6,10],[7,6,1],[11,7,1],[2,11,1]],[[1,9,6],[9,8,6],[8,7,6],[3,1,6],[11,3,6]],
[[9,0,1],[11,7,6]],[[0,11,3],[6,11,0],[7,6,0],[8,7,0]],[[7,6,11]],[[11,6,7]],[[3,8,0],[11,6,7]],[[1,0,9],[6,7,11]],[[1,3,9],[3,8,9],[6,7,11]],[[10,2,1],[6,7,11]],[[10,2,1],[3,8,0],[6,7,11]],[[9,2,0],[9,10,2],[11,6,7]],[[11,6,7],[3,8,2],[2,8,10],[10,8,9]],[[2,6,3],[6,7,3]],[[8,6,7],[0,6,8],[2,6,0]],[[7,2,6],[7,3,2],[1,0,9]],[[8,9,7],[7,9,2],[2,9,1],[7,2,6]],[[6,1,10],[7,1,6],[3,1,7]],[[8,0,7],[7,0,6],[6,0,1],[6,1,10]],[[7,3,6],[6,3,9],[3,0,9],[6,9,10]],[[7,8,6],[6,8,10],[10,8,9]],[[8,11,4],[11,6,4]],[[11,0,3],[6,0,11],[4,0,6]],[[6,4,11],[4,8,11],[1,0,9]],[[1,3,9],[9,3,6],[3,11,6],[9,6,4]],[[8,11,4],[11,6,4],[1,10,2]],[[1,10,2],[11,0,3],[6,0,11],[4,0,6]],[[2,9,10],[0,9,2],[4,11,6],[8,11,4]],[[3,4,9],[3,6,4],[3,11,6],[3,9,10],[3,10,2]],[[3,2,8],[8,2,4],[4,2,6]],[[2,4,0],[6,4,2]],[[0,9,1],[3,2,8],[8,2,4],[4,2,6]],[[1,2,9],[9,2,4],[4,2,6]],[[10,3,1],[4,3,10],[4,8,3],[6,4,10]],[[10,0,1],[6,0,10],[4,0,6]],[[3,10,6],[3,9,10],[3,0,9],[3,6,4],[3,4,8]],[[9,10,4],[10,6,4]],[[9,4,5],[7,11,6]],[[9,4,5],[7,11,6],[0,3,8]],[[0,5,1],[0,4,5],[6,7,11]],[[11,6,7],[4,3,8],[5,3,4],[1,3,5]],[[1,10,2],[9,4,5],[6,7,11]],
[[8,0,3],[4,5,9],[10,2,1],[11,6,7]],[[7,11,6],[10,4,5],[2,4,10],[0,4,2]],[[8,2,3],[10,2,8],[4,10,8],[5,10,4],[11,6,7]],[[2,6,3],[6,7,3],[9,4,5]],[[5,9,4],[8,6,7],[0,6,8],[2,6,0]],[[7,3,6],[6,3,2],[4,5,0],[0,5,1]],[[8,1,2],[8,5,1],[8,4,5],[8,2,6],[8,6,7]],[[9,4,5],[6,1,10],[7,1,6],[3,1,7]],[[7,8,6],[6,8,0],[6,0,10],[10,0,1],[5,9,4]],[[3,0,10],[0,4,10],[4,5,10],[7,3,10],[6,7,10]],[[8,6,7],[10,6,8],[5,10,8],[4,5,8]],[[5,9,6],[6,9,11],[11,9,8]],[[11,6,3],[3,6,0],[0,6,5],[0,5,9]],[[8,11,0],[0,11,5],[5,11,6],[0,5,1]],[[6,3,11],[5,3,6],[1,3,5]],[[10,2,1],[5,9,6],[6,9,11],[11,9,8]],[[3,11,0],[0,11,6],[0,6,9],[9,6,5],[1,10,2]],[[0,8,5],[8,11,5],[11,6,5],[2,0,5],[10,2,5]],[[11,6,3],[3,6,5],[3,5,10],[3,10,2]],[[3,9,8],[6,9,3],[5,9,6],[2,6,3]],[[9,6,5],[0,6,9],[2,6,0]],[[6,5,8],[5,1,8],[1,0,8],[2,6,8],[3,2,8]],[[2,6,1],[6,5,1]],[[6,8,3],[6,9,8],[6,5,9],[6,3,1],[6,1,10]],[[1,10,0],[0,10,6],[0,6,5],[0,5,9]],[[3,0,8],[6,5,10]],[[10,6,5]],[[5,11,10],[5,7,11]],[[5,11,10],[5,7,11],[3,8,0]],[[11,10,7],[10,5,7],[0,9,1]],[[5,7,10],[10,7,11],[9,1,8],[8,1,3]],[[2,1,11],[11,1,7],[7,1,5]],[[3,8,0],[2,1,11],[11,1,7],[7,1,5]],[[2,0,11],[11,0,5],[5,0,9],[11,5,7]],[[2,9,5],[2,8,9],[2,3,8],[2,5,7],[2,7,11]],[[10,3,2],[5,3,10],[7,3,5]],[[10,0,2],[7,0,10],[8,0,7],[5,7,10]],[[0,9,1],[10,3,2],[5,3,10],[7,3,5]],[[7,8,2],[8,9,2],[9,1,2],[5,7,2],[10,5,2]],[[3,1,7],[7,1,5]],[[0,7,8],[1,7,0],[5,7,1]],[[9,5,0],[0,5,3],[3,5,7]],[[5,7,9],[7,8,9]],[[4,10,5],[8,10,4],[11,10,8]],[[3,4,0],[10,4,3],[10,5,4],[11,10,3]],[[1,0,9],[4,10,5],[8,10,4],[11,10,8]],
[[4,3,11],[4,1,3],[4,9,1],[4,11,10],[4,10,5]],[[1,5,2],[2,5,8],[5,4,8],[2,8,11]],[[5,4,11],[4,0,11],[0,3,11],[1,5,11],[2,1,11]],[[5,11,2],[5,8,11],[5,4,8],[5,2,0],[5,0,9]],[[5,4,9],[2,3,11]],[[3,4,8],[2,4,3],[5,4,2],[10,5,2]],[[5,4,10],[10,4,2],[2,4,0]],[[2,8,3],[4,8,2],[10,4,2],[5,4,10],[0,9,1]],[[4,10,5],[2,10,4],[1,2,4],[9,1,4]],[[8,3,4],[4,3,5],[5,3,1]],[[1,5,0],[5,4,0]],[[5,0,9],[3,0,5],[8,3,5],[4,8,5]],[[5,4,9]],[[7,11,4],[4,11,9],[9,11,10]],[[8,0,3],[7,11,4],[4,11,9],[9,11,10]],[[0,4,1],[1,4,11],[4,7,11],[1,11,10]],[[10,1,4],[1,3,4],[3,8,4],[11,10,4],[7,11,4]],[[9,4,1],[1,4,2],[2,4,7],[2,7,11]],[[1,9,2],[2,9,4],[2,4,11],[11,4,7],[3,8,0]],[[11,4,7],[2,4,11],[0,4,2]],[[7,11,4],[4,11,2],[4,2,3],[4,3,8]],[[10,9,2],[2,9,7],[7,9,4],[2,7,3]],[[2,10,7],[10,9,7],[9,4,7],[0,2,7],[8,0,7]],[[10,4,7],[10,0,4],[10,1,0],[10,7,3],[10,3,2]],[[8,4,7],[10,1,2]],[[4,1,9],[7,1,4],[3,1,7]],[[8,0,7],[7,0,1],[7,1,9],[7,9,4]],[[0,7,3],[0,4,7]],[[8,4,7]],[[9,8,10],[10,8,11]],[[3,11,0],[0,11,9],[9,11,10]],[[0,10,1],[8,10,0],[11,10,8]],[[11,10,3],[10,1,3]],[[1,9,2],[2,9,11],[11,9,8]],[[9,2,1],[11,2,9],[3,11,9],[0,3,9]],[[8,2,0],[8,11,2]],[[11,2,3]],[[2,8,3],[10,8,2],[9,8,10]],[[0,2,9],[2,10,9]],[[3,2,8],[8,2,10],[8,10,1],[8,1,0]],[[1,2,10]],[[3,1,8],[1,9,8]],[[9,0,1]],[[3,0,8]],[]];