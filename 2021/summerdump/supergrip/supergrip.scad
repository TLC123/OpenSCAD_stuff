r=(1-$t*2) *-50;
r2=-max(0,-r);
rotate([r2,0,0])translate([0,-6,200]){
scale(2){
  rotate([-r2,-0,0]){grip();
  
    cylinder(2,4,4);
mirror ([1,0])grip();}}
translate([0,6,-15])rotate([-90,0,0])back();
}
rotate([0,90,0])cylinder(200,5,5,true);

translate([0,30,0]){
rotate([r2,0,0])translate([0,-6,200]){
   rotate([-r2,-0,0]){ 
  hull(){
    translate([0,3,-5])cylinder(2,4,4); 
    translate([0,-30,-5])cylinder(4,4,4);}
}

translate([0,6,-15])rotate([-90,0,0])back();
}
rotate([0,90,0])cylinder(200,5,5,true);
}


translate([0,-28,max(0,pow((.8-$t),2)*130-5)+1])
rotate([2*max(.5,(1-$t)),5*max(.5,(1-$t)),90*min(.5,$t)])
{
cylinder(220,18,18);
translate([0,0,205])cube([70,20,1],true);
translate([0,0,205])cube([20,70,1],true);
}

module gripbase(){
rotate(min(0,(r-45)*.5))translate([0, -11])difference()
{
    
intersection(){
translate([0,4])scale([1.2,1.6])circle(9);
 circle(14);
}

circle(9);
translate([0,-9])circle(4);
translate([0, 11])scale([1,2])circle(4);
translate([0,-10])square(40);

}}

module grip(){
      linear_extrude(5,center=true)
 difference(){
   offset(.5)gripbase();
  offset(-.5) gripbase();
    }
    }

module back ()
{
     linear_extrude(5,center=true)
    difference(){
     offset(3)base();
 
   offset(3)offset(-3)           union(){ 
    difference(){ 
         base();
    
    for(y=[-5:20:250]){
    translate([0,y])square([150,2],true);
    }
       
    }
 
    }

}
    }
    
    
    
    module base(){
difference(){        
      offset(3) hull(){
    square(10,true);
  translate([0,180,0])  square([150,5],true);
    }
    
        hull(){
translate([0,20,0])  square([20,10],true);
        translate([0,210,0])  square([130,5],true);
    }
    
}}