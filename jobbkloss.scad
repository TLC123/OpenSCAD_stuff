$fn=20;
linear_extrude(28)translate([0,3])shape();
linear_extrude(28)translate([0,-15.5])shape2();
linear_extrude(62,scale=1)scale([1,2])translate([0,-15])shape3();
flarp();
mirror([1,0,0])
flarp();


module flarp()
{
    translate([16+1.5,0,61.9])rotate([0,15,0])
translate([0,0,-1])linear_extrude(22,scale=[1,0.9])scale([1,2])translate([0,-15])shape4();
}
module shape(){
difference(){    
    offset(3)square([60,6.5],true);
    square([60,6],true);
   translate([0,3])
 square([50,9],true);
 square([4,69],true);
    
    
    }}
    
    module shape2(){
    offset(1.8)    offset(-1.4){
     difference(){
    
   offset(3) square([32,24],true);
   translate([0,0]) square([32,24],true);
     translate([0,15])     square([3,20],true);

    }}
}


    module shape3(){
    offset(1.8)    offset(-1.4){
     difference(){
    
   offset(3) square([32,24],true);
   translate([0,-1]) square([32,39],true);
    }}
}

module shape4(){
    
     offset(1.8 -1.4)offset(1.5)  square([0.0001,24+1.25],true);
    
    }