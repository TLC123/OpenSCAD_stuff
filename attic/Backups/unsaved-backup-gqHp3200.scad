$fn=80;
 translate([6,0,0])rotate(45)cube(13,center=true);
 translate([-10,0,0])cube([16,4,12],center=true);



minkowski(){
sphere(1,$fn=40);
difference(){
minkowski(){
sphere(4,$fn=40);
intersection(){
translate([6,0,0])rotate(45)cube(13,center=true);
translate([-10,0,0])cube([16,4,12],center=true);
}
}

minkowski(){
sphere(2,$fn=40);
intersection(){
translate([6,0,0])rotate(45)cube(13,center=true);
translate([-10,0,0])cube([16,4,12],center=true);
}
}}}