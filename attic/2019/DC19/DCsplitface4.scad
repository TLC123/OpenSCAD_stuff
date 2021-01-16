

function splitfaces(points,faces,scene,treshold)=len(faces)<1?[[],[]]:
[for (i=[0:len(faces)-1])
let(
poly=faces[i])
 len(poly)==4?
let(face4=[
points[poly[0]],
points[poly[1]],
points[poly[2]],
points[poly[3]]])
split4(face4,scene,treshold)
:
let(
face3=[
points[poly[0]],
points[poly[1]],
points[poly[2]] ])
split3(face3,scene,treshold)



 

]
;


function split4(p,scene,treshold)= 
let(
e02=abs(eval(lerp(p[0],p[2],.5),scene)),
e13=abs(eval(lerp(p[1],p[3],.5),scene)) )
//e02<freezeclose&&
//e13<freezeclose&&
//eval( lerp(p[0],p[1],.5),scene)<freezeclose&&
//eval( lerp(p[1],p[2],.5),scene)<freezeclose&&
//eval( lerp(p[2],p[3],.5),scene)<freezeclose&&
//eval( lerp(p[3],p[0],.5),scene)<freezeclose?
//[p,[[0,1,2,3]]]
//:

( e02<e13 )?
cbp(
split3([p[0],p[1],p[2]],scene,treshold),
split3([p[0],p[2],p[3]],scene,treshold)
):
cbp(
split3([p[3],p[0],p[1]],scene,treshold),
split3([p[3],p[1],p[2]],scene,treshold)
)
;



function split3(poly,scene,treshold)= 
 
let(
 p0=poly[0],
 p1=poly[1],
 p2=poly[2],

p01=lerp(p0,p1,0.5),
p12=lerp(p1,p2,0.5),
p20=lerp(p2,p0,0.5),
p012=(p01+p12+p20)/3,
e01=abs(eval(p01,scene)),
e12=abs(eval(p12,scene)),
e20=abs(eval(p20,scene)),
e012=abs(eval(p012,scene)),
//snapped



lim01=norm(p0-p1)*treshold ,
lim12=norm(p1-p2)*treshold ,
lim20=norm(p2-p0)*treshold ,
lim012=min(lim01,lim12,lim20)*2,
//lim01= treshold,
//lim12=treshold,
//lim20=treshold,

pvt =[e01>lim01,e12>lim12,e20>lim20,e012>lim012],
pvts=[e01>lim01,e12>lim12,e20>lim20]) // shot version saves a bunch of ||'s
 //pvts== [false, false, false]  ?[[p0,p1,p2],[[0,1,2]]]:
  pvt== [false, false, false,false]  ?[[p0,p1,p2],[[0,1,2]]]:

let(
//sp0=fit1(p0,scene),
//sp1=fit1(p1,scene),
//sp2=fit1(p2,scene),
sp0= (p0),
sp1= (p1 ),
sp2= (p2)

//
)
  pvt== [false, false, false,true]  ?
  let(
  nsp01=un(v3(evalnorm(p01,scene))),
  nsp12=un(v3(evalnorm(p12,scene))),
  nsp20=un(v3(evalnorm(p20,scene))),
  
  sp012= fit1( findp2p( (p012), [[p01,nsp01],[p12,nsp12] ,[p20,nsp20]]),scene)

  
  
  )
  
  [[p0,p01,p1,p12,p2,p20,sp012],[[6,0,2],[6,2,4],[6,4,0]]]:

