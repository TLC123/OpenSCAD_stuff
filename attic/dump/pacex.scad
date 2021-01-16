O=4;




difference(){
color("red")
linear_extrude(109,convexity=150)difference(){
  offset(-O)offset(2*O)offset(-O)  circle(20,$fn=12);
  offset(-O)offset(2*O)offset(-O)  circle(19,$fn=12);
    
}
linear_extrude(109,twist=720,slices=400,convexity=150)square([30,5]);
}