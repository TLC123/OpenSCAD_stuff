intersection(){
import("bunny.stl", convexity=3);
translate ([0,0,-100])%minkowski(){

cylinder(100,50,0);
import("bunny.stl", convexity=3);
}
}