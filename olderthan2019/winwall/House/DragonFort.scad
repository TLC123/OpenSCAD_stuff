//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike



//main call
union(){
rotate([0,0,90])house(housex*1.1,housey*0.9,housez,roofz*0.9);
house(housex,housey,housez,roofz);
rotate([0,0,90])house(housex*1.35,housey/2,housez,roofz/2);
house(housex*1.35,housey/2,housez,roofz/2);


translate([0,0,housez*1.1])
{
  house(housex*0.7,housey*0.5,housez*2,roofz*0.5);
   translate([0,0,housez*1.3])
    {
  house(housex*0.7*0.6,housey*0.5*0.6,housez*2.4,roofz*0.5*0.6);
    }
}


}








// preview[view:north east, tilt:top diagonal]
// settings
/* [House] */
//dimensions in cm
housex = 1000; //[100:2000]
housey = 800; //[100:2000]
housez = 180; //[100:500]
//roof height
roofz = 300; //[30:3000]








//export as plate
asplate =0; //[1,0]
//0=everything
part=0;//[0,1,2,3,4,5,6,7,8]
roofh = sqrt((housey / 2) * (housey / 2) + (roofz * roofz));
roofang = 90 - atan2(roofz, housey / 2);
/* [Windows and Doors] */
winh = 60; //[10:500]
winw = 50; //[10:500]
wind = 20; //[10:30]
winz = 42; //[0:500]
doorh = 180; //[10:500]
doorw = 10; //[10:500]
doord = 10; //[10:30]
doorz = 0; //[0:500]
//distance from corner to first window
vanpadding =80; //[0:500]
//spaceing
spacew = 60; //[0:500]
//windows and doors order win=1 door=2
WD1 = [2, 1, 2, 1,2, 1, 1, 1, 2, 2, 2];
WD2 = [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 2, 2];
WD3 = [2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2];
WD4 = [2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2];
/* [Walls] */
//wood/brick sizes
stoneh = 320; //[10:500]
stonew = 20; //[10:500]
stoned = 31; //[5:50]

md=1;//[0.01:1]
hd=0.8;//[0.01:1]
hp=0.2;//[00:1]
vd=0.8;//[0.01:1]
vp=0.041;//[0:1]
corners=0;//[0,1] 
//round wall tiles
stonetypewall = 0; 

/* [Roof] */
// roof over shoot [10:200]
overhang = 90;
overhang2 = 60;
//rooftile size
roofstoneh = 40; //[10:1000]
roofstonew = 30; //[10:1000]
roofstoned = 10; //[5:50]
// roof tiles
stonetype = 0; //[0,1] 

/* [Chimney] */
//dimensions in cm 
chimney=0;//[1,0]

chimx = 100; //[20:3000]
chimy = 100; //[20:3000]
chimz = 600; //[20:3000]
chimofx = -30; //[-1000:3000]
chimofy = -180; //[-3000:1000]
// end of settings

fudge=0.001;
fr=0;
fr2=0;
module house(x,y,z,r){
translate([-x*0.5,y*0.5,0]){

hx=x;
hy=y;
hz=z;
rz=r;
rh = sqrt((hy / 2) * (hy / 2) + (rz * rz));
rang = 90 - atan2(rz, hy / 2);  
	union()
	{
        
 
        //house
		translate([0, 0, 0]) wall(hx, wind, hz, WD1);
		translate([hx, 0, 0]) rotate([0, 0, -90]) wall(hy, wind, hz, WD2);
		translate([hx, -hy, 0]) rotate([0, 0, -180]) wall(hx, wind, hz, WD3);
		translate([0, -hy, 0]) rotate([0, 0, -270]) wall(hy, wind, hz, WD4);
		translate([0, 0, hz]) rotate([rang, 0, 0]) roofblock(hx, rh);
		translate([hx, 0, hz]) rotate([0, 0, -90]) roofside(hy, rz,rang,rh);
		translate([hx, -hy, hz]) rotate([0, 0, -180]) rotate([rang, 0, 0]) roofblock(hx, rh);
		translate([0, -hy, hz]) rotate([0, 0, 90]) roofside(hy, rz,rang,rh);
	
    }
}}
//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
//modules below
colors = [color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0]),color([rands(0.5,1,1)[0],0.3,0])
];
n_colors = 5;
module stone()
{
	  rotate([-90,0,0])
union(){
			 translate ([0,0,0])cube([1-hp+fudge, 1-vp+fudge, md]);
			translate ([1-hp,0,0])cube([hp+fudge, 1, hd]);
		translate ([0,1-vp,0])cube([1, vp+fudge, vd]);
    }
	
}
module basestone()
{
	rotate([rands(0, 360, 1)[0], rands(0, 360, 1)[0], rands(0, 360, 1)[0]])
	resize([rands(3, 10, 1)[0], rands(3, 10, 1)[0], rands(3, 10, 1)[0]])
		//import("rock.stl", convexity=3);
	sphere(1, $fa = 15, $fs = 1);
}
module roofstone()
{
	if (stonetype == 1)
	{
		///////pannor
	}
	else
	{
		 translate ([0,0,-1])rotate([-180, 0, 0]) translate ([0,0,1]){
			 
             
		 intersection(){translate([0,-1,0])cube([3,2,1]);
             rotate([25,0,0])
    union(){
    color([1,0,0])translate([0,0.5,-1])cube([1,2,3]);
   translate([0.5,0,-0.10])scale([1,1,2])rotate([-90,0,0])cylinder(2,0.5,0.5,$fn=10);
    }
    }
             
             }}
		}
	
