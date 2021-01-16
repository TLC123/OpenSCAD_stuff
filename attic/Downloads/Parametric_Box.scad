// Fully parametric box for 3D printing
// v4a
// http://www.thingiverse.com/thing:1918169
//
// Original box based on:
// http://tinyurl.com/oznh2p4
//
// Ventilation holes based on:
// http://www.thingiverse.com/thing:1826360

// Configure below
//
/* Box parameters */
// Length of box in mm
length = 150;   //[10:254]
// Width of box in mm
width = 100;    //[10:254]
// Height of box in mm
tall = 50;      //[10:254]
// Wall thickness of box in mm
thick = 3;      //[1:15]
// Depth of lip on lid in mm
lDepth = 6;     //[1:15]
// Corner radius; 0 = four square corners
cRadius = 10;   //[0:25]   
// Fancy: Square two opposing corners; 0=no, 1=yes (must be using cRadius)
sqCorners = 1;  //[0,1]
/* Vent Parameters */
// Vent hole size in mm; 0 = no vents
hSize = 3;      //[0:15]
// Hole Spacing in mm; must be > 0
hSpace = 1;     //[1:15]
// Vent hole type; 0=round, 1=square
hType = 0;      //[0,1]
//
// Configure above

//$fn=200;            // 200 fragments per cicle; comment for draft mode

// Draw Box
translate([cRadius, cRadius, 0]){
    // Create a hollow box
    difference() {
        // Create box shape
		roundedBox(length,width,tall,cRadius,sqCorners); 
        // Create negative box shape, smaller by wall thickness 
		translate([thick,thick,thick]) {roundedBox(length-(thick*2),width-(thick*2),tall,cRadius,sqCorners);
        // Add vent holes to long sides
        if (hSize>0) addVentHoles(
			length,     						    // Panel Width
			tall,								    // Panel Height
			max(floor(tall*.2),thick*2,cRadius+hSize),  // Gutter Width
			max(floor(tall*.2),thick*2,cRadius+hSize),  // Gutter Height
			hSize,								    // Hole Radius
			hSpace,					    		    // Hole Spacing
			width+thick,						    // Hole Length
			-(cRadius+thick),					    // X Location
			-(cRadius+thick),					    // Y Location
			hType								    // Hole Type
		);}
    }
}

// Draw Box Lid
// Shift along-side first box
translate([(width*2)+(10-cRadius), cRadius, 0]){
    mirror([1,0,0]) {
		// Create lid
        roundedBox(length,width,thick,cRadius,sqCorners);
		// Create lip on top of lid
        difference() {
			// Create lip shape
            translate([thick,thick,thick]) {
				roundedBox(length-(thick*2),width-(thick*2),lDepth,cRadius,sqCorners);}
			// Create negative shape, smaller by wall thickness
            // (add 0.01 to depth to bypass rendering bug)
            translate([(thick*2),(thick*2),thick+0.01]) {
				roundedBox(length-(thick*4),width-(thick*4),lDepth,cRadius,sqCorners);}    
        }
    }
}

// Render box according to parameters
module roundedBox(length, width, tall, radius, sqCorners)
{
	if (radius==0) {
		// Draw regular cube
		cube(size=[width,length,tall]);
	} else {
		// Draw rounded corner cube
		diam=2*radius;

		// Draw base rounded shape
		minkowski() {
			cube(size=[width-diam,length-diam, tall/2]);
			cylinder(r=radius, h=tall/2);
		}

        // Square opposing corners
		if (sqCorners==1) {
			// Corner cube bottom right
			translate([width-diam,-radius,0]) {cube(size=[radius,radius,tall]);}

			// Corner cube top left
			translate([-radius,length-diam,0]) {cube(size=[radius,radius,tall]);}  
		}
	}
}

// Ventillate opposing panels Y-axis panels
module addVentHoles (pWidth, pHeight, gWidth, gHeight, hSize, hSpace, hLength, xLoc, yLoc, hType) {
	hSpacing = hSpace + hSize;
    mainRowHoles = floor((pWidth - (2 * gWidth))  / hSpacing);
    rows = floor((pHeight - (2 * gHeight)) / hSpacing);

    for (n = [0:rows]) {
        for (i = [0:mainRowHoles]) {
            // If we're on an even-number row, then we put holes across the panel
            if (n % 2 == 0)
                translate([
					xLoc,
					yLoc+(i*hSpacing)+(gWidth),
					(n*hSpacing)+gHeight])
					
					rotate([0,90,0])
                    // Choose square or round hole
					if (hType==0) {
						cylinder(h=hLength, r=hSize/2);
					} else {
						translate([0,0,hLength/2]) cube(size=[hSize,hSize,hLength], center=true);
					}	

            // If we're on an odd-number row then we offset the holes, and drop one
            if ((n % 2 == 1) && (i<mainRowHoles)) // This drops the hole
				translate([
					xLoc,
					yLoc+(i*hSpacing)+(gWidth)+(hSpacing/2),
					(n*hSpacing)+gHeight]) 
					
					rotate([0,90,0])
					// Choose square or round hole
					if (hType==0) {				 
						cylinder(h=hLength, r=hSize/2);
					} else {
						translate([0,0,hLength/2]) cube(size=[hSize,hSize,hLength], center=true);
					}	
        }
    }
}