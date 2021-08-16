f = 1;
$fs=0.4; $fa=5; //corner fix

//// grid example: ////
/*grid(30,15,false,2)
{
	square([25,10]);
	square([25,10]);
	square([25,10]);
	square([25,10]);
	square([25,10]);
	square([25,10]);
	square([25,10]);
	square([25,10]);
	square([25,10]);
}*/

//// ellipse, ellipsePart, complexRoundSquare and parameter examples: ////
grid(105,105,true,4)
{
	// ellipse
	ellipse(50,75);

	// part of ellipse (a number of quarters)
	ellipsePart(50,75,3);
	ellipsePart(50,75,2);
	ellipsePart(50,75,1);

	// complexRoundSquare examples
	complexRoundSquare([100,100],[20,10],[20,10],[20,10],[20,10]);
	complexRoundSquare([75,100],[20,10],[20,10],[20,10],[20,10]);
	complexRoundSquare([75,100],[0,0],[0,0],[20,10],[20,10]);
	complexRoundSquare([100,100],[10,20],[10,20],[10,20],[10,20],false);
	complexRoundSquare([100,100]);
	complexRoundSquare([100,100],[10,20],[10,10]);

	// setting parameters by their name
	complexRoundSquare([100,100],[10,20],[20,10],center=false);
	complexRoundSquare([100,100],[20,20],[0,0],[20,20],center=false);
	complexRoundSquare([100,100],rads1=[20,20],rads3=[20,20],center=false);
	complexRoundSquare([100,100],rads1=[20,20],rads3=[20,20],center=false);

	// pie slice
	translate([50,50]) pieSlice(50,0,10);
	translate([50,50]) pieSlice(50,45,190);
	translate([50,50]) pieSlice([50,20],180,270);

	// donut slice
	translate([50,50]) donutSlice(20,50,0,350);
	translate([50,50]) donutSlice(30,50,190,270);
	translate([50,50]) donutSlice([40,22],[50,30],180,270);
	translate([50,50]) donutSlice([50,20],50,180,270);
	translate([50,50]) donutSlice([20,30],[50,40],0,270);
}

//// bolt connection example: ////
/*width = 50;
height = 25;
thickness = 5;
boltWidth = 5;
boltLength = 16;
nutWidth = 8;
nutHeight = 4;

spaceAroundBolt = 10;
plugWidth = 20;
plugHeight = thickness;
translate([0,height+10]) 
{
	difference()
	{
		union()
		{
			translate([width/2,0]) plug();
			square(size=[width, height]);
		}
		translate([width/2,-thickness]) boltCutOutSide();
	}
}
difference()
{
	square(size=[width, height]);
	translate([width/2,height-thickness]) rotate([0,0,180]) boltCutOutFront();
}*/

//// custom shape: ////
//polygon([[0,0],[100,0],[50,100],[0,90]]);

//// rounded square ////
//roundedSquare([100,75],20);

//// rough offset: ////
//%square([50,40]);
//roughOffset(5) square([50,40]);

///////////// bolt connection utils /////////////
module plug() // origin: bottom center
{
	translate([-plugWidth/2,-plugHeight,0]) square([plugWidth,plugHeight+f]);
}
module boltCutOutSide() //origin: top center
{
	union()
	{
		translate([-spaceAroundBolt/2,-f,0]) 
			square([spaceAroundBolt,plugHeight+f]);
		translate([-nutWidth/2,plugHeight+thickness,0]) //plugHeight2+thickness
			square([nutWidth,nutHeight]);
		translate([-boltWidth/2,0,0]) 
			square([boltWidth,boltLength]);
	}
}
module boltCutOutFront() //origin: top center
{
	translate([0,thickness/2]) 
	{
		difference()
		{
			square([plugWidth,thickness],center=true);
			translate(0,-f,0) square([spaceAroundBolt,thickness+f*2],center=true);
		}
		circle(r=boltWidth/2);
	}
}

///////////// layout utils /////////////
module list(itemHeight)
{
	for (i = [0 : $children-1]) 
		translate([0,i*itemHeight]) child(i);
}
module grid(iWidth,iHeight,inYDir = true,limit=3)
{
	for (i = [0 : $children-1]) 
	{
		translate([(inYDir)? (iWidth)*(i%limit) : (iWidth)*floor(i/limit),
					(inYDir)? (iHeight)*floor(i/limit) : (iHeight)*(i%limit)])
					child(i);
	}
}

