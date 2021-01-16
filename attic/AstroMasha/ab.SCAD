
select=4;
maxtrace=6;
packnumber=[12,12,3,12,10,7,7,7,20][select];
maxpack=15;
 advance=0.4;
epsilon=0001;
overlap=0;
nooverlap=1;
minmult=.1;
maxmult=2;
maxstall=40;
bail=0.2;
symmetry=[true,true,true,true,false,false,false,false,false,false][select];;
shake=1;
name=["ab","torax","collum","head","foot","crus","thigh","upperarm","ulna","hand"][select];
include <ab2.scad>;
include <torax2.scad>;
include <collum.scad>;
include <head.scad>;
include <foot2.scad>;
include <crus.scad>;
include <thigh.scad>;
include <uarm.scad>;
include <ulna.scad>;
include <hand.scad>;

pget=let(e=echo(str("select: ",select," ",name ," - pack: ",packnumber," - sym: ",symmetry)))
select==0?p0():
select==1?p1():
select==2?p2():
select==3?p3():
select==4?p4():
select==5?p5():
select==6?p6():
select==7?p7():
select==8?p8():p9() ;
p1=[for(i=pget[0])v4(i,.1)];
pp=[for(i=[0:max(1,len(p1)/2000):len(p1)-1])p1[round(i)]];
p= symmetry?
    [for(i=pp)if(i.x>=0)i]: 
    [for(i=pp) i];
    echo(len(p));
cell=bbox(p);
fcell=bbox(pp);
cellsize=cell[1]-cell[0]*1.5;
cellmin=min(cellsize);
cellmax=norm(cellsize);
pivot=symmetry? v3(fcell[1]+fcell[0])/2: v3(cell[1]+cell[0])/2; 
pushpower=(cellmax/packnumber)*.125 ;
pullpower=(cellmax/packnumber)*.25;

//boundinspheres=[
//[-1000,0,0,(1000-cell[0].x)],
//[0,-1000,0,(1000-cell[0].y)],
//[0,0,-1000,(1000-cell[0].z)],
//[1000,0,0,(1000-cell[1].x)],
//[0,1000,0,(1000-cell[1].y)],
//[0,0,1000,(1000-cell[1].z)]
//];
boundmax=(symmetry?150:300);
bs=[for(i=[0:boundmax])
let(
//c=pivot+un(pp[rnd(len(pp)-1)]-pivot)*cellmax*0.55,
//c=pivot+un(rands(-1,1,3))*cellmax*0.55,
c=pivot+un(p[rnd(len(p)-1)]-pivot+rands(-1,1,3))*cellmax*.55,
d=symmetry?
min(getdistances([abs(c.x),c.y,c.z],p,nooverlap)):
min(getdistances([c.x,c.y,c.z],p,nooverlap))
)
[c.x,c.y,c.z,d]

];

boundinspheres=

symmetry?concat(bs,[ [-10000,0,0,10000-cellmin]]):
bs;

//d=min(getdistances(pivot,pp,0));
//
//difference(){
//  translate(pivot)  sphere (cellmax*.5);
//    union(convexity=100){
//        translate(pivot)sphere(d*2);
//        for(i=boundinspheres)
//            translate(v3(i))
//                sphere(i[3],$fn=12);
//        
//        }
//    }

//    for(i=boundinspheres)
//            translate(v3(i))
//                sphere(.4);


maxradius=min([cellsize.x,cellsize.y,cellsize.z])*maxmult;
minradius=min([cellsize.x,cellsize.y,cellsize.z])*minmult;

res= ( [for(i=[1:packnumber])v4(rndcell(),.3) ])


;

for(i=p )translate(v3(i))sphere(i[3]); 

raw=  setsize( pack(maxpack,p,res),p );
//filter oversized
sph=[for(i=raw)if(i[3]<cellmin*0.5)i];
echo(len(sph));
echo(roundlist(sph));

color("yellow")for(i=sph){
  if (symmetry)  { 
      if(i.x>=0) 
    {
        translate([i.x,i.y,i.z])sphere(i[3]);
       translate([-i.x,i.y,i.z])sphere(i[3]);
    }}
else {
        translate([i.x,i.y,i.z])sphere(i[3]);
}
    }
     
    
//#hull(){
//    for(i=sph){
//    translate([i.x,i.y,i.z])sphere(i[3]);
//     }
//        } 
  

 //************************
 //************************
 //************************
 //************************
 //************************

function pack(n,points,fres)=

n<=0?
clip( (fres),boundinspheres,true):

let(  e2=echo(str("pushpull: ",maxpack-n)  ))
let(res=  rattle(shake,fres,boundinspheres,points))
//let(res=setsize(res, (points))
//, e3=echo(res))
let(diff=norm(avrgp(fres-res) )) 
let(  e2=echo(str(maxpack-n," diff: ",diff )))
diff<=bail?
clip( res,boundinspheres,true):

