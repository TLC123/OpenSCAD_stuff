    ////////////////////////////////////////////////////////
    /*
    unionRound() 1.0 Module by Torleif Ceder - TLC123 late summer 2021
     Pretty fast Union with radius, But limited to a subset of cases
    Usage 
     unionRound( radius , detail  )
        {
         YourObject1();
         YourObject2(); 
        } 
      unionRoundMask (r, detail , epsilon ,showMask )
        {
         YourObject1();
         YourObject2(); 
         YourMask();
         YourMask();   
         
         // ...
         // ...
         // ...
         
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
    demo= true;
    if (demo)  
     union()for(i=[0:360/5:360-360/5])unionRoundMask(1.5, 5) {
     cube([10,10,2],true);
     rotate(i)translate ([4,0,0])rotate([20,-10,0])cylinder(5,1,1,$fn=12);   
     rotate(i) translate ([4,0,0])cylinder(2.5,3.5,3.5 ); //mask
   
    }
    
    // end of demo code
    //
    module unionRoundMask(r, detail = 5, epsilon = 1e-6, showMask = true) {
    //automask if none
    if($children <=2){
        unionRoundMask(r,detail,epsilon,showMask)
        {
            children(0);
            children(1);
            clad(r) intersection(){
                    children(0);
                    children(1);
                }
            }
            }
    else {
    union() {
        children(0);
        children(1);
        if (showMask && $children > 2) %
            for (i = [2: max(2, $children - 1)]) children(i);

        if ($children > 2)
            for (i = [2: max(2, $children - 1)]) {
                intersection() {
                    children(i);

                    unionRound(r, detail, epsilon) {
                        intersection() {
                            children(0);
                            children(i); // mask
                        }
                        intersection() {
                            children(1);
                            children(i); // mask
                        }
                    }
                }
            }
        }
     }
}
    
    
    module unionRound(r, detail = 5,  epsilon = 1e-6) {
        
        children(0);
        children(1);
        step = 90 / detail;
      union()for (i = [0:  detail-1]) {
            {
                x = r - sin(i * step ) * r;
                y = r - cos(i * step ) * r;
                xi = r - sin((i * step + step)  ) * r;
                yi = r - cos((i * step + step)  ) * r;
                color(rands(0, 1, 3, i))
                hull() {
                    intersection() {
                        // shell(epsilon) 
                        clad(x) children(0);
                        // shell(epsilon) 
                        clad(y) children(1);
                    }
                    intersection() {
                        // shell(epsilon) 
                        clad(xi) children(0);
                        // shell(epsilon) 
                        clad(yi) children(1);
                    }
                }
            }
        }
    }
    
    module unionIntersection(r, detail = 5,  epsilon = 1e-6,showOperands = true) {
        %if (showOperands){children(0);
        children(1);}
 
                    clad(r,30) inset(r,70)
                     hull()intersection() {
                           children(0);
                           children(1);
                    }
 
    }
    
    // unionRound helper expand by r
    module clad(r,q=70) {
        minkowski() {
            children();
            //        icosphere(r,2);
             isosphere(r,q); 
        }
    }
    // unionRound helper
    module shell(r,q=70) {
        difference() {
            clad(r,q) children();
            children();
        }
    }
    
    // inset 3d  "negative offset", optimally on convex hull
    // else jagged inner corners by q quality factor 
    module inset(r,q=20){
    a= generatepoints(q)*r;
    //#children();
    intersection_for(t=a){
      translate(t ) children();
    }
}
    
    
    /*    
    // The following is a sphere with some equidistant properties.
    // Not strictly necessary

    Kogan, Jonathan (2017) "A New Computationally Efficient Method for Spacing n Points on a Sphere," Rose-Hulman Undergraduate Mathematics Journal: Vol. 18 : Iss. 2 , Article 5.
    Available at: https://scholar.rose-hulman.edu/rhumj/vol18/iss2/5 */
    
    function sphericalcoordinate(x,y)=  [cos(x  )*cos(y  ), sin(x  )*cos(y  ), sin(y  )];
    function NX(n,x)= 
    let(toDeg=57.2958,PI=acos(-1)/toDeg,
    start=(-1.+1./(n-1.)),increment=(2.-2./(n-1.))/(n-1.) )
    [ for (j= [0:n-1])let (s=start+j*increment )
    sphericalcoordinate(   s*x*toDeg,  PI/2.* sign(s)*(1.-sqrt(1.-abs(s)))*toDeg)];
    function generatepoints(n)= NX(n,0.1+1.2*n);
    module isosphere(r,detail){
    a= generatepoints(detail);
    scale(r)hull()polyhedron(a,[[for(i=[0:len(a)-1])i]]);
    }
