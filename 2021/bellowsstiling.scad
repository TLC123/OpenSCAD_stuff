cylinder(40,20,20);
for(t=[0:20:30]){
translate([0,0,t])
{
hull(){
cube([80,40,.03],center=true);
translate([0,0,10])rotate(90)cube([80,40,.03],center=true);
}
translate([0,0,10])hull(){
translate([0,0,10])cube([80,40,.03],center=true);
rotate(90) cube([80,40,.03],center=true);
}}}

translate([0,0,30])hull(){
translate([0,0,10])cube([80,40,.03],center=true);
translate([0,0,25])scale(([.8,.01]))cube([80,40,.03],center=true);
}