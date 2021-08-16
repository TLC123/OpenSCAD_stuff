module select(tr,sc,ro){
    union(){
        difference(){
    children(0);
     children(1);
        }
        
       translate(tr)scale(sc)rotate(ro)   intersection(){
    children(0);
    children(1);
        }
    }
    
    }
 
 module   caller (i){ 
   select([-1,0,0],[1,1,1],[5,45,0]) {
    if(i==0){cube(10);}else {caller(i-1);}
     sphere(5,center=true);}
 }
 caller(45);