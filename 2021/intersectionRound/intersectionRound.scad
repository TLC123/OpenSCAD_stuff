 
////////////////////////////////////////////////////////
/*
unionRound Module by Torleif Ceder - TLC123 late summer 2021
 Pretty fast Union with radius, But limited to subset of cases
Usage 
 unionRound( radius , detail , epsilon= 0.00001){ YourObject();YourObject(); YourIsolatingMASKObject(); } 
limitations: 
 0. Only really fast when boolean operands are convex, Minkowski is fast in that case. 
 1. Boolean operands may be concave but can only touch in a single convex area
 2. Radius is of elliptic type and is only approximate r were operand intersect at perpendicular angle. 
 3. For chamfer detail can be set to 1 with approximate double the radius  



Full function:
module unionRound( 
radius=1,                // fillet radius
detail=5,               //  fillet detail
epsilon = 0.00001,      // some numeric  CGAL issues resolve with different value
showIsolators = false,  // visualize isolation masks in red
forceFaster=true,       // force all operands to be convex before minkowski
microTranslateSeed=.1   // some numeric  CGAL issues resolve with micro-translations
)

*/
////////////////////////////////////////////////////////
// demo code
 $fn=$preview ?8:18;
 
unionRound(radius = 1, detail = 4, epsilon = 0.00001, showIsolators = false ,forceFaster=true,microTranslateSeed=0.5) {
    color ("red")
   cylinder(10,3,2);
    

  
  color("green",.5)
      
       cylinder(3,5,5,true); 
    


 

 
}
 

 
 
// end of demo
 
// end of demo
////////////////////////////////////////////////////////
module unionRound(radius=1, detail=1, epsilon = 0.00001, showIsolators = false,
forceFaster=true, microTranslateSeed=.1) {
 r=radius;
    
    difference(){
    intersection(){
     children(0);
     children(1);
    }
    
   for(i=[.2:1/detail:.5]){
res=tanrad(i,r);

clad(res.z){
   
        intersection(){
         shell(epsilon)   clad(res.x )children(0);
          shell(epsilon)  clad(res.y ) children(1);
      }
  }
 
  }
  
 
 }
}

   function tanrad(i,r,m=1)=
   let(a= smooth(i)*90,
   x=(tan(a)*r* m ) ,
y=(tan(90-a)*r* m ),
        xd=x+r,
        yd=y+r,
        d=sqrt(xd*xd+yd*yd)-r) [x,y,d];
// unionRound helper
module clad(r) {
    minkowski() {
        children();
        sphere(r, $fa = 12);
    }
}
// unionRound helper
module shell(r) {
    difference() {
        clad(r) children();
        children();
    }
}
  module slimline(r,i,from,to,epsilon,forceFaster ){
      
      
                          intersection() {
                        shell(lerp(from, to, i)) if ($children > 2) {
                       if(forceFaster) 
                        {hull()intersection() { children(0); children(2); }}
                          else{intersection() { children(0); children(2); }}
                        }
                        else { children(0); }
                        shell(epsilon) if ($children > 2) {
                        if(forceFaster)
                         { hull()intersection() { children(1); children(2);}}
                           else{ intersection() { children(1); children(2);}}
                        }
                        else { children(1); }
                    }
                        
                        }
function lerp(start, end, bias) = (end * bias + start * (1 - bias));