use <utils/build_plate.scad>	 // build plate

// Tread width
treadWidth = 30;
// links between axels
numlinksinrow = 10;
// links around bearings
linksaround = 30;

//bearing();
//scale([.5,.5,.5])
tank();

module tank() {
    beltRadius = D+7;
    echo(str(beltRadius," belt radius."));
    echo(D+7, beltRadius);
    treadLength = numlinksinrow*s;
    echo(str(numlinksinrow," links in row, distance is ",treadLength,"."));
    astep = 180/linksaround;
    echo(str("astep ", astep));
    echo(str("len ",beltRadius*sin(astep)));
    sd = ns*pitch/(2*3.1415926);
    
    center_start = 57;
    cut_diag = center_start-sd;
    cut_side = cut_diag/sqrt(2);
    
    difference() {
        union() {
            // bearings
            scale([2,2,2]) bearing();
            translate([treadLength,0,0]) scale([2,2,2]) bearing();
            // straight tread runs
            translate([s/2-1.5,-beltRadius,0]) rotate([0,0,90]) vrow(s,treadLength-s);
            translate([treadLength+s/2+1.2,beltRadius,0]) rotate([0,0,-90]) vrow(s,treadLength);
            for (a = [astep*.4:astep:180]) {
                //echo(str("angle ",a));
                rotate([0,0,90+a]) translate([beltRadius,0,0]) rotate([0,0,180+90/linksaround]) vblock();
            }
            translate([treadLength,0,0]) for (a = [astep*.4:astep:179]) {
                //echo(str("angle ",a));
                rotate([0,0,-90+a]) translate([beltRadius,0,0]) rotate([0,0,180+90/linksaround]) vblock();
            }
        }
        translate([-200,-200,-h]) cube([400,400,h]); // clip top of belt
        translate([-200,-200,h]) cube([400,400,h]); // clip bottom of belt
        //translate([-200,-200,h/2]) cube([400,400,h]); // clip bottom of belt
    }
    // block
    echo(str("sd ",sd));
    echo(str("treadWidth ",treadWidth));
    echo(str("treadLength ",treadLength));
    difference() {
        translate([-sd,-sd,treadWidth]) cube([treadLength+2*sd,2*sd,treadWidth]);
        translate([sd,-sd-1,treadWidth]) rotate([0,45,0]) cube([cut_side,2*sd+2,cut_side]);
        translate([sd+cut_diag+treadLength-2*center_start,-sd-1,treadWidth]) rotate([0,45,0]) cube([cut_side,2*sd+2,cut_side]);
    }
    translate([center_start,-sd/2,0]) cube([treadLength-2*center_start,sd,treadWidth]);    // center support

    // minus gap from gear 1 to center
    // minus gap from center to gear 2
}

module treadTrack() {
    linear_extrude(height=h,twist=twist,slices=twist/6) translate([20,0,0]) circle(5);
}

// TREAD

// End with a clip (so the end clips to the other end) or an X (for using a buckle).
endShape = 1;//[1:Clip, 2:X Link]
	
// Shape, full belt, buckle, or previews
printShape = 4;//[2:Belt, 5:Buckle, 6:Belt & Buckle, 1:Test links, 3:X Link, 4:Preview Buckle]

// Show length of belt (show for configuring, hide for printing)
sl=1*1; // [0:Hide, 1:Show]

// Radius of pivot bars	
ir=2*1;
		
// gap between bar and enclosing shape to provide smooth rotation
g=0.75;
			
// Number of sides to cylinders (smoother is slower to render, any resolution will work)
sides=8;	// [6:hexagons, 8:octagons, 16:round, 32:super-smooth]

// Print whole or half belt
half=0; // [0:Whole, 1:Slice through belt to check alignments]

