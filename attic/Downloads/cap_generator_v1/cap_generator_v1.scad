/*----------------------------------------------------------------------------*/
/* Cap Generator
/* by Ziv Botzer
/*----------------------------------------------------------------------------*/

// Turn on for validation during preview, TURN OFF FOR PRODUCTION
show_slice = "On"; // [On, Off]

// Hole shape
hole_shape = "Square"; // [Round, Square, Rectangle]

// HOLE Dimension 1 (if circular = diameter)
hole_dimension1 = 34.8; // [10:0.1:150]

// HOLE Dimension 2 (only for rectangle shape)
hole_dimension2 = 50; // [10:0.1:150]

// HOLE Corner Radius (for square/rectangle shapes)
hole_radius = 10; // [0:0.1:20]

// HOLE Depth (e.g. for a table, thickness of the board)
hole_depth = 20; // [2:0.1:100]


// PLUG: plug length
plug_length = 15; // [2:0.1:100]

// PLUG: plug clearance inside hole
plug_clearance = 1; // [0:0.1:5]

// PLUG: plug material thickness
plug_thickness = 1.5; // [0.5:0.1:5]

// PLUG: Choose if you like snaps or fins
features = "Snaps"; // [Snaps, Fins, None]

// PLUG: Snaps/Fins protrusion of teeth (mm)
feature_length = 1.0; // [0.1:0.1:6]

// PLUG: Snaps/Fins height of teeth (mm)
feature_height = 1.5; // [0.1:0.1:6]

// PLUG FINS: Number of fins
fin_number = 3; // [1:1:6]

// PLUG SNAPS: Determines gaps size between snaps
snap_width_factor = 0.5; // [0.1:0.1:1]


// COVER: thickness (mm)
cover_thickness = 2; // [0.5:0.1:15]

// COVER: Overlap around hole
cover_offset = 3; // [0:0.1:30]

// COVER: Edge design
cover_edge = "Chamfer"; // [Chamfer, Round]

// COVER: Edge design ratio 1 (relative size of chamfer/fillet)
cover_edge_ratioV = 0.5; // [0:0.1:1]

// COVER: Edge design ratio 2 (relative size of chamfer/fillet)
cover_edge_ratioH = 0.1; // [0:0.1:1]

// QUALITY: number of polygon facets
$fn = 40;

// QUALITY: steps in fillet cover design 
fillet_steps = 6; // [4:1:15]


/* [Hidden] */
clearance = 0.01;
show_slice_ = (show_slice=="On");
snaps = features == "Snaps";
fins = features == "Fins";

/* testing area
hole_shape = "Rectangle"; // [Round, Square, Rectangle]
snap_width_factor = .5; // [0.1:0.1:1]
show_slice = "Off"; // [On, Off]
features = "Fins"; // [Snaps, Fins, None]
fin_number = 3; // [1:1:6]
hole_radius = 1; // [0:0.1:20]
*/

/*****************************************/
// Show hole

larger_dim = ((hole_shape=="Rectangle")?max(hole_dimension1, hole_dimension2) : hole_dimension1) + cover_offset;
smaller_dim = (hole_shape=="Rectangle")?min(hole_dimension1, hole_dimension2) : hole_dimension1;
largest_depth = max(hole_depth, plug_length)+cover_thickness+1;

// can't have corner radius exceed half the facet length
hole_radius_safe = (hole_radius > smaller_dim/2) ? (smaller_dim/2 - clearance) : hole_radius;

// Illustrate the piece needing a cover
if (show_slice_)
%difference() {
    translate([0,0,-hole_depth/2])
    cube([larger_dim*1.5,larger_dim*1.5,hole_depth],center=true);
    
    translate([0,0,-(hole_depth+clearance)])
    linear_extrude(hole_depth+4*clearance)
    gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);

    if (show_slice_)
        translate([0,-larger_dim/2, -(largest_depth/2-clearance)])
        cube([larger_dim*2.2, larger_dim*1, largest_depth+clearance*4], center=true);
}

// Generate the cap
difference() {
    generate_cap();
    
    color("Red")
    if (show_slice_)
        translate([0,-larger_dim/2-0.01, -(largest_depth/2)])
        cube([larger_dim*1.8, larger_dim*1, largest_depth*2], center=true);
}




//********************** FUNCTIONS *****************************

module generate_cap () {
    
    union() {
        // Generate cover with corner design
        if (cover_edge == "Chamfer") {
            linear_extrude((1-cover_edge_ratioV)*cover_thickness + clearance, convexity = 4)
            offset(r=cover_offset)
                gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
            
            hull() {
                translate([0,0,(1-cover_edge_ratioV)*cover_thickness])
                for (i = [0,1]) {
                    translate([0,0,i*cover_edge_ratioV*cover_thickness])
                    linear_extrude(0.01)
                    offset(r=cover_offset-i*cover_edge_ratioH*smaller_dim)
                    gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                }
            }
            
         
        }
        else if (cover_edge == "Round") {
            linear_extrude((1-cover_edge_ratioV)*cover_thickness + clearance, convexity = 4)
            offset(r=cover_offset)
                gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
            
            hull() {
                translate([0,0,(1-cover_edge_ratioV)*cover_thickness])
                for (i = [0:1/fillet_steps:1]) {
                    translate([0,0, sin(i*90)*cover_edge_ratioV*cover_thickness])
                    linear_extrude(0.01)
                    offset(r=cover_offset - (1-cos(i*90))*cover_edge_ratioH*smaller_dim)
                    gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                }
            }
        }
        
