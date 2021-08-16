$fn=8;
%square(180);

linear_extrude(15)offset(delta=.5 , chamfer=true
)offset(-.5 , chamfer=true){
    $fn=16;
translate([4,4])difference(){
translate([14,14])circle(27.9/2);
translate([14-1,14+1])circle(24/2);
    
    
    }
    translate([146,146])difference(){
translate([14,14])circle(27.9/2);
translate([14-1,14+1])circle(24/2);
    
    
    }}
linear_extrude(2){
difference(){
translate([10,-10])hull(){
 translate([9,9]) translate([14,14])circle(20/2);
     translate([141,141])   translate([14,14])circle(20/2);
     translate([110,110])   translate([-24,24])circle(30/2);
     translate([70,70])   translate([-24,24])circle(30/2);
    translate([130,130])   translate([5,-5])circle(30/2);
     translate([50,50])   translate([5,-5])circle(30/2);
    
    }    
    
 translate([4,4])     translate([14-1,14+1])circle(24/2, $fn=16);
 translate([146,146])  translate([14-1,14+1])circle(24/2, $fn=16);
    
    
    }}