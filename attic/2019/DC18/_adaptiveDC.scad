//v1=rnd()*120;
//v2=rnd(0.1,0.25);
//v3=rnd(-1,1);
//v4=rnd(-1,1);
//v5=rnd(-1,1);
//v6=rnd(3,4);
//v7=rnd(-1,1);
//v8=rnd(-1,1);
//v9=rnd(-1,1);
//v10=rnd(2,v6);
//v17=rnd(-2,2);
//v18=rnd(-2,2);
//v19=rnd(-2,2);
//v110=rnd(2,v6);
// 
//function evalv(p)=
//max(max(p.x*sin(v1)-v2 -p.z*cos(v1) ,p.y,cube(p-[v3,v4,v5],0.35+v6,1)),-sphere(p-[v7,-v8,v9],v10),-cube(p-[v17,-v18,v19],v110));
//function evalv(p)=minR(
//cube(p+[0,1.1,1],2,0),
//max(cube(p-[0,1.1,1],2,0),-sphere(p,1)),   
//0.001);
// x=-1;y=0;z=1;    
//function evalv(p)=sphere(p,4)+ (sin(atan2(p.y,p.x)*4))*(1-abs(un(p).z)) ;
 function evalv(p)=min(cube(p-[2,2,2],   2),sphere(p+[2.1,2.1,2.1],   2));




result=octree([[-10,-10,-10],[10,10,10]],   subdivision = 8);
recho(result);
 
flatresults=flatoct(result);

function flatoct()=[];
module recho (n,d=0)
{
//echo(str(indent(d),n[0]));
if(d==8) color([1,0,0],1/max(1,abs(n[0][1])) ) translate(n[0][0])cube(20*pow(0.5,d+0.1),center=true);
if(n[1]!=undef){
 recho (n[1][0],d+1);
 recho (n[1][1],d+1);
 recho (n[1][2],d+1);
 recho (n[1][3],d+1);
 recho (n[1][4],d+1);
 recho (n[1][5],d+1);
 recho (n[1][6],d+1);
 recho (n[1][7],d+1);
}
//else echo( );
}
function indent(d)=chr([for(i=[0:d])32]);




function octree(cell,   subdivision = 6) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
eO = evalv(O),  eC = evalv(C), 
p1 = O,   
p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
p8 = ([S.x, S.y, S.z ]),            p9 = C)
// if 
subdivision > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ? [[C,eC]] :  [[C,eC],[
 // else split cell in 8 new cells constructed by corners and center point
octree(bflip(p1, C),   subdivision - 1), octree(bflip(p2, C),   subdivision - 1), 
octree(bflip(p3, C),   subdivision - 1), octree(bflip(p4, C),   subdivision - 1), 
octree(bflip(p5, C),   subdivision - 1), octree(bflip(p6, C),   subdivision - 1), 
octree(bflip(p7, C),   subdivision - 1), octree(bflip(p8, C),  subdivision - 1) ]]:
[[C,eC]];
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];

//geometry
 function sphere(p, b = 1) = norm(p) - b;
function cube(p, b = 1, r = 0.001) =
let (d = abs3(p) - [b - r, b - r, b - r])
(min(max(d.x, d.y, d.z), 0.0) + norm(max3(d, 0.0)) - r);

function max3(a, b) = [max(a[0], b),
 max(a[1], b), max(a[2], b)
];
function abs3(v) = [abs(v[0]), abs(v[1]),
 abs(v[2])
];
function torus(p, tx = 2.9, ty = 0.61) =
let (q = [norm([p.x, p.z]) - tx, p.y]) norm(q) - ty;