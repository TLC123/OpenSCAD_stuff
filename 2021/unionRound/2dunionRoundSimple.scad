    ////////////////////////////////////////////////////////
    /*
    Based on the 3D unionRound Module
    unionRound2D Module by Torleif Ceder - TLC123 late summer 2021
     Pretty fast Union with radius, But limited to a subset of cases
    Usage 
     unionRound2D( radius , detail , epsilon )
        {
         YourShape1();
         YourShape2(); 
        } 
    limitations: 
     0. Only really fast when boolean operands are convex, 
            Minkowski is fast in that case. 
     1. Boolean operands may be concave but can only touch 
            in a single convex area
     2. Radius is of elliptic type and is only approximate r
            were operand intersect at perpendicular angle. 
    */
    //////////////////////////////////////////////////////// 
    // Demo code
 
   voxelpass(3,  5) {       
        translate([10,5]) rotate(30)difference (){ square(30,true); square(20,true);}
text ("R",size=20);



        }
    // end of demo code
    //

module voxelpass(r, detail = 5){

 range=[-30:r*.5:30];
    
for(x=range,y=range )
   {
 
    unionRound2D(r, detail) { 
      intersection(){ children(0);         patch(x,y,r){children();};}
        intersection(){  children(1);  patch(x,y,r){children();};}
                } 

   }
   
   module patch(x,y,r){
       
       {
       color(rands(0,1,3))   hull()  offset(r*.25) intersection(){
           hull(){children();}
      translate([0,y]) square([1e16,r],true);  
       translate([x,0])square([r,1e16],true);  
       }
       }}
       
       }

    module unionRound2D(r, detail = 5) {
        epsilon = 1e-6;
        children(0);
        children(1);
        step = 1 / detail;
        for (i = [0: step: 1 - step]) {
            {
                x = r - sin(i * 90) * r;
                y = r - cos(i * 90) * r;
                xi = r - sin((i + step) * 90) * r;
                yi = r - cos((i + step) * 90) * r;
                 
                hull() {
                    intersection() {
//                          shell2D(e psilon) 
                        clad2D(x) children(0);
//                          shell2D(epsilon) 
                        clad2D(y) children(1);
                    }
                    intersection() {
//                          shell2D(epsilon) 
                        clad2D(xi) children(0);
//                          shell2D(epsilon) 
                        clad2D(yi) children(1);
                    }
                }
            }
        }
    }
    // unionRound helper expand by r
    module clad2D(r) {
     offset(r)children();
    }
    // unionRound helper
    module shell2D(r) {
        difference() {
            clad2D(r) children();
            children();
        }
    }