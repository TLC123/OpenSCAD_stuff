cubesCenters=[for(i=[0:1],j=[0:1],k=[0:1 ])[i,j,k]];


 
uray=[[.2,.2,.2],un(rndc()-[0.5,0.5,0.5])];
ray=[uray[0]+uray[1]*3,-uray[1]];


distances=[each[for(i=cubesCenters)point2Plane(ray,i)]];
sorted =  quicksort( distances);
selection=search(  sorted, distances  ,1,0);
 echo ( selection );

 



for(i=[0:len(selection)-1]) {
translate(cubesCenters[selection[i]])linear_extrude(0.125)text(str(i),0.25);
}

color("Red")
hull(){
    translate(ray[0]) sphere(0.2);
translate(ray[0]+ray[1]) sphere(0.1);
 }
 
 
 echo ( selection );
 
function point2Plane(ray,point)=let(rayOrigin=ray[0],rayNormal=ray[1])((point-rayOrigin)*rayNormal);

function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
(rands(min(a, b), max(   a, b), 1)[0]) 
: 
(rands(min(a, b), max(a, b), 1, s)[0])
; 
function rndc(a=1,b=0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function un(v)=is_list(v)? v/max( is_undef(norm(v))?0:norm(v),1e-16):v;
function quicksort(kvs) = 
  len(kvs)>0
     ? let( 
         pivot   = kvs[floor(len(kvs)/2)], 
         lesser  = [ for (y = kvs) if (y  < pivot) y ], 
         equal   = [ for (y = kvs) if (y == pivot) y ], 
         greater = [ for (y = kvs) if (y  > pivot) y ] )
          concat( quicksort(lesser), equal, quicksort(greater))
      : [];