include <OpenScadFont.scad>

radius=40;
thickness=11;
edge=18;

Text1=[ ["M"],["a"],["k"],["e"],["r"],["B"],["o"],["t"] ];
Kern1=[ -3,0,0,0,0,0,0,0 ];

Text2=[ ["I"],["n"],["d"],["u"],["s"],["t"],["r"],["i"],["e"],["s"] ];
Kern2=[ 6,0,0,0,0,0,0,0,-6,-6 ];

difference()
{
	rotate([0,-90,-45])
	union()
	{
		rotate([0,-90,0])
		translate([0,0,1])
		difference()
		{
			translate([0,0,-thickness/2-1])
			cylinder(h=thickness+1,r1=radius+edge,r2=radius+edge);
	
			translate([0,0,-thickness/2-2])
			cylinder(h=thickness/2+2,r1=radius,r2=radius);
		}
	
		intersection()
		{
			rotate([0,90,0])
			translate([0,0,-1])
			cylinder(h=1,r1=radius,r2=radius);
			
			translate([0,0,-radius-15])
			scale([20,1,1])
			import_stl("BreTest01_lowpoly.STL");
		}
	
		intersection()
		{
			rotate([0,90,0])
			cylinder(h=thickness/2,r1=radius,r2=radius);
			
			translate([0,0,-radius-15])
			scale([0.3,1,1])
			import_stl("BreTest01_lowpoly.STL");
		}
	}

	union()
	{
		for(i=[0:7])
		{
			rotate([0,0,-i*16 -Kern1[i]])
			translate([-radius-edge/2-2,0,thickness/3])
			scale(0.6) 
			fnt_str( Text1[i], 1, 1, 10 );
		}
		
		for(i=[0:9])
		{
			rotate([0,0,80+i*12  +Kern2[i]])
			translate([-radius-4,0,thickness/3])
			rotate([0,0,180])
			scale(0.6)
			fnt_str( Text2[i], 1, 1, 10 );
		}
	}
}