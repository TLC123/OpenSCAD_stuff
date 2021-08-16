n=131;
sp=0.3;
intersection (){
    
   cylinder(43,11,11);
translate([0,0,9]){
chief();
 translate([0,0,25])chief();
translate([0,0,10])bone();
}
}

module bone(){
rotate_extrude( convexity =40)
     intersection(){ 
translate([20,0,0])square([40,100],center=true);
 
offset(-5)offset(5)union(){
  translate([0,-10,0])circle(9.9);
square([5,35],center=true);
 translate([0,15,0])circle(9.9);
}
}}

 module chief(){

demi()   ;
rotate([180,0,0])demi()   ;
core(10);
 }


module demi(){
for (i=[0:n*.7])
      {
          
          hull(){
              sphere(8 , $fn=12 );
          translate(_pos(i,n)*10) sphere(sp, $fn=6 );
          }
           
          }
          
      }
      
      module core (r){
          
          hull() fibonacci_sphere(r, n, $fn=1 );}
          
          
module  fibonacci_sphere(r, n, $fn=1 ){
    $n = n==undef? ceil((0.5*$fn*$fn)/2) : n;
    hull()
    polyhedron(points = [
        for(i=[-$n:($n-2)])
            r * _pos(i,$n)
    ], faces=[
        for(i=[0:3:2*$n])
            [i,i+1,i+2]
        // for(i=[-$n:3:($n-2)])
        //     [i+$n,i+1+$n,i+2+$n]
    ]);
}

//calculates ith vertex position on a fibonacci unit sphere of 2*n vertices
function _pos(i, n) =
	[cos(_lon(i)) * _xy(_z(i,n)), 
	 sin(_lon(i)) * _xy(_z(i,n)), 
	 _z(i,n)];

function _lon(i) = _golden_angle*i;
function _z(i,n) = 2*i/(2*n+1);
function _xy(z)  = sqrt(1-pow(z,2));

_golden_ratio = 1.61803;
_golden_angle = 360 * _golden_ratio; 
