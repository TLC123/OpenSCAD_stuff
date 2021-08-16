//DC19 atempt to work with quads as far as possible


include <polytools.scad>


 
function octoba( scene, cell,subdivision = 6) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
//out=!verbose?0:echo(str("level : ",subdivision)),

O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
eO = eval(O, scene),  eC = eval(C, scene), 
p1 = O,   
p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
p8 = ([S.x, S.y, S.z ]),            p9 = C)
// if 
let(meshlet=
subdivision > 0 ?
 // if DF at cell center i larger than aproximate cell bundary sphere then do nothing
 abs(eC) > maxD * 1.71 * 0.5 ? [[],[]] :   // else split cell in 8 new cells constructed by corners and center point
(
cbp(
cbp(
    cbp( octoba(scene,bflip(p1, C), subdivision - 1), octoba(scene,bflip(p2, C), subdivision - 1)), 
    cbp( octoba(scene,bflip(p3, C), subdivision - 1), octoba(scene,bflip(p4, C), subdivision - 1)))
,cbp( 
   cbp(octoba(scene,bflip(p5, C),   subdivision - 1), octoba(scene,bflip(p6, C), subdivision - 1)), 
   cbp( octoba(scene,bflip(p7, C),   subdivision - 1), octoba(scene,bflip(p8, C), subdivision - 1)) )
)) :

  meshcell([O,S], scenegraph ),
  
  gluedmeshlet=glue(meshlet))

 (
simplifyonbuild 
&& len(gluedmeshlet[1])>minfacesforsimp  
&& len(gluedmeshlet[1])<maxfacesforsimp)  ?
let($calledfromctoba=true)
edgecollapseflat(gluedmeshlet,0, $cms*3,scene,ECbuildcount):gluedmeshlet; 

 function inter(t,r,Threshold=0)=
(t==r)?1:(t>Threshold)?
(r<Threshold)? abs(Threshold-t)/abs(t-r) :
0 :
(r>Threshold)? abs(Threshold-t)/abs(t-r) :
1 ;

 function cornerlogic(p,q,elist)=
!(elist[0]<0)?q:
let(
//eveC=elist[0],evex00=elist[1],eve0y0=elist[2],,eve00z=elist[3],

llist=[for(i=elist)i<0],
//eC,ex00,e0y0,e00z,exy0,exy0,ex0z,exyz 
eC=llist[0],ex00=llist[1],e0y0=llist[2],e00z=llist[3],
exy0=llist[4],ex0z=llist[5],e0yz=llist[6],exyz=llist[7], 
//q=[
//lerp(p.x,pp.x,inter(eveC,max(0,lerp(eveC,evex00,0.5)))), 
//lerp(p.y,pp.y,inter(eveC,max(0,lerp(eveC,eve0y0,0.5)))), 
//lerp(p.z,pp.z,inter(eveC,max(0,lerp(eveC,eve00z,0.5)))), 
//], 

x=ex00  ||(e0y0 && exy0) ||(e00z && ex0z)
||(exyz && e0yz && (e0y0||e00z))?p.x:q.x ,

y=e0y0  ||(ex00 && exy0) ||(e00z && e0yz)
||(exyz && ex0z && (ex00||e00z)) ?p.y:q.y ,
   
z=e00z  ||(ex00 && ex0z) ||(e0y0 && e0yz)
||(exyz && exy0 && ( ex00||e0y0)) ?p.z:q.z
)     
[x,y,z];
 
    function meshcell(cell, scene ) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], 
S = cell[1], 
C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z) ,
d=0,


P000= (O+[0,0,0]),
P100= (O+[D.x,0,0]),
P010= (O+[0,D.y,0]),
P011= (O+[0,D.y,D.z]),
P001= (O+[0,0,D.z]),
P110= (O+[D.x,D.y,0]),
P101= (O+[D.x,0,D.z]),
P111= (O+[D.x,D.y,D.z]),


inset=cornershy,

