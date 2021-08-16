r=rands(+0,360,3);
t=rands(-10,10,3);
translate(t)    rotate(r) cube(10,true);
translate(-t)    rotate(-r*r) cube(10,true);

color("red",.25)
fast_minkowski(5) {
translate(t)      rotate(r) cube(10,true);
translate(-t)      rotate(-r) cube(10,true);
 
}

module fast_minkowski (padding){
    
 intersection(){
     linear_extrude(100,center=true){
      
  offset(delta=padding)projection() hull()children();
      
    }
    
    
  
 rotate(-[90,0,0])  linear_extrude(100,center=true){ 
     offset(delta=padding)projection()  rotate([90,0,0])  hull()children();

}
    
    
     rotate(-[0,90,0])    linear_extrude(100,center=true){
      
  offset(delta=padding)projection()      rotate([0,90,0])hull() children();

    
    
}
    }
     }