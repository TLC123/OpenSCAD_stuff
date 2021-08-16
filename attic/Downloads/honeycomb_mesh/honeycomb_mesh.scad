//---------------------------------------------------------------
//-- CUSTOMIZER PARAMETERS
//---------------------------------------------------------------

// - honeycomb length
hc_length = 244;
// - honeycomb width
hc_width = 172;
// - honeycomb height
hc_height = 3;
// - hexagon hole diameter
hexagon_diameter = 20;
// - hexagon frame thickness
hexagon_thickness = 2;

box = [hc_width, hc_length, hc_height];



//---------------------------------------------------------------
//-- MODULES
//---------------------------------------------------------------



// * HONEYCOMB

module hexagonal_grid(box, hexagon_diameter, hexagon_thickness){
// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 

// example 
//    hexagonal_grid([25, 25, 5], 5, 1);

    difference(){
        cube(box, center = true);
        hexgrid(box, hexagon_diameter, hexagon_thickness);
    }
}


module hex_hole(hexdiameter, height){
        translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(d = hexdiameter, h = height, center = true, $fn = 6);
}




module hexgrid(box, hexagon_diameter, hexagon_thickness) {
    cos60 = cos(60);
    sin60 = sin(60);
    d = hexagon_diameter + hexagon_thickness;
    a = d*sin60;

    moduloX = (box[0] % a);
//    numX = (box[0] - moduloX) / a;
    numX =  floor(box[0]/a);
    oddX = numX % 2;
    numberX = numX;

    moduloY = (box[1] % a);
//    numY = (box[1] - moduloY) / a;
    numY =  floor(box[1]/a);
    oddY = numY % 2;
    numberY = numY;
    

// Center the central hexagon on the origin of coordinates    
    deltaX = oddX == 1 ? d/2 : a/2 + d/2;
    deltaY = oddY == 1 ? 0 : a/2;

    x0 = (numberX + 2) * a/2 + deltaX;
    y0 = (numberY + 2) * a/2 + deltaY;

    for(x = [ -x0: 2*a*sin60 : x0]) {
        for(y = [ -y0 : a : y0]) {
            translate([x, y, 0]) hex_hole(hexdiameter = hexagon_diameter, height = box[2] + 0.001);
           translate([x + a*sin60, y + a*cos60 , 0]) hex_hole(hexdiameter = hexagon_diameter, height = box[2] + 0.001);
 echo ([x, y]);
 echo ([x + a*sin60, y + a*cos60]);
            
         } //fo
    } //fo
} //mo

// * END OF HONEYCOMB



//---------------------------------------------------------------
//-- RENDERS
//---------------------------------------------------------------


    hexagonal_grid(box, hexagon_diameter, hexagon_thickness);
//    hexagonal_grid([25, 25, 5], 5, 1);

