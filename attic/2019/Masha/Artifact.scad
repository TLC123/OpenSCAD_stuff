include <DC19\DCmath.scad>
$fn=10;
 
 translate([0,40,0] )artifact();
 translate([0,-40,0] )artifact();
 translate([-25,0,11] )scale([0.87,2.95,2])artifact();
 
 
 module artifact(){
  color("LightGray")xyzunion(){
     for(i=[-35:20:35]){
      translate([i,0])scale([1,30/abs(i)])shape();
     }
     
     scale([1,1])
     for(i=[-35:20:35]){
      translate([i/1.1,0])scale([1,30/abs(i)])shape();
     }
 
      translate([0,0])shape();
    
 
     }
 
   color("LightGray")  {  
 translate([rnd(-8,8),rnd(-8,8),rnd(-5,5)]) color("Gray")scale([1,0.5,0.5])rotate(90,[0,0,1])rotate(90,[1,0,0])linear_extrude(100+rnd(-10,48),center=true ,convexity=20)offset(-1)offset(-1.2)shape();

 translate([rnd(-10,8),rnd(-8,8)-3,rnd(-5,5)-4]) color("Gray")scale([1,0.5,0.5])rotate(90,[0,0,1])rotate(90,[1,0,0])linear_extrude(50+rnd(-10,48),center=true ,convexity=20)offset(-0)offset(-1.2)shape();
       
 translate([rnd(-10,8),rnd(-8,8)+3,rnd(-5,5)-4]) color("Gray")scale([1,0.5,0.5])rotate(90,[0,0,1])rotate(90,[1,0,0])linear_extrude(100+rnd(-10,8),center=true ,convexity=20)offset(-0)offset(-1.2)shape();   }
  translate([rnd(-50,50),rnd(-12,12),rnd(-10,10)]) color("Gray")scale([1,0.5,0.5])rotate(90,[0,0,1])rotate(90,[1,0,0])linear_extrude(30+rnd(-10,8),center=true ,convexity=20)offset(-1)offset(-1.2)shape();
       
    }
 
 module xyzunion(){
     
  
         
         
 intersection(){
color("Red")rotate(00,[1,0,0])linear_extrude(20,center=true ,convexity=20)offset(-0)children(0);
color("Yellow")rotate(90+rnd(-60,60),[1,0,0])linear_extrude(20,center=true ,convexity=20)offset(-0)children(1);
color("Blue")rotate(90,[0,0,1])rotate(90,[1,0,0])linear_extrude(80,center=true ,convexity=20 ,scale=rnd(0.5,1.2))offset(-0)children(2);
 }  
 
 
 
 
 
 }
 
 
 

module shape(){
         offset(rnd(1),$fn=rnd(5,7))
   offset(-rnd(1),$fn=rnd(.5,7))
   offset(rnd(1),$fn=rnd(.2,7))
    difference(){
        
    offset(rnd(1),$fn=rnd(2,7))
   offset(-rnd(1),$fn=rnd(2,7))
   offset(rnd(1),$fn=rnd(2,7))for(i=[0:4]){
   hull(){  
       translate([rnd(-8,8),rnd(-5,5)]) rotate(rnd(0,180)) circle(rnd(1,6),$fn=rnd(3,9));   
    translate([rnd(-8,8),rnd(-5,5)]) rotate(rnd(0,180)) circle(rnd(1,6),$fn=rnd(3,9));   
    
       }}
        offset(rnd(1),$fn=rnd(5,6))
   offset(-rnd(1),$fn=rnd(6,5))
   offset(rnd(1),$fn=rnd(6,5))   for(i=[0:1]){
              translate([rnd(-5,5),rnd(-5,5)]) rotate(45)circle(rnd(0.3,4),$fn=rnd(4,8));     
  }
   hull(){ 
       translate([rnd(-5,5),rnd(-5,5)]) rotate(45) circle(rnd(.3,4),$fn=floor(rnd(2,4))*2);     
       translate([rnd(-5,5),rnd(-5,5)]) rotate(45) circle(rnd(.3,4),$fn=floor(rnd(2,4))*2);   
    }
    
  
}
    }
    
    function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper