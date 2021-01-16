include <polytools.scad>

function tet(e1,e2,e3,e4,p1,p2,p3,p4) =
let(
v=[asign(e1),asign(e2),asign(e3),asign(e4)],
p12=(p1+p2)/2,
p13=(p1+p3)/2,
p14=(p1+p4)/2,
p23=(p2+p3)/2,
p24=(p2+p4)/2,
p34=(p3+p4)/2)
(v==[0,0,0,1]) ?  [[p14,p24,p34],[[0,1,2]]]:
(v==[0,0,1,0]) ?  [[p23,p13,p34],[[0,1,2]]]:
(v==[0,0,1,1]) ?  [[p23,p13,p14,p24],[[0,1,2],[0,2,3]]]:
(v==[0,1,0,0]) ?  [[p12,p23,p24],[[0,1,2]]]:
(v==[0,1,0,1]) ?  [[p23,p12,p14,p34],[[1,0,2],[2,0,3]]]: 
(v==[0,1,1,0]) ?  [[p12,p13,p34,p24],[[0,1,2],[0,2,3]]]: 
(v==[0,1,1,1]) ?  [[p12,p13,p14],[[0,1,2]]]: 
(v==[1,0,0,0]) ?  [[p13,p12,p14],[[0,1,2]]]: 
(v==[1,0,0,1]) ?  [[p12,p13,p34,p24],[[1,0,2],[2,0,3]]]: 
(v==[1,0,1,0]) ?  [[p23,p12,p14,p34],[[0,1,2],[0,2,3]]]: 
(v==[1,0,1,1]) ?  [[p23,p12,p24],[[0,1,2]]]: 
(v==[1,1,0,0]) ?  [[p23,p13,p14,p24],[[1,0,2],[2,0,3]]]: 
(v==[1,1,0,1]) ?  [[p13,p23,p34],[[0,1,2]]]:  
(v==[1,1,1,0]) ?  [[p24,p14,p34],[[0,1,2]]]:[[],[]];

function meshcell(cell, scene ) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], 
S = cell[1], 
C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z) ,
p000= (O+[0  ,0,  0]),
p100= (O+[D.x,0,  0]),
p010= (O+[0  ,D.y,0]),
p011= (O+[0,D.y,D.z]),
p001= (O+[0,0,D.z]),
p110= (O+[D.x,D.y,0]),
p101= (O+[D.x,0,D.z]),
p111= (O+[D.x,D.y,D.z])
) 
cbpl([
fp_flip(meshcellW( [C,p000], scene )),
(meshcellW( [C,p100], scene )),
(meshcellW( [C,p010], scene )),
fp_flip(meshcellW( [C,p011], scene )),
(meshcellW( [C,p001], scene )),
fp_flip(meshcellW( [C,p110], scene )),
fp_flip(meshcellW( [C,p101], scene )),
(meshcellW( [C,p111], scene ))
]);
function meshcellW(cell, scene ) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], 
S = cell[1], 
 

C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z) ,

 p=O,
p000= (O+[0,0,0]),
p100= (O+[D.x,0,0]),
p010= (O+[0,D.y,0]),
p011= (O+[0,D.y,D.z]),
p001= (O+[0,0,D.z]),
p110= (O+[D.x,D.y,0]),
p101= (O+[D.x,0,D.z]),
p111= (O+[D.x,D.y,D.z]),
e000=eval(O+[0,0,0],scene),
e100=eval(O+[D.x,0,0],scene),
e010=eval(O+[0,D.y,0],scene),
e011=eval(O+[0,D.y,D.z],scene),
e001=eval(O+[0,0,D.z],scene),
e110=eval(O+[D.x,D.y,0],scene),
e101=eval(O+[D.x,0,D.z],scene),
e111=eval(O+[D.x,D.y,D.z],scene),
//
//t1=tet(e000,e100,e101,e111,p000,p100,p101,p111),
//t2=tet(e000,e101,e001,e111,p000,p101,p001,p111),
//t3=tet(e000,e001,e011,e111,p000,p001,p011,p111),
//t4=tet(e000,e011,e010,e111,p000,p011,p010,p111),
//t5=tet(e000,e010,e110,e111,p000,p010,p110,p111),
//t6=tet(e000,e110,e100,e111,p000,p110,p100,p111) ) 
//
// cbp(t1,cbp(t2,cbp(t3,cbp(t4,cbp(t5,t6)))))

t1=tet(e000,e110,e101,e011,
       p000,p110,p101,p011),

t2=tet(e000,e110,e011,e010,
       p000,p110,p011,p010),

t3=tet(e000,e110,e100,e101,
       p000,p110,p100,p101),

t4=tet(e011,e101,e000,e001,
       p011,p101,p000,p001),

t5=tet(e011,e101,e111,e110,
       p011,p101,p111,p110)

)

  cbp(t1,cbp(t2,cbp(t3,cbp(t4,t5))))

;
//function cbpl(l,n,c=0)=n==undef?cbpl(l,len(l)): c<n-1?cbp(l[c],cbpl(l,n,c+1)):l[c];
//function cbpl(l,n,c=0)= let($L=l)cbplw(len(l)); 
//
//function cbplw(n,c=0)=  c<n-1?cbp($L[c],cbplw(n,c+1)):$L[c];
//
//function cbp(p1,p2)= (combinepolyhedron(p1,p2));
function asign(x)=max(0,sign(x));
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];
  function fp_flip(w)=len(w[1])>0?[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]]:[[],[]];