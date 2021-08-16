$fn=10;
fillet_extrude(e=10,r=1)  
union(){ circle(5);
translate([2,2])square(6); 
  rotate(180)  translate([2,2])offset(1)square(4); 
    }

  module fillet_extrude(e=10,r=1 ,s=$fn)
           {
               
               for(t= [0:1/s:1 ]){
                   
               linear_extrude((e-2*r)+sin(t*90)*r*2,center=true)
                   
                   offset(-r+cos(t*90)*r )children();
               }
               
               }
 