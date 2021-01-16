$fn=12;
ins=1.8+1.5;

module basecard(){
offset(2)offset(-2)square([68,82],center = true);
}


linear_extrude(2)
offset(1) basecard();
translate([0,0,0])    linear_extrude(2) offset(-2)offset(2)
difference(){
 offset(2)  basecard();
 
scale([2,1])   offset(-8)basecard(); 
scale([1,2])   offset(-8)basecard(); 
}
linear_extrude(3.5)difference(){
 offset(2)  basecard();
 offset(1)  basecard();
 
}
for(x=[-1:2:1],y=[-1:2:1])
translate([(34-ins)*x,(41-ins)*y,2]){
cylinder(1.5,2,2);
cylinder(5,1.5,1.25);
    }
linear_extrude(13) offset(-2)offset(2)
difference(){
offset(2)    basecard();
offset(1)basecard();
scale([2,1])   offset(-8)basecard(); 
scale([1,2])   offset(-8)basecard(); 
}    
    
 translate([80,0,14])mirror([0,0,1])   
color("red")
    {



for(x=[-1:2:1],y=[-1:2:1])
translate([(34-ins)*x,(41-ins)*y,2]){
    
    difference()
{ translate([0,0,4])cylinder (7,2,3);
    
    cylinder(1.5,2,2);
cylinder(6,1.5,1.5);
}   }


    
translate([0,0,13])    linear_extrude(1) offset(-2)offset(2)
difference(){
 offset(2)  basecard();
 
scale([2,1])   offset(-8)basecard(); 
scale([1,2])   offset(-8)basecard(); 
}


translate([0,0,12])    linear_extrude(2) offset(-3)offset(3){
difference(){
 offset(.5)  basecard();

scale([2,1])   offset(-8)basecard(); 
scale([1,2])   offset(-8)basecard(); 
} 

difference(){
    offset(-6)  basecard(); 
offset(-20)basecard();
}
}}