///////////// shape utils /////////////
// top left, top right, bottom right, bottom left
module complexRoundSquare(size,rads1=[0,0], rads2=[0,0], rads3=[0,0], rads4=[0,0], center=true)
{
	width = size[0];
	height = size[1];
	//%square(size=[width, height],center=true);
	x1 = 0-width/2+rads1[0];
	y1 = 0-height/2+rads1[1];
	x2 = width/2-rads2[0];
	y2 = 0-height/2+rads2[1];
	x3 = width/2-rads3[0];
	y3 = height/2-rads3[1];
	x4 = 0-width/2+rads4[0];
	y4 = height/2-rads4[1];

	scs = 0.1; //straight corner size

	x = (center)? 0: width/2;
	y = (center)? 0: height/2;

	translate([x,y,0])
	{
		hull() {
			// top left
			if(rads1[0] > 0 && rads1[1] > 0)
				translate([x1,y1]) mirror([1,0])		ellipsePart(rads1[0]*2,rads1[1]*2,1);
			else 
				translate([x1,y1]) 						square(size=[scs, scs]);
			
			// top right
			if(rads2[0] > 0 && rads2[1] > 0)
				translate([x2,y2]) 						ellipsePart(rads2[0]*2,rads2[1]*2,1);	
			else 
				translate([width/2-scs,0-height/2]) 	square(size=[scs, scs]);

			// bottom right
			if(rads3[0] > 0 && rads3[1] > 0)
				translate([x3,y3]) mirror([0,1]) 		ellipsePart(rads3[0]*2,rads3[1]*2,1);
			else 
				translate([width/2-scs,height/2-scs]) 	square(size=[scs, scs]);
			
			// bottom left
			if(rads4[0] > 0 && rads4[1] > 0)
				translate([x4,y4]) rotate([0,0,-180]) 	ellipsePart(rads4[0]*2,rads4[1]*2,1);
			else 
				translate([0-width/2,height/2-scs]) 	square(size=[scs, scs]);
		}
	}
}
module roundedSquare(pos=[10,10],r=2) {
	minkowski() {
		square([pos[0]-r*2,pos[1]-r*2],center=true);
		circle(r=r);
	}
}
module roughOffset(offset) // only works outwards and with one shape. Removes holes
{
    minkowski() {
        union() for (i = [0 : $children-1]) child(i);
        circle(r=offset);
    }
}
// round shapes
module ellipsePart(width,height,numQuarters)
{
	difference()
	{
		ellipse(width,height);
		if(numQuarters <= 3)
			translate([0-width/2-f,0-height/2-f,0]) square([width/2+f,height/2+f]);
		if(numQuarters <= 2)
			translate([0-width/2-f,-f,0]) square([width/2+f,height/2+f*2]);
		if(numQuarters < 2)
			translate([-f,0,0]) square([width/2+f*2,height/2+f]);
	}
}
module donutSlice(innerSize,outerSize, start_angle, end_angle) 
{   
    difference()
    {
        pieSlice(outerSize, start_angle, end_angle);
        if(len(innerSize) > 1) ellipse(innerSize[0]*2,innerSize[1]*2); //(innerSize, start_angle-1, end_angle+1);
        else circle(innerSize);
    }
}
module pieSlice(size, start_angle, end_angle) //size in radius(es)
{	
    rx = ((len(size) > 1)? size[0] : size);
    ry = ((len(size) > 1)? size[1] : size);
    trx = rx* sqrt(2) + 1;
    try = ry* sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
		if(len(size) > 1)
        	ellipse(rx*2,ry*2);
		else
			circle(rx);
        polygon([
            [0,0],
            [trx * cos(a0), try * sin(a0)],
            [trx * cos(a1), try * sin(a1)],
            [trx * cos(a2), try * sin(a2)],
            [trx * cos(a3), try * sin(a3)],
            [trx * cos(a4), try * sin(a4)],
            [0,0]
       ]);
    }
}
module ellipse(width, height) {
  scale([1, height/width, 1]) circle(r=width/2);
}
module ellipse(width, height) {
  scale([1, height/width, 1]) circle(r=width/2);
}
