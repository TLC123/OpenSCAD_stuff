difference(){
 translate([100,0,0])sphere(10,$fn=50);
 scale(1)import("sphere.stl",convexity=10);
//import("tag1.stl");
}