boundary=3;
module iradious(r,fn=8){
    minkowski(){

children();
sphere(r,$fn=fn);    
}   }

module ioradious(r){
difference(){
    cube(boundary*2,center=true);
iradious(r,20){
difference(){
    cube(boundary*2,center=true);
iradious(r*2,20){children();
}}}}}  
    
  
  
  
   ioradious(0.2){
    difference(){   sphere(2,$fn=20);
translate([1,1,1])    sphere(2,$fn=20);
 translate([-1,-1,-1])    cube(3,center=true);        
    }}