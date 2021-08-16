include <polytools.scad>
 
function octoba( scene, cell,subdivision = 6) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], S = cell[1], C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z), 
eO = eval(O, scene),  eC = eval(C, scene), 
p1 = O,   
p2 = ([S.x, O.y, O.z]),             p3 = ([O.x, S.y, O.z]), 
p4 = ([O.x, O.y, S.z ]),            p5 = ([S.x, S.y, O.z]), 
p6 = ([S.x, O.y, S.z ]),            p7 = ([O.x, S.y, S.z]),
p8 = ([S.x, S.y, S.z ]),            p9 = C)
// if 
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
meshcell([O,S], scenegraph ); 
 
 
function meshcell(cell, scene ) =
/*O= cell origin S=cell max corner C=cell center D= cell size*/
let (
O = cell[0], 
S = cell[1], 
C = (O + S) / 2, 
D = S - O, maxD = max( D.x, D.y, D.z) ,



P000= (O+[0,0,0]),
P100= (O+[D.x,0,0]),
P010= (O+[0,D.y,0]),
P011= (O+[0,D.y,D.z]),
P001= (O+[0,0,D.z]),
P110= (O+[D.x,D.y,0]),
P101= (O+[D.x,0,D.z]),
P111= (O+[D.x,D.y,D.z]),




eC=   eval(C, scene),
emx=  eval(C+[-D.x ,0   ,0   ] , scene),
epx=  eval(C+[ D.x ,0   ,0   ] , scene),
emy=  eval(C+[0    ,-D.y,0   ] , scene),
epy=  eval(C+[0    , D.y,0   ] , scene),

emz=  eval(C+[0    ,0   ,-D.z] , scene),
epz=  eval(C+[0    ,0   , D.z] , scene), 

p000= (eC<0&&( emx<0 || emy<0 || emz<0) )?P000:lerp(P000,C,cornershy),
p100= (eC<0&&( epx<0 || emy<0 || emz<0) )?P100:lerp(P100,C,cornershy),
p110= (eC<0&&( epx<0 || epy<0 || emz<0) )?P110:lerp(P110,C,cornershy),
p010= (eC<0&&( emx<0 || epy<0 || emz<0) )?P010:lerp(P010,C,cornershy),

p001= (eC<0&&( emx<0 || emy<0 || epz<0) )?P001:lerp(P001,C,cornershy),
p101= (eC<0&&( epx<0 || emy<0 || epz<0) )?P101:lerp(P101,C,cornershy),
p111= (eC<0&&( epx<0 || epy<0 || epz<0) )?P111:lerp(P111,C,cornershy),
p011= (eC<0&&( emx<0 || epy<0 || epz<0) )?P011:lerp(P011,C,cornershy),


points=[p000 ,p100 ,p110 ,p010 , p001 ,p101 ,p111 ,p011  ],
//
//f1= (eC<0&& epz>=0 )? [[p001 ,p101 ,p111 ,p011 ],[ [3,2,1,0]]]:[],  // top
//f2= (eC<0&& emz>=0 )? [[p000 ,p100 ,p110 ,p010],[ [0,1,2,3]]]:[],  // bottom
//
//f3= (eC<0&& emy>=0 )? [[p001,p101,p100,p000],[ [0,1,2,3]]]:[],  // front
//f4= (eC<0&& epy>=0 )? [[p111 ,p011,p010,p110],[ [0,1,2,3]]]:[],  // back
//
//f5= (eC<0&& epx>=0 )? [[p101 ,p111 ,p110,p100],[ [0,1,2,3]]]:[],  // right
//f6= (eC<0&& emx>=0 )? [[p011, p001,p000 ,p010],[ [0,1,2,3]]]:[] , // left     
 
f1= (eC<0&& epz>=0 )? [[p001 ,p101 ,p111 ,p011 ],[ [3,2,1],[3,1,0]]]:[],  // top
f2= (eC<0&& emz>=0 )? [[p000 ,p100 ,p110 ,p010],[[0,1,2],[0,2,3]]]:[],  // bottom

f3= (eC<0&& emy>=0 )? [[p001,p101,p100,p000],[ [0,1,2],[0,2,3]]]:[],  // front
f4= (eC<0&& epy>=0 )? [[p111 ,p011,p010,p110],[ [0,1,2],[0,2,3]]]:[],  // back

f5= (eC<0&& epx>=0 )? [[p101 ,p111 ,p110,p100],[ [0,1,2],[0,2,3]]]:[],  // right
f6= (eC<0&& emx>=0 )? [[p011, p001,p000 ,p010],[ [0,1,2],[0,2,3]]]:[] , // left           

 
res=   ( cbp(f6,cbp(f5,cbp(f4,cbp(f3,cbp(f1,f2)))))),
return= ( ([for(i=res)if(i!=[])i]))// remove empty meshlets
)
return;

 




 
function asign(x)=max(0,sign(x));
function bflip(a, b) = [
 [min(a.x, b.x), min(a.y, b.y), min(a.z, b.z)],
 [max(a.x, b.x), max(a.y, b.y), max(a.z, b.z)]
];
  function fp_flip(w)=len(w[1])>0?[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]]:[[],[]];