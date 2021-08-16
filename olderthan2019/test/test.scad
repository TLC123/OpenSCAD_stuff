
// Domino

fn = 10;
length = 40;
width = 21.25;
depth = 6.25;
pip_radius = 1.75;
pip_depth = 0.75;

spacing = 3;

pip_pat = [ [[]],  //     #0 has no pips
            [[[0,0]]], // #1
            [[[-1,-1],[1,1]]], // #2
            [[[-1,-1],[0,0],[1,1]]],  // #3
            [[[-1,-1],[-1,1],[1,-1],[1,1]]], // #4
            [[[-1,-1],[-1,1],[1,-1],[1,1],[0,0]]], // #5
            [[[-1,-1],[-1,0],[-1,1],[1,-1],[1,0],[1,1]]]  // #6
];
        
module pip(r, d) {
    sphere_radius = (pow(r,2) + pow(d,2)) / (2*d);
    translate([0,0,sphere_radius-d]) sphere(sphere_radius, $fn=fn);
}

module pips(num, size, r, d) {
    union () {
        for(all_pips = pip_pat[num]) {
            for(this_pip = all_pips) {
                translate(size*[this_pip[0],this_pip[1],0]) pip(r,d);
            }
        }
    }
}

module domino(num_A, num_B, length, width, depth) {
    difference () {
        cube([length,width,depth], r=0.5, center=true);
        translate([0,0,depth/2]) 
            rotate([90,0,0]) 
                cylinder(h=1.1*width, r=pip_radius/3, center=true, $fn=fn);
        translate([length/4,0,depth/2])  pips(num_A,width/4, pip_radius, pip_depth);
        translate([-length/4,0,depth/2])  pips(num_B,width/4, pip_radius, pip_depth);
    }
}

module dominoes(length, width, depth, spacing, maxpips) {
    union () {
        for(row = [0:maxpips]) {
            for(col = [row:maxpips]) {
                translate([col*(length+spacing),row*(width+spacing),0]) domino(col, row, length, width, depth);
            }
        }
    }
}

dominoes(length,width,depth,spacing, 3);
