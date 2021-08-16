    ////////////////////////////////////////////////////////
    /*
    unionRound() Module by Torleif Ceder - TLC123 late summer 2021
     Pretty fast Union with radius, But limited to a subset of cases
    Usage 
     unionRound( radius , detail , epsilon )
        {
         YourObject();
         YourObject(); 
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
    for (i=[0:6])unionRound(1.5, 5) {
     translate([0,0,-1]+rands(0, 1e-6,3))cube([17 ,17,2],true);// debug, rands to void cache
     rotate(i*60)  translate([6,0,0]) rotate([20,-10,0])cylinder(5,1,1,$fn=12);
    }
    // end of demo code
    //
    module unionRound(r, detail = 5) {
        epsilon = 1e-6;
        children(0);
        children(1);
        step = 90 / detail;
           unionRoundRecursiveLoopWorker(r,step,detail-1)
   {
        children(0);
        children(1);
        }
 
    }
 module unionRoundRecursiveLoopWorker(r,step,i)
    {
        union(){
        if(i>0)    unionRoundRecursiveLoopWorker(r,step,i-1){children(0);children(1);}
          {
                x = r - sin(i * step ) * r;
                y = r - cos(i * step ) * r;
                xi = r - sin((i * step + step)  ) * r;
                yi = r - cos((i * step + step)  ) * r;
//               x =   sin(i * step ) * r/2;
//                y =   cos(i * step ) * r;
//                xi =   sin((i * step + step)  ) * r/2;
//                yi =   cos((i * step + step)  ) * r;
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
    
    // unionRound helper expand by r
    module clad(r) {
        minkowski() {
            children();
            //        icosphere(r,2);
             isosphere(r,70); 
        }
    }
    // unionRound helper
    module shell(r) {
        difference() {
            clad(r) children();
            children();
        }
    }
    
    /*
A New Computationally Efficient Method for Spacing n Points on 
a Sphere - Jonathan Kogan  */
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
   