eC=   eval(C, scene))
eC>0? []:
let(
exyz=  eval(C+[-D.x , -D.y  ,-D.z ] , scene),
e0yz=  eval(C+[   0 , -D.y  ,-D.z ] , scene),
eXyz=  eval(C+[ D.x , -D.y  ,-D.z ] , scene),
 
ex0z=  eval(C+[-D.x ,    0  ,-D.z ] , scene),
e00z=  eval(C+[   0 ,    0  ,-D.z ] , scene),
eX0z=  eval(C+[ D.x ,    0  ,-D.z ] , scene),

exYz=  eval(C+[-D.x ,  D.y  ,-D.z ] , scene),
e0Yz=  eval(C+[   0 ,  D.y  ,-D.z ] , scene),
eXYz=  eval(C+[ D.x ,  D.y  ,-D.z ] , scene),

exy0=  eval(C+[-D.x , -D.y  ,   0 ] , scene),
e0y0=  eval(C+[   0 , -D.y  ,   0 ] , scene),
eXy0=  eval(C+[ D.x , -D.y  ,   0 ] , scene),
 
ex00=  eval(C+[-D.x ,    0  ,   0 ] , scene),
e000=  eval(C+[   0 ,    0  ,   0 ] , scene),
eX00=  eval(C+[ D.x ,    0  ,   0 ] , scene),

exY0=  eval(C+[-D.x ,  D.y  ,   0 ] , scene),
e0Y0=  eval(C+[   0 ,  D.y  ,   0 ] , scene),
eXY0=  eval(C+[ D.x ,  D.y  ,   0 ] , scene),

exyZ=  eval(C+[-D.x , -D.y  , D.z ] , scene),
e0yZ=  eval(C+[   0 , -D.y  , D.z ] , scene),
eXyZ=  eval(C+[ D.x , -D.y  , D.z ] , scene),
 
ex0Z=  eval(C+[-D.x ,    0  , D.z ] , scene),
e00Z=  eval(C+[   0 ,    0  , D.z ] , scene),
eX0Z=  eval(C+[ D.x ,    0  , D.z ] , scene),

exYZ=  eval(C+[-D.x ,  D.y  , D.z ] , scene),
e0YZ=  eval(C+[   0 ,  D.y  , D.z ] , scene),
eXYZ=  eval(C+[ D.x ,  D.y  , D.z ] , scene),







// ex00 neg x 0 in yz
// exyz neg xyz 0 in yz
// e0YZ  0 x positive yz


p000= cornerlogic( P000,lerp(P000,C,inset),[eC,ex00,e0y0,e00z,exy0,ex0z,e0yz,exyz ]),
p100= cornerlogic( P100,lerp(P100,C,inset),[eC,eX00,e0y0,e00z,eXy0,eX0z,e0yz,eXyz ]),
p110= cornerlogic( P110,lerp(P110,C,inset),[eC,eX00,e0Y0,e00z,eXY0,eX0z,e0Yz,eXYz ]),
p010= cornerlogic( P010,lerp(P010,C,inset),[eC,ex00,e0Y0,e00z,exY0,ex0z,e0Yz,exYz ]),

p001= cornerlogic( P001,lerp(P001,C,inset),[eC,ex00,e0y0,e00Z,exy0,ex0Z,e0yZ,exyZ ]),
p101= cornerlogic( P101,lerp(P101,C,inset),[eC,eX00,e0y0,e00Z,eXy0,eX0Z,e0yZ,eXyZ ]),
p111= cornerlogic( P111,lerp(P111,C,inset),[eC,eX00,e0Y0,e00Z,eXY0,eX0Z,e0YZ,eXYZ ]),
p011= cornerlogic( P011,lerp(P011,C,inset),[eC,ex00,e0Y0,e00Z,exY0,ex0Z,e0YZ,exYZ ]),


points=[p000 ,p100 ,p110 ,p010 , p001 ,p101 ,p111 ,p011  ],

q1= (eC<d  &&   e00Z>=d )? [[p001 ,p101 ,p111 ,p011 ],[ [3,2,1,0]]]:[],  // top
q2= (eC<d  &&   e00z>=d )? [[p000 ,p100 ,p110 ,p010],[ [0,1,2,3]]]:[],  // bottom

q3= (eC<d  &&   e0y0>=d )? [[p001,p101,p100,p000],[ [0,1,2,3]]]:[],  // front
q4= (eC<d  &&   e0Y0>=d )? [[p111 ,p011,p010,p110],[ [0,1,2,3]]]:[],  // back

q5= (eC<d &&  eX00>=d )? [[p101 ,p111 ,p110,p100],[ [0,1,2,3]]]:[],  // right
q6= (eC<d &&  ex00>=d )? [[p011, p001,p000 ,p010],[ [0,1,2,3]]]:[] , // left     
 
f1= (eC<0 &&  e00Z>=0 )? [[p001 ,p101 ,p111 ,p011 ],[ [3,2,1],[3,1,0]]]:[],  // top
f2= (eC<0 &&  e00z>=0 )? [[p000 ,p100 ,p110 ,p010],[[0,1,2],[0,2,3]]]:[],  // bottom

f3= (eC<0 &&  e0y0>=0 )? [[p001,p101,p100,p000],[ [0,1,2],[0,2,3]]]:[],  // front
f4= (eC<0 &&  e0Y0>=0 )? [[p111 ,p011,p010,p110],[ [0,1,2],[0,2,3]]]:[],  // back

f5= (eC<0 &&  eX00>=0 )? [[p101 ,p111 ,p110,p100],[ [0,1,2],[0,2,3]]]:[],  // right
f6= (eC<0 &&  ex00>=0 )? [[p011,p001,p000,p010],[ [0,1,2],[0,2,3]]]:[] , //left           

 
res=  quads?  ( cbp(q6,cbp(q5,cbp(q4,cbp(q3,cbp(q1,q2))))))
:( cbp(f6,cbp(f5,cbp(f4,cbp(f3,cbp(f1,f2)))))),
ret =( ([for(i=res)if(i!=[])i])),// remove empty meshlets

return=glue(ret)
)
return;
 

 




 
function asign(x)=max(0,sign(x));
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];
  function fp_flip(w)=len(w[1])>0?[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]]:[[],[]];