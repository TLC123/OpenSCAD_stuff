$fn=36;
//for(a=[0:120:360])
//    rotate([0,0,a])
// difference(){ 
// color("red")hc();  

//}
//translate([0,0,-7.5])translate([0,0,-3])import("platecage.stl",convexity=100);
mirror([0,0,1])translate([0,0,-12.5])translate([0,0,-3])tp();
translate([0,0,-12.5])translate([0,0,-3])tp();
translate([32,0,-12.5])translate([0,0,-3])tp();
mirror([0,0,1])translate([32,0,-12.5])translate([0,0,-3])tp();
  halfcage();
 rotate([0,180,0])mirror([0,1,0])halfcage();
 
module halfcage(){
    
    translate([0,0,-7.5]){
    
hg();
    



translate([0,0,-3])import("platecage.stl",convexity=100);
translate([0,0,-10])rotate([-90,0,0])import("spline.stl",convexity=100);



for(a=[0:120:360])
    rotate([0,0,a])
 
translate([10,0,0]){
    
mirror([0,0,1])translate([0,0,-5])hg();
    
mirror([0,0,0])translate([0,0,5])hg();
    
sp();
}}}
module sp(){rotate([-90,0,0])import("spline.stl",convexity=100);}

module tp(){rotate(2)import("platetransfer.stl",convexity=100);}
module hg(){
  import("herringbone_gear.stl",convexity=100);
    
    }
    module hc(){
  import("Pancakecross.stl",convexity=100);
    
    }