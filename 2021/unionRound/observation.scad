unionRound(1, 1) {
    translate([2, 5, 5]) sphere(7);
     rotate([10, 20, 30]) cube(10, true);
}
module unionRound(r, detail = 1) {
    epsilon = 1e-6;
    children(0);
    children(1);
    step = 1 / detail;
    for (i = [0: step: 1 - step]) {
        {
            x = r - sin(i * 90) * r;
            y = r - cos(i * 90) * r;
            xi = r - sin((i + step) * 90) * r;
            yi = r - cos((i + step) * 90) * r;
            color(rands(0, 1, 3, i))
            hull() {
                intersection() {
                    // shell(epsilon) 
                    clad(x) children(0);
                    // shell(epsilon) 
                    clad(y) children(1);
                }
                intersection() {
                    // shell(epsilon) 
                    clad(xi) children(0);
                    // shell(epsilon) 
                    clad(yi) children(1);
                }
            }
        }
    }
}
// unionRound helper expand by r
module clad(r) {
    minkowski() {
        children();
        //        icosphere(r,2);
        sphere(r, $fn = 19.5);
    }
}
// unionRound helper
module shell(r) {
    difference() {
        clad(r) children();
        children();
    }
}