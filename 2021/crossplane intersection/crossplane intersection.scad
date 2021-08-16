translate([-10,0,0])
    intersect_planes(h=26){
     
      square([40,8],center=true);       //XY
      circle(5.5);                      //YZ
      text("OK!",halign="center",valign="center"); // XZ
    }
translate([30,0,0])
    show_intersect_planes(h=26){
      text("XY",halign="center",valign="center"); 
      text("YZ",halign="center",valign="center"); 
      text("XZ",halign="center",valign="center"); 
    }

module intersect_planes(h ){
intersection(){
color("blue") 
    linear_extrude(h,center=true,convexity=20)children(0);
color("red") rotate([0,-90,0])rotate(-90)
    linear_extrude(h,center=true,convexity=20)children(1);
color("green")   rotate([90,0,0]) 
    linear_extrude(h,center=true,convexity=20)children(2);
}    }
    
module show_intersect_planes(){  
union(){
color("blue") 
    linear_extrude(h,center=true,convexity=20)children(0);
color("red") rotate([0,-90,0])rotate(-90)
    linear_extrude(h,center=true,convexity=20)children(1);
color("green")  rotate([90,0,0]) 
    linear_extrude(h,center=true,convexity=20)children(2);
}
}