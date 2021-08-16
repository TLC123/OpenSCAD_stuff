/*
A New Computationally Efficient Method for Spacing n Points on 
a Sphere - Jonathan Kogan  */
function sphericalcoordinate(x,y)=  [cos(x  )*cos(y  ), sin(x  )*cos(y  ), sin(y  )];
function NX(n,x)= 
let(PI=acos(-1)/57.2958,toDeg=57.2958,
start=(-1.+1./(n-1.)),increment=(2.-2./(n-1.))/(n-1.) )
[ for (j= [0:n-1])let (s=start+j*increment )
 sphericalcoordinate(   s*x*toDeg,  PI/2.* sign(s)*(1.-sqrt(1.-abs(s)))*toDeg)];
function generatepoints(n)= NX(n,0.1+1.2*n);
module isosphere(r,detail){
a= generatepoints(detail);
scale(20)hull()polyhedron(a,[[for(i=[0:len(a)-1])i]]);
}
    isosphere(20,70);
 
    