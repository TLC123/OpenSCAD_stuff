goldenratio = 1.61803399;
joinfactor = 0.125; 

gSteps = 50;
gHeight = 6;

gArmLength = 45;

gAxleRadius = 3/8/2*25.4*1.04; 
gAxleOR = gAxleRadius*2*goldenratio;
gAxleLength = 1/2*25.4;

//axlemount(gAxleLength, gAxleOR, gAxleRadius, 5); 

//SwoopArm();
SwoopArms();

module axlemount(axlelength, axlesize, axleRadius, axleoffset) 
{
	difference()
	{
		union()
		{
			// The base of the part
			translate([-axlesize/2, -axlelength/2, 0])
			cube(size=[axlesize, axlelength, axlesize/2+axleoffset]);

			// The rounded top of the part
			translate([0, 0, axlesize/2+axleoffset])
			rotate([90, 0, 0])
			cylinder(r= axlesize/2, h=axlelength, center=true);
		}

		// Subtract out the axle hole
		translate([0, 0, axlesize/2+axleoffset])
		rotate([90, 0, 0])
		cylinder(r= axleRadius, h=axlelength+2*joinfactor, center=true);
	}
}

module SwoopArm(width =20)
{
	endradius = width/2;
	halfarm = gArmLength / 2;

	BezCubicRibbon([
		[0,-halfarm],[halfarm,0],[halfarm,halfarm],[halfarm/goldenratio,halfarm]], 
		[[0,-halfarm-width],[halfarm+width,width/2],[halfarm+width,halfarm],[halfarm+width,halfarm+width/2]]
	); 
	
	// The looped end
	BezCubicFilletColored(
		[[halfarm/goldenratio,halfarm],
		[halfarm/goldenratio/goldenratio,halfarm+width],
		[halfarm,halfarm+width*goldenratio],
		[halfarm+width,halfarm+width/2]], 
		[(halfarm/goldenratio)+((halfarm+width)-(halfarm/goldenratio))/2,(halfarm/goldenratio)+((halfarm+width)-(halfarm/goldenratio))/2 ]);

	rotate([0,0,40])
	translate([halfarm*goldenratio, 0,gHeight-joinfactor])
	rotate([0,0,0])
	axlemount(gAxleLength, gAxleOR, gAxleRadius, 5); 

}

module SwoopArms()
{
	numberofarms = 3;
	angle = 360/numberofarms;

	for(arm=[0:numberofarms-1])
	{
		rotate([0,0,angle*arm])
		SwoopArm();
	}
}

//=======================================
// Functions
// These are the 4 blending functions for a cubic bezier curve
//=======================================
// Bernstein Polynomials
function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

// Calculate a singe point along a cubic bezier curve
function PointOnBezCubic2D(p0, p1, p2, p3, u) = [
BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]];

function PointOnBezCubic3D(p0, p1, p2, p3, u) = [
BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1],
BEZ03(u)*p0[2]+BEZ13(u)*p1[2]+BEZ23(u)*p2[2]+BEZ33(u)*p3[2]];

//=======================================
// Modules
//=======================================

module BezCubicFilletColored(c, focalPoint, steps=gSteps, height=gHeight, colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]])
{
for(step = [steps:1])
{
color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
linear_extrude(height = height, convexity = 10) 
polygon(
points=[
focalPoint,
PointOnBezCubic2D(c[0], c[1], c[2],c[3], step/steps),
PointOnBezCubic2D(c[0], c[1], c[2],c[3], (step-1)/steps)],
paths=[[0,1,2,0]]
);
}
}


module BezCubicRibbon(c1, c2, steps=gSteps, height=gHeight, colors=[[1,0,0],[1,1,0],[0,1,1],[0,0,1]])
{
for (step=[0:steps-1])
{
color(PointOnBezCubic3D(colors[0], colors[1], colors[2], colors[3], step/steps))
linear_extrude(height = height, convexity = 10) 
polygon(
points=[
PointOnBezCubic2D(c1[0], c1[1], c1[2],c1[3], step/steps),
PointOnBezCubic2D(c2[0], c2[1], c2[2],c2[3], (step)/steps),
PointOnBezCubic2D(c2[0], c2[1], c2[2],c2[3], (step+1)/steps),
PointOnBezCubic2D(c1[0], c1[1], c1[2],c1[3], (step+1)/steps)],
paths=[[0,1,2,3]]
);

}
}