// Width of the belt (height of links)
h=30*1;				
or=ir+g;			// radius of cylinder around bar
// Thickness of the belt (width of links)
oor=4*1;			
round=1*1;
octagon=2*1;
// Shape of links
shape=1*1; // [1:Round, 2:Octagon]	
// roundness of round links: 1 - round, 0.1 is extremely skinny, 0.7 is what I use. If you change this, make sure you preview the belt carefully to make sure that the links don't intersect.
ooratio = 1.1*1;	
// spacing between links (if you change this, be prepared for advanced tweaking)
s=13*1;				
rl=numlinksinrow*s; 	// row length
// spacing between rows in 'snake', must be correct to align rows properly. If you change the spacing or number of links, you have to tweak (or calculate) this to get an exact fit.
rw=35.5*1;			

$fn=sides;	

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

// End Customizer params

// make a 'bar'

module bar() {
    translate([0,0,-2*ir]) scale([1,ooratio,1]) cylinder(r=oor,h=h,$fn=16);
	}

module v() {
	difference() {
		union() {
			cylinder(r=ir, h=h, $fn=sides);
			rotate([45,0,0]) bar();
//				if (shape==round) {
//					translate([0,0,-2*ir]) scale([1,ooratio,1]) cylinder(r=oor,h=h, $fn=16);
//					}
//				else {
//					translate([-oorm,-irm,-ir]) minkowski() {
//						cube([2*oorm,2*irm,h]);
//						cylinder(r=m, h=1, $fn=8);
//						}
//					}
			}
		union() {
			//translate([-1.5*oor,-oor,-1.5*oor]) cube([s+2*oor,2*oor,1.5*oor]);
			translate([-1.5*oor,-oor-h,h/2]) cube([s+2*oor,2*oor+h,h/2+g]);
			translate([0,-s,0]) cylinder(r=or,h=h, $fn=32);
			}
		}
	}

module vblock() {
	v();
	translate([0,0,h]) rotate([0,180,0]) v();
	}

module vrow(s,l) {
	for ( i = [0 : s : l] ) {
		translate([0,-i,0]) vblock();
		}
	}

module oswoop() {
	translate([0,rl+2*s,0]) vrow();
	translate([0,s,0]) vblock();
	rotate([0,0,45]) {
		vblock();
		translate([0,-s,0]) rotate([0,0,45]) {
			vblock();
			translate([0,-s,0]) rotate([0,0,45]) {
				vblock();
				translate([0,-s,0]) rotate([0,0,45]) {
					vblock();
					translate([0,-s,0]) vrow();
					translate ([0,-rl-2*s,0]) rotate([0,0,-45]) {
						vblock();
						translate([0,-s,0]) rotate([0,0,-45]) {
							vblock();
							translate([0,-s,0]) rotate([0,0,-45]) {
								vblock();
								}
							}
						}
					}
				}
			}
		}
	}

module swoop() {
	translate([0,rl+2*s,0]) vrow();
	translate([0,s,0]) vblock();
	rotate([0,0,60]) {
		vblock();
		translate([0,-s,0]) rotate([0,0,60]) {
			vblock();
			translate([0,-s,0]) rotate([0,0,60]) {
				vblock();
				rotate([0,0,angle]) translate([0,-s,0]) vrow();
				translate ([9.5,-rl-2*s+.4,0]) rotate([0,0,-60]) {
					vblock();
					translate([0,-s,0]) rotate([0,0,-60]) {
						vblock();
						}
					}
				}
			}
		}
	}

module snake() {
	for ( j = [0:rw:numrows*rw]) {
		translate([j,0,0]) swoop();
		}
	translate([(1+numrows)*rw,rl+2*s-0.4,0]) vrow();
	translate([(1+numrows)*rw,s,0]) {
		if (endShape==1) cblock();
		if (endShape==2) xblock();
		}
	}
    
