/*
	Metaballs.scad
	Public Domain Code
	Placed By: William A Adams
	4 June 2011

	This code is a rudimentary implementation of the so called 'metaball' technique of soft object rendering.  It uses "granules" to register the isosurface which is the interaction of the various balls.

	Some good reading on metaballs can be found here:
http://www.gamedev.net/page/resources/_//feature/fprogramming/exploring-metaballs-and-isosurfaces-in-2d-r2556

*/

step=5;

DrawMetaballs([[50,50,50,35],[25,5,5,25]]);


// metaball - _x, _y, _z,  _radius

function  MBInfluence(x, y,z, mball) = (mball[3]/ sqrt((x-mball[0])*(x-mball[0]) + (y-mball[1])*(y-mball[1])+(z-mball[2])*(z-mball[2])));

function Someballs (x,y,z,mballs, i)=(i==0)?MBInfluence(x,y,z,mballs[0]):MBInfluence(x,y,z,mballs[i])+Someballs(x,y,z,mballs,i-1);


module DrawMetaballs( ballList)
{	
	xres =1;
	yres = 1;



	MIN_THRESHOLD = 0;
	MAX_THRESHOLD = 1.5;
	sum = 0;

	// Ideally, we'd do a linear_extrude, but right now, it's
	// way too computationally expensive
	//linear_extrude(height=thickness)
	for (y=[00:step:100])
	{
		for (x=[00:step:100])
		{
			for(z=[0:step:100])
			{
				              suma=Someballs(x, y, z,ballList,len(ballList)-1);
                              sumb=Someballs(x+step, y, z,ballList,len(ballList)-1);
                              sumc=Someballs(x, y+step, z,ballList,len(ballList)-1);
                              sumd=Someballs(x+step, y+step, z,ballList,len(ballList)-1);
                
                              sume=Someballs(x, y, z+step,ballList,len(ballList)-1);
                              sumf=Someballs(x+step, y, z+step,ballList,len(ballList)-1);
                              sumg=Someballs(x, y+step, z+step,ballList,len(ballList)-1);
                              sumh=Someballs(x+step, y+step, z+step,ballList,len(ballList)-1);
                
				{
                    color(rndc())  {
					if (suma > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x, y, z])scross(0.1);}}
					if (sumb > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x+step, y, z])scross(0.1);}}
					if (sumc > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x, y+step, z])scross(0.1);}}
					if (sumd > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x+step, y+step, z])scross(0.1);}}
					
                    if (sume > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x, y, z+step])scross(0.1);}}
					if (sumf > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x+step, y, z+step])scross(0.1);}}
					if (sumg > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x, y+step, z+step])scross(0.1);}}
					if (sumh > MAX_THRESHOLD){intersection(){translate([x, y, z])cube(step);translate([x+step, y+step, z+step])scross(0.1);}}
                }
				}
			}
		}
	}
}

module scross()      {
    cube(step,0.1,0.1,center=true);
    cube(0.1,step,0.1,center=true);
    cube(0.1,0.1,step,center=true);}
function rndc()=[rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]];