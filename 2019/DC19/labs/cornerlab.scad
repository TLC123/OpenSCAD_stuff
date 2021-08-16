include<DCmath.scad>
include<polytools.scad>

M= cbpl( [for (x=[-10:2:10],y=[-10:2:10],z=[-10:2:10])
 Meshcell([x,y,z],[x,y,z]+[2,2,2])] );

 
polyhedron(M[0],M[1]);
$R= rnd(7,8);
echo(M);

function eval(p)=let(s=sign(norm(p-[.1,.1,.1])-2.1)) s==0?-1:s;



 function Meshcell(O,S)=
//O = [0,0,0],
//S = [10,10,10], 
 
let(
C = (O + S) / 2, 
D = S - O,
maxD = max( D.x, D.y, D.z) ,


p=O,
p000= (O+[0,0,0]),
p100= (O+[D.x,0,0]),
p010= (O+[0,D.y,0]),
p011= (O+[0,D.y,D.z]),
p001= (O+[0,0,D.z]),
p110= (O+[D.x,D.y,0]),
p101= (O+[D.x,0,D.z]),
p111= (O+[D.x,D.y,D.z]),

e000=  eval(p000),
e100=  eval(p100),
e010=  eval(p010),
e011=  eval(p011),
e001=  eval(p001),
e110=  eval(p110),
e101=  eval(p101),
e111=  eval(p111),





m1=corner(p000,e000,C,e100,e010,e001),
m2=corner(p001,e001,C,e101,e011,e000),
m3=corner(p010,e010,C,e110,e000,e011),
m4=corner(p011,e011,C,e111,e001,e010),
m5=corner(p100,e100,C,e000,e110,e101),
m6=corner(p101,e101,C,e001,e111,e100),
m7=corner(p110,e110,C,e010,e100,e111),
m8=corner(p111,e111,C,e011,e101,e110),
return=cbp(m8,cbp(m7,cbp(m6,cbp(m5,cbp(m4,cbp(m3,cbp(m1,m2))))))),
n=1
)
return;

 
    
    function  corner (P,E,C,e1,e2,e3)=
let(
c=lerp(P,C,0.8) ,
//CC= [E==e1?C.x:c.x,  E==e2?C.y:c.y,  E==e3?C.z:c.z]    ,
CC= E==e1|| E==e2|| E==e3?C:c  ,
p000= ([P.x,P.y,P.z]),
p100= ([C.x,P.y,P.z]),
p010= ([P.x,C.y,P.z]),
p011= ([P.x,C.y,C.z]),
p001= ([P.x,P.y,C.z]),
p110= ([C.x,C.y,P.z]),
p101= ([C.x,P.y,C.z]),
p111= (CC),    

parity=  (((P.x<C.x?0:1)+(P.y<C.y?0:1)+(P.z<C.z?0:1))%2==1),
    
f1=  !parity && E<0 && e1!=E  ?  [[p111,p101,p100,p110],[[3,2,1,0] ]]:[],
f2=  !parity && E<0 && e2!=E   ? [[p111,p011,p010,p110],[[0,1,2,3] ]]:[],
f3=  !parity && E<0 && e3!=E  ?  [[p111,p011,p001,p101],[[3,2,1,0] ]]:[],

f4=  (parity && E<0 && e1!=E ) ?   [[p111,p101,p100,p110],[[0,1,2,3] ]]:[],
f5=  (parity && E<0 && e2!=E ) ?   [[p111,p011,p010,p110],[[3,2,1,0] ]]:[],
f6=  (parity && E<0 && e3!=E)  ?  [[p111,p011,p001,p101],[[0,1,2,3] ]]:[],
 
     return=cbp(f6,cbp(f5,cbp(f4,cbp(f3,cbp(f1,f2))))),
  n=1
   )
 return
 ;