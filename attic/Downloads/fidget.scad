// Center bearing outer diameter. 608 bearing is 22 mm.
bearing_od = 22;

// Height of center bearing.
bearing_height = 7;

// Weight outer diameter.
weight_od = 22;

// Shape used as weight. "cylinder" for bearings, "sphere" for balls.
weight_type = "cylinder"; // [cylinder, sphere]

// Customizer will time out when previewing unless this is set to 1. Set to 0 before saving to get a solid model.
preview = 1; // [1, 0]


// Thickness of wall between bearing and weights.
wall_thickness = 5;

/* [Hidden] */
$fa = 5;
$fs = 0.5;

bearing_to_weight_centers_dist = (bearing_od + weight_od)/2 + wall_thickness;
lobe_r = weight_od/2 + wall_thickness;

// Calculate the tangent circle between the top, right, and center circles.
tc = tangent_circle(0, 0, bearing_od/2 + wall_thickness,
		    0, bearing_to_weight_centers_dist, lobe_r,
		    cos(30)*bearing_to_weight_centers_dist, -sin(30)*bearing_to_weight_centers_dist, lobe_r);


if (preview == 1) spinner_preview();
else spinner();

module spinner() {
     // Take the solid spinner body, cut the bearing and weight holes.
     difference() {
	  spinner_solid();
	  cylinder(d=bearing_od, h=100, center=true);
	  weights();
     }
}

module spinner_preview() {
     difference() {
	  linear_extrude(height = bearing_height, center = true) profile();
	  cylinder(d=bearing_od, h=100, center=true);
	  weights();
     }
}

module spinner_solid() {
     // Take the spinner profile, generate a 3D solid body with rounded edges.
     minkowski() {
	  linear_extrude(height = 0.1) offset(r=-bearing_height/2) profile();
	  sphere(d=bearing_height);
     }
}

module weight() {
     if (weight_type == "cylinder") {
	  translate([0, bearing_to_weight_centers_dist]) cylinder(d=weight_od, h=100, center=true);
     } else {
	  translate([0, bearing_to_weight_centers_dist]) sphere(d=weight_od);
     }
}

module weights() {
     weight();
     rotate([0, 0, 120]) weight();
     rotate([0, 0, 240]) weight();
}

// Creates a 2D circle at a position. Takes a vector, [x, y, r]
module circ(v) {
     translate([v[0], v[1]]) circle(v[2]);
}

module lobe() {
     circ([0, bearing_to_weight_centers_dist, lobe_r]);
}

module lobes() {
     lobe();
     rotate([0, 0, 120]) lobe();
     rotate([0, 0, 240]) lobe();
}

module body() {
     polygon([[0, bearing_to_weight_centers_dist],
	      [tc[0], tc[1]],
	      [cos(30)*bearing_to_weight_centers_dist, -sin(30)*bearing_to_weight_centers_dist],
	      [0, -sqrt(tc[0]*tc[0] + tc[1]*tc[1])],
	      [-cos(30)*bearing_to_weight_centers_dist, -sin(30)*bearing_to_weight_centers_dist],
	      [-tc[0], tc[1]]]);
     lobes();
}

module cutter() {
     circ(tc);
}

// Solves the Apollonius problem of a circle externally tangent to three other circles.
// Returns a vector, [x, y, r] of the solution circle.
function tangent_circle(x1, y1, r1, x2, y2, r2, x3, y3, r3) =
     let (a2 = 2*(x1 - x2),
	  a3 = 2*(x1 - x3),
	  b2 = 2*(y1 - y2),
	  b3 = 2*(y1 - y3),
	  c2 = 2*(r1 - r2),
	  c3 = 2*(r1 - r3),
	  d2 = (x1*x1 + y1*y1 - r1*r1) - (x2*x2 + y2*y2 - r2*r2),
	  d3 = (x1*x1 + y1*y1 - r1*r1) - (x3*x3 + y3*y3 - r3*r3),
	  N = (b2*d3 - b3*d2) / (a3*b2 - a2*b3),
	  M = (b3*c2 - b2*c3) / (a3*b2 - a2*b3),
	  P = (a2*d3 - a3*d2) / (a2*b3 - a3*b2),
	  Q = (a3*c2 - a2*c3) / (a2*b3 - a3*b2),
	  S = N - x1,
	  T = P - y1,
	  a = M*M + Q*Q - 1,
	  b = 2*(S*M + T*Q - r1),
	  c = S*S + T*T - r1*r1,
	  r = max((-b + sqrt(b*b - 4*a*c)) / (2*a), (-b - sqrt(b*b - 4*a*c)) / (2*a)),
	  x = N + M*r,
	  y = P + Q*r)
     [x, y, r];

// 2D shape of the spinner outline.
module profile() {
     difference() {
	  body();
	  cutter();
	  rotate([0, 0, 120]) cutter();
	  rotate([0, 0, 240]) cutter(); 
     }
}
