include<DCgeometry.scad>
include<DCparser_eval.scad>
include<DCbb.scad>
include<DCmath.scad>
//include<DCtet.scad>
include<DCcube.scad>
include<DCedge.scad>
include<DCsplitface.scad>
include<DCfitness.scad>
// to do  write new flattness check 

$treshold=1/30; //curv tolerance
divs=5;
massage1=2;
massage2=2;
massage3=2;
$fitmeshsharp=3;
$fitmeshsharpS=2; // smooth step per shapening
QEFsteps=60;
fitstracesteps=25;
Maxacute=.48;
flatness=0.99;

scenegraph  =  randomscene(spread=rnd(9,13));
k= polygonize (scenegraph ,divs);

union(){sphere(0.1);

render ( k);
}

echo("done");
 

// rendererror(k,scenegraph );

function polygonize (scenegraph,divisions=1)= let(
 scenecell=autobound(scenegraph,cubic=true,pad=0.2),
eth2=echo(str("Bounding Cell: ",scenecell )),
eth3=let (v=pow(2,divs))echo(str("Subdivisions: ", v,"X",v,"X",v," =", v*v*v )),
// showcell(scenecell), 
$cellmaxsize=cellmax(scenecell),
eth3v=echo(str("Constructing raw mesh " )),
rawmesh=       octoba(scenegraph,scenecell,divisions) ,
echraw=echo( str("raw mesh   -  Points: ",len(rawmesh[0]),"  Faces: ",len(rawmesh[1]))),

eth4=echo(str("Gluing raw mesh " )),
gluedrawmesh=       glue( rawmesh) ,
ech07=echo( str("glued mesh -  Points: ",len(gluedrawmesh[0]),"  Faces: ",len(gluedrawmesh[1]))),


eth5=echo(str("Preprocessing glued mesh " )),

 intermesh1=meshmassage1(gluedrawmesh,scenegraph ,massage1),
 intermesh2=meshmassage2(intermesh1,scenegraph ,massage2),
  final=meshmassage3(intermesh2,scenegraph ,massage3),
   end=0)
 final;
 
  // intermesh;




function meshmassage1(x,scenegraph,  c=0)=c<1?x:

let( 
ech0=echo( str("M1 Start of prepass: ",massage1-c+1)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),

 i0= true? snapmesh(scenegraph, x ) : x,  
 ech000=echo( str("snapped " )),
 i1=  false ?  rlxmesh(scenegraph, i0 ): i0,  
 //ech01=echo( str("relaxed ", norm(addl( i0.x-i1.x)))), 

 i2= false? fitmesh(scenegraph, i1 ,1  ):i1 ,  
 //ech02=echo( str("fitted " )),


i6= edgecollapseflat(i2,flatness, $cellmaxsize/12,scenegraph,5),
ech06=echo( str("After edge collapse  -  Points: ",len(i6[0]),"  Faces: ",len(i6[1]))),
i7= true ? glue( i6):i6 ,
 ech07=echo( str("glued  -  Points: ",len(i7[0]),"  Faces: ",len(i7[1]))),

 i8= true? fitmesh(scenegraph, i7 ,1  ):i7 ,  
 ech08=echo( str("fitted ", norm(addl(i8.x-i7.x)))),

 
return= (i8)
) 
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) 
meshmassage1(return,scenegraph, c-1);


function meshmassage2(x,scenegraph,c=0)=c<1?x:
let( 
ech0=echo( str("M2 Start of pass: ",massage2-c+1)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),

i7=  glue(cbpl(splitfaces    (x[0],x[1],scenegraph, $treshold))), 
ech01=echo( str("splitface and glued  -  Points: ",len(i7[0]),"  Faces: ",len(i7[1]))),
i8=  fitmeshsharp(scenegraph, i7 ,$fitmeshsharp,$fitmeshsharpS) , 
ech02=echo( str("fitted ", norm(addl(i7.x-i8.x))  )),

i9= edgecollapseflat(i8,flatness, $cellmaxsize/16,scenegraph,5),
ech09=echo( str("After edge collapse  -  Points: ",len(i9[0]),"  Faces: ",len(i9[1]))),

return= (i8)
)
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) meshmassage2(return,scenegraph,c-1); 









function meshmassage3(x,scenegraph,  c=0)=c<1?x:

let( 
ech0=echo( str("M3 Start of postpass: ",massage3-c+1)),
ech00=echo( str("incomming  -  Points: ",len(x[0]),"  Faces: ",len(x[1]))),

 i0= false? snapmesh(scenegraph, x ) : x,  
// ech000=echo( str("snapped ", norm(addl(x.x-i0.x)))),
 i1=  false ?  rlxmesh(scenegraph, i0 ): i0,  
// ech01=echo( str("relaxed ", norm(addl( i0.x-i1.x)))), 

 i2= false? fitmesh(scenegraph, i1 ,1  ):i1 ,  
// ech02=echo( str("fitted ", norm(addl(i1.x-i2.x)))),


i6= edgecollapseflat(i2,flatness, $cellmaxsize/16,scenegraph,25),
ech06=echo( str("Afteredgecollapse  -  Points: ",len(i6[0]),"  Faces: ",len(i6[1]))),
i7= false ? glue( i6):i6 ,
//ech07=echo( str("glued  -  Points: ",len(i7[0]),"  Faces: ",len(i7[1]))),

 i8= false? fitmesh(scenegraph, i7 ,3  ):i7 ,  
 //ech08=echo( str("fitted ", norm(addl(i8.x-i7.x)))),

 
return= (i8)
) 
// bail when nothing changes
len(x[0])==len(return[0])&&len(x[1])==len(return[1])?let(ech7=echo( str("Diminishing Returns, Bailed")))return :let(ech8=echo( str("Remaining passes: ",c-1))) 
meshmassage3(return,scenegraph, c-1);














function cellmax(cell)=let(O = cell[0], S = cell[1],D = S - O) max( D.x, D.y, D.z) ;



module render(k){echo(str(" Points: ",len(k[0]),"  Faces: ",len(k[1]))); polyhedron(untagall(k[0]),k[1]);}
module rendererror(k,scene){ 

for(f=[0:len(k[1])-1]){
lff=len(k[1][f])-1;
     for( i=[0:lff]){
    nexti=wrap(i+1,lff+1);
  p1= k[0][k[1][f][i] ];
p2= k[0][k[1][f][nexti]] ;
mp=lerp(p1,p2,0.5);
if (abs(eval(mp,scene))>0.05) color("red")translate(v3(mp))sphere(0.5);
if (abs(eval(p1,scene))>0.05) color("blue")translate(v3(p1))sphere(0.5);

}}
}
   function randomscene(spread)=
  subtraction(0,[
  
    union( max(1,rnd(-2,0)),[  for(i=[0:2])
    translate([rnd(-spread,spread),rnd(-spread,spread),rnd(-spread,spread)],
                [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)],[ 
rnd(2)>0.8?
cube([rnd(6,10),max(0,rnd(-1,1))]):
//cube([rnd(5,10),max(0,rnd(-1,0))])
sphere(rnd(8,10))
])])     
]      ),
    
        union( max(1,rnd(-2,0)),[  for(i=[0:1])
    translate([rnd(-spread,spread),rnd(-spread,spread),rnd(-spread,spread)],
                [rotate([rnd(-60,60),rnd(-60,60),rnd(-60,60)],[ 
rnd(2)>0.8?
cube([rnd(5,6),max(0,rnd(-1,0))]):
//cube([rnd(5,10),max(0,rnd(-1,0))])
sphere(rnd(4,6))
])])     
]      )
      
    ])
  
    ;