module belt() {

// And print the belt

translate([-90,20,0]) rotate([0,0,-90])
difference() {
	union() {
		if ((printShape==2) || (printShape==6)) {
			snake();
			if (printShape==6) 
				translate([45+rw*numrows,0,0]) translate([0,0,3]) rotate([0,90,0]) buckle();
			}
		if (printShape==1) {
			vblock();
			//translate([0,-s,0]) rotate([0,0,60]) xblock();	
			translate([0,-s,0]) vblock();	
			translate([0,s,0]) cblock();	
			translate([0,-2*s,0]) rotate([0,0,60]) cblock();
			}
		if (printShape==3) xblock();
		if (printShape==4) {
			vblock();
			translate([0,-s,0]) vblock();
			translate([0,7*s,0]) xblock();
			translate([0,8*s,0]) vblock();
			translate([or,-oor-3,0]) buckle();
			}
		if (printShape==5) {
			translate([0,0,3]) rotate([0,90,0]) buckle();
			}
		}
    translate([-200,-200,-h]) cube([400,400,h]); // clip top of belt
    if (half) translate([-200,-200,h/2]) cube([400,400,h]);	// chop in half to check alignments
    translate([-200,-200,h]) cube([400,400,h]); // clip bottom of belt
    }

    label=str(links," links ",length," mm = ",floor(length/.245)/100," inches.");
    echo(label);
    if (sl) 
        %translate([0,-50-rw*numrows,0]) 
            write(label,h=10,t=1, space=1, center=true, font="write/Letters.dxf");

    build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
    }

// BEARING

// Planetary gear bearing (customizable)

// outer diameter of ring (not counting gears)
D=51.7;
// Number of gears on outside of bearing
outergearcount = 2*linksaround; // all the way around
// Outer gear spacing
outergearheight = -.2;
// thickness
T=15;
// clearance
tol=0.3;
number_of_planets=5;
number_of_teeth_on_planets=7;
approximate_number_of_teeth_on_sun=9;
// pressure angle
P=45;//[30:60]
// number of teeth to twist across
nTwist=1;
// width of hexagonal hole
whole=6.7;

DR=0.5*1;// maximum depth ratio of teeth

m=round(number_of_planets);
np=round(number_of_teeth_on_planets);
ns1=approximate_number_of_teeth_on_sun;
k1=round(2/m*(ns1+np));
k= k1*m%2!=0 ? k1+1 : k1;
ns=k*m/2-np;
echo(ns);
nr=ns+2*np;
pitchD=0.9*D/(1+min(PI/(2*nr*tan(P)),PI*DR/nr));
pitch=pitchD*PI/nr;
echo(pitch);
helix_angle=atan(2*nTwist*pitch/T);
echo(helix_angle);

phi=$t*360/m;

module bearing(){

    translate([0,0,T/2]){
        // outer ring
        difference(){
            union() {
                herringbone(outergearcount,pitch+outergearheight,P,DR/2,-tol,helix_angle,T)
                cylinder(r=D/2,h=T,center=true,$fn=100);
            }
            herringbone(nr,pitch,P,DR,-tol,helix_angle,T+0.2);
//            difference(){
//                translate([0,-D/2,0])rotate([90,0,0])monogram(h=10);
//                cylinder(r=D/2-0.25,h=T+2,center=true,$fn=100);
//                }
            }
        // sun gear
        rotate([0,0,(np+1)*180/ns+phi*(ns+np)*2/ns])
        difference() {
            mirror([0,1,0])
                herringbone(ns,pitch,P,DR,tol,helix_angle,T);
            cylinder(r=whole/sqrt(3),h=T+1,center=true,$fn=6);
        }
        // planet gears
        for(i=[1:m]){
                rotate([0,0,i*360/m+phi])translate([pitchD/2*(ns+np)/nr,0,0])
                    rotate([0,0,i*ns/m*360/np-phi*(ns+np)/np-phi])
                        herringbone(np,pitch,P,DR,tol,helix_angle,T);
            }
        }
    }

module rack(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	helix_angle=0,
	clearance=0,
	gear_thickness=5,
	flat=false) {
		addendum=circular_pitch/(4*tan(pressure_angle));
		
		flat_extrude(h=gear_thickness,flat=flat)translate([0,-clearance*cos(pressure_angle)/2])
			union(){
				translate([0,-0.5-addendum])square([number_of_teeth*circular_pitch,1],center=true);
				for(i=[1:number_of_teeth])
					translate([circular_pitch*(i-number_of_teeth/2-0.5),0])
					polygon(points=[[-circular_pitch/2,-addendum],[circular_pitch/2,-addendum],[0,addendum]]);
			}
		}

