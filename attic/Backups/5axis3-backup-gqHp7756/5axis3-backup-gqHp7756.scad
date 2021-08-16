
slice(){
dof();
difference(){
dof();
translate([0,1])dof();
}}

module slice(n=10)
{
children([0]);

if(n>0)translate([0,0,1])slice(n-1){
union(){
offset(-1)children([0]);
children([1]);//Undersides
}
//Undersides
difference(){
children([0]);
translate([0,1])children([0]);
}}


}












module dof(){
scale(6){
difference(){
offset(-3,$fn=50)union(){square(10);
circle(7);}
translate([-3,0,0])circle(1);
translate([2,4,0])circle(1);}
translate([5,0,0])circle(1);}
}

