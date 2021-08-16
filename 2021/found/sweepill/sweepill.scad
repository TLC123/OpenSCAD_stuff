color("Yellow",1){
rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);
translate([200,0,0]) rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);




}
//color("Blue",1) 
translate([135,0,0]) rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);

 

//color("Blue",1)translate([100,0,0]) rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);
//color("Blue",1)translate([90,0,0]) rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);
//color("Green",1)translate([85,0,0]) rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);





#hull(){
 rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);
translate([200,0,0]) rotate([-10,-20,-5])scale([100,10,10])rotate([10,10,0])cube(center=true);}

color("Red")           {
translate([200,-10,0])sphere(7);
translate([0,-10,0])sphere(7);
translate([135,-10,0])sphere(7);


translate([135,-10,50])sphere(7);
*translate([85,-10,0])sphere(7);

hull(){translate([200,-10,0])sphere(3);
translate([0,-10,0])sphere(3);}
hull(){translate([135,-10,0])sphere(3);
translate([135,-10,50])sphere(3);}

}
color("Black")           {
translate([135,-20,50])rotate([90,0,0])text("P");
translate([0,-20,0])rotate([90,0,0])text("a");
translate([200,-20,0])rotate([90,0,0])text("b");
translate([135,-20,0])rotate([90,0,0])text("ba");
*translate([65,-20,10])rotate([90,0,0])text("better ba");
}