//SpaceX HLS moon parking
$fn=40;
 
  $vpr=[90,0,-20];  
  $vpt=[40,0,25];
    convexity=100;
 
    union( ){
 t=max(0,-35+(sin(10+$t*90))*130);   
        for(s=[2:.5:4]){

        
           for(i=[0.1:.1:.8]){
  %translate([i*((t*t)/(90*90))*50,-10,1+i+s])  {
    color([0,0,0,0.02/s*t/60]) scale([2,2,.5])sphere(6-s);
  }


   %translate([i*((t*t)/(90*90))*50,-10,1+i])  {
    color([0,0,0,0.03/s*t/60]) scale([1,1,.5])sphere(6-s);
   



}}
{
translate([((t*t*t*t*t)/(90*90*90*90*90))*2,0,((t*t*t*t*t)/(90*90*90*90*90))*7])
rotate([0,(t*t)/100,0])
x();
}

 {color([1,.6,.2]*.8)cube([300,300,.1],center=true);
 color([1,.6,.2]) translate([40,0,0])hull(){
    
    
   translate([5,0,0]) rotate([5,0,0])cube([10,20,10],center=true);
    cube([30,30,.1],center=true);
    
    }
     mirror([0,1,0])color([1,.6,.2]) translate([40,0,0])hull(){
    
    
   translate([5,0,0]) rotate([5,0,0])cube([10,20,10],center=true);
    cube([30,30,.1],center=true);
    
    }

}}}
module x(){
translate ([0,0,3]){
     


hullx();


flaps();
mirror([0,10,0])flaps();
r=30;
rotate(r)girdle();
mirror([0,10,0])rotate(r)girdle();

    }}
    
   
    
    
    module girdle(){
        th=.15;
       scale([1.125,1,1])  color([.97,.5,.5])rotate([90,0,0])linear_extrude(th*2,center=true,convexity=100){
difference() {
    union() {
 base();
        
    }
   offset(.5) offset(-.5)difference(){
  offset(-th)  base();
      translate([0,-th*3])square([4.5-th*1.5,40]);
translate([4,16])rotate(-120) square([th,50],center=true);
translate([4,11])rotate(29.5) square([th,50],center=true);

 translate([4,18])rotate(-45) square([th,50],center=true);
translate([4,3])rotate(27) square([th,50],center=true);
}}
    }}
    module hullx(){
         color([.7,.7,.7])hull(){
cylinder(30,4.5,4.5);
translate([0,0,50-1])sphere(1);
translate([0,0,36])scale([1,1,1.6])sphere(4.5);
    translate([0,0,50-9])scale([1,1,1.5])sphere(3.8);
}
        }
    
    
    module flaps(){
         rotate(-90) color([.5,.5,.5])hull(){
   
        translate([0,0,49])sphere(0.25);
        translate([0,0,36])sphere(0.25);
        translate([8,0,37])sphere(0.25);
        translate([8,0,41])sphere(0.25);
    }
    rotate(-90) color([.5,.5,.5])hull(){
   
        translate([0,0,21])sphere(0.25);
        translate([0,0,0])sphere(0.25);
        translate([9,0,2])sphere(0.25);
        translate([9,0,10])sphere(0.25);
    }}
    module base(){  offset(1.5)offset(-1)hull() polygon([
     ([8,22]),
        ([4.5,0]),
         ([7.5,4]),
         ([7.5,8]),
         ([8.7,13]),
         ([0,-3]),
    ([0,32])]);}