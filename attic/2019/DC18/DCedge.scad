include<polytools.scad>
include<DCparser_eval.scad>
include<DCbodlib.scad>
include<DCfitness.scad>

//points=[for(x=[-10:10],y=[-10:10])[x+rnd(-1,1),y+rnd(-1,1),rnd(-1,1)]];
//faces=concat([for(x=[0:19],y=[0:19])
//[
//(x+0)+(y+0)*21,
//(x+1)+(y+0)*21,
//(x+0)+(y+1)*21,
//]  
//]
//,
//[for(x=[0:19],y=[0:19])
//[
//(x+0)+(y+1)*21,
//(x+1)+(y+0)*21,
//
//(x+1)+(y+1)*21,
//]  
//]
//
//);
//x= ([points,faces]);
//
//
// 
//
// 
//final=edgecollapse(x);
//
// polyhedron(final[0],final[1]);

 

//function edgecollapse(x,lenghtlim,curvlim,flatlim,sizelim,scene,c=10)=c<1?let(echoi=echo(str("EC bail @ ",50-c)))x:
//let(
//points=x[0],
//faces =x[1],
//meshedges=edges(x),
//
//
//apr0= [for(i=[1: len(meshedges)-1])i],
//apr1= [for(i=apr0)if(!isedgeopen(i,meshedges))i],
//
//apr2=len(apr1)>0?[for(i=apr1)
////  let( e0=echo(str("evalmidpoint ",abs( evalmidpoint(i,points,meshedges,scene)) )))
//if(abs(evalmidpoint(i,points,meshedges,scene))<lenghtof(i,points,meshedges)*0.5)i]:apr1, 
//
//apr3a=len(apr2)>0?[for(i=apr2)                  // edge limits
////    let(e=echo(str("lenght ", lenghtof(i,points,meshedges) )))
//    if(lenghtof(i,points,meshedges)<lenghtlim /max(1,c-7))i]:apr2,
//
//apr3b=len(apr3a)>0?[for(i=apr3a)                //Area limit 
////    let(e=echo(str("size ", sizeof(i,points,faces,meshedges) )))
//    if(sizeof(i,points,faces,meshedges)<sizelim/max(1,c-7))i]:apr3a,
//
//apr3c=len(apr3b)>0?[for(i=apr3b)                // Part of flat area
////     let(e=echo(str("flat ", flatof(i,points,faces,meshedges,scene) )))
//    if(flatof(i,points,faces,meshedges,scene)>flatlim)i]:apr3b,
//
//apr3=len(apr3c)>0?[for(i=apr3c)                 //Bend limit
////    let(e=echo(str("curv ", curveof(i,points,faces,meshedges) )))
//    if(curveof(i,points,faces,meshedges)>curvlim)i]:apr3c,
//
//aprx= [for(i=apr1)                 //add 180 degree flip corrupt edge
////    let(e=echo(str("curv ", curveof(i,points,faces,meshedges) )))
//    if(curveof(i,points,faces,meshedges)==-1)i] ,
//apry=[for(i=apr1)                // add zero area right face corrupt edge
////    let(e=echo(str("size ", sizeof(i,points,faces,meshedges) )))
//    if(sizeof(i,points,faces,meshedges)==0)i] ,
//aprz=[for(i=apr1)                  // add zero lenght corrupt edge
////    let(e=echo(str("lenght ", lenghtof(i,points,meshedges) )))
//    if(lenghtof(i,points,meshedges)==0)i] ,
//
//apr4=len(apr3)>0?soloedges(meshedges,concat(apry,aprx,aprz, apr3)):apr3,
//finalx=len(apr4)>0?collapsedges(points,faces,meshedges, apr4,scene):x
//    
//)
//
// len(apr4)<1?let(echoo=echo(str("EC bail @ ",10-c)))x: edgecollapse(    finalx  ,lenghtlim,curvlim,flatlim,sizelim,scene,c-1);





function edgecollapseflat (x, curvlim , lenghtlim, scene,c=10,co)=c<1?let(echoi=echo(str("EC bail @ ",co-c)))x:
let(
    nul=echo(str("Begin EC pass ",c)),  

    points=x[0],
    faces=x[1],
    neighbours = pointneighbours (points,faces),
//  e=echo(neighbours),
meshedges=edges(x), 
    nue=echo(str("half edges  ",len(meshedges), "   -  Points: ",len(points),"  Faces: ",len(faces))),  

apr0= [for(i=[1: len(meshedges)-1])i],

    
        nul1=echo(str("eliminate open edges ",len(apr0))),  
apr1= [for(i=apr0)if(!isedgeopen(i,meshedges))i],

    nul5=echo(str("eliminate creased edges "),len(apr1)),  
apr2=len(apr1)>0?[for(i=apr1)                 //Bend limit
//    let(e=echo(str("curv ", curveof(i,points,faces,meshedges) )))
    if(curveof(i,points,faces,meshedges)>curvlim)i]:apr1,
        
        nul2=echo(str("eliminate too kong edges ",len(apr2))),  
apr3=len(apr2)>0?[for(i=apr2)                  // edge limits
//    let(e=echo(str("lenght ", lenghtof(i,points,meshedges) )))
    if(lenghtof(i,points,meshedges)<lenghtlim )i]:apr2,
   
    nul4=echo(str("eliminate creased points ",len(apr3))),  
 apr4=len(apr3)>0?[for(i=apr3)                 //Bend limit
   let( ife=isflatedge(i,points,faces,meshedges,neighbours,curvlim)
//,          e=echo(str("isflatedge ", ife)
    )    if(ife)i]:apr3 ,
        


        
    nul6=echo(str("eliminate joined edges "),len(apr4)),      
apr5=len(apr4)>0?soloedges(meshedges, shuffle( apr4)):apr4,

    nul7=echo(str("ready to collapse edges "),len(apr5)),  
 finalx=len(apr5)>0?   glue((collapsedges(points,faces,meshedges, apr5,scene))):x
)  let(nuf=echo( str("   EC step ",c, "   -  Points: ",len(finalx[0]),"  Faces: ",len(finalx[1])))
)
 len(apr5)<1?let(echoo=echo(str("EC bail @ ",(co==undef?c:co)-c)))x: edgecollapseflat( finalx  , curvlim, lenghtlim, scene,c-1,co==undef?c:co);


    
    
    
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

