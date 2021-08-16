

function splitfaces(points,faces,scene,treshold)=len(faces)<1?[[],[]]:
[for (i=[0:len(faces)-1])
let(
poly=faces[i],
p0=points[poly[0]],
p1=points[poly[1]],
p2=points[poly[2]],
p01=lerp(p0,p1,0.5),
p12=lerp(p1,p2,0.5),
p20=lerp(p2,p0,0.5),
p012=(p0+p1+p2)/3,
e01=abs(eval(p01,scene)),
e12=abs(eval(p12,scene)),
e20=abs(eval(p20,scene)),
e012=abs(eval(p012,scene)),
//snapped



lim01=norm(p0-p1)*treshold ,
lim12=norm(p1-p2)*treshold ,
lim20=norm(p2-p0)*treshold ,
lim012=min(lim01,lim12,lim20),
//lim01= treshold,
//lim12=treshold,
//lim20=treshold,

pvt=[e01>lim01,e12>lim12,e20>lim20,e012>lim012],
pvts=[e01>lim01,e12>lim12,e20>lim20]) // shot version saves a bunch of ||'s
 pvts== [false, false, false]  ?[[p0,p1,p2],[[0,1,2]]]:
// pvts== [false, false, false,true]  ?[[p0,sp01,p1,sp12,p2,sp20,p012],[[6,0,2],[6,2,4],[6,4,0]]]:
let(
//sp0=fit1(p0,scene),
//sp1=fit1(p1,scene),
//sp2=fit1(p2,scene),
sp0= (p0),
sp1= (p1 ),
sp2= (p2),
//nsp0=un(v3(evalnorm(p0,scene))),
//nsp1=un(v3(evalnorm(p1,scene))),
//nsp2=un(v3(evalnorm(p2,scene))),
//
//sp01= ( findp2p( (p01), [[sp0,nsp0],[sp1,nsp1] ])),
//sp12= (findp2p( (p12), [[sp1,nsp1],[sp2,nsp2]])),
//sp20= (findp2p( (p20), [[sp2,nsp2],[sp0,nsp0]]))

//sp01=  fit1(p01,scene) ,
//sp12= fit1( p12,scene) ,
//sp20=  fit1(p20,scene) 

//sp012=fit1(p012,scene)
sp01=   (p01 ) ,
sp12=  ( p12 ) ,
sp20=   (p20 )

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

]
;