a=50;
$fn=60;
clearance=.75;
exc=[1.0,1.];
linear_extrude(40){
   offset(1)offset(-1) difference(){
    block();
    offset(clearance)bar();
    mirror([1,0])offset(clearance)bar();
    }
 color("blue") bar();
  mirror([1,0])color("blue") bar();
}

module block(){
    offset(-3)offset(3)
difference(){
    offset(5)offset(-5) square([180,110],true);
square([96,60],true);
 translate([0,30])square([96,60],true);
}
{
 


 
 translate([-60,-14])
rotate(a)
{
 translate([40,0]){
    rotate(-a) translate([7.5,20])square([25,70],true);
    rotate(-a) translate([1.5,21])square([25,70],true);
 }
}
 translate([60,-14])
rotate(-a)
{
 translate([-40,0]){
 
rotate(a) translate([-7.5,20])square([25,70],true);
rotate(a) translate([-1.5,21])square([25,70],true);
 }
}



}}




module bar(){
    offset(-3)offset(3)
translate([-60,-14]){
 translate([0,0])
rotate(a)
{
    hull(){
 translate([0,0])circle(5); 
 translate([40,0])circle(5); 
}

     {
 translate([0,0])scale(exc)circle(10); 
 translate([40,0])scale(exc)circle(10); 
         
         
}}


 translate([0,40])
rotate(a)
{
    hull(){
 translate([0,0])circle(5); 
 translate([40,0])circle(5); 
} translate([0,0])scale(exc)circle(10); 
 translate([40,0])scale(exc)circle(10); }
 
 }}