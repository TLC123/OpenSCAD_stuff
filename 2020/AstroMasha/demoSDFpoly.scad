convexity=100;
$convexity=100;
include<sdfpoly.scad>
include<ulna.scad>
$budget=25;
$pack=1;
symmetry =false;
$tracemax=15;
$rigid=0.1;

mesh=p();
cell=bbox(getpoints(mesh));
//cell=[[0,-12,7.8],[6,-9,10]];
cellsize=cell[1]-cell[0];
cellminsize=min(cellsize);
$minSphereAccept=cellminsize*0.5*0.95;

xsize=cell[1].x-cell[0].x;
ires= []       
  
 

;
 
// [[4.254, -1.214, -3.427, 3.281], [1.362, -0.608, -1.828, 3.324], [7.172, -2.43, -5.173, 2.837], [10.276, -3.222, -7.143, 2.66], [12.292, -4.044, -8.638, 2.342], [8.431, -2.985, -5.375, 2.371], [3.683, -0.968, -0.747, 2.328], [14.38, -4.926, -10.095, 2.015], [4.199, -1.707, -4.329, 2.554], [6.084, -3.005, -3.008, 1.911], [6.326, -0.464, -4.448, 1.912], [5.856, -1.337, -1.895, 1.71], [-0.018, -0.262, 0.33, 2.044], [1.407, 0.151, 0.304, 2.31], [16.525, -6.094, -11.506, 1.868]]    


res=roundlist(drive(mesh,ires),0.001);

//**************************************************************
//**************************************************************
//**************************************************************

if($pack==0) %translate(cell[0])cube(cell[1]-cell[0]);

%polyhedron(getpoints(mesh),getfaces(mesh));
echo(len(res),str("          ",res,"          "));
if(symmetry) for(i=res){
    
        if(i==res[len(res)-1]) 
                {
          color("red")      translate(v3(i))sphere(i[3],$fn=24);
             if(i.x>0.1)   mirror([-1,0,0])translate(v3(i))sphere(i[3],$fn=24); 
                    }
       else if(len(res)>1 && i==res[len(res)-2]) 
               {
             color("yellow")    translate(v3(i))sphere(i[3],$fn=24);
             if(i.x>0.1)     mirror([-1,0,0])translate(v3(i))sphere(i[3],$fn=24);
                    }
      else
                translate(v3(i))sphere(i[3],$fn=24);
              if(i.x>0.1)    mirror([-1,0,0])translate(v3(i))sphere(i[3],$fn=24);    
    
   
    }
else
for(i=res){
       if(i==res[len(res)-1]) color("red")
    translate(v3(i))sphere(i[3],$fn=24);
 else
    if(len(res)>1&&i==res[len(res)-2]) color("yellow")
    translate(v3(i))sphere(i[3],$fn=24);
 else
    translate(v3(i))sphere(i[3],$fn=24);
    }
    
//**************************************************************
//**************************************************************
//**************************************************************

function drive(mesh,ires,drive=10)=
drive<0||len(ires)>$budget?ires:
let($minSphereAccept=$minSphereAccept*0.9)
let($pack=$pack+0.5)
let($tracemax=$tracemax*0.95)
let ($rigid=$rigid+0.0125)
let(res=pack($pack,mesh,ires))
  let(e=echo(str(
    " drive:",drive
   )))
 
drive(mesh,res,drive-1)
;
    
    function pack(c,mesh,res=[])=
c>0?
 let($frigid=$rigid /*max(0.25,$rigid-(1/$pack))*/)
let(res= symmetry?concat([[-10000- xsize ,0,0,10000/$rigid]],res):res)
let(e=echo(str("sphere:",$pack-c)))
    
let(new=iterpack(res,mesh))

let(e=echo(str("added:",new)))
let(res=concat(res,[new]))
pack(c-1,mesh,res)
:
   [for(i= res )if(i.x>-5000&&i[3]>=$minSphereAccept)[symmetry?abs(i.x):i.x,i.y,i.z,i[3]]] //strip out bounding sphere
 ;

