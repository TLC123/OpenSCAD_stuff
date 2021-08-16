$fn=50;
union(){
linear_extrude(1){
difference(){
difference(){
translate([2,2])square(10);
circle(5);}

color("red")offset(-1)difference(){
translate([2,2])square(10);
circle(5);}
}}
color("red")linear_extrude(2, center = true){


offset(-1)difference(){
translate([2,2])square(10);
circle(5);}
}}