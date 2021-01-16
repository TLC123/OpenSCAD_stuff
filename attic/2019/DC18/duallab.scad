include<DCmath.scad>
include<polytools.scad>

M=    cbpl( [for (x=[-10:1:10],y=[-10:1:10],z=[-10:1:10])
let(r= Meshcell([x,y,z],[x,y,z]+[1,1,1]))if(r!=[])r

] );


//for(i=[0:len(M)-1]) if(len(M[i][1])>0){
//echo(M[i]);
//polyhedron(M[0],M[1]);
//}
 echo(M);


union(){
polyhedron(M[0],M[1]);
sphere(0.0001);}

function eval(p)=let(s=
sign(
min(
norm(p-[0,0,0] )-3.1,
norm(p-[-3.5,2.5,2.5] )-.8

)


)) s==0?-1:s;



 function Meshcell(O,S)=
//O = [0,0,0],
//S = [10,10,10], 
 
let(
C = (O + S) / 2, 
D = S - O,
maxD = max( D.x, D.y, D.z) ,



P000= (O+[0,0,0]),
P100= (O+[D.x,0,0]),
P010= (O+[0,D.y,0]),
P011= (O+[0,D.y,D.z]),
P001= (O+[0,0,D.z]),
P110= (O+[D.x,D.y,0]),
P101= (O+[D.x,0,D.z]),
P111= (O+[D.x,D.y,D.z]),




eC=   eval(C),
emx=  eval(C+[-D.x ,0   ,0   ] ),
epx=  eval(C+[ D.x ,0   ,0   ] ),
emy=  eval(C+[0    ,-D.y,0   ] ),
epy=  eval(C+[0    , D.y,0   ] ),

emz=  eval(C+[0    ,0   ,-D.z] ),
epz=  eval(C+[0    ,0   , D.z] ), 

p000= (eC<0&&( emx<0 || emy<0 || emz<0) )?P000:lerp(P000,C,0.1),
p100= (eC<0&&( epx<0 || emy<0 || emz<0) )?P100:lerp(P100,C,0.1),
p110= (eC<0&&( epx<0 || epy<0 || emz<0) )?P110:lerp(P110,C,0.1),
p010= (eC<0&&( emx<0 || epy<0 || emz<0) )?P010:lerp(P010,C,0.1),

p001= (eC<0&&( emx<0 || emy<0 || epz<0) )?P001:lerp(P001,C,0.1),
p101= (eC<0&&( epx<0 || emy<0 || epz<0) )?P101:lerp(P101,C,0.1),
p111= (eC<0&&( epx<0 || epy<0 || epz<0) )?P111:lerp(P111,C,0.1),
p011= (eC<0&&( emx<0 || epy<0 || epz<0) )?P011:lerp(P011,C,0.1),


points=[p000 ,p100 ,p110 ,p010 , p001 ,p101 ,p111 ,p011  ],

f1= (eC<0&& epz>=0 )? [[p001 ,p101 ,p111 ,p011 ],[ [3,2,1,0]]]:[],  // top
f2= (eC<0&& emz>=0 )? [[p000 ,p100 ,p110 ,p010],[ [0,1,2,3]]]:[],  // bottom

f3= (eC<0&& emy>=0 )? [[p001,p101,p100,p000],[ [0,1,2,3]]]:[],  // front
f4= (eC<0&& epy>=0 )? [[p111 ,p011,p010,p110],[ [0,1,2,3]]]:[],  // back

f5= (eC<0&& epx>=0 )? [[p101 ,p111 ,p110,p100],[ [0,1,2,3]]]:[],  // right
f6= (eC<0&& emx>=0 )? [[p011, p001,p000 ,p010],[ [0,1,2,3]]]:[] , // left     
 
      

 
res=   ( cbp(f6,cbp(f5,cbp(f4,cbp(f3,cbp(f1,f2)))))),
return= ( ([for(i=res)if(i!=[])i]))
)
return;

 
    
 