function iterpack(res,mesh,od,bestof=[0,0,0,0],c=3)=
   let(e=echo(str(
   " Found: ",len(res) 
   ," pack:",$pack
   ," minSphereAccept:",$minSphereAccept
   ," tracemax:",$tracemax
   ," rigid:",$rigid
    )))
  
let( p= rndcell(res, mesh))
  let(e=echo(str( 
    " attempt:",c
    ," from:",p
    )))
let(t=comboTrace(p,res,mesh,$tracemax))
let(d=SDFcombo(t,[], mesh   ) *1.1)
//let(n=SDFcomboNormal( t,res, mesh   ))
let(new=concat(t,[d]))
let(bestof=new[3]>bestof[3]?new:bestof)
// c>0&& d < ($minSphereAccept*(1-1/c)) &&od!=d?
    c>0&& d < ($minSphereAccept ) &&od!=d?

let(e=echo("failed pack"))
let(e=echo(str("refused:",new," best:",bestof)))
iterpack(res,mesh,d,bestof,c-1):
  bestof;


  


 


function comboTrace(p,spheres,mesh,max,on=[1,0,0],ostep=3)=
max>0&&ostep>0.02?
let(n=(un(SDFcomboNormal(p,spheres,mesh))))
//let(step=clamp(step*((on*n)+1)/1.5+.5,0.001,5))// double if sam half if opposite
let(step=ostep) 
let(step=clamp(ostep* (on*n>0.5?1.5:on*n>-.5?1:0.4 ),0.0125,5)) 
//let(n=on*n<-0.25?un((on+n)/2):n)
let(n= un((on*0.25+n*0.75)))
//let(e=echo(str( "ostep:",ostep," step:",step," flow:",on*n,on,n)))
let(p=p+ n*max(0.125,step))
comboTrace( (p),spheres,mesh,max-1,n,step)
:let(e=echo("traced:",$tracemax-max," last stepsize",ostep))p;

function getpoints(mesh)=mesh[0];
function getfaces (mesh)=mesh[1];


function SDFcomboNormal(p,spheres,mesh)=
 ([
SDFcombo(p+[epsilon,0,0],spheres, mesh)-SDFcombo(p-[epsilon,0,0],spheres, mesh),
SDFcombo(p+[0,epsilon,0],spheres, mesh)-SDFcombo(p-[0,epsilon,0],spheres, mesh),
SDFcombo(p+[0,0,epsilon],spheres, mesh)-SDFcombo(p-[0,0,epsilon],spheres, mesh),
])
;

function un(v)=assert (is_list(v)) v/max((norm( (v))),1e-64) ;
function SDFcombo(p,spheres, mesh   )=
  len(spheres)==0?SDFpolyhedron(p,mesh):
min( SDFpolyhedron(p,mesh),SDFspheres(p,spheres))
;

function  SDFspheres(p,spheres)=

//[for(i=points) i==oc || !is_vec3(i) ?0:  norm(v3(i)-v3(oc)) ]
min([for(i=spheres) let(d=norm(v3(i)-v3(p))) if(d>2*epsilon)   d-(i[3])*$frigid])
;
function v3(p)=[p.x,p.y,p.z];
function xabs(p)=symmetry?[abs(p.x),p.y,p.z]:p;
function bbox(v)=
let(x=[for(i=v)i.x],y=[for(i=v)i.y],z=[for(i=v)i.z])
[[min(x),min(y),min(z)],[max(x),max(y),max(z)]];

function rndcell(res, mesh ,od=-100000,p=[0,0,0],c=10)=
c<0?p:
let(
cellsize=cell[1]-cell[0])
let(try=cell[0]+[rnd(cellsize.x),rnd(cellsize.y),rnd(cellsize.z)])
let(try=symmetry?[abs(try.x),try.y,try.z]:try)
 
let(d=SDFcombo(try,res, mesh   ))
d>od?
rndcell(res, mesh,d,try,c-1):
rndcell(res, mesh,od,p,c-1)
;
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);
 function roundlist(v,r = 0.01) = is_num(v) ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = v) roundlist(i,r)];