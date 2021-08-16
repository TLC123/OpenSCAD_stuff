$fn=9;
difference(){
     
  hull(){
 cylinder(35,18,1,true);
cylinder(35/2,10,10);
//cylinder(21/2,10,18);

translate([0,0,-3])cylinder(10,26,24,true);
}
 rotate([.5,0,0]) translate([0,0,-15])cylinder(40,7,8);

}