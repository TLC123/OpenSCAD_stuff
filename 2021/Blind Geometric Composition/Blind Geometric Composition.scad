 /* 
 Blind Geometric Composition  Torleif Ceder / TLC123 late summer 2021

 Within OpenSCAD the parameter evaluation is blind to resultant geometry.
 Here i collect operations that can reason and store result in intermediate shapes
 Thin slivers of epsilon thickness plays a important roll as 2d planes.
 We cannot scale  object in place without also translating them.
 We cannot rotate object in place without also translating them.
 
 Lets build up a language of blind operations.  
 clad()
 inset()
 shell()
 
 From this we can construct a solid boundingbox
 That gives we can select the epsilon thic wall on each side
 
 BBoxUnTranslate()
 Strips the bounding box of translation and fix it to the origo.
 Frward caled a neutralized bounding box
 There we can scale it to half size or epsilon thin features

 BBoxHalf()
 Those can then be minkowski composed with one perpendicular thin wall slice.
 This effectively blindly replicates a boundingbox identical to the original but now translated half its own size without ever measuring itts dimentions. Pure mathemagics.

 Each bounding wall can be minkowski-summed 
 with a neutrilzed boundingbox, freely arbitrary in the face normal direction.
 
 Thereby we show that any cube within the bounding box
 can be constructed by intersecting a overlaping set of expanded boundingwalls
 
 Whith this language we can construct epsilon thin midplanes, axises, midpoints. Any any epsilon small cube in the bounding box can be minkowskied with arbitrary geomety. 
 
 more to come
 
 */
range=[-1:1];
for(x=range,y=range,z=range){
translate([x,y,z]*10)
if(abs(x)+abs(y)+abs(z)==1)BBoxHalf([x,y,z])translate([-10,20,30])cube(10);

}
 module BBoxHalf(d,  epsilon = 1e-6){
     crossscale=
         abs(d.x)==1?[1,epsilon,1]:
         abs(d.y)==1?[epsilon,1,1]:
         [epsilon,1,1];
     crosswall=
         abs(d.x)==1?[0,0,1]:
         abs(d.y)==1?[1,0,0]:
         [1,0,1];
     intersection(){
            color("red")children();

            minkowski(){    
                BBoxWall(d)
                    children();
                scale(crossscale)
                    BBoxUnTranslate() 
                        BBoxWall(crosswall)
                            children();
            }
} 
}
 
 
 



module BBoxWall(d=[0,0,1],  epsilon = 1e-6)
{
difference(){
    
   translate(d*epsilon)
    children();
    children();
    }    
    
    }


// relocates bounding box  to the origo
module BBoxUnTranslate(){
//         % hull()children();
     scale(.5)
         minkowski(){
            hull() children();
             mirror([1,0,0])      mirror([0,1,0])      mirror([0,0,1])
            hull() children();
         
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


    // unionRound helper expand by r  "positive offset" fast on convex hull
    module clad(r,q=20) {
        minkowski() {
            children();
            //        icosphere(r,2);
             isosphere(r,q); 
        }
    }
    // unionRound helper
    module shell(r,q) {
        difference() {
            clad(r,q) children();
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
