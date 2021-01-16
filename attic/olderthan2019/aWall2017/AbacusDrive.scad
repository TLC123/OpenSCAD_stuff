$fn=100;

id=30;
od=40;
icyc=6;
ocyc=8;
rollers=7;
roller=10;
cone=0.1;

step=360/360;


for (i=[0:360/rollers:360])
{rotate([0,0,i])
 translate([od+10+roller*1.5,0,0]){
  rotate_extrude(angle = 360, convexity = 2) hull(){
offset(0.5,$fn=3)offset(-0.5)hull(){
square([roller,0.01]);
translate([roller*cone,-10,0])square([0.01,20] );
}
translate([0,-9,0])square([0.01,16] );
}}
}
difference(){
orace(od,20);


for(i=[0:step:360])
{
hull(){
rotate([0,0,i])translate([40,0,0])
scale([1.1+ (sin(i *ocyc))  ,1,1.1+ (sin(i *ocyc))  ])scale([1,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);

rotate([0,0,(i+step)])translate([40,0,0])
scale([1.1+ (sin((i+step) *ocyc))  ,1,1.1+ (sin((i+step) *ocyc))  ])scale([1,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);
 }
}}
difference(){
 irace(id,20);
for(i=[0:step:360])
{
hull(){
rotate([0,0,i])translate([30,0,0])
scale([1+ (sin(i *icyc)) ,1,1.1+ (sin(i *icyc))  ])scale([1,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);

rotate([0,0,(i+step)])translate([30,0,0])
scale([1+ (sin((i+step)*icyc)) ,1,1.1+ (sin((i+step) *icyc))  ])scale([1.5,1,0.5])rotate([0,45,0])
cube([10,0.1,10],center=true);
}
}}
module orace (ri,ro)
{
 
 rotate_extrude(angle = 360, convexity = 2)
 offset(1,$fn=5)offset(-1 )translate([ri , -ro*0.5 ])square([ro*0.5 ,ro] );
}
module irace (ri,ro)
{
 
 rotate_extrude(angle = 360, convexity = 2)
 offset(1,$fn=5)offset(-1 )translate([ri -ro*0.5, -ro*0.5 ])square([ro*0.5 ,ro] );
}