r=10;
epsilon = 1e-6;
difference(){
clad(r) translate([01,30,50])sphere(100);
#cladx(r*4 )translate([01,30,50]) sphere(100);
}



module clad(r) {
        minkowski() {
            children();
            //        icosphere(r,2);
             isosphere(r,70); 
        }
    }
    
    module cladx(r) {
        minkowski() {
            children();
               cube([epsilon,r,r],center=true); 
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