pack(n-1,(points), (res))
;




 //************************
function setsize(res,points)=
[for(i=res)[i.x,i.y,i.z,min(getdistances(v3(i),points,overlap))]];
    

function rattle(n,res,boundinspheres,p)=
n>0?

let( res=clip(res,boundinspheres,true) )
let( res=push(res)  )
let( res= tract(res,boundinspheres ) )
//let( res= tract(res,concat(p,boundinspheres) ) )

rattle(n-1,res,boundinspheres,p):
clip(res,boundinspheres,true)

;
 //************************
function clip(res,bound,recycle=true,k=10)= 
k<=0? res:
let(e=echo("clip-clip"))
let(nres=[
for(i=res)
  let (m=      min(getdistances(i,bound,nooverlap)))
     (m>=(cellmin*minmult))?
          i:
           
            (
//                let(new=(trace(i ,1, concat(bound,res) )))
                let(new=(trace(i ,maxtrace, bound)))
                v4(new, 0.1 ) ) 
     
    
        ]) 


    res==nres?res:clip(nres,bound,recycle,k-1);
    

 function push(points)=
 [for(i=points)v4( i+addlp(
     [
 for (j=points) 
     if(v3(i)!=v3(j))
         -pushpower* un(v3(j)-v3(i))/max(.1,norm(v3s(v3(j)-v3(i))))
     ]),0.1)]
 ;
 
 function tract(res,bound )=
  [for(i=res) trace(v3(i),maxtrace,concat (bound ,res) )];
      
 //************************
  
function trace(c, n,points)=
let(
d= getdistances(c,points,nooverlap),
midPointDist=min(d ),
mind=midPointDist,
maxd=max(d)
)
n<=0 ? 
[c.x,c.y,c.z,0.1] :

 let(

v=un([
midPointDist-(
min(getdistances(c+[epsilon,0,0],points,nooverlap))),
midPointDist-(
min(getdistances(c+[0,epsilon,0],points,nooverlap))),
midPointDist-(
min(getdistances(c+[0,0,epsilon],points,nooverlap)))
])+un(rands(-1,1,3))*0.1,


//sc= xabs(c-v*cellmin/max(1,maxtrace-n)) 
sc=  xabs(c-v*pullpower ) 

 

//, e=echo(sp,  roundd(mind ), roundd(maxd ),sc,v)

)


 

//!is_inside(cell,sc)&&midPointDist<maxradius?[]:
trace(sc,  n-1,points )
 ;

 //************************
 //************************
 
 

function  getdistances(oc,points,o)=

//[for(i=points) i==oc || !is_vec3(i) ?0:  norm(v3(i)-v3(oc)) ]
[for(i=points) if(norm(v3(i)-v3(oc))>2*epsilon)   norm(v3(i)-v3(oc))-i[3]*o]
;







function rndcell()=
let(
cellsize=cell[1]-cell[0])
cell[0]+[rnd(cellsize.x),rnd(cellsize.y),rnd(cellsize.z)]
;
function rndavr (p)=
avrgp([for(i=[0:1]) p[rnd(len(p)-1)]])
;
function roundd(d )=round(d*100)/100;
function is_inside(cell,p)=

p.x >= cell[0].x &&
p.x <= cell[1].x &&

p.y >= cell[0].y &&
p.y <= cell[1].y &&

p.z >= cell[0].z &&
p.z <= cell[1].z  ;




function sanize(v)=is_list(v)?[for(i=v)sanize(i)]:is_num(v)?v:0;

function is_vec3(oc)=(is_num(oc[0])&&is_num(oc[1])&&is_num(oc[2]));

function xabs(p)=symmetry?[abs(p.x),p.y,p.z]:p;
function v3(p) =[p.x,p.y,p.z];
function v3s(p) =let(pr=p)
   
concat(sanize([pr.x,pr.y,pr.z]),[0,0,0])+[0,0,0];

function v4(p,i) = 
   
concat(sanize([p.x,p.y,p.z,i]),[0,0,0,0])+[0,0,0,0];
     // vec3 formatter
function rev(v) = [for (i = [len(v) - 1: -1: 0]) v[i]];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;
function addlp(v,i=0,r=[0,0,0]) = i<len(v) ? addlp(v,i+1,r+v[i]) : r;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v)=assert (is_list(v)) v/max((norm( (v))),1e-64) ;
function rndc(a = 1,b = 0,s = [])=[rnd(a,b,s),rnd(a,b,s),rnd(a,b,s)];
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);

function bbox(v)=
let(x=[for(i=v)i.x],y=[for(i=v)i.y],z=[for(i=v)i.z])
[[min(x),min(y),min(z)],[max(x),max(y),max(z)]];


function roundlist(v,r = 0.01) = is_num(v) ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = v) roundlist(i,r)];
      
 

