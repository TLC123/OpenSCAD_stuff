select=3;
fudge=.25;
 steps= 30;
 mindetail=.5;
 packnumber=[12,12,3,12,10,7,7,7,20][select];
 include<sdfpolyQ.scad>

symmetry=[false,false,false,false ,false,false,false,false,false,false][select];;
 
name=["ab","torax","collum","head","foot","crus","thigh","upperarm","ulna","hand"][select];
include <ab2.scad>;
include <torax2.scad>;
include <collum.scad>;
include <head3.scad>;
include <foot2.scad>;
include <crus.scad>;
include <thigh.scad>;
include <uarm.scad>;
include <ulna.scad>;
include <hand.scad>;

mesh= 
select==0?p0():
select==1?p1():
select==2?p2():
select==3?p3():
select==4?p4():
select==5?p5():
select==6?p6():
select==7?p7():
select==8?p8():p9() ; 

p=mesh[0];

cell=bbox(p);
//fcell=bbox(pp);
cellsize=cell[1]-cell[0] ;
cellmin=min(cellsize);
cellmax=norm(cellsize);
pivot=symmetry? v3(fcell[1]+fcell[0])/2: v3(cell[1]+cell[0])/2; 
maxradius=min([cellsize.x,cellsize.y,cellsize.z]);
 

 ires=[for(
i=[
//cell[0].x
 pivot.x
 :cellmin/steps:cell[1].x],
j=[cell[0].y:cellmin/steps:cell[1].y],
k=[cell[0].z:cellmin/steps:cell[1].z]) 
 let(r=SDFpolyhedron([i,j,k],mesh))
     
 if(r>mindetail &&r<=cellmin*.5)[i,j,k,r]]
 ;
 resii=_sort(ires);
 res=reduce(resii);
 echo(len(resii));
 echo(len(res));

 
//translate(cell[0]) cube(cellsize);
 #  polyhedron(mesh[0],mesh[1]);
 
 
 
 echo(roundlist(res));
 
 for(i=res){
     c=1-1/i[3];
    color( clampcolor([c, sin(c*360)/2+0.5 , 1-c]),c) translate([i.x,i.y,i.z])sphere(i[3]);
 }
 
 


 


function reduce (res,pick=0)=
pick>len(res)-1?res:
let (res= [for(i=res) if( (res[pick] == i) || !inside(res[pick],i) )i])
    reduce(res,pick+1);


function inside(a,b)=a==b?true:
 
norm([a.x,a.y,a.z]-[b.x,b.y,b.z])-(a[3]-b[3]*fudge)<=0;



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
      
  function _sort(arr, idx=3) =
	(len(arr)<=1) ? arr :
	let(
		pivot = arr[floor(len(arr)/2)],
		pivotval =  pivot[idx],
		compare = [
			for (entry = arr) let(
				val =   entry[idx],
				cmp = ( pivotval-val)
			) cmp
		],
		lesser  = [ for (i = [0:1:len(arr)-1]) if (compare[i] < 0) arr[i] ],
		equal   = [ for (i = [0:1:len(arr)-1]) if (compare[i] ==0) arr[i] ],
		greater = [ for (i = [0:1:len(arr)-1]) if (compare[i] > 0) arr[i] ]
	)
	concat(_sort(lesser,idx), equal, _sort(greater,idx));
function clampcolor(c)=[for(i=c)min(1,max(0,i))];
