

module this(){
    
    square(30);
    circle(20);
    }

 r=5;
for(x=[-100:r:100],y=[-100:r:100] )
   {
     color(rands(0,1,3)) offset(-.5) intersection(){
           this();
      translate([0,y]) square([1e16,r],true);  
       translate([x,0])square([r,1e16],true);  
       }
       
       
       
       } 