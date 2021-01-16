{


    //
    for (i = [-1: 0.005: 3])

        color("gray") hull() {
            translate([jsin(10 * i * 360) * 0.1, 0, 0])
            translate([i * 2, min(i, 0) * -12, 0]) rotate([max(i, 0) * 360, 0, 0]) translate([0, 0, 2]) cube([2 - 0.1, 0.01, 0.05], center = true);
            j = i + 0.01;
            translate([jsin(10 * j * 360) * 0.1, 0, 0])
            translate([j * 2, min(j, 0) * -12, 0]) rotate([max(j, 0) * 360, 0, 0]) translate([0, 0, 2]) cube([2 - .1, 0.01, 0.05], center = true);
        }

    // uncut stainless
    color("gray") translate([-0.17, 1, 0] * 0.22)
    translate([0, 0, 2])
    linear_extrude(0.05,center=true)
    polygon([
        [-3, 12],
        [-1, 12],
        [0, 6],
        [-2, 6]
    ]);




    // final rocket trunk
    color("gray")translate([4, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(13) difference() {
        $fn = 120;
        circle(2 + 0.01);
        circle(2 - 0.002);
    }
     // final rocket weld
    color("orange") translate([2, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(2) difference() {
        $fn = 120;
        circle(2 + 0.01);
        circle(2 - 0.002);
    }
    $fn = 120;
 color("gold") translate([1, 0, 0]) color([0.6, 0.6, 0.6]) rotate([0, 90, 0]) linear_extrude(1) difference() {
        $fn = 120;
        circle(2 + 0.01);
        circle(2 - 0.002);
    }
    $fn = 120;
    // laser cutter profile edges
    color([0.4, 0.5, 0.7]) translate([-1.8, 12] * 0.5) translate([0, 0, 2]) cube([2.4, 0.5, 1], center = true);

    // coil
    color([0.6, 0.6, 0.6]) translate([-2, 12] * 1.025) translate([0, 0, 1]) rotate([0, 0, 7]) rotate([0, 90, 0]) cylinder(2, 1, 1, center = true);


    // xray and heat treat
    color("red") rotate([30, 0, 0]) translate([1, 0, 2]) cube([.5, 0.25, 1], center = true);
    color("orange") rotate([50, 0, 0]) translate([1, 0, 2]) cube([.5, 0.25, 1], center = true);
    color("gold") rotate([60, 0, 0]) translate([1, 0, 2]) cube([.5, 0.25, 1], center = true);
    color("blue") rotate([90, 0, 0]) translate([1, 0, 2]) cube([.5, 0.25, 1], center = true);


    //welder
    color("yellow") rotate([1, 0, 0]) translate([1, 0, 2]) cube([.125, 0.125, 1.5], center = true);
    color([1, .8, .3]) rotate([1, 0, 0]) translate([1, 0, 2]) cube([.4, 0.4, .25], center = true);


}

function jsin(s) =
max(clamp(sin(($t*-360)+s + 60) * 3, -0.5, 0.5), clamp(sin((
$t
*-360)+s) * 3, -0.5, 0.5));


function clamp(a, b, c) = min(max(a, min(b, c)), max(b, c));