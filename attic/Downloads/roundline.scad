//This rounding is recursive chamfer. 
//Roundline will not pass through original points. 
//Roundline will pass through midpoints of straigt lines between original points
$fn=12;
RoundSize=5;
Iterations=3;
Points=8;
//some list of XYZS points
v=[for(i=[0:Points])
[rnd(100)+i*100/Points,rnd(100),rnd(100),rnd(5)+2,rndc()]
];
//rounline recursivley chamfer corners to roundness
e =rounline(v,RoundSize,Iterations);
plotroundline(e);
module plotroundline(){
for(i=[0:len(e)-1]){ line(e[i][0],e[i][1]);
 }
}

function rounline(v,r=1,i=0)= i==0? fillgap(shrimp(makesegmentline(v),r)): fillgap(shrimp(rounline(v,r,i-1) ,r));
function makesegmentline(v)=len(v)-1>0?[for(i=[0:len(v)-2])[v[i],v[i+1]]]:[[v[0],v[0]]];
function shrimp(v,r=10)=[for(i=[0:len(v)-1])let(first=(i==0?0:1),last=(i==len(v)-1?0:1),L=len3(v[i][1]-v[i][0])/4.5)let(n=un(v[i][1]-v[i][0]))[v[i][0]+(first*n*min(r,L)),v[i][1]-(last*n*min(r,L))]];

function fillgap(v)=[for(i=[0:0.5:len(v)-1])i==i-i%1?v[i]:[v[i-0.5][1],v[i+0.5][0]]];



// helper functions
module line(p1, p2) {
  color(p1[4])hull() {    translate([p1[0],p1[1],p1[2]])  sphere(p1[3]);
    translate([p2[0],p2[1],p2[2]])  sphere(p2[3]);  }
}

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);

function rndc(seed) =seed==undef? [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]]:[rands(0, 1, 1,seed)[0], rands(0, 1, 1,seed+101)[0], rands(0, 1, 1,seed+201)[0]];
function half(b,select=1,l1=0.68,l2=0.5)=let(np1=lerp(b[0],b[3],l1),np2=lerp(b[1],b[2],l2))select==1?[b[0],b[1],np2,np1]:[np1,np2,b[2],b[3]];
function flip(b)=[b[1],b[2],b[3],b[0]];

function un(v) = v / max(len3(v), 0.000001) * 1;

 
function len3(v) =  sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));


function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));// smoothcurve and its two friends
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));