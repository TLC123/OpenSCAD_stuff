 BBoxDetranslate() translate([30,0,1])rotate([10,02,30])cylinder(10,1,1);
 
 module BBoxDetranslate(){
     #children();
     scale(.5)
     minkowski(){
     children();
     mirror([1,0,0])
     mirror([0,1,0])
     mirror([0,0,1])
     children();
     
     }
     }
 
module inset(r,q=20){
  a= generatepoints(q)*r;
//#children();

intersection_for(t=a){
      translate(t ) children();
    }


}


    // unionRound helper expand by r
    module clad(r) {
        minkowski() {
            children();
            //        icosphere(r,2);
             isosphere(r,20); 
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
