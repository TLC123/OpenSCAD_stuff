module select(tr,sc,ro){
    union(){
       scale(1.001) difference(){
    children(0);
     children(1);
        }
        
       translate(tr)scale(sc)rotate(ro)   intersection(){
    children(0);
    children(1);
        }
    }
    
    }
 

 select([0,0,-3],[1,1,1],[0,9,0]) {
        select([0,0,-3],[1,1,1],[9,0,0]) {
      difference(){
          cube(5,center=true);
          cube(4,center=true);
      }    
      
    translate( [rands(-1,1,1)[0],rands(-1,1,1)[0],3  ]) union(){
        sphere(1.52,$fn=8);
         for(i=[1:10]){
             translate( [rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]]) rotate([rands(0,360,1)[0],0,rands(0,360,1)[0]])sphere(1,$fn=8);
             }
         
         
         }
     
     }    
      
   translate( [rands(-1,1,1)[0],rands(-1,1,1)[0],2  ]) scale(2) union(){
        sphere(1.52);
         for(i=[1:10]){
             translate( [rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]]) rotate([rands(0,360,1)[0],0,rands(0,360,1)[0]])sphere(1,$fn=8);
             }
         
         
         }
     
     }

    
 