let(

nsp0=un(v3(evalnorm(p0,scene))),
nsp1=un(v3(evalnorm(p1,scene))),
nsp2=un(v3(evalnorm(p2,scene))),

p0hat=p0+nsp0,
p1hat=p1+nsp1,
p2hat=p2+nsp2,
xn01= un(cross(p0hat-p01,p1hat-p01)),
xn12= un(cross(p1hat-p12,p2hat-p12)),
xn20= un(cross(p2hat-p20,p0hat-p20)),


 sp01= fitsplit? 

 let(f2p01=findp2p( (p01), [[sp0,nsp0],[sp1,nsp1],[p01,xn01],[p01,un(p01-p0)] ]))
  fitsplittrace?
 traceline( p01,f2p01 ,scene )
 :f2p01
 :p01,
 
 sp12= fitsplit?
 
  let(f2p12= findp2p( (p12), [[sp1,nsp1],[sp2,nsp2],[p12,xn12],[p12,un(p12-p1)]]))
  fitsplittrace?
 traceline( p12,f2p12 ,scene  )
  :f2p12
   :p12,
 
 sp20= fitsplit? 
 let(f2p20= findp2p( (p20), [[sp2,nsp2],[sp0,nsp0],[p20,xn20],[p20,un(p20-p2)]]))
  fitsplittrace?
 traceline( p20,f2p20 ,scene  )
 :f2p20
 :p20

//sp01=  fit1(p01,scene) ,
//sp12= fit1( p12,scene) ,
//sp20=  fit1(p20,scene) 

//sp012=fit1(p012,scene)
//sp01=   (p01 ) ,
//sp12=  ( p12 ) ,
//sp20=   (p20 )

)
 (pvts== [true, false, false ]) ?[[p0,sp01,p1,sp12,p2,sp20],[[0,1,4],[1,2,4]]]:
 (pvts== [false, true, false ]) ?[[p0,sp01,p1,sp12,p2,sp20],[[2,3,0],[3,4,0]]]:
 (pvts== [false, false, true ])? [[p0,sp01,p1,sp12,p2,sp20],[[2,5,0],[2,4,5]]]:

 (pvts== [true, true, false]) ? 
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
 norm(p0-p12)<norm(p01-p2)?[[0,1,3],[0,3,4],[1,2,3]]:[[1,3,4],[0,1,4],[1,2,3]] ] :

 (pvts== [ false,true, true ]) ?
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
  norm(p0-p12)<norm(p1-p20)?[[0,2,3],[0,3,5],[3,4,5]]:[[5,2,3],[0,2,5],[3,4,5]]]:

 (pvts== [ true,false, true]) ?
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
 norm(p1-p20)<norm(p01-p2)?[[1,2,5],[2,4,5],[0,1,5]]:[[1,4,5],[1,2,4],[0,1,5]]]:


// (pvt== [true,true,true ]) ? 
    [[p0, (sp01),p1, (sp12),p2, (sp20)] ,
,[[0,1,5],[1,2,3],[3,4,5],[1,3,5]]]
//:

// (pvt== [false,false,false ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,2],[6,2,4],[6,4,0]]]
//:

//
// (pvt== [true,false,false,true ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,1],[6,1,2],[6,2,4],[6,4,0]]]:
// 
//(pvt== [false,true,false,true ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,2],[6,2,3],[6,3,4],[6,4,0]]]:
//
// (pvt== [false,false,true,true ]) ? 
//[[p0,sp01,p1,sp12,p2,sp20,sp012],[[6,0,2],[6,2,4],[6,4,5],[6,5,0]]]:
//
// (pvt== [false,true,true,true ]) ? //case blue
// [[p0,sp01,p1,sp12,p2,sp20,sp012],
//concat([[2,3,6],[2,6,0],[5,0,6]],
//norm(p12-p20)<norm(p2-p012)?[[3,5,6],[3,4,5]]:[[3,4,6],[4,5,6]])]:
//
// (pvt== [true,false,true,true ]) ? //case red
// [[p0,sp01,p1,sp12,p2,sp20,sp012],
//concat([[4,5,6],[2,4,6],[1,2,6]],
//norm(p20-p01)<norm(p0-p012)?[[5,1,6],[5,0,1]]:[[5,0,6],[0,1,6]])]:
//
// (pvt== [true,true,false,true ]) ?//case black
// [[p0,sp01,p1,sp12,p2,sp20,sp012],
//concat([[6,0,1],[6,3,4],[6,4,0]],
//norm(p01-p12)<norm(p1-p012)?[[1,3,6],[1,2,3]]:[[1,2,6],[2,3,6]])]:
//
// [[p0,sp01,p1,sp12,p2,sp20,sp012],concat( 
//norm(p01-p12)<norm(p1-p012)?[[1,3,6],[1,2,3]]:[[1,2,6],[2,3,6]],
//norm(p12-p20)<norm(p2-p012)?[[3,5,6],[3,4,5]]:[[3,4,6],[4,5,6]],
//norm(p20-p01)<norm(p0-p012)?[[5,1,6],[5,0,1]]:[[5,0,6],[0,1,6]]
//)]

 
;