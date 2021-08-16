 difference(){

translate([0,-25,0])rotate([-90])linear_extrude (convexity=100)sleve();


hull(){
translate([-20,20,0])rotate([0,90,0])cylinder(40,20,20,center=true);
translate([-20,20,-20])rotate([0,90,0])cylinder(40,20,20,center=true);
translate([-20,-30,0])rotate([0,90,0])cylinder(40,40,20,center=true);
translate([-20,-30,-20])rotate([0,90,0])cylinder(40,40,20,center=true);
}

hull(){
translate([20,0,0])rotate([0,90,0])cylinder(40,15,15,center=true);
translate([20,60,0])rotate([0,90,0])cylinder(40,15,15,center=true);
}
}

 difference(){
hull(){
translate([20,0,0])rotate([0,90,0])cylinder(20,10,10,center=true);
translate([10,0,0])rotate([0,90,0])cylinder(10,16,16);
 translate([10,60,0])rotate([0,90,0])cylinder(5,10,10);
 translate([10,60,0])rotate([0,90,0])cylinder(1,16,16);



translate([3,0,19+5]) scale([0.5,1,1])linear_extrude(1)projection(){
   hull(){
translate([20,0,0])rotate([0,90,0])cylinder(20,10,10,center=true);
translate([10,0,0])rotate([0,90,0])cylinder(10,16,16);
 translate([10,60,0])rotate([0,90,0])cylinder(5,10,10);
 translate([10,60,0])rotate([0,90,0])cylinder(1,16,16);

}
    }

}

translate([-.1,0,0])hull(){
translate([20-5,0,0])rotate([0,90,0])cylinder(18+5,8,8,center=true);
translate([10-5,0,0])rotate([0,90,0])cylinder(8+5,14,14);
 translate([10-5,60,0])rotate([0,90,0])cylinder(3+5,8,8);
 translate([10-5,60,0])rotate([0,90,0])cylinder(0.01+5,14,14);

}
}

module sleve(){
    r=7;
  difference(){
    offset(2) sleve_profile();     
      sleve_profile();
      square([2,45]);

  }
    }
    module sleve_profile(){
         r=7;
   offset(r)offset(-r) square([17,45],center=true);
        }