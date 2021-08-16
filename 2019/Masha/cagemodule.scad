$fn=30;  


intersection(){
//scale([0.8,0.8,0.85])cage(40);
}

 intersection(){
//scale([3,3,0.9])sphere(100);
//scale([0.9,3,3])sphere(100);
//scale([3,0.9,3])sphere(100);
//cage(70);
web();
 

} 
//intersection(){
////scale([3,3,0.9])sphere(100);
////scale([0.9,3,3])sphere(100);
////scale([3,0.9,3])sphere(100);
//
//
////cage(70);
//rotate([0,90,0])web();
// 
//
//}
//intersection(){
////scale([3,3,0.9])sphere(100);
////scale([0.9,3,3])sphere(100);
////scale([3,0.9,3])sphere(100);
////cage(70);
//translate([1e-8,1e-8,1e-8])rotate([90,0,0])web();
//
//}

module cage(r)
{
union(){
cylinder(300,60,60,center=true);

hull(){
cylinder(300,60,60,center=true);
translate([(100-r),(100-r),(100-r)])scale([1,1,1])sphere((r));
translate([-(100-r),(100-r),(100-r)])scale([1,1,1])sphere((r));
translate([-(100-r),-(100-r),(100-r)])scale([1,1,1])sphere((r));
translate([(100-r),-(100-r),(100-r)])scale([1,1,1])sphere((r));
 translate([(100-r),(100-r),-(100-r)])scale([1,1,1])sphere((r));
translate([-(100-r),(100-r),-(100-r)])scale([1,1,1])sphere((r));
translate([-(100-r),-(100-r),-(100-r)])scale([1,1,1])sphere((r));
translate([(100-r),-(100-r),-(100-r)])scale([1,1,1])sphere((r));
 }}
}

module web(){
linear_extrude (25,center=true,convexity=15)offset(r=-7,$fn=7)offset(r=+7,$fn=4)
for(i=[-90:30:90])
{
translate([i,0,0])square([3,250],center= true);
translate([0,i,0])square([250,3],center= true);

}
}