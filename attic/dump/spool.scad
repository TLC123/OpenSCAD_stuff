difference(){
    linear_extrude(100,scale=3,twist=0,convexity=0100){
difference(){
    circle(10);
  
}} 
translate( [0,0,-5])
linear_extrude(210,slices=20, twist=45,convexity=100){
square([120,4]);
mirror( [0,-1,0])square([120,4]);
}
translate( [0,0,-5])cylinder(300,6,6);
}