        // Generate plug
        difference() {
            
            union() {
                translate([0,0,-(plug_length) + clearance])
                linear_extrude(plug_length+clearance, convexity = 4)
                offset(r=-plug_clearance)
                gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);

                
                // Generate plug fins
                //translate([0,0,-(hole_depth) + clearance])
                if (fins) {
                    d = plug_length/(fin_number+1);
                    for (i = [1:fin_number]) {
                        translate([0,0,-(d*i + 0.3*d)])
                        hull() {
                            linear_extrude(0.01)
                            offset(r=-plug_clearance)
                            gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                            
                            translate([0,0,feature_height])
                            linear_extrude(0.2)
                            offset(r=feature_length-plug_clearance)
                            gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                        }
                    }
                }
                
                if (snaps) {
                    translate([0,0,-plug_length])
                    hull() {
                        linear_extrude(0.01)
                        offset(r=-plug_clearance)
                        gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                        
                        translate([0,0,feature_height])
                        linear_extrude(0.2)
                        offset(r=feature_length-plug_clearance)
                        gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                    }

                }
            }
            
            // remove inner volume of plug
            translate([0,0,-(plug_length) - clearance])
            linear_extrude(plug_length+2*clearance, convexity = 4)
            offset(r=-(plug_clearance+plug_thickness))
            gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
            
            // remove edge chamfer
            if (!snaps)
            translate([0,0,-(plug_length) ])
            difference() {
                linear_extrude(plug_thickness/2 + clearance )
                offset(r=-plug_clearance  + clearance)
                gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
            
                hull() {
                    linear_extrude(0.01)
                    offset(r=-plug_clearance -(plug_thickness/2)  + 2*clearance)
                    gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                    
                    translate([0,0,plug_thickness/2 + 2*clearance ])
                    linear_extrude(0.01)
                    offset(r=-plug_clearance)
                    gen_hole_shape(hole_dimension1, hole_dimension2, hole_radius_safe);
                }
            }
            
            // remove snap gaps
            if (snaps) {
                if (hole_shape == "Square") {
                    factor = 0.5+snap_width_factor*0.4;
                    rotate([0,0,45])
                    for (i = [1:4]) {
                        rotate([0,0,i*360/4])
                        translate([factor*hole_dimension1/sin(45),0,-(plug_length/2 + clearance)])
                        rotate([0,0,45])
                        cube([hole_dimension1,hole_dimension1,plug_length+4*clearance], center=true);
                    }
                    
                } 
                else if (hole_shape == "Round") {
                    factor = 0.48+snap_width_factor*0.3;
                    rotate([0,0,45])
                    for (i = [1:4]) {
                        rotate([0,0,i*360/4])
                        translate([factor*hole_dimension1/sin(45),0,-(plug_length/2 + clearance)])
                        rotate([0,0,45])
                        cube([hole_dimension1,hole_dimension1,plug_length+4*clearance], center=true);
                    }
                }
                else { // Rectangle
                    factor = 0.5+0.4*snap_width_factor;
                    
                    translate([-factor*hole_dimension1,factor*hole_dimension2,-(plug_length/2 + clearance)])
                    cube([hole_dimension1,hole_dimension2,plug_length+4*clearance], center=true);
                    
                    translate([factor*hole_dimension1,factor*hole_dimension2,-(plug_length/2 + clearance)])
                    cube([hole_dimension1,hole_dimension2,plug_length+4*clearance], center=true);
                    
                    translate([-factor*hole_dimension1,-factor*hole_dimension2,-(plug_length/2 + clearance)])
                    cube([hole_dimension1,hole_dimension2,plug_length+4*clearance], center=true);
                    
                    translate([factor*hole_dimension1,-factor*hole_dimension2,-(plug_length/2 + clearance)])
                    cube([hole_dimension1,hole_dimension2,plug_length+4*clearance], center=true);
                    
                }
                
            }
            
        }
    }
}

module gen_hole_shape ( d1, d2, r1 ) {
    if (hole_shape == "Round") {
        circle(d=d1);
    }
    else {
        d1b = d1 - 2*r1;
        d2b = ((hole_shape == "Square")?d1:d2) - 2*r1;
        
        translate([-d1b/2,-d2b/2,0]) {
            if (r1 > 0)
                minkowski() {
                    circle(r1);
                    square([d1b,d2b]);
                }
            else {
                square([d1b,d2b]);
            }
        }
    }
}
