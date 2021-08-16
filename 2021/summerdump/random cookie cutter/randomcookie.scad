    // sharp cookiecutter, prompted by online question
    cutterheight = 15;
    connecting_brim = true; // hold together multipart cutter
    brim_height = 5;
    brim_width = 4;
    // demo code
    sharpcookie() random_shape(seed = 1141111);
    // or
    //sharpcookie () scale(2.5) import("easypeasy.svg");
    // end demo code
    //
    // generates cookiecutter from any 2d shape
    module sharpcookie() {
        if (connecting_brim) {
            connecting_brim() children();
        }
        minkowski() {
            linear_extrude(0.001) difference() {
                children();
                offset(-.05) children();
            }
            union() {
                $fn = 3;
                if (!connecting_brim) cylinder(brim_height, brim_width / 2, brim_width / 2);
                cylinder(cutterheight, 1.5, 0);
            }
        }
    }
    //
    // extended brim to hold cutter parts together
    module connecting_brim() {
        linear_extrude(brim_height) difference() {
            hull() offset(brim_width / 2) children();
            offset(-brim_width / 2) children();
        }
    }
    //
    // random shape generator for demo
    module random_shape(seed = 10) {
        offset(chamfer = true, delta = 10, $fn = 0) offset(delta = -20, $fn = 2) offset(10, $fn = 2)
        scale(.5)
        for (i = [0.1: 3]) {
            $fn = 16;
            translate(rands(-30, 60, 2, seed + i))
            circle(10 + rands(0, 40, 1)[0]);
            translate(rands(-50, 20, 2))
            rotate(rands(0, 12, 1)[0] * 30)
            square(20 + rands(0, 50, 1)[0]);
            translate(rands(-40, 40, 2))
            rotate(rands(0, 12, 1)[0] * 30)
            square(20 + rands(0, 50, 1)[0], true);
        }
    }