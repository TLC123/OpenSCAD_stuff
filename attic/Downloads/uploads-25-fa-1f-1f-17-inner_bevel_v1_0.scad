// inner_bevel_v1_0
// GPLv2
// (c) 2013 TakeItAndRun
//
// This is based on an idea by GregFrost on how to make 
// a bevel for an arbirary (2D) shape.
// see: http://www.thingiverse.com/thing:135408

// height of the z-plane to put bevels on
h=20;

// height of the bevel
h_bevel=4;
// width of the bevel
r_bevel=4;

// number of faces of a circle
// (don`t set this too high as the time to compile will increase rabbitly(sp?))
$fn=16;// decrease to 8 for testing

// small number
e=0.02;

// your part
module part(){
	cube([30,40,20]);
	cube([20,10,40]);
	cube([10,25,40]);
	translate([10,25,0])
		cylinder(40,5,5);
// this cylinder is commented out, because minkowski() is not implemented
// for disjointed objects
//	translate([40,10,0])
//		cylinder(40,5,5);
}

// 2D slice of the part at the hight h
module slice(h){
	projection(cut=true)
		translate([0,0,-h])
			child();	
}

// edge of the 2D slice 
// the edge has a width of approx. e
module edge(size=e){
	difference(){
		minkowski(){
			child();
			square(size,true);
		}
	child();
	}
}

// inner edges of the part at hight h
module diffedge(h){
	difference(){
// edge above the plane at hight h
		edge()slice(h+e)child();
// edge of the plane at hight h
		edge()slice(h)child();
	}
}

// create the bevel by "moving" the form of the bevel along the inner edge
module bevel_edge(h)
	minkowski(){
// extrude the 2D inner edge to a very thin 3D part,
// as minkowski can akt only on either 2D or 3D arguments
		linear_extrude(height=e)
			diffedge(h)child();
		bevel();
}

// shape of the bevel
module bevel(){
//	cylinder(h=h_bevel,r1=r_bevel,r2=0); // use this for a simple straight bevel (commenting out the rest of this modul)
		rotate_extrude()
		scale([1,h_bevel/r_bevel])
		difference(){
			square(r_bevel);
			translate([r_bevel,r_bevel])circle(r_bevel);
		}
}

// add the bevel to the part
module add_bevel(h){
	child();
	translate([0,0,h])
		bevel_edge(h)child();
}

// subtract the bevel the extends over the edge of the original part
// (This is not perfect and may, for complicated parts, requiere additional (manual) pruning.)
module inner_bevel(h){
	intersection(){
		add_bevel(h)child();
		hull()child();
	}
}

// inner bevel onto the z-plane at height h
inner_bevel(h)
part();


