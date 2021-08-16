$fn=40;
main();

module main(){
translate ([17.5,-25,29])rotate([-90,0,0])insert();
translate ([-17.5,-25,29])rotate([-90,0,0])insert();
difference(){
union(){
rotate([90,0,0])linear_extrude(30,center=true,convexity=20)bottomprofile1();
rotate([90,0,0])linear_extrude(40,center=true,convexity=20)bottomprofile2();
translate ([0,0,10]) rotate([90,0,0])linear_extrude(40,center=true,convexity=20)topprofile2();
translate ([0,0,10]) rotate([90,0,0])linear_extrude(30,center=true,convexity=20)topprofile1();
}
 translate([-30, 7.5,30])cylinder(100,2.25,2.25,center=true);
 translate([ 30, 7.5,30])cylinder(100,2.25,2.25,center=true);
 translate([ 30,-7.5,30])cylinder(100,2.25,2.25,center=true);
 translate([-30,-7.5,30])cylinder(100,2.25,2.25,center=true); 
 translate([  0, 15, 30])cylinder(100,2.25,2.25,center=true);
 translate([  0,-15, 30])cylinder(100,2.25,2.25,center=true);

}}

module insert(){ difference()
{color("blue"){
cylinder(5,10,10);
cylinder(45,7.5,7.5);}
translate([0,0,-0.01])cylinder(45.04,5.5,5.5);
 }}
module bottomprofile1()
{ 
difference(){
union(){polygon([[0,5],[25,5],[20,0],[42.5,0],[42.5,12.5],[35,15],[35,25],[0,25]]);
mirror()polygon([[0,5],[25,5],[20,0],[42.5,0],[42.5,12.5],[35,15],[35,25],[0,25]]);
}
translate ([17.5,25])circle(7.5);
translate ([-17.5,25])circle(7.5);
}}


module bottomprofile2(){
difference(){
union(){intersection(){
 square([70,50],center=true);
union(){ hull(){
translate ([17.5,25])circle(12.5);
translate ([-17.5,25])circle(12.5);
}
translate ([0,12.5])square(15,center=true);
}
}
}
translate ([17.5,25])circle(7.5);
translate ([-17.5,25])circle(7.5);
}}
module topprofile1()
{ difference(){translate ([0,25])
hull(){

translate ([0,5.75]) square([70,11.5],center=true);
translate ([0,6.25])  square([68,12.5],center=true);
}
translate ([17.5,25])circle(7.5);
translate ([-17.5,25])circle(7.5);
}
}
 
module topprofile2(){
difference(){
union(){intersection(){
 translate ([0,50]) square([70,50],center=true);
union(){ hull(){
translate ([17.5,25])circle(12.5);
translate ([-17.5,25])circle(12.5);
}
translate ([0,12.5])square(15,center=true);
}
}
}
translate ([17.5,25])circle(7.5);
translate ([-17.5,25])circle(7.5);
}}

