Sz=5;
scene=[];
$octcache=BuildOctree( scene, [-Sz,Sz]);
echo($octcache);
echo(EvalCache( [1,1,1] ) );


function eval(p,nullscene)=let(s=
 (
min(
norm(p-[0,0,0] )-3.1,
norm(p-[-3.5,2.5,2.5] )-.8

)


)) s ;


function BuildOctree( scene, cell,subdiv = 2) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
eO = eval(O, scene),  eC = eval(C, scene), 
p1 = O,                     //0000
p2 = ([S.x, O.y, O.z]),     //1001         
p3 = ([O.x, S.y, O.z]),     //2010
p4 = ([O.x, O.y, S.z ]),    //3001        
p5 = ([S.x, S.y, O.z]),     //4110
p6 = ([S.x, O.y, S.z ]),    //5101        
p7 = ([O.x, S.y, S.z]),     //6011
p8 = ([S.x, S.y, S.z ]),    //7111        
p9 = C)
// if 
subdiv > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ? [[O,S,eC]] :   // else split cell in 8 new cells constructed by corners and center point
[[O,S,eC],[
 
BuildOctree(scene,bflip(p1, C), subdiv - 1), 
BuildOctree(scene,bflip(p2, C), subdiv - 1), 
BuildOctree(scene,bflip(p3, C), subdiv - 1), 
BuildOctree(scene,bflip(p4, C), subdiv - 1),  
BuildOctree(scene,bflip(p5, C), subdiv - 1), 
BuildOctree(scene,bflip(p6, C), subdiv - 1), 
BuildOctree(scene,bflip(p7, C), subdiv - 1),
BuildOctree(scene,bflip(p8, C), subdiv - 1) 
 ] ]:
[[O,S,eC]];


function EvalCache (p,level=0,branch=[])=
let(cell=drilldown(p))
len(cell)==1?cell[0][2]:cell
//let(
//O = cell[0][0], S = cell[0][1], C = (O + S) / 2, 
// select= 
//p.x<C.x? 
//    p.y<C.y? 
//        p.z<C.z?0:3
//:
//        p.z<C.z?2:6 
// :
//    p.y<C.y? 
//        p.z<C.z?1:5
//:
//        p.z<C.z?4:7
// )
// EvalCache (p,level+1,concat(branch,[select]))
 ; 


function drilldown(b)=
len(b)==0?$octcache[0]:
len(b)==1?$octcache[1][b[0]][0]:
len(b)==2?$octcache[1][b[0]][1][b[1]][0]:
len(b)==3?$octcache[1][b[0]][1][b[1]][1][b[2]][0]:
len(b)==4?$octcache[1][b[0]][1][b[1]][1][b[2]][1][b[3]][0]:
len(b)==5?$octcache[1][b[0]][1][b[1]][1][b[2]][1][b[3]][1][b[4]][0]:
len(b)==6?$octcache[1][b[0]][1][b[1]][1][b[2]][1][b[3]][1][b[4]][1][b[5]][0]:
//len(b)==7?
$octcache[1][b[0]][1][b[1]][1][b[2]][1][b[3]][1][b[4]][1][b[5]][1][b[6]][0]

;
 


function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];