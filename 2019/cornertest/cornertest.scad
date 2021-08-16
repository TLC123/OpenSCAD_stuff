corners=[[[[1],[-1]],[[1],[-1]]],[[[-1],[-1]],[[1],[-1]]]];
function meshcell(cell, scene ) =
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
)
 
[[],faces] 
 
 

;
function eval(p,s)=eval[p.x][p.y],[p.z];

m=meshcell([[0,0],[1,1]]);
p=m[0];f=m[1];
polyhedron(p,f):