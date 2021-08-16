 Length=200;
 Height=130;
BlockLength=45;
BlockHeight=35;

Wall(Length, Height,BlockLength,BlockHeight);

module stone(){ 
hull(){
rotate([rands(0, 360, 1)[0],rands(0, 90, 1)[0],rands(0, 360, 1)[0]])
resize([rands(3, 7, 1)[0],rands(3, 10, 1)[0],rands(3, 5, 1)[0]])
     sphere(1, $fa=15, $fs=1); 
rotate([rands(0, 360, 1)[0],rands(0, 90, 1)[0],rands(0, 360, 1)[0]])
resize([rands(3, 7, 1)[0],rands(3, 10, 1)[0],rands(3, 7, 1)[0]])
     sphere(1, $fa=15, $fs=1); }
    }


module Wall( length, height,aproxblocklength,aproxblockheigh)
{
blocklength= length/ round(length/aproxblocklength);
blockheight=height/round(height/aproxblockheigh);
  wigle=blockheight*0.1; 
    intersection() {
   hull() { 
 translate([0,length*0.5,height*0.5]) cube([blockheight*2,length+blocklength *0.75 ,height-blocklength *0.20 ],center=true) ;
 translate([0,length*0.5,height*0.5]) cube([blockheight*1,length+blocklength ,height  ],center=true) ;
   }
    union() {
       translate([-20,10,0]) cube([40,length-20,height-5 ]) ;
		// Wall
		for( i = [0:blockheight:height]) {
			for ( j = [0:blocklength:length] )
{
translate([rands(-wigle, wigle, 1)[0]+blockheight*0.5,j -((i/blockheight)%2)*blocklength*0.5+blocklength*0.25,i -blockheight*0.65])
			scale(1.2)	resize([blockheight,blocklength,blockheight*1.2]) stone(); 
translate([rands(-wigle, wigle, 1)[0]-blockheight*0.5,j -((i/blockheight)%2)*blocklength*0.5+blocklength*0.25,i -blockheight*0.65])
			scale(1.2)	resize([blockheight,blocklength*1.1,blockheight*1.2]) stone(); 
			}
		}



		
		// Top stones
	 				for ( j = [0:blocklength:length] )
{
translate(
[rands(-wigle, wigle, 1)[0] ,
j-((height/blockheight)%2)  *blocklength*0.5  ,
height -blockheight*0.15])
 scale(1.1) 	resize([blockheight,blocklength,blockheight*0.4]) stone(); 
		}
        
        	// end stones
	 				for ( i = [0:blockheight:height] )
{
translate(
[rands(-wigle, wigle, 1)[0] ,
0  -blockheight*0.65 ,
i -blockheight*0.55])
 scale(1.1) 	resize([blockheight,blocklength*0.4,blockheight]) stone(); 
		}
            	// end stones
 				for ( i = [0:blockheight:height] )
{
translate(
[rands(-wigle, wigle, 1)[0] ,
length  +blockheight*0.65 ,
i -blockheight*0.55])
 scale(1.1) 	resize([blockheight,blocklength*0.4,blockheight]) stone(); 
		}
	}}




		// Base stones
	 intersection() {
 hull(){  
 translate([0,length*0.5,blockheight *0.5]) cube([blockheight*3,length ,blocklength*0.5  ],center=true) ;
 translate([0,length*0.5,blockheight *0.5])cube([blockheight*1,length+blocklength ,blockheight  ],center=true) ;}

			union(){
				 
			for ( j = [0.5:blocklength*1.1:length] )
{
translate([rands(-wigle, wigle, 1)[0]+blockheight*0.8 ,j -1*blocklength*0.5+blocklength*0.25,0  ])
			scale(1.2)	resize([blockheight,blocklength,blockheight*1.5]) stone();
 translate([rands(-wigle, wigle, 1)[0]-blockheight*0.8 ,j -1*blocklength*0.5+blocklength*0.25,0  ])
			scale(1.2)	resize([blockheight,blocklength,blockheight*1.5]) stone(); 
			}}
			
		 
		}
	 
}



 



 