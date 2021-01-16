$fn=20;
mirrorcopy (){
translate ([7.,-1.2,-1])rotate ([90,0,14])sphere(5);
translate ([6.6,-1,-1])rotate ([-20,-10,0])cylinder(3,6,5);
translate ([6.6,-1,-1])rotate ([30+180])cylinder(3,6,7);
translate ([6.6,-1,-1])rotate ([20+180,0,40])cylinder(3,6,6);

translate ([2,-8,-14])rotate ([30+180,-4,6])cylinder(5,4,4);
translate ([1,-8,-16])rotate ([-40,10,0])cylinder(6,6,5);

 hull(){

translate ([0,-0,2])rotate ([180-50,0,0])cylinder(16.6,2,3);
translate ([0,-0,2])rotate ([180-50,0,0])cylinder(17.3,2,2);
translate ([0,-0,2])rotate ([180-40,0,1])cylinder(17.4,1,1);
 }  
    translate ([0,-0,2])rotate ([180-50,0,0])cylinder(7,5,2);



}
mirrorcopyhull (){
    
   hull(){  
 translate ([0,-4,-5])rotate ([180-55,0,30])cylinder(8.6,2,3);
translate ([0,-4,-5])rotate ([180-45,0,30])cylinder(9,2,2.5);
   }

hull(){ 
         translate ([7,8,-5])rotate ([0,30,0])sphere(10);

    translate ([3,6,4])rotate ([0,0,0])sphere(12);
    translate ([2,12, 3])rotate ([0,0,0])sphere(14);

    }
 
    hull(){ 
translate ([1,10,-5])rotate ([0,0,0])sphere(16);
  translate ([2,12, 3])rotate ([0,0,0])sphere(14);
   
    
    } 
hull(){
    translate ([2,1,-12])rotate ([0,0,0])sphere(11);
     translate ([8,0,-10])rotate ([0,30,0])sphere(7);
     translate ([7,8,-5])rotate ([0,30,0])sphere(10);

}
hull(){
    translate ([0.5,-5,-18])rotate ([150,0,0])sphere(6);
translate ([3,-4,-15])rotate ([0,20,0])sphere(6);
 
}
hull(){
    translate ([0.5,-5,-18])rotate ([150,0,0])sphere(6);
translate ([3,-4,-15])rotate ([0,20,0])sphere(6);
    translate ([2,1,-12])rotate ([0,0,0])sphere(11);

}
}
module mirrorcopy ()
{
    children();
    mirror ()children();
    }
    
    module mirrorcopyhull ()
{ for(i=[0:$children-1])
    hull(){
    children(i);
    mirror ()children(i);
    }}