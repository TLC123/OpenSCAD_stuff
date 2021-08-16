//CUSTOMIZER VARIABLES

//Radius of the entire bearing (all values in mm by default)
Bearing_Radius = 170;

//Height of the entire bearing (also diameter of the internal balls)
Bearing_Height = 5;

//Minimum radius of the certer portion of the bearing
Bearing_Internal_Radius = 40;

//Number of balls within the bearing
Bearing_Number = 16;

//Space between the balls and the internal bearing walls (on each side, must be greater than 0 or balls will print fused)
Bearing_Tolerance = 0.5;

//Cleaning up of the rough edges on the exterior of the bearing (recommended on)
Debur = "on"; // [on,off]

//Amount of material removed by the deburring process (try it till you find a good result)
Debur_Severity = 5;

//Radius of the bearing hole
Hole_Radius = 55;

//Number of sides of the bearing hole (only enabled if Hole Type is set to "userdef")
Hole_Facets = 30;

//Type of hole
Hole_Type = "userdef"; // [circle,square,userdef]

//Definition of the entire model
Definition = 100;
module cage(radius, height, intthickness, bearingnum, bearingtol, debur, deburseverity, holerad, holefacet, holetype) {
	//cylinder(height, radius, radius, true);
difference(){
	   union(){	
    
           
   	rotate_extrude()translate([intthickness+bearingtol+height/2,0,0])
       translate([0,height/2.5,0])scale([0.85,0.85,1])square(bearingtol+height/2,center=true);
         for(n = [0:bearingnum-1] ) {

	rotate([0,0,(360/bearingnum)*n])translate([intthickness+bearingtol+height/2,0,0]){   rotate([90,0,0])cylinder(height*1.5,height*0.45,height*0.45,center=true,$fn=6);
    }
    
	} 
          
           }
for(n = [0:bearingnum-1] ) {

	rotate([0,0,(360/bearingnum)*n])translate([intthickness+bearingtol+height/2,0,0]){sphere(height/2);
    cube([height*1.5,height/1.5,height],center=true);
    }
    
	}

    }
        
        }




cage(Bearing_Radius,Bearing_Height,Bearing_Internal_Radius,Bearing_Number,Bearing_Tolerance,Debur,Debur_Severity,Hole_Radius,Hole_Facets,Hole_Type,$fn = Definition);