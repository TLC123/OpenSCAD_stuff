crop(maxh = 30) union() {
    for (t = [0: 99]) {
        r = rands(0, 360, 3);
        rotate(r) cube(20);
    }
}


module crop(maxh = 100) {
    intersection() {
        color() {
            children();
        }
        linear_extrude(maxh)
        hull()
        projection() {
            children();
        }
    }}
