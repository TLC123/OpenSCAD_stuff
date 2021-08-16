color("Red"){translate([4,4,0]){cylinder(51,5,5);
translate([0,0,51])sphere(6,center=true);}
translate([96.5*5,0,0])translate([4,4,0]){cylinder(51,5,5);
translate([0,0,51])sphere(6,center=true);}
translate([0,95.5*5,0])translate([5,5,0]){cylinder(51,5,5);
translate([0,0,51])sphere(6,center=true);}
translate([96.5*5,95.5*5,0])translate([5,5,0]){cylinder(51,5,5);
translate([0,0,51])sphere(6,center=true);}

intersection(){
translate([5,5,-0.1])cube([100*5-20,100*5-20,50]);
 for (y=[0:100:100*4]){for (x=[0:100:100*4]){
color("Red")translate([x+45,y+45,0])piece();
}

}
}
intersection(){
translate([5,-1.1,-0.1])cube([100*5-10,100*5+2,60]);
for (x=[0:100:100*4]){
color("Red"){

translate([x-2.25 ,0 ,0])linear_extrude(47, convexity = 5)square([89.5,5]);
translate([x-2.25 ,0 ,0.001])linear_extrude(5, convexity = 5)square([89,15]);

}
color("Red"){
translate([x+2.75 ,100*5-19 ,0])linear_extrude(47, convexity = 5)square([89.5,5]);
translate([x+2.75 ,100*5-25 ,0.001])linear_extrude(5, convexity = 5)square([89,10]);
}}}
translate([100*5,0,0])rotate([0,0,90]) intersection(){
translate([5,-1,-0.1])cube([100*5-19,100*5,60]);
for (x=[0:100:100*4]){
color("Red"){

translate([x-2.25 ,10 ,0])linear_extrude(47, convexity = 5)square([89.5,5]);
translate([x-2.25 ,10 ,0.001])linear_extrude(5, convexity = 5)square([89,15]);

}
color("Red"){
translate([x+2.75 ,99*5 ,0])linear_extrude(47, convexity = 5)square([89.5,5]);
translate([x+2.75 ,99*5-10 ,0.001])linear_extrude(5, convexity = 5)square([89,10]);
}}};


}
module piece(){rotate([0,0,0]) quart();
rotate([0,0,90]) quart();
rotate([0,0,180]) quart();
rotate([0,0,270]) quart();
cylinder(45,5,5);
translate([0,0,44])sphere(6,center=true);
}


module quart(){
$fn=15;
translate([22.5,22.5]){
linear_extrude(5, convexity = 5){
offset(r=2)offset(r=-6)offset(r=4){ difference(){
translate([1,-1.25,-0])square([42.5,42],center=true);
rotate([0,0,90])translate([15,0,0]) circle(5);

}translate([-1,-22.5,-0])square([42.5,5],center=true);

hull(){
translate([30,0,0]) circle(4.75);
*translate([20,0,0]) circle(1);}}
}
translate([-0.25,0.25,0]){

if(dice()==true){
linear_extrude(40, convexity = 5){
polygon([[20,-20],[20,19.5],[22.5,22],[25,19.5],[25,-20],[22.5,-22.5]]); }
}
else {difference(){

linear_extrude(40, convexity = 5){
polygon([[20,-20],[20,19.5],[22.5,22],[25,19.5],[25,-20],[22.5,-22.5]]); }
union() {
translate([20,-12.5,5])cube([15,25,25]);
translate([25,0,25])rotate([0,90,0])cylinder(30,12.5,12.5,center=true);
}
}}


if(dice()==true){linear_extrude(40, convexity = 5)rotate([0,0,-90])polygon([[20,-20],[20,20],[22.5,22.5],[25,20],[25,-20],[22.5,-22.5]]);}
else {difference(){

linear_extrude(40, convexity = 5){
rotate([0,0,-90])polygon([[20,-20],[20,20],[22.5,22.5],[25,20],[25,-20],[22.5,-22.5]]); }
union(){
translate([20,-12.5,5])cube([15,25,25]);
translate([25,0,25])rotate([0,90,0])cylinder(30,12.5,12.5,center=true);}
}}
}}}
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
function dice()=round (rnd(1.77))==1?false:true;
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];