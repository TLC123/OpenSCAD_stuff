 
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
 difference(){
 
   union() { 
unionRound(radius = 1, detail = $fn/3, epsilon = 0.00001, showIsolators = false ,forceFaster=false,microTranslateSeed=0.5) {
    color ("red")
 cylinder(10,3,2,true);
    color("green")
 rotate([0,50,0]) cylinder(7,1.5,.5);

}
unionRound(radius = .5, detail = $fn/3, epsilon = 0.00001, showIsolators = false ,forceFaster=true,microTranslateSeed=0.5) {
    color ("red")
 cylinder(10,3,2,true);
    color("green")
  translate([-3.5,0,2])rotate([0,-20,0])scale([.5,1,1])rotate([0,20,0])rotate([90,0,0])rotate_extrude(angle=280)translate([3,0,0])scale([1,2])circle(.35);

}

}

 union(){
translate([0,0,1]) cylinder(10,2.75,1.75,true);
 rotate([0,50,0])translate([0,0,1]) cylinder(7,1.25,.25);
 }}
 
// end of demo
 
// end of demo
////////////////////////////////////////////////////////
module unionRound(radius=1, detail=5, epsilon = 0.00001, showIsolators = false,
forceFaster=true, microTranslateSeed=.1) {
//    // automatic isolator if none, mask via intersection and clad , possible speedup  
//    echo($children,call);

    if(forceFaster && ($children == 2))
        {
        unionRound(radius=radius , detail=detail , epsilon=epsilon  , showIsolators=showIsolators  ,forceFaster=true)
            {
            translate(microTranslateSeed%1*rands(-epsilon,epsilon,3,microTranslateSeed+3))
                children(0);
            translate(microTranslateSeed%1*rands(-epsilon,epsilon,3,microTranslateSeed+1))
                children(1) ;
            translate(microTranslateSeed%1*rands(-epsilon,epsilon,3,microTranslateSeed+2))
                hull()clad(radius)hull(){intersection(){ children(0); children(1);}      }     
            }
        }
else
    {
    union() {
        children(0);
        children(1);
        #        if ($children  > 2 && showIsolators)            for (j = [2: max(2, $children - 1)]) children(j);
              if ($children > 2 && forceFaster)            for (j = [2: max(2, $children - 1)]){
                  hull()intersection(){ children(0);children(j);}
                  hull()intersection(){ children(1);children(j);}}
        r = radius;
        if (detail > 0)
            for (j = [2: max(2, $children - 1)]) {
                for (i = [(1 / detail) * .2: 1 / (detail): 1 + epsilon]) hull() {
                    
                  
                               slimline(r,i,r,0,epsilon=epsilon,forceFaster=forceFaster){

                                children(0);
                                children(1);
                               if ($children > 2) children(j);
                                       }
                      slimline(r,i,0,r,epsilon=epsilon,forceFaster=forceFaster){

                                children(1);
                                children(0);
                               if ($children > 2) children(j);
                                       }
                   
                }
            }
    }
}}
// unionRound helper
module clad(r) {
    minkowski() {
        children();
          icosphere(r,2); 
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
                        
                        
                         


module icosphere(r,s)
{
 pf=ico();
  scale(r)hull()
 for(f=pf[1]){
     p3=[for(i=f)pf[0][i]];
 subpoly(p3,s);
    
    }}


 module subpoly(p,s=3){
     if(s>0){
         p0=un(p[0]);p1=un(p[1]);p2=un(p[2]);
         p01=un((p0+p1)/2);p12=un((p1+p2)/2); p20=un((p2+p0)/2);
          hull() {
         subpoly([p0,p01,p20],s-1);
         subpoly([p01,p1,p12],s-1);
         subpoly([p12,p2,p20],s-1);
         subpoly([p01,p12,p20],s-1);
          }
         }
     else{
         
         polyhedron(p,[[0,1,2]]);
         }
      
     }
     function ico( )=
let(a=1,r=1*(1+sqrt(5))/2,pf=[[[0,-r,a],[0,r,a],[0,r,-a],[0,-r,-a],[a,0,r],[-a,0,r],[-a,0,-r],[a,0,-r],[r,a,0],[-r,a,0],[-r,-a,0],[r,-a,0]],[[0,5,4],[0,4,11],[11,4,8],[11,8,7],[4,5,1],[4,1,8],[8,1,2],[8,2,7],[1,5,9],[1,9,2],[2,9,6],[2,6,7],[9,5,10],[9,10,6],[6,10,3],[6,3,7],[10,5,0],[10,0,3],[3,0,11],[3,11,7]]]) 
pf
;
      function un(v) = v / max(norm(v), 1e-64) * 1;  
     
