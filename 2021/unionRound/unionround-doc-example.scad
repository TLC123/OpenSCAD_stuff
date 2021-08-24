include<unionRoundMask.scad>
 
 
 
 unionRoundMask(1,3,showMask=true)
 {
    color("red") cube([15,15,1 ] ,true);
     union(){
   translate([5,5]) color("blue") cube([1, 1 ,10] ,true);
   translate([-5,5]) color("blue") cube([1, 1 ,10] ,true);
   translate([-5,-5]) color("blue") cube([1, 1 ,10] ,true);
   translate([5,-5]) color("blue") cube([1, 1 ,10] ,true);
     }
   //masks
   
   translate([ 5, 5])   cube(4 ,true);
   translate([-5, 5])   cube(4 ,true);
   translate([-5,-5])   cube(4 ,true);
   translate([ 5,-5])   cube(4 ,true);
     
     
     
     
     }