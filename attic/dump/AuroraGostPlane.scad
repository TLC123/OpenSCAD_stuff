$fn=60;
r=80;
scale([1,.25,4])

rotate_extrude()intersection(){
    translate([0,-r])square([r,r*2]);
difference(){
    circle(30);
    
   rotate(-45) translate([r+7,0,0])circle(r);
}}