module wallblock(length, height)
{
	union()
	{
		intersection()
			{
				
				 color([rands(0.6,0.9,1)[0],0.3,0]) translate([0,  -stoned*0.2-fudge, 0]) cube([length -fudge, stoned*2 +fudge, height+fudge]);
				union()
				{
					 color([rands(0.6,0.9,1)[0],0.3,0]) translate([0, -wind, 0]) cube([length, wind * 2, height]);
					// Wall
					for (i = [0: height*2 / stoneh])
					{
						for (j = [0: length / stonew])
						{
		                        color([rands(0.6,0.9,1)[0],0.3,0]) translate([j * stonew - (i % 2) * stonew / 2,-stoned*0.2 , i * stoneh ]) 
                            resize([stonew+fudge, stoned+fudge, stoneh+fudge ])   stone();
						
						}
					}
				}
			}
        }}
module roofside(length, height,ra,rh)
{
    
    color([rands(0.5,1,1)[0],0.3,0])translate([length/2,overhang2*0.95,height*1.25])resize([10,100,120])mirror([0,1,0])dragon();
	difference()
	{
		
		translate([0, 0 - stoned*0.5]) union()
		{
		union()
	{
		intersection()
			{
				
						color([rands(0.5,1,1)[0],0.3,0])
translate([0+fudge,  -stoned*0.2-fudge, -fudge]) cube([length +fudge, stoned*2 +fudge, height+fudge]);
				union()
				{
					//translate([0, -wind, 0]) cube([length, wind * 2, height]);
					// Wall
					for (i = [1: height / stoneh])
					{
						for (j = [0: length / stonew])
						{
									color([rands(0.5,1,1)[0],0.3,0])

	translate([j * stonew - (i % 2) * stonew / 2,-stoned*0.2 , i * stoneh ]) 
                            resize([stonew+fudge, stoned+fudge, stoneh +fudge]) stone();
						
						}
					}
				}
			}
        }}
		
		translate([length / 2, -50, height]) rotate([0, 90 - ra, 0]) cube([max(rh * 20, height * 20), 100, max(rh * 20, height * 20)]);
		translate([length / 2, -50, height]) rotate([0, 180 + ra, 0]) cube([max(rh * 20, height * 20), 100, max(rh * 20, height * 20)]);
	}
}
module roofblock(l, h)
{
	height = h + overhang;
	length = l + overhang2 * 2;
	translate([-overhang2, roofstoned*0.5, -overhang]) union()
	{
        	
			color( [0.54,0.25,0.07]) {
                translate([-1, -18 ,0 ]) cube([10, roofstoned*4.3+fudge, height+ roofstoned * 3.6]);
                translate([length-9, -18 ,0 ]) cube([10, roofstoned*4.3+fudge, height+ roofstoned * 3.6]);
            }
              color([rands(0.6,0.9,1)[0],0.3,0])  translate([0,0, height-roofstoned*2]) cube([length, roofstoned*1.5, roofstoned*3.5+fudge]);
            
		intersection()
		{
			
			color( [0.54,0.25,0.07]) translate([fudge,-roofstoned-fudge,fudge])cube([length+fudge, roofstoned * 8, height + roofstoned * 1.6]);
			union()
			{
			
                
				for (i = [-1: roofstoneh + height / roofstoneh])
				{
					for (j = [0: length / roofstonew])
					{
						
                        color([rands(0.6,0.9,1)[0],0.3,0])
						translate([j * roofstonew - (i % 2) * roofstonew / 2, roofstoned*0.5, i * roofstoneh])  resize([roofstonew+fudge, roofstoned+fudge, roofstoneh +fudge]) roofstone();
					}
				}
			}
		}
	}
}
module centerblock()
{
	color(colors[rands(0, n_colors - 1, 1)[0]])
	translate([0, -0.5, 0.5]) cube(1, center = true);
}
module cutter(w, d, h)
{
	color(colors[rands(0, n_colors - 1, 1)[0]])
	resize([w, d, h]) centerblock();
}
module window(w, d, h)
{
	color( [0.54,0.25,0.07]) 
	union()
	{
		resize([w, d, h])
		difference()
		{
			
			centerblock();
			
			translate([0, 0, 0]) resize([0.95, 0.2, 0.97]) centerblock();
		
			translate([-0.33, 0, 0.1]) resize([0.25, 0.5, 0.22]) centerblock();
translate([0, 0, 0.1]) resize([0.25, 0.5, 0.22]) centerblock();			
			translate([0.33, 0, 0.1]) resize([0.25, 0.5, 0.22]) centerblock();
				translate([-0.33, 0, 0.35]) resize([0.25, 0.5, 0.22]) centerblock();
	translate([0, 0, 0.35]) resize([0.25, 0.5, 0.22]) centerblock();			
			translate([0.33, 0, 0.35]) resize([0.25, 0.5, 0.22]) centerblock();
			translate([-0.33, 0, 0.65]) resize([0.25, 0.5, 0.22]) centerblock();
translate([0, 0, 0.65]) resize([0.25, 0.5, 0.22]) centerblock();			
			translate([0.33, 0, 0.65]) resize([0.25, 0.5, 0.22]) centerblock();
		}
		color(colors[rands(0, n_colors - 1, 1)[0]])
		translate([0, wind * 0.3, 0]) resize([w * 1.2, d, h * 0.05]) centerblock();
		color(colors[rands(0, n_colors - 1, 1)[0]])
		translate([0, wind * 0.3, h * 0.97]) resize([w * 1.2, d, h * 0.05]) centerblock();
	}
}
module door(w, d, h)
{
	color( [0.54,0.25,0.07]) 	union()
	{
		resize([w, d, h])
		difference()
		{
			color(colors[rands(0, n_colors - 1, 1)[0]])
			centerblock();
			translate([0, 0, 0]) resize([0.85, 0.5, 0.92]) centerblock();
		}
		color(colors[rands(0, n_colors - 1, 1)[0]])
		*translate([0, wind * 1.5, 0]) resize([w * 1.2, d * 3, h * 0.05]) centerblock();
		color(colors[rands(0, n_colors - 1, 1)[0]])
		*translate([0, wind * 0.5, h * 0.97]) resize([w * 1.2, d, h * 0.05]) centerblock();
	}
}
module wall(w, d, h, order)
	{
		union()
		{
            corn=stoned*0.7;
            if (corners==0){color( [0.54,0.25,0.07]) 
                translate([0,-stoned+5,-fudge]) cube([corn+fudge,stoned+fudge,h+fudge+fudge]);
               color( [0.54,0.25,0.07])  translate([w-corn+fudge,-stoned+5,-fudge]) cube([corn+fudge+5,stoned+fudge,h+fudge+fudge]);
                }
			difference()
			{
				translate([0, -d, 0])
					wallblock(w, h);
				//cube([w,d,h]);
				union()
				{
					fw = w - vanpadding * 2;
					numw = floor(fw / (winw + spacew));
					step = fw / numw;
					for (i = [vanpadding: step: w - vanpadding])
					{
						if (order[i / step] == 1)
						{
							translate([i, wind * 2, winz]) color( [0.54,0.25,0.07]) cutter(winw, wind * 2.9, winh);
						}
						else
						{
							translate([i, doord * 3, doorz - 1]) color( [0.54,0.25,0.07]) cutter(doorw, doord * 3.9, doorh + 1);
						}
					}
				}
			}
			fw = w - vanpadding * 2;
			numw = floor(fw / (winw + spacew));
			step = fw / numw;
			for (i = [vanpadding: step: w - vanpadding])
			{
				if (order[i / step] == 1)
				{
					translate([i, wind * 0.5, winz]) color( [0.54,0.25,0.07]) window(winw, wind, winh);
				}
				else
				{
					translate([i, doord * 0.5, doorz])color( [0.54,0.25,0.07])  door(doorw, doord, doorh);
				}
			}
		}
	}
    
 module dragon(){
     union(){cube([2,5,12],center=true) ;
         translate([0,10,-14])cube([4,30,18],center=true) ;
translate([0,0,5])rotate([20,0,0]){
cube([2,7,7],center=true) ;
    translate([0,0,5])rotate([15,0,0]){
        cube([2,7,7],center=true) ;
            translate([0,0,5])rotate([20,0,0]){
            
            cube([2,6,8],center=true) ;
                translate([0,-5])rotate([20,0,0]){
                cube([2,4,8],center=true) ;
                    translate([0,-1,5])rotate([ 20,0,0]){
                    cube([2,4,6],center=true) ;
                        translate([0,0,2])rotate([ 20,0,0]){
                        cube([2,4,6],center=true) ;
                        translate([0,0,2])rotate([ 20,0,0])cube([2,4,5],center=true) ;}
    
    }}
            cube([2,4,7],center=true) ;
                translate([0,0,5])rotate([20,0,0]){
                cube([2,5,5],center=true) ;
                    translate([0,1,5])rotate([-20,0,0]){
                    cube([2,5,6],center=true) ;
                        translate([0,1,2])rotate([-20,0,0]){
                        cube([2,4,6],center=true) ;
                        translate([0,0,2])rotate([-20,0,0])cube([2,3,6],center=true) ;}
    
    }}}}
}
}
     }
	//rotate([-5,0,0])roofstone();,
	//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike