//Like  rotate extrude but minimizes polygons on smal diameters 
  
    FSrotate_extrude(1){  
   difference(){
       circle(8);
    translate([8,2])circle(4);
}}
     






module FSrotate_extrude($fs=4){
step=$fs;
for(i=[-10e3:step:10e3])
hull(){


   rotate($fs* i)

rotate_extrude(){
   
   intersection(){
 
    translate([0,i])square([10e5,10e-5]);
      children();    
   }
   intersection(){
 
    translate([0,i-step])square([ 10e-5,step*2]);
      children();    
   }
   
   }
   rotate($fs*( i+step))
rotate_extrude(){
   
   intersection(){
 
    translate([0,i+step])square([10e5,.10e-5]);
        children();
   }
   
}
}
}