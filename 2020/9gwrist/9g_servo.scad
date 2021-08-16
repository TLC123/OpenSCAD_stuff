if (false) assembly();
else partial();
    


module partial(){
    
        baseboard();
gear();
      translate([-6,10,0])  center();
    
    }


module baseboard(){
  translate([0,0,-20])   difference(){		
   cube([20,48,5 ],center=true);
       rotate([90,0,0])    cylinder(120,1,1,center=true,$fn=4); 
    translate([6,0,0])   rotate([90,0,0])    cylinder(120,1,1,center=true,$fn=4); 
    translate([-6,0,0])   rotate([90,0,0])    cylinder(120,1,1,center=true,$fn=4); 
        
        
        }

}
module assembly()
{
    
    baseboard();
    rotate(  [0,0,0])gear();
rotate(  [0,120,0])gear();
//rotate(  [0,-120,0])gear();
rotate(  [90,0,0])gear();
rotate(  [-90,0,0])gear();

center();


rotate(  [0,-90,0])                 {
rotate(  [-90,0,0]) 9g_motor();
rotate(  [ 90,0,0]) 9g_motor();
}

 }


module 9g_motor(){
translate([0,0,-6.325*2])translate([-5.5,0, -18])difference(){			
		union(){
			color("blue") cube([23,12.5,22], center=true);
			color("blue") translate([0,0,5]) cube([32,12,2], center=true);
			color("blue") translate([5.5,0,2.75]) cylinder(r=6, h=25.75, $fn=20, center=true);
			color("blue") translate([-.5,0,2.75]) cylinder(r=1, h=25.75, $fn=20, center=true);
			color("blue") translate([-1,0,2.75]) cube([5,5.6,24.5], center=true);		
			color("white") translate([5.5,0,3.65]) cylinder(r=2.35, h=29.25, $fn=20, center=true);				
		}
		translate([10,0,-11]) rotate([0,-30,0]) cube([8,13,4], center=true);
		for ( hole = [14,-14] ){
			translate([hole,0,5]) cylinder(r=2.2, h=4, $fn=20, center=true);
		}	
	}
}

module gear(){
    
translate([0,0,-6.325*2]) difference(){
union(){
    cylinder(6.325,8,4);
scale(.5)translate([0.0,1,-21]) import("D:/g/OpenSCAD/attic/2020/9gwrist/Bottom_Gear2.stl",convexity=10);
}
 cylinder(19,2.5,2.5,center=true,$fn=32);
 
}}

module center(){
    
    rotate(  [0,0,0])corpart();
    rotate(  [0,120,0])corpart();
    rotate(  [0,-120,0])corpart();
 
}    

 
    
    
    module corpart(){
        difference(){
            
            hull(){
translate([0,0,-2])cube(6,center=true);
translate([0,0,-4])cube(4.5,center=true);
}    
       cylinder(20,1,1,center=true,$fn=4); }}