
 
intersection (){
rotate(rands(-60,60,3))translate(rands(-10,10,3))cube(rands(10,40,3),center=true );
rotate(rands(-60,60,3))translate(rands(-10,10,3))torus(rands(10,20,1) [0],rands(3,10,1) [0]) ;
}
 


module torus(a,b)                  {
    
    rotate_extrude(convexity=100)translate([a,0,0])circle(b);
    }