    module base() {
    //difference (){
    //cube(10);
    //translate ([1,1,1])cube(10);}
     resize([10,10,10])import("tote.stl", convexity=3);
        }
    
    difference (){
    translate ([-4,-4,-4])
    cube(18);
    minkowski(){ 
    difference (){
    translate ([-5,-5,-5])
    cube(20);
    minkowski(){
    //base();
    sphere(2,center=true); 
    }
    }  
    sphere(1,center=true); 
    }}