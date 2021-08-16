h=20;

h_bevel=3;
r_bevel=3;

function h_bev(i)=h_bevel*(1-cos(90*i));
function r_bev(i)=((i==1)?e:0)+r_bevel*(1-sin(90*i));


e=0.001;

fn_bevel=16 ;
$fn=32;

module part_base(){
	cube([60,30,20]);
}

module part1(){
	translate([25,15,20])
		rotate([0,45,0])
			cylinder(40,10,2.5,true,$fn=4);
}

module part2(){
	translate([25,15,20])
		difference(){
		rotate([90,0,0])
			rotate_extrude()translate([10,0,0])circle(5);
		rotate([0,45,0])translate([100,0,0])cube(200,true);
		}
}

module part3(){
	translate([25,15,20])
		rotate([0,135,0])
			translate([-10,0,0])
			linear_extrude(height=15+e,scale=[1,e])circle(5);
}

module slice(h){
	projection(cut=true)
		translate([0,0,-h])
			child();
}

module edge(){
	difference(){
		minkowski(){
			child();
			circle(e);
		}
		child();
	}
}

module bev(i){
	minkowski(){
		child();
		circle(r_bev(i));
	}
}

module extrude(){
	linear_extrude(height=e)child();
}

module bevel(h,h_bevel,r_bevel,fn_bevel){
	translate([0,0,h])
		for(i=[0:1/fn_bevel:1-1/fn_bevel]){
			hull(){
				translate([0,0,h_bev(i)])
					extrude()bev(i)edge()slice(h+h_bev(i))child();
				translate([0,0,h_bev(i+1/fn_bevel)])
					extrude()bev(i+1/fn_bevel)edge()slice(h+h_bev(i+1/fn_bevel))child();
			}
		}
}

bevel(h,h_bevel,r_bevel,fn_bevel)part2();
bevel(h,h_bevel,r_bevel,fn_bevel)part3();
part3();
part2();
part_base();
