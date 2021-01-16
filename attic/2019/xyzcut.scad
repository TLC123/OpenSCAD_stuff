include <DC19\DCmath.scad>
$fn=20;
 minkowski(){
 intersection(){
rotate(90,[1,0,0])linear_extrude(20,center=true ,convexity=20)shape();
rotate(90,[0,1,0])linear_extrude(20,center=true ,convexity=20)shape();
rotate(90,[0,0,1])linear_extrude(20,center=true ,convexity=20)shape();
 }
 
 sphere(0.5,$fn = 12);
 }


module shape(){
    
    offset(-0.5)
 
    for(i=[0:4]){
 translate([rnd(-5,5),rnd(-5,5)]) circle(rnd(1,5));   
    }
    
    
    }