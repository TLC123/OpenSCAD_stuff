$fn = 50;
llen = 50;
lhgt = 7;
lwid = lhgt;
lthk = 1.5;
lxtr = 10;
dpost = 1.5;
dhole = dpost+0.3;
psqs = lwid;
l2wid = lwid - 1;
thgt = lthk + dhole/2 + 0.5;
cwid = 5;
chgt = lthk+0.75;
nwid = lwid-2*lthk-0.5;
nlen = lwid/2+0.5;

use <write/Write.scad>

module tab(disp) {
	difference() {
		union () {
			translate([0,disp,thgt]) rotate([90,0,0]) 
				cylinder(h=lthk,d=lwid,center=true);
			translate([0,disp,thgt/2]) 
				cube([lwid,lthk,thgt],center=true);
		}
		translate([0,disp,thgt]) rotate ([90,0,0]) 
			cylinder(h=2*lthk,d=dhole,center=true);
		translate([0,disp,-lwid/4]) 
			cube([lwid,lthk+1,lwid/2],center=true);
	}
}

module base() {
	translate([-lxtr,-lwid/2,0]) cube([llen+lxtr,lwid,lthk]);
	translate([-lxtr,-lwid/2,0]) 
		cube([lxtr-lwid/2,lwid,thgt-lthk/2]);
	translate([llen-(psqs/1.4142135),0,0]) rotate ([0,0,-45]) 
		cube([psqs,psqs,lthk]);
	translate([llen-2,-0.35*lwid,0])
		#write("2",t=chgt,h=cwid,font="Letters.dxf",space=1.3);
	for (disp=[(lthk-lwid)/2,(lwid-lthk)/2]) tab(disp);
	translate([-lwid/2,0,0]) cube([lwid,llen,lthk]);
	translate([0,llen-(psqs/1.4142135),0]) rotate ([0,0,45]) 
		cube([psqs,psqs,lthk]);
	rotate([0,0,90]) translate([llen-11,-0.35*lwid,0])
		#write("1x2",t=chgt,h=cwid,font="Letters.dxf",space=1.3);
}

module arm() {
	translate([0,-nwid/2,0]) cube([llen,nwid,lthk]);
	translate([nlen,-lwid/2,0]) cube([llen-nlen,lwid,lthk]);
	translate([llen-(psqs/1.4142135),0,0]) rotate ([0,0,-45]) 
		cube([psqs,psqs,lthk]);
	translate([0,0,lthk/2]) rotate([90,0,0]) 
		cylinder(h=nwid+1,d=dpost,center=true);
	translate([llen-2,-0.35*lwid,0])
		#write("1",t=chgt,h=cwid,font="Letters.dxf",space=1.3);
}

base();
translate([lwid,llen-0.8*lwid,0]) rotate([0,0,-45]) arm();