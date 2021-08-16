// Aleksandr Saechnikov 17 june 2015

extrusion_profile_20x20_v_slot(size=20, height=10);
translate([30,0,0]) extrusion_profile_20x20_v_slot_smooth(size=20, height=10);

$fn = 30;

module extrusion_profile_20x20_v_slot(size=20, height=10) {
	linear_extrude(height=height) {
		union() {
			extrusion_profile_20x20_v_slot_part(size);
			rotate([0,0,90])  extrusion_profile_20x20_v_slot_part(size);
			rotate([0,0,180]) extrusion_profile_20x20_v_slot_part(size);
			rotate([0,0,270]) extrusion_profile_20x20_v_slot_part(size);
		}
	}
}

module extrusion_profile_20x20_v_slot_part(size=20) {
	d = 5;
	r = 1.5;
	s1 = 1.8;
	s2 = 2;
	s3 = 6;
	s4 = 6.2;
	s5 = 9.5;
	s6 = 10.6;
	s7 = 20;

	reSize = size/20; // Scalling

	k0 = 0;
	k1 = d*0.5*cos(45)*reSize;
	k2 = d*0.5*reSize;
	k3 = ( (s7*0.5-s3)-s1*0.5*sqrt(2) )*reSize;
	k4 = s4*0.5*reSize;
	k5 = ( s7*0.5-s3 )*reSize;
	k6 = s6*0.5*reSize;
	k7 = ( s6*0.5+s1*0.5*sqrt(2) )*reSize;
	k8 = ( s7*0.5-s2 )*reSize;
	k9 = s5*0.5*reSize;
	k10 = s7*0.5*reSize;
	k10_1 = k10-r*(1-cos(45))*reSize;
	k10_2 = k10-r*reSize;

	polygon(points=[
		[k1,k1],[k0,k2],[k0,k5],[k3,k5],
		[k6,k7],[k6,k8],[k4,k8],[k9,k10],
		[k10_2,k10],[k10_1,k10_1],
		[k10,k10_2],
		[k10,k9],[k8,k4],[k8,k6],[k7,k6],
		[k5,k3],[k5,k0],[k2,k0]
	]);
}

module extrusion_profile_20x20_v_slot_smooth(size=20, height=10) {
	linear_extrude(height=height) {
		difference() {	
			union() {
				extrusion_profile_20x20_v_slot_part_smooth(size);
				rotate([0,0,90])  extrusion_profile_20x20_v_slot_part_smooth(size);
				rotate([0,0,180]) extrusion_profile_20x20_v_slot_part_smooth(size);
				rotate([0,0,270]) extrusion_profile_20x20_v_slot_part_smooth(size);
			}
			circle([0,0],r=size/20.*2.5);
		}
	}
}

module extrusion_profile_20x20_v_slot_part_smooth(size=20) {
	r_center = 0.5*size-1.5*size/20;
	union() {
		translate ([r_center,r_center]) circle(r=1.5*size/20);
		extrusion_profile_20x20_v_slot_part(size);
	}
}




