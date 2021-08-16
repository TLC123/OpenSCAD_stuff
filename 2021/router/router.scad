shape = [
    for (i = [1: 5]) rands(-100, 100, 2)
];

height = 5;
router_offset = 1;
epsilon = 1e-2;
$fn = 16;

router() 
{
    shape();
    cutterpin();
}
  %cutterpin();

module router() 
{
    color("green")
    difference() {
        linear_extrude(height, convexity = 20) children(0); //"shape()" basic shape
        minkowski(convexity = 120) {
            linear_extrude(epsilon, convexity = 20) difference() { // make inverted shape
                offset(delta = max(height, router_offset * 2)) hull() children(0); //"shape()"
                offset(router_offset) children(0); //"shape()"
            }
            children(1) ;// "cutterpin()"
        }
    }
}


module cutterpin() 
{
    //!
    rotate_extrude() 
    intersection() {
        square([height + router_offset, height + router_offset]); // cut away all geometry in negative quadrant,
        union() {
// insert your own profile here
            polygon([
                [0, 0],
                [router_offset, 0],
                [router_offset + height * .25, height * .5],
                [router_offset + height, height],
                [router_offset, height],
                [0, height]
            ]);
        }
    }
}

module shape() {
    //import your svg here 
    offset(3) polygon(shape);
}