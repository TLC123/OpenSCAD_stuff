intersection(){
import("bunny.stl", convexity=3);
translate ([0,0,-100])%minkowski(){
hull(){import("bunny.stl", convexity=3);
}
cylinder(100,50,0);
}
}