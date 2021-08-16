// moreShapes library
// 2D and 3D utility shape functions
// Author: Damian Axford
// Updated:  8 Apr 2013
// Public Domain

// some borrowed from nophead / Mendel90 utils.scad

include <polyholes.scad>
include <teardrops.scad>

// fudge
eta = 0.01;


module line(start, end, r) {
	hull() {
		translate(start) sphere(r=r);
		translate(end) sphere(r=r);
	}
}

module roundedRect(size, radius, center=false) {
	x = size[0];
	y = size[1];
	z = size[2];
	
	translate([center?-x/2:0, center?-y/2:0, center?-z/2:0])
	linear_extrude(height=z) 
	hull() {
		translate([radius, radius, 0])
		circle(r=radius);
		
		translate([x - radius, radius, 0])
		circle(r=radius);
		
		translate([x - radius, y - radius, 0])
		circle(r=radius);
		
		translate([radius, y - radius, 0])
		circle(r=radius);
	}
}

module roundedRectX(size, radius, center=false) {
	// X-axis aligned roundedRect
	translate([0,0,center?0:size[2]]) rotate([0,90,0]) roundedRect([size[2],size[1],size[0]], radius, center);
}

module roundedRectY(size, radius, center=false) {
	// Y-axis aligned roundedRect
	translate([0,0,center?0:size[2]]) rotate([-90,0,0]) roundedRect([size[0],size[2],size[1]], radius, center);
}

module allRoundedRect(size, radius, center=false) {
	// lazy implementation - must do better
	// runs VERY slow
	translate([center?-size[0]/2:0, center?-size[1]/2:0, center?-size[2]/2:0])
	hull() {
		for (x=[0,size[0]], y=[0,size[1]], z=[0,size[2]]) {
			translate([x,y,z]) sphere(r=radius);
		}
	}
}



module torusSlice(r1, r2, start_angle, end_angle, convexity=10, r3=0, $fn=64) {
	rx = r1 + r2;
    ry = rx;
    trx = rx* sqrt(2) + 1;
    try = ry* sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
			rotate_extrude(convexity=convexity) translate([r1,0,0]) difference() {
				circle(r2, $fn=$fn/4);
				circle(r3, $fn=$fn/4);
			}

			translate([0,0,-r2-1])
			linear_extrude(height=2*r2+2)
        		polygon([
		            [0,0],
		            [trx * cos(a0), try * sin(a0)],
		            [trx * cos(a1), try * sin(a1)],
		            [trx * cos(a2), try * sin(a2)],
		            [trx * cos(a3), try * sin(a3)],
		            [trx * cos(a4), try * sin(a4)],
		            [0,0]
		       ]);
    }
}


module trapezoid(a,b,h,aOffset=0,center=false) {
	// lies in x/y plane
	// edges a,b are paralle to x axis
	// h is in direction of y axis	
	// b is anchored at origin, extends along positive x axis
	// a is offset along y by h, extends along positive x axis
	// a if offset along x axis, from y axis, by aOffset
	// centering is relative to edge b

	translate([center?-b/2:0, center?-h/2:0, 0]) 
	polygon(points=[	[0,0],
					[aOffset,h],
					[aOffset + a, h],
					[b,0]]); 
}

module trapezoidPrism(a,b,h,aOffset,height,center=false) {
	translate([0,0, center?-height/2:0]) linear_extrude(height=height) trapezoid(a,b,h,aOffset,center);
}


module arrangeShapesOnAxis(axis=[1,0,0], spacing=50) {
	for (i=[0:$children-1]) {
		translate([spacing * axis[0] *i,
					spacing * axis[1]*i,
					spacing * axis[2]*i]) child(i);
	}
}

