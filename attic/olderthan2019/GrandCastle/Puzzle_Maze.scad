piece_side_length = 25;
side_length = piece_side_length;
piece_height = 2;
xs = 6;
ys = 6;
spacing = 0.3;

// Create a puzzle piece.
//
// Parameters: 
//     side_length - the length of the piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
module knob(p1,r){
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;
x=p1[0];
y=p1[1];

if (x>circle_radius&&y>circle_radius&&x<piece_side_length*xs-circle_radius*2&&y<piece_side_length*ys-circle_radius*2)
translate(p1) 
			circle(r);
}
module klack(){translate([spacing*0.75,-spacing*3]) square([(piece_side_length*0.5 -spacing *4 ) ,(piece_side_length*0.5 +spacing*5) ] ); 	}
module wklack(){translate([spacing*0.75,piece_side_length*0.5-spacing*2.5]) square([(piece_side_length*0.5 -spacing *4 ) ,( spacing*5) ] ); 	}
module puzzle_piece(p1,side_length, spacing) {
	$fn = 24;
	
	circle_radius = side_length / 10;
	half_circle_radius = circle_radius / 1;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;
    off=[(piece_side_length -spacing)*0.5,(piece_side_length -spacing)*0.5];


	offset(r=-spacing)	offset(r=spacing*2)
	offset(r=-spacing) union(){	difference() {union(){
	*translate(p1+[spacing*1.5,spacing*1.5]  ) square([piece_side_length -spacing*3 ,piece_side_length -spacing*3 ] ); 

	translate(p1 +off )rotate([0,0,00])klack();
    translate(p1 +off )rotate([0,0,090])klack();
 	translate(p1 +off )rotate([0,0,180])klack();
	translate(p1 +off )rotate([0,0,270])klack();


		}
		// left
		knob(p1+[half_circle_radius , side_length_div_4, 0],circle_radius);
		knob(p1+[side_length -half_circle_radius-spacing, side_length_div_4 * 3, 0],circle_radius);
			
		// top
		knob(p1+[side_length_div_4, side_length - half_circle_radius-spacing, 0],circle_radius);
		knob(p1+[side_length_div_4 * 3,  half_circle_radius, 0],circle_radius);		
	}

	// right
	knob(p1+[side_length + half_circle_radius, side_length_div_4, 0],bulge_circle_radius);
	knob(p1+[- half_circle_radius-spacing, side_length_div_4 * 3, 0],bulge_circle_radius);

	// bottom
	knob(p1+[side_length_div_4, -half_circle_radius-spacing, 0],bulge_circle_radius);
	knob(p1+[side_length_div_4 * 3,side_length + half_circle_radius, 0],bulge_circle_radius);
}}

module wall_piece(p1,side_length, spacing) {
	$fn = 24;
	
	circle_radius = side_length / 10;
	half_circle_radius = circle_radius / 1;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;
    off=[(piece_side_length -spacing)*0.5,(piece_side_length -spacing)*0.5];


	offset(r=-spacing)	offset(r=spacing*2)
	offset(r=-spacing) union(){


	translate(p1 +off )rotate([0,0,00])wklack();
    translate(p1 +off )rotate([0,0,090])wklack();
 	translate(p1 +off )rotate([0,0,180])wklack();
	translate(p1 +off )rotate([0,0,270])wklack();

    translate(p1   )rotate([0,0,090*round(rnd(4))])wklack();
      translate(p1   )rotate([0,0,090*round(rnd(4))])wklack();


		}}


// Create a puzzle.
//
// Parameters: 
//     xs - the amount of pieces in x direction.
//     ys - the amount of pieces in y direction.
//     piece_side_length - the length of a piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
module puzzle(xs, ys, piece_side_length, spacing) {
    $fn = 48;
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = piece_side_length / 4;
	intersection() {
 for(x = [0 : xs - 1]) {
			for(y = [0 : ys - 1]) {
				 
					puzzle_piece([piece_side_length * x, piece_side_length * y, 0],piece_side_length, spacing);
					
  
		
 	}
}
	translate([spacing*3,spacing*3] ) square([piece_side_length * xs - spacing*6, piece_side_length * ys - spacing*6]);
	}

}

module wall(xs, ys, piece_side_length, spacing) {
    $fn = 48;
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = piece_side_length / 4;
	intersection() {
 for(x = [0 : xs - 1]) {
			for(y = [0 : ys - 1]) {
				 
					wall_piece([piece_side_length * x, piece_side_length * y, 0],piece_side_length, spacing);
					
  
		
 	}
}
	translate([spacing*3,spacing*3] ) square([piece_side_length * xs - spacing*6, piece_side_length * ys - spacing*6]);
	}

}

linear_extrude(piece_height) 
    puzzle(xs, ys, piece_side_length, spacing);
linear_extrude(15) 
    wall(xs, ys, piece_side_length, spacing);
function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