function edgeflip(x,scene,c=10,co)=
    c<1?let(echoi=echo(str("EF bail @ ",co-c)))x:
let(
points=x[0],
faces =x[1],
meshedges=edges(x),
apr0= [for(i=[0: len(meshedges)-1])i] ,
apr1= [for(i=apr0)if(!isedgeopen(i,meshedges))i],


apr3=[for(i=apr1)
let(    i0= firstpointof(i,meshedges), 
        i1= lastpointof(i,meshedges),
        i2=thirdpointofright(i,meshedges),
        i3=thirdpointofleft(i,meshedges),
p0=points[i0],
p1=points[i1],
p2=points[i2],
p3=points[i3],
f0=[p0,p1,p2],
f1=[p0,p3,p1],
f2=[p0,p3,p2],
f3=[p1,p2,p3],
 
pa0=polyarea(p0,p1,p2),
pa1=polyarea(p0,p3,p1),
pa2=polyarea(p0,p2,p3),
pa3=polyarea(p1,p2,p3),

fn0=face_normal(f0),
fn1=face_normal(f1),
fn2=face_normal(f2),
fn3=face_normal(f3),
fold01=dot(fn0,fn1),
fold23=dot(fn2,fn3),
mp01=(p0+p1)/2, //midpoint of original edge
mp23=(p2+p3)/2, //midpoint of hypothetical flipped edge
l01=norm(p0-p1),
l23=norm(p2-p3),
ev01=abs(eval(mp01,scene)),
ev23=abs(eval(mp23,scene))
//,
//e=echo(str("flip? ",ev23<ev01,ev01,ev23) )
)

if(
//(ev23<ev01&&abs(ev23-ev01)>0.01&&fold23>-0.999&&pa2>0.1&&pa3>0.1)
(ev23<0.01&&ev01>=0.01&&fold23>-0.9999)//&&pa2>0.1&&pa3>0.1)
//||(l23<l01&&abs(ev23-ev01)<0.001&&fold23>-0.999&&pa2>0.1&&pa3>0.1)
//||((pa0<1||pa1<1))
//||(fold01<-0.999 )
)
i
],// select candidate edges
apr4=len(apr3)>0?soloedges(meshedges,shuffle ( apr3)):apr3,

e0=echo(str("EF pass: ",(co==undef?c:co)-c," of max ",(co==undef?c:co)," flipping ",len(apr4)," edges ",apr4[0],"-",apr4[len(apr4)-1]  )),
finalx=len(apr4)>0?flipedges(points,faces,meshedges,  apr4,scene):x
)
len(apr4)<1?let(echoo=echo(str("EF bail @ ",co-c)))x: 
    edgeflip(    finalx  ,scene,c-1,co==undef?c:co);
    
function flipedges(points,faces,meshedges, flip,scene)=       
// flip is a list of halfedges selected to flip
let( 
     fl1=[for(i=flip) [
        rightfaceof (i,meshedges) , 
        firstpointof(i,meshedges), 
        thirdpointofleft(i,meshedges),
        thirdpointofright(i,meshedges)] ], // table of faces to flip and their new ipoints
     fl2=[for(i=flip) [
        leftfaceof (i,meshedges) , 
        lastpointof(i,meshedges),
        thirdpointofright(i,meshedges), 
        thirdpointofleft(i,meshedges)] ], // table of faces to flip and their new ipoints
fl=concat(fl1,fl2),
fls=[for(i=fl)i[0]],
//e2=echo(fl),
//e3=echo(fls),
//e4=echo(len(points),len(faces),len(meshedges)) ,
    newfaces=[ for(i=[0:len(faces)-1]) 
let(
j=search(i,fls)[0] ,
//e5=echo(str("search ",i," ",j)) )
newface= j==undef?faces[i]:[fl[j][1],fl[j][2],fl[j][3] ]
// ,e3=echo(str("newiface ",i," ",j," ",newface)) 
//,e4=echo(str("newface ",i," ",j," ",[points [newface[0]],points [newface[1]],points [newface[2]]]))

)
 
newface
    ] )    // loop through faces and replace selected faces with new
   
[ points  ,newfaces];

////////////////////////////////////////////////////////////////////////////////////////

function flistfilter(face,fl )= [for(l=[0:len(fl)-1]) if(face==fl[l])l]   ;


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

function shuffle(il,repeat=1)=len(il)<=1?il:
let(l=repeat>0?shuffle(il,repeat-1):il, p=split(l))
round(rands(0,2,1)[0])==0?
concat( shuffle(p[0]),shuffle(p[1])):
concat( shuffle(p[1]),shuffle(p[0]));

function split(l)=[
[for(i=[0:2:len(l)-1])l[i]],
[for(i=[1:2:len(l)-1])l[i]]]  ;
