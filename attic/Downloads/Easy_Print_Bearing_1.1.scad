//DIMENSIONS
width=21;					//width of bearing
out_rad1=50;				//outer radius
out_rad2=out_rad1;			//change for tapered bearings
in_rad=(1/2)*out_rad1;		//inner radius


//MODULE DEFINITIONS
module case()
{
	difference()
	{
		cylinder(width,out_rad1,out_rad2, center=true, $fn=100);
		cylinder(1.1*width,in_rad,in_rad,center=true, $fn=100);
	}
}

module ring()
{
	rotate_extrude($fn=100) translate([(3/4)*out_rad1,0,0]) scale([0.75,1.25]) circle((1/2)*width);
}

module roller()
{
	intersection()
	{
		translate([0,(3/4)*out_rad1,0]) scale([0.95,0.95,1]) scale([0.75,0.75,1.25]) sphere((1/2)*width, $fn=50);

		//Above: first scale is to make rollers have a gap between the walls of the inner and outer ring, second scale is to get the correct roller shape. If the roller gap needs to be larger or smaller adjust the values is the first scale appropriatly (don't forget to change all three the same so the profile of the roller doesn't change!). 

		translate([0,(3/4)*out_rad1,0]) cube(width, center=true);
	}
}

//CONSTRUCTION
difference()
{
	case();
	ring();
}

for(n=[1:15])
{
	rotate([0,0,(n*(360/15))]) roller();
}