
function fitmesh(scene,m,c=1,neighbours)=
neighbours ==undef?  fitmesh(scene,m,c,pointneighbours (m[0],m[1])):
c>0?
    fitmesh(scene, smoothmesh( fits(m[0],scene) ,m[1],2,neighbours)   ,c-1,neighbours)
     // fitmesh(scene, m    ,c-1,neighbours) 
     :[fits(m[0],scene) ,m[1]];

function snapmesh(scene,m )=[fits(m[0],scene) ,m[1]];

function rlxmesh(scene,m,c=1,neighbours)=
neighbours ==undef?  fitmesh(scene,m,c,pointneighbours (m[0],m[1])):
c>0?
     fitmesh(scene, smoothmesh(  m[0] ,m[1],2,neighbours)   ,c-1,neighbours)
   
    
    
    :

[fits(m[0],scene) ,m[1]];

function fitmeshsharp(scene,mi,c=1,S=2 ,neighbours)= 
neighbours ==undef?  fitmeshsharp(scene,mi,c,S ,pointneighbours (mi[0],mi[1])):
c>0?
let(
 m= smoothmesh( mi[0] ,mi[1],S,neighbours), 
points=m[0], faces=m[1], 
 
midpoints=  facemidpoints(points  ,faces),
facenormals=facenormals (points,faces),
fittedmidpoints=fitstrace(midpoints,facenormals,scene,2),
//fittedmidpoints=fits(midpoints, scene),
 //relaxpoints=pointneighbourscenterpoint(midpoints,neighbours,points),
normalatfmidpoints=[for(i= fittedmidpoints)v3(evalnorm(i,scene))], 
newpoints=[
for(i=[0:len(points)-1])
len(neighbours[i])<1   
//|| abs(eval(points[i] ,scene))<0.001 

? points[i] :

let ( 
avrgmidpoints= points[i],
 avrgdistofmidpoints= avrgp([for(j=[0:len(neighbours[i])-1])let(k=neighbours[i][j])  norm(points[i]-midpoints[k]) ])
)



let (res=findp2p( avrgmidpoints,

[
for(j=[0:len(neighbours[i])-1])
let(k=neighbours[i][j])
[fittedmidpoints[k],normalatfmidpoints[k]]
]


)) norm(res-points[i])  >avrgdistofmidpoints *Maxacute? 
//points[i]+un(res-points[i])*avrgdistofmidpoints 

let(mp=avrgp([for(j=[0:len(neighbours[i])-1])let(k=neighbours[i][j])  midpoints[k]]),
    nv=un(res-mp), np=mp+nv*avrgdistofmidpoints *0.5)    np
:res // if sharp point is way of use old 
] )
fitmeshsharp(scene,[newpoints,faces],c-1,S ,neighbours ): mi;



function fits(m,scene,c=5)= c>0? 
let(nm=[for(i=m) let(probe=evalnorm(i,scene)) i- un(v3(probe))*probe[3]*0.75 ]) fits(nm,scene,c-1):m;
    

function fitsinglepoint(p,scene,c=5)= c>0? 
let(probe=evalnorm(p,scene))
let(np= p- un(v3(probe))*probe[3]*0.75 ) fitsinglepoint(np,scene,c-1):p;  
    


function fitstrace(m,norms,scene,c=fitstracesteps,oldprobes)= c>0? 

let(
probes  = [ for(i=[0:len(m)-1]) eval(m[i],scene) ],
newnorms= [ for(i=[0:len(m)-1]) 
    (oldprobes[i]>probes[i]&&oldprobes[i]>0)||
    (oldprobes[i]<probes[i]&&oldprobes[i]<0)
    
?norms[i]:-norms[i]],

nm= [ for(i=[0:len(m)-1]) let(probe=probes[i]) m[i]+ newnorms[i]*probe*(.99/max(1,c*c)) ]
    
) fitstrace(nm,newnorms,scene,c-1,probes):m;



    
  function fp_flip(w)=len(w[1])>0?[w[0],[for(i=[0:len(w[1])-1])[w[1][i][0],w[1][i][2],w[1][i][1]]]]:[[],[]];



function tagsharp(v)=[v.x,v.y,v.z,"sharp"];
function untagall(v)=[for(i=v)v3(i)];
function fit1(p,scene,c=0)=c>0?fit1( fits([p],scene)[0],scene,c-1):fits([p],scene)[0];

 
function findp2p(inp, pl,   f = QEFsteps) =
let (p =  (inp ) )
f > 0 && len(pl) > 0   ?

 let (
q = avrgp([ for (i = [0: len(pl) - 1]) 
let (new_p=point2plane(p, pl[i][0], un(pl[i][1])))  new_p
 ]),
 df = q - p
 ) 

 findp2p((p+df*0.99), pl,   f - 1) :p;
////////////
////////////
////////////
////////////
////////////

// project a point to a plane
function point2plane(p, o, n) =
let (v = o - p) p + (n * (v.x * n.x + v.y * n.y + v.z * n.z)); //proj ap to a plane
