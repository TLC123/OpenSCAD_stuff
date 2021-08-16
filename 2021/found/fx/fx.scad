//For F9 v1.2:
//Total length: 70 m
//first stage (full length of the stage incl. engines) 40,5 m
//interstage 6,7 m 
//2nd stage 9,3 m (length of the outer skin visible on a stacked rocket, so excl engine)
//These are ±0.5 m due to distortion in the photos I used.
//3.66
//42.6 m (47m w/ Interstage)



color("grey")engineassembly();
color("darkgrey") intersection()
{translate([0,0,2]) cylinder(10,2.5,1.86,$fn=50);
translate([0,0,2+6])cube([3.6,3.6,12],center=true);
}



color("lightgrey")
{translate([0,0,2]) cylinder(42.7,1.86,1.86,$fn=50);
}
color("darkgrey")translate([0,0,2+42.7]) cylinder(4.3,1.86,1.86,$fn=50);

color("lightgrey")translate([0,0,2+47]) cylinder(9.3,1.86,1.86,$fn=50);


module engineassembly(){

translate([0,0,0])rap();
rotate([0,0,45*0])translate([1.6,0,0])rap();
rotate([0,0,45*1])translate([1.6,0,0])rap();
rotate([0,0,45*2])translate([1.6,0,0])rap();
rotate([0,0,45*3])translate([1.6,0,0])rap();
rotate([0,0,45*4])translate([1.6,0,0])rap();
rotate([0,0,45*5])translate([1.6,0,0])rap();
rotate([0,0,45*6])translate([1.6,0,0])rap();
rotate([0,0,45*7])translate([1.6,0,0])rap();
  

}















module rap(){
rotate_extrude(,$fn=25){
translate([0.4,1.2])circle(.13,$fn=25);
hull(){
translate([0.2,1.5])circle(.15,$fn=25);
translate([0.2,1.7])circle(.15,$fn=25);
}
translate([0.0,1])square([0.2,1]);
intersection(){
square([1.7/2,1.8]);
difference(){
translate([-3.56,-1])circle(4.3,$fn=150);
translate([-3.4,-1.2])circle(4.15,$fn=50);
}

}}}