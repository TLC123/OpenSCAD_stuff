$fn=100;
//cheville
*rotate_extrude(){
polygon([[0,0],[3,0],[4,2],[4,38],[3,40],[0,40]]);
}
//vis
scale([0.1,0.1,0.1])
rotate([-90,0,0])
union(){
		translate([0,0,-3]) {
			difference(){
				cylinder(3,3,1);
				translate([0,0,-0.1]) linear_extrude(height=1.1,scale=0.4){
					polygon([[-0.5,-2],[0.5,-2],[0.5,-0.5],[2,-0.5],[2,0.5],[0.5,0.5],[0.5,2],[-0.5,2],[-0.5,0.5],[-2,0.5],[-2,-0.5],[-0.5,-0.5]]);
				}
			}
			translate([0,0,2]) cylinder(14,1,1);
			translate([0,0,15.9]) cylinder(4.1,1,0.1);
		}
	linear_extrude(height=13,twist=9*360){
		translate([0.5,0.5,0]) circle(1);
	}
	translate([0,0,13]) {
		linear_extrude(height=3,twist=3*360,scale=0.1){
			translate([0.5,0.5,0]) circle(1);
		}
	}
}
