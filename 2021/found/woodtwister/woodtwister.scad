difference() {
  translate([0, 0, 32]) intersection() {
    rotate([90, 0, 0])
    linear_extrude(height = 532, center = true, convexity = 10, twist = 0, $fn = 10) offset(r = -1) offset(r = 2) offset(r = -1) translate([0, -10])
    difference() {
      square([60, 44], center = true);
      translate([0, 12]) circle(22, $fn = 40);
      translate([0, 30]) circle(30, $fn = 40);
    }
    rotate([90, 0, 0])
    linear_extrude(height = 432, center = true, convexity = 10, twist = 360, $fn = 140)
    offset(r = -1, $fn = 40) offset(r = 2) offset(r = -1) difference() {
      square([100, 100], center = true);
      square([40, 40], center = true);
      square([43, 20], center = true);
      square([45, 5], center = true);
      square([5, 41], center = true);
      translate([12.5, -20]) square([5, 5], center = true);
      translate([-12.5, -20]) square([5, 5], center = true);
    }
  }
  translate([0, -217.66, -1]) linear_extrude(height = 20, convexity = 10) offset(r = -0.5) offset(r = 1) offset(r = -0.5) union() {
    translate([0, 1 * 1 / 2])
    square([40, 1 * 1], center = true);
    translate([0, (11.5 + .3) / 2 + 1 * 1])
    square([6 - .3 * 2, 11.5 + .3], center = true);
    translate([0, 11.5 + .3 + 1 * 1])
    circle(r = 6 - .3, $fn = 32);
  };
}
translate([0, 214.5, 0]) linear_extrude(height = 11.5, convexity = 10) offset(r = -0.5) offset(r = 1) offset(r = -0.5) union() {
  translate([0, 1 * 1 / 2])
  square([40, 1 * 1], center = true);
  translate([0, (11.5 + .3) / 2 + 1 * 1])
  square([6 - .3 * 2, 11.5 + .3], center = true);
  translate([0, 11.5 + .3 + 1 * 1])
  circle(r = 6 - .3, $fn = 32);
};


 
