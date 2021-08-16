W=[true,true,true,true];
G=[true,true,true,true];
I=[false,true,true,true];



translate([96.5*5,95.5*5,0])translate([5,5,0]){cylinder(51,5,5);
translate([0,0,51])sphere(6);}

 
color("Red") piece(W,G,I);
 


module piece(W,G,I){
rotate([0,0,0]) quart(G[0],I[0]);
rotate([0,0,90]) quart(G[1],I[1]);
rotate([0,0,180]) quart(G[2],I[2]);
rotate([0,0,270]) quart(G[3],I[3]);
cylinder(45,5,5);
translate([0,0,44])sphere(6);
}


module quart(g,i){
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

if(i==true){
linear_extrude(40, convexity = 5){
polygon([[20,-20],[20,19.5],[22.5,22],[25,19.5],[25,-20],[22.5,-22.5]]); }
}
else {difference(){

linear_extrude(40, convexity = 5){
polygon([[20,-20],[20,19.5],[22.5,22],[25,19.5],[25,-20],[22.5,-22.5]]); }
union() {
translate([10,-12.5,5])cube([25,25,25]);
translate([25,0,25])rotate([0,90,0])cylinder(30,12.5,12.5,center=true);
}
}}


if(g==true){
linear_extrude(40, convexity = 5)rotate([0,0,-90])
polygon([[20,-20],[20,20],[22.5,22.5],[25,20],[25,-20],[22.5,-22.5]]);}
else {difference(){

linear_extrude(40, convexity = 5){
rotate([0,0,-90])polygon([[20,-20],[20,20],[22.5,22.5],[25,20],[25,-20],[22.5,-22.5]]); }
rotate([0,0,-90])union(){
translate([10,-12.5,5])cube([25,25,25]);
translate([25,0,25])rotate([0,90,0])cylinder(30,12.5,12.5,center=true);}
}}
}}}
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
function dice()=round (rnd(2.2))==1?false:true;
function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];