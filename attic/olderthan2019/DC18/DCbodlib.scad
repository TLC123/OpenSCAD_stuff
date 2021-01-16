 include<polytools.scad>
//Edgetype [
//0 indexed starting vertex,
//1 next halfedge,
//2 reverse halfedge,
//3 indexed righthand face ]

//function collapse(points,faces,p1,p2)
//function getalledgesaroundapoint(pi,edges)
//function edges(points,faces)
//function edges(mesh)

//function reverse(l)  
//function getedgesof(points,faces)
//function tracereference(edges,start,track,result=[])
function firstpointof(i,edges)=edges[i][0];
function nextedgeof  (i,edges)=edges[i][1];
function revedgeof   (i,edges)=edges[i][2];
function rightfaceof (i,edges)=edges[i][3];

function thirdpointofright(i,edges)=lastpointof(nextedgeof  (i,edges),edges);
function thirdpointofleft(i,edges)= thirdpointofright(revedgeof (i,edges),edges);

function lastpointof(i,edges)=firstpointof(nextedgeof(i,edges),edges);
function leftfaceof(i,edges)=rightfaceof(revedgeof(i,edges),edges);
function isedgeopen(i,edges)=revedgeof (i,edges)==[]?true:false;
function lenghtof(i,points,edges)=norm (points[lastpointof(i,edges)] -points[firstpointof(i,edges)] );

function curveof(i,points,faces,edges)= dot(
    ifacenormal((rightfaceof (i,edges)),points,faces),
    ifacenormal((leftfaceof (i,edges)),points,faces));
function evalmidpoint(i,points, edges,scene)= eval( lerp(points[lastpointof(i,edges)] ,points[firstpointof(i,edges)],0.5 ),scene);

function flatof(i,points,faces,edges,scene)= 
//let(er=echo(str([
// un(v3(evalnorm( points[firstpointof(i,edges)],scene))),
// un(v3(evalnorm( points[lastpointof (i,edges)],scene)))]
//)
//)) 
dot(
 un(v3(evalnorm(points[firstpointof(i,edges)],scene))),
 un(v3(evalnorm(points[lastpointof(i,edges)],scene))));

function sizeof(i,points,faces,edges)=  ifacesize( rightfaceof (i,edges) ,points,faces) ;

function ifacenormal(i,points,faces)=let(f=faces[i],p=points)face_normal([ p[f[0]],p[f[1]],p[f[2]] ]);
function ifacesize(i,points,faces)=let(f=faces[i],p=points) polyarea( p[f[0]], p[f[1]], p[f[2]] );
 
//fullmesh=[points,faces,edges,facenormals,pointnormals,faceedges]
 
function pconstruct(p0,p1,scene)=
let(
p01=lerp(p0,p1,0.5),
sp0=fit1(p0,scene),
sp1=fit1(p1,scene),
nsp0=un(v3(evalnorm(sp0,scene))),
nsp1=un(v3(evalnorm(sp1,scene))),
sp01= ( findp2p( (p01), [[sp0,nsp0],[sp1,nsp1] ])))
sp01
;



 function collapsedges(points,faces,meshedges, remove,scene)=
 let(lenpoints=len(points),
midpoints=[for(i=remove)
 pconstruct(points[firstpointof(i,meshedges)] ,points[ lastpointof(i,meshedges)],scene)],

pl=[for(i=remove) [firstpointof(i,meshedges) , lastpointof(i,meshedges)] ],
newfaces=[for(nf=faces) let(newface=[
plistfilter(nf[0],pl,lenpoints),
plistfilter(nf[1],pl,lenpoints),
plistfilter(nf[2],pl,lenpoints)
]) if(newface[0]!=newface[1]&&newface[1]!=newface[2]&&newface[2]!=newface[0])newface
]
)

[concat(points,midpoints ),newfaces];

function plistfilter(tp,pl,lenpoints)=let(rslt=[for(l=[0:len(pl)-1]) if(tp==pl[l][0]||tp==pl[l][1])l+lenpoints][0])
rslt==undef?tp:rslt ;

 

function collapse(points,faces,p1,p2)=
let(mp=len(points),
newfaces1=[for(nf=faces)[
pfilter(nf[0],p1,p2,mp),
pfilter(nf[1],p1,p2,mp),
pfilter(nf[2],p1,p2,mp)
]]
)

[concat(points,[(points[p1]+points[p2])/2] ),newfaces];

function pfilter(tp,p1,p2,mp)=tp==p1||tp==p2?mp:tp;

// echo (getalledgesaroundapoint(10,e));
function edges(points,faces)= 
 faces==undef?edges(points[0],points[1])://one var recall split for two:
let(
e=getedgesof(points,faces), //get raw edges [ipoint,ipoint,undef,iface]
el=[for(i=[0:len(e)-1])[e[i][0],e[i][1]]],// create pure edgelist [ipoint, ipoint]
//ech=echo(search([reverse(el[61])],el,1 )[0] ),
ef=[for(i=[0:len(e)-1])[e[i][0],e[i][3]]],// create pure facelist [ipoint, iface]
en=[for(i=[0:len(e)-1]) search([ [e[i][1],e[i][3]] ],ef,1 ) [0]    ],// create nextlist [iedge]
ep=[for(i=[0:len(e)-1])
[ e[i][0]/*starting verterx*/
,en[i]/*next halfedge*/
, search([reverse(el[i])],el,1 )[0] /* find reverse halfedge*/
,e[i][3] ]]  /*face*/)

ep ;

function getedgesof(points,faces)= flatten(

[for(f=[0:len(faces)-1]) let(lff=len(faces[f])-1)
    [ for( i=[0:lff])let(nexti=wrap(i+1,lff+1)) [ faces[f][i] , faces[f][nexti] ,undef,f ]]] );



function getalledgesaroundapoint(pi,edges)=
let(
pil=column(edges,0),
firstedge=search(pi,pil,1)[0]


)

tracereference(edges,firstedge)

;

 function tracereference(edges,start,track,result=[])=
let(vtx=0,next=1,counter=2,face=3)
track==undef? tracereference(edges,start,edges[edges[start][counter]][next],[start]):
track!=start?
tracereference(edges,start,edges[edges[track][counter]][next],concat(result,[track,edges[track][counter]]))
:result
;


function column(v,c)=[for(i=[0:len(v)-1]) v[i][c]];

function reverse(l) = len(l)>0 ? 
    [ for(i=[len(l)-1:-1:0]) l[i] ] : len(l)==0 ? [] : undef; 
 function soloedges(meshedges,testedges,c=0,usedup=[],e=[])=c<len(testedges)?
let(
fp=firstpointof(testedges[c],meshedges),
lp=lastpointof(testedges[c],meshedges),
notfound=search(fp,usedup,1)==[]&&search(lp,usedup,1)==[],
nusedup=notfound?concat(usedup,[fp],[lp]):usedup,
ne=notfound?concat(e,testedges[c]):e)
soloedges(meshedges,testedges,c+1,nusedup,ne)
:
e;
//[[point,point,undef,face on the right]...]


