winh=160;
winw=110;
wind=20;
winz=72;
doorh=160+72;
doorw=110;
doord=20;
doorz=0;
vanh=250;
vanpadding=150;
spacew=100;


colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;

module stone(){ rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(3, 10, 1)[0],rands(3, 10, 1)[0],rands(3, 10, 1)[0]])
    //import("rock.stl", convexity=3);
    sphere(1, $fa=15, $fs=1); 
    }


module wallblock( length, height)
{
    color( colors[rands(0, n_colors-1, 1)[0]])
	scale([0.2,0.2,0.20])  
     union() {
    intersection() {
    
    translate([-34,-22,0]) cube([68,length*40+38,height*20+15 ]) ;
   
    union() {
        translate([-20,10,0]) cube([40,length*40-20,height*20-5 ]) ;
		// Wall
		for( i = [1:height]) {
			for ( j = [0:length] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
                        translate([40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
				resize([35,45,35]) stone();
                		translate([-40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
				resize([35,45,35]) stone();
			}
		}
		
		// Top stones
		for (j = [0:length]) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([rands(-10, 10, 1)[0],j*40+rands(-5, 5, 1)[0],(height+.5)*20])
				resize([40,40,15]) stone();
		}
        
        	// end stones
		for (j = [0:height]) {
				color("Red")
				translate([0,-5,j*20])
				resize([40,40,40]) stone();
		}
            	// end stones
		for (j = [0:height]) {
				color("Red")
				translate([0,length*40-2,j*20])
				resize([40,40,40]) stone();
		}
	}}
		// Base stones
		difference() {
			scale([1,1,1.5])
			union(){
				for( i = [0:160]) {
					color( colors[rands(0, n_colors-1, 1)[0]])
					translate([rands(-45, 45, 1)[0], rands(0, length*40, 1)[0],rands(0, 15, 1)[0]])
					resize([30,40,20]) stone();
				}
			}
			
			translate([-240/2,-40, -40])
			cube([240, 80+40*length+20, 40]);
		}
	}
}

module centerblock(){    
    translate ([0,-0.5,0.5])cube(1,center=true);}
    
module cutter(w,d,h){resize([w,d,h])centerblock();}
    
    
module window(w,d,h){
    union(){
    resize([w,d,h]) 
    difference(){
        centerblock();
        translate([0,0,0]) resize([0.95,0.2,0.97]) centerblock();
        translate([-0.25,0,0.1]) resize([0.4,0.5,0.4]) centerblock();
        translate([0.25,0,0.1]) resize([0.4,0.5,0.4]) centerblock();
        translate([-0.25,0,0.55]) resize([0.4,0.5,0.4]) centerblock();
        translate([0.25,0,0.55]) resize([0.4,0.5,0.4]) centerblock();
    }
    translate([0,wind*0.3,0]) resize([w*1.2,d,h*0.05])centerblock();
    translate([0,wind*0.3,h*0.97]) resize([w*1.2,d,h*0.05])centerblock();
}}
module door(w,d,h){
    union(){
    resize([w,d,h]) 
    difference(){
        centerblock();
        translate([0,0,0]) resize([0.95,0.2,0.97]) centerblock();
        
    }
    translate([0,wind*0.7,0]) resize([w*1.2,d,h*0.05])centerblock();
    translate([0,wind*0.3,h*0.97]) resize([w*1.2,d,h*0.05])centerblock();
}}    

  module wall (w,d,h){union(){
      difference(){translate([0,-d,0])
          wallblock(w,h);
          //cube([w,d,h]);
      union(){
      fw=w-vanpadding*2;
      numw=floor(fw/    (winw+spacew));
      step=fw/numw;
          
      for ( i = [vanpadding : step : w-vanpadding] )
{
translate ([i,wind,winz])cutter(winw,wind*1.9,winh);
//translate ([i,doord,doorz])cutter(doorw,doord*1.9,doorh);

}
     }
     } 
         fw=w-vanpadding*2;
      numw=floor(fw/    (winw+spacew));
      step=fw/numw; 
           for ( i = [vanpadding : step : w-vanpadding] )
{
  translate ([i,wind*0.5,winz])window(winw,wind,winh);
 // translate ([i,doord*0.5,doorz])door(doorw,doord,doorh);

}
     }}
      
      
     
  
    wall(1560,wind,350);
    
      
  //window(6,5,6);
    //cutter(6,2,6);