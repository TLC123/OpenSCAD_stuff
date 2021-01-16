$fn=12;
 
iBeamThat(8,2)
 ioRoundThat(3.8)
    myShape();


module iBeamThat(h=1,r=2.5){
  
difference(){

  color("yellow") linear_extrude(h,center= true,convexity=130)
 children();
    
  color("orange") translate([0,0,-h*0.501])
linear_extrude(h*0.3,convexity=130)
ioRoundThat(r*1.5)     
offset(-r)
    children();
    
  color("orange")mirror([0,0,1])
translate([0,0,-h*0.501])
linear_extrude(h*0.3,convexity=130)
ioRoundThat(r*1.5) 
offset(-r)
    children();
}

}



module ioRoundThat(i=0){

offset(abs(i)*.5)
offset(-abs(i))
offset(abs(i)*.5)
children();
}




module myShape(){
    $fn=32;
    difference(){
        union(){
    hull(){
  translate([0,6,0])  circle(6);
  translate([30,0,0])  circle(8);
    }
    hull(){
  translate([0,0,0])  circle(10);
  translate([-20,20,0])  circle(8);
    }
}
  translate([30,0,0])  circle(4);
  translate([0,0,0])  circle(5);
  translate([-20,20,0])  circle(3);

}
  
    }