module monogram(h=1)
	linear_extrude(height=h,center=true)
	translate(-[3,2.5])union(){
		difference(){
			square([4,5]);
			translate([1,1])square([2,3]);
		}
		square([6,1]);
		translate([0,2])square([2,1]);
	}

module herringbone(
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5){
     //echo(str("herringbone ",number_of_teeth," teeth, circular pitch ", circular_pitch));
		union(){
			gear(number_of_teeth,
				circular_pitch,
				pressure_angle,
				depth_ratio,
				clearance,
				helix_angle,
				gear_thickness/2);
			mirror([0,0,1])
				gear(number_of_teeth,
					circular_pitch,
					pressure_angle,
					depth_ratio,
					clearance,
					helix_angle,
					gear_thickness/2);
		}
	}

module gear (
	number_of_teeth=15,
	circular_pitch=10,
	pressure_angle=28,
	depth_ratio=1,
	clearance=0,
	helix_angle=0,
	gear_thickness=5,
	flat=false){
		pitch_radius = number_of_teeth*circular_pitch/(2*PI);
		twist=tan(helix_angle)*gear_thickness/pitch_radius*180/PI;
		
		flat_extrude(h=gear_thickness,twist=twist,flat=flat)
			gear2D (
				number_of_teeth,
				circular_pitch,
				pressure_angle,
				depth_ratio,
				clearance);
		}

module flat_extrude(h,twist,flat){
	if(flat==false)
		linear_extrude(height=h,twist=twist,slices=twist/6)child(0);
	else
		child(0);
	}

module gear2D (
	number_of_teeth,
	circular_pitch,
	pressure_angle,
	depth_ratio,
	clearance){
		pitch_radius = number_of_teeth*circular_pitch/(2*PI);
		base_radius = pitch_radius*cos(pressure_angle);
		depth=circular_pitch/(2*tan(pressure_angle));
		outer_radius = clearance<0 ? pitch_radius+depth/2-clearance : pitch_radius+depth/2;
		root_radius1 = pitch_radius-depth/2-clearance/2;
		root_radius = (clearance<0 && root_radius1<base_radius) ? base_radius : root_radius1;
		backlash_angle = clearance/(pitch_radius*cos(pressure_angle)) * 180 / PI;
		half_thick_angle = 90/number_of_teeth - backlash_angle/2;
		pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
		pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
		min_radius = max (base_radius,root_radius);

		intersection(){
			rotate(90/number_of_teeth)
				circle($fn=number_of_teeth*3,r=pitch_radius+depth_ratio*circular_pitch/2-clearance/2);
			union(){
				rotate(90/number_of_teeth)
					circle($fn=number_of_teeth*2,r=max(root_radius,pitch_radius-depth_ratio*circular_pitch/2-clearance/2));
				for (i = [1:number_of_teeth])rotate(i*360/number_of_teeth){
					halftooth (
						pitch_angle,
						base_radius,
						min_radius,
						outer_radius,
						half_thick_angle);		
					mirror([0,1])halftooth (
						pitch_angle,
						base_radius,
						min_radius,
						outer_radius,
						half_thick_angle);
				}
			}
		}
	}

module halftooth (
	pitch_angle,
	base_radius,
	min_radius,
	outer_radius,
	half_thick_angle){
index=[0,1,2,3,4,5];
start_angle = max(involute_intersect_angle (base_radius, min_radius)-5,0);
stop_angle = involute_intersect_angle (base_radius, outer_radius);
angle=index*(stop_angle-start_angle)/index[len(index)-1];
p=[[0,0],
	involute(base_radius,angle[0]+start_angle),
	involute(base_radius,angle[1]+start_angle),
	involute(base_radius,angle[2]+start_angle),
	involute(base_radius,angle[3]+start_angle),
	involute(base_radius,angle[4]+start_angle),
	involute(base_radius,angle[5]+start_angle)];

difference(){
	rotate(-pitch_angle-half_thick_angle)polygon(points=p);
	square(2*outer_radius);
}}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / PI;

// Calculate the involute position for a given base radius and involute angle.

function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*PI/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*PI/180*cos (involute_angle))
];