module arrangeShapesOnGrid(xSpacing=50, ySpacing=50, cols=3, showLocalAxes=false) {	
	// layout is cols, rows
	for (i=[0:$children-1]) {
		translate([(i - floor(i / cols)*cols) * xSpacing, floor(i / cols) * ySpacing, 0]) {
			child(i);

			if (showLocalAxes) {
				color("red") line([0,0,0], [xSpacing/2,0,0], 0.2);
				color("green") line([0,0,0], [0, ySpacing/2,0], 0.2);
				color("blue") line([0,0,0], [0, 0,xSpacing], 0.2);
			}
		}
	}
}

module slot(h, r, l, center = true)
    linear_extrude(height = h, convexity = 6, center = center)
        hull() {
            translate([l/2,0,0])
                circle(r = r, center = true);
            translate([-l/2,0,0])
                circle(r = r, center = true);
        }



module fillet(r, h) {
	// ready to be unioned onto another part, eta fudge included
	// extends along x, y, z

    translate([r / 2, r / 2, 0])
        difference() {
            cube([r + eta, r + eta, h], center = true);
            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);
        }
}

module right_triangle(width, height, h, center = true) {
    linear_extrude(height = h, center = center)
        polygon(points = [[0,0], [width, 0], [0, height]]);
}

module rounded_square(w, h, r)
{
	// 2D
    union() {
        square([w - 2 * r, h], center = true);
        square([w, h - 2 * r], center = true);
        for(x = [-w/2 + r, w/2 - r])
            for(y = [-h/2 + r, h/2 - r])
                translate([x, y])
                    circle(r = r);
    }
}

//
// Cylinder with rounded ends
//
module rounded_cylinder(r, h, r2, roundBothEnds=false)
{
    rotate_extrude()
        union() {
            square([r - r2, h]);
            translate([0,roundBothEnds?r2:0,0]) square([r, roundBothEnds? h-2*r2 : h - r2]);
            translate([r - r2, h - r2])
                circle(r = r2);
			if (roundBothEnds) {
				translate([r - r2, r2])
                circle(r = r2);
			}
			
        }
}

module sector(r, a, h, , center = true) {
    linear_extrude(height = h, center = center)
        intersection() {
            circle(r = r, center = true);
                polygon(points = [
                    [0, 0],
                    [2 * r * cos(a / 2),  2 * r * sin(a / 2)],
                    [2 * r * cos(a / 2), -2 * r * sin(a / 2)],
                ]);
        }
}

module tube(or, ir, h, center = true) {
    linear_extrude(height = h, center = center, convexity = 5)
        difference() {
            circle(or);
            circle(ir);
        }
}



module moreShapesExamples() {
	arrangeShapesOnGrid(xSpacing=100, ySpacing=80, cols=4, showLocalAxes=true) {
		roundedRect([50,30,20], 5);
		roundedRectX([50,30,20], 5);
		roundedRectY([50,30,20], 5);
		//allRoundedRect([50,30,20], 5);

		roundedRect([50,30,20], 5, true);
		roundedRectX([50,30,20], 5, true);
		roundedRectY([50,30,20], 5, true);
		//allRoundedRect([50,30,20], 5, true);


		torusSlice(50, 6, 0, 120, $fn=64);
		torusSlice(r1=50, r2=6, r3=4, start_angle=0, end_angle=120, $fn=64);   // define r3 for a hollow torus

		trapezoidPrism(20,50,20,10,20);
		trapezoidPrism(20,50,20,10,20,true);

		// to be differenced
		slot(h=20, r=5, l=10);

		// to be unioned
		fillet(r=5, h=50);

		right_triangle(width=30, height=20, h=10, center = false);
		rounded_square(w=30, h=20, r=5);
		rounded_cylinder(r=10, h=50, r2=5, roundBothEnds=false);
		rounded_cylinder(r=10, h=50, r2=5, roundBothEnds=true);
		
		// same as extruded pieSlice
		sector(r=10, a=70, h=20, center = false);

		tube(or=10, ir=5, h=50, center = false);
	}
}

moreShapesExamples();



