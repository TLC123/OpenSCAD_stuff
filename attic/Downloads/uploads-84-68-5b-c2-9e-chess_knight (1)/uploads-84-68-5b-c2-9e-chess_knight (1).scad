segments = 64;

scale(0.2)
rotate([0, 0, 0])
translate([0, 0, 0]) {

translate([0, 0, 30])
union () {
    rotate_extrude(convexity = 10, $fn = 64) {
	import_dxf(file = "knight_profile.dxf");
    }
    // Import STL for the knight
    translate([-8, -12, 28])
    scale(3.2)
    import(file = "horse3.stl");
}

}
