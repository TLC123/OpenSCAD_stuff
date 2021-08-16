//CUSTOMIZER VARIABLES

//Radius of the entire bearing (all values in mm by default)
Bearing_Radius = 50;

//Height of the entire bearing (also diameter of the internal balls)
Bearing_Height = 20;

//Minimum radius of the certer portion of the bearing
Bearing_Internal_Radius = 25;

//Number of balls within the bearing
Bearing_Number = 10;

//Space between the balls and the internal bearing walls (on each side, must be greater than 0 or balls will print fused)
Bearing_Tolerance = 0.5;

//Cleaning up of the rough edges on the exterior of the bearing (recommended on)
Debur = "on"; // [on,off]

//Amount of material removed by the deburring process (try it till you find a good result)
Debur_Severity = 5;

//Radius of the bearing hole
Hole_Radius = 20;

//Number of sides of the bearing hole (only enabled if Hole Type is set to "userdef")
Hole_Facets = 6;

//Type of hole
Hole_Type = "userdef"; // [circle,square,userdef]

//Definition of the entire model
Definition = 100;

module bearing (radius, height, intthickness, bearingnum, bearingtol, debur, deburseverity, holerad, holefacet, holetype) {

	difference(){

		cylinder(height, radius, radius, true);

		rotate_extrude()translate([intthickness+bearingtol+height/2,0,0])circle(bearingtol+height/2);

		if(debur == "on"){

			difference(){

			cylinder(height+2, intthickness+bearingtol+height/2+deburseverity, intthickness+bearingtol+height/2+deburseverity, true);

			cylinder(height+2, intthickness+bearingtol+height/2-deburseverity, intthickness+bearingtol+height/2-deburseverity, true);

			};

		};

		if(holetype == "circle"){

			cylinder(height+2,holerad,holerad,true);

		};

		if(holetype == "square"){

			cube([holerad*2,holerad*2,height+2],true);

		};

		if(holetype == "userdef"){

			cylinder(height+2,holerad,holerad,true, $fn = holefacet);

		};

	};

	for(n = [0:bearingnum-1]){

	rotate([0,0,(360/bearingnum)*n])translate([intthickness+bearingtol+height/2,0,0])sphere(height/2);

	};

}; 

bearing(Bearing_Radius,Bearing_Height,Bearing_Internal_Radius,Bearing_Number,Bearing_Tolerance,Debur,Debur_Severity,Hole_Radius,Hole_Facets,Hole_Type,$fn = Definition);