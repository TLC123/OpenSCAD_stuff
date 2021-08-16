//translate([-30,60,15])rotate([90,0,0])linear_extrude(50,center=true) color("black") offset(2)offset(-4)offset(2){
//    
//    square([200,10],true);}
//translate([-30,-60,15])rotate([90,0,0])linear_extrude(50,center=true) color("black") offset(2)offset(-4)offset(2){
//    
//    square([200,10],true);}
 rotate(45)difference(){
    
    union(){
 color("tan")   rotate([90,0,0])linear_extrude(20,center=true,convexity=10) color("black") offset(4)offset(-4)offset(2)  shape(); 
 color("yellow")   rotate([90,0,0])linear_extrude(70,center=true,convexity=10) color("black") offset(-1)offset(-4)offset(2)  shape(); 
        
  color("tan")  translate([0,35,0]) rotate([90,0,0])linear_extrude(10,center=true,convexity=10) color("black") offset(3)offset(-4)offset(2)  shape();        
 color("tan")  translate([0,-35,0]) rotate([90,0,0])linear_extrude(10,center=true,convexity=10) color("black") offset(3)offset(-4)offset(2)  shape(); 
        }
    
 {

 color("tan") for(a=[0:1/10:1])
   translate([72,0,70]) 
      rotate([0,sin(a*360)*60+15,0])translate([0,0,29])rotate([0,90,0])cylinder(100,25,25,center=true);

}}

     module shape()  {square([12,10],true);
union()                                                                  {
translate([5,0])rotate(35){
    translate([20,0]) square([34,10],true);
translate([40,0])rotate(10){
    translate([20,0]) square([32,10],true);
translate([40,0]) rotate(30){
    translate([20,0]) square([30,10],true);
    
    
}   
    
}    
    
}
    }
union()                                                                  {
translate([-5,0])rotate(180-40){
    translate([20,0]) square([34,10],true);
translate([40,0])rotate(40){
    translate([20,0]) square([32,10],true);
translate([40,0]) rotate(20){
    translate([20,0]) square([32,10],true);
    
 translate([40,0]) rotate(-70){
    translate([10,0]) square([20,10],true);
    
    
}   
}   
    
}    
    
}
    }                   }