for (i=[1:120:360]){
    rotate(i*2)
  translate([25,6,0])   rotate(i*.7)  knodel();
    
    }
    




module knodel (){
color(skin() )import("Head.stl" );

color("blue",.2) translate([0,-.1,0])render(){ 
intersection (){
    mask();
    translate([0,-11,1.6]) scale([1.25,1,.7])rotate([90,0,0])cylinder(5,3,3);
}

}

  color("yellow")difference(){
mask();

translate([0,-11,1.6]) scale([1.25,1,.7])rotate([90,0,0])cylinder(5,3,3);
}

 * color("yellow"){
      translate([5.3,-7,3]) rotate([0,-70,-18])scale([1.45,1.45,.5])sphere(3);
   mirror([1,0,0]) translate([5.3,-7,3]) rotate([0,-70,-18])scale([1.45,1.45,.5])sphere(3);
  }
  }
  
  
  module mask(){
      hull(){
    nasmou();
                   translate([5,-7,3]) rotate([0,-70,-20])scale([1.5,1.5,.5])sphere(3);
   mirror([1,0,0]) translate([5,-7,3]) rotate([0,-70,-20])scale([1.5,1.5,.5])sphere(3);
    }
      }
module nasmou(){
translate([0,-11,2.4]) scale(1.05) translate(-[0,-11,2.4])  intersection(){

 union(){
import("Head.stl" );
 
}

translate([0,-11,2.4])scale([2,1.25,.85])sphere(5.5);
    
    }
    }
    
    
    function skin() =
let (sho = (rands(0, 1, 3)), mix = sho / (sho.x + sho.y + sho.z))(mix[
        0] * [255, 224, 189] / 255 + mix[1] * [255, 205, 148] / 255 +
    mix[2] * [244, 152, 80] / 255) * 0.9;