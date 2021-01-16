
		 translate ([0,0,-1])rotate([-180, 0, 0]) translate ([0,0,1]){
			 
             
		 intersection(){translate([0,-1,0])cube([3,2,1]);
             rotate([25,0,0])
    union(){
    color([1,0,0])translate([0,0.5,-1])cube([1,2,3]);
   translate([0.5,0,-0.10])scale([1,1,2])rotate([-90,0,0])cylinder(2,0.5,0.5,$fn=10);
    }
    }
             
             }