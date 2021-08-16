module yourshape() {
    // for example
    difference() {
        offset(-1) offset(delta = +1, $fn = 0)
        union() {
            rotate(-180) square(4);
            square(4);
        }
        translate([2, 2]) circle(1.1, $fn = 16);
        translate(-[2, 2]) square(2,true);
    }
}
//
module yourprofile() {
    // for example
    hull() {
        translate([0, -1]) circle(.25, $fn = 4);
        translate([0, 1]) circle(.25, $fn = 16);
    }
}
//
profile_on_shape_sweep() {
    yourshape();
    yourprofile();
};
//
//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//
//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//
//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//*//
//
module profile_on_shape_sweep($fn = 12) {
    minkowski() {
        rotate_extrude() trimToZeroX() children(1);
        ExtrudeToNothing() children(0);
    }
}
//convert 2d shape to almost flat 3d shape
module ExtrudeToNothing() {
    s = 1e5;
    scale(1 / s)
    linear_extrude(height = 1) {
        scale(s)
        children();
    }
}
// trimToZeroX() helper
module bbox2d() {
    minkowski() {
        projection()
        rotate([0, -90, 0])
        linear_extrude(1e-6)
        children();
        projection()
        rotate([90, 0, 0])
        linear_extrude(1e-6, center = true)
        flipcopy([1, 0]) children();
    }
}
// trimToZeroX() helper
module flipcopy(flip) {
    union() {
        children();
        mirror(flip) children();
    }
}
// auto clip 2d shape by y axis, keep positive side
module trimToZeroX() {
    intersection() {
        children();
        minkowski() {
            translate([0, 0]) difference() {
                translate([0.001, 0])
                bbox2d() children();
                bbox2d() children();
            }
            projection()
            rotate([90, 0, 0])
            linear_extrude(1e-6, center = true)
            children();
        }
    }
}