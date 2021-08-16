for(n=[0:100]){
  color(rands(0,1,3))  
    translate(rands(-1000,1000,3))
     rotate(rands(-360,360,3))
      cube(rands(30,200,3),true);
      color(rands(0,1,3))  

    translate(rands(-1000,1000,3))
     rotate(rands(-360,360,3))
      sphere(rands(50,200,1).x );
    
      color(rands(0,1,3))  

    translate(rands(-1000,1000,3))
     rotate(rands(-360,360,3))
      cylinder(rands(50,200,3),true);
    
    }