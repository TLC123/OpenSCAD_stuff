union()
{

	translate([-3,.5,10])
	import_stl("tentacle.stl");

	import_stl("Y1.stl", convexity = 5);

	cylinder(h = 11, r = 15);
	
}