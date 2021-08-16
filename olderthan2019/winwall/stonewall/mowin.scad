//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike


colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;

module stone(){ 
    
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])
    resize([rands(3, 10, 1)[0],rands(3, 10, 1)[0],rands(3, 10, 1)[0]])
    //import("rock.stl", convexity=3);
    sphere(1, $fa=15, $fs=1); 
    //cube(1);
    }
module roofstone(){ 
    if (stonetype==1){
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])
    resize([rands(3, 10, 1)[0],rands(3, 10, 1)[0],rands(3, 10, 1)[0]])
    //import("rock.stl", convexity=3);
    sphere(1, $fa=15, $fs=1); 
    
    }
    else{
            rotate([-90,0,0])union(){
        cube([1,1,0.4]);
       translate([0.1,0,0])cube([0.8,1,1]);
            }
        }
    }


module wallblock( length, height)
{
    color( colors[rands(0, n_colors-1, 1)[0]])
	 
     union() {
    intersection() {
    
       color( colors[rands(0, n_colors-1, 1)[0]])
translate([-(stoned-wind)*0.5,0,0]) cube([length+(stoned-wind),stoned,height ]) ;
   
    union() {
        translate([0,-wind,0])cube([length,wind*2,height ]) ;
		// Wall
		for( i = [1:height/stoneh]) {
			for ( j = [0:length/stonew] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
                        translate([j*stonew-(i%2)*stonew/2,0+rands(-5, 5, 1)[0],i*stoneh+rands(-stoneh*0.3, stoneh*0.3, 1)[0]])
				resize([stonew,stoned,stoneh*1.1]) stone();
                		translate([j*stonew-(i%2)*stonew/2,stoned/2+rands(-5, 5, 1)[0],i*stoneh])
				resize([stonew*1.4,stoned,stoneh*1.1]) stone();
			}
		}
		

	}}
		// Base stones
		intersection() {
			//scale([1,1,1.5])
			union(){
				for( i = [0:length*2/stonew]) {
					color( colors[rands(0, n_colors-1, 1)[0]])
					translate([rands(0, length, 1)[0], stoned*0.7, rands(0, stoneh/2, 1)[0]])
					resize([stonew*1.5,stoned*1.5,stoneh*1.5]) stone();
				}
			}
			
			translate([0,0, 0])
			cube([length, stoned*2, stoneh]);
		}
	}
}


module roofside( length, height)
{ difference(){
    color( colors[rands(0, n_colors-1, 1)[0]])
	    translate([0,0-stoned]) union() {
    intersection() {
           color( colors[rands(0, n_colors-1, 1)[0]])
translate([-(stoned-wind)*0.5,0,0]) cube([length+(stoned-wind),stoned,height ]) ;
   
    union() {
        translate([0,-wind,0])cube([length,wind*2,height ]) ;
		// Wall
		for( i = [1:height/stoneh]) {
			for ( j = [0:length/stonew] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
                        translate([j*stonew-(i%2)*stonew/2,0+rands(-5, 5, 1)[0],i*stoneh+rands(-stoneh*0.3, stoneh*0.3, 1)[0]])
				resize([stonew,stoned,stoneh*1.1]) stone();
                		translate([j*stonew-(i%2)*stonew/2,stoned/2+rands(-5, 5, 1)[0],i*stoneh])
				resize([stonew*1.4,stoned,stoneh*1.1]) stone();
			}		}	}}}
        color( colors[rands(0, n_colors-1, 1)[0]])
 translate([housey/2,-50,roofz])rotate([0,90-roofang,0])  cube([max(roofh*20,roofz*20),100,max(roofh*20,roofz*20)]);
        color( colors[rands(0, n_colors-1, 1)[0]])
translate([housey/2,-50,roofz])rotate([0,180+roofang,0])   cube([max(roofh*20,roofz*20),100,max(roofh*20,roofz*20)]);

}}
module roofblock( l, h)
{ height=h+overhang;
  length=l+overhang2*2;  
	 
    translate([-overhang2,0,-overhang]) union() {
    intersection() {
    
        color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0,-roofstoned/2,0]) cube([length,roofstoned*3,height +roofstoned*0.6 ]) ;
   
    union() {
               color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0,-roofstoned*0.5,])cube([length,roofstoned,height ]) ;
		
		for( i = [0.5:1+height/roofstoneh]) {
			for ( j = [0:length/roofstonew] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
translate([j*roofstonew,0,i*roofstoneh])rotate([2,0,0])resize([roofstonew,roofstoned,roofstoneh]) roofstone();
			}
		}
		

	}}
	
	}
}

module centerblock(){      color( colors[rands(0, n_colors-1, 1)[0]])

    translate ([0,-0.5,0.5])cube(1,center=true);}
    
module cutter(w,d,h){        color( colors[rands(0, n_colors-1, 1)[0]])
resize([w,d,h])centerblock();}
    
    
module window(w,d,h){   

        color( colors[rands(0, n_colors-1, 1)[0]])

    union(){
    resize([w,d,h]) 
    difference(){
                          color( colors[rands(0, n_colors-1, 1)[0]])
  centerblock();
                    

               color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0,0,0]) resize([0.95,0.2,0.97]) centerblock();

               color( colors[rands(0, n_colors-1, 1)[0]])
 translate([-0.25,0,0.1]) resize([0.4,0.5,0.4]) centerblock();
               color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0.25,0,0.1]) resize([0.4,0.5,0.4]) centerblock();

              color( colors[rands(0, n_colors-1, 1)[0]])
  translate([-0.25,0,0.55]) resize([0.4,0.5,0.4]) centerblock();
               color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0.25,0,0.55]) resize([0.4,0.5,0.4]) centerblock();
    }

            color( colors[rands(0, n_colors-1, 1)[0]])
translate([0,wind*0.3,0]) resize([w*1.2,d,h*0.05])centerblock();

            color( colors[rands(0, n_colors-1, 1)[0]])
translate([0,wind*0.3,h*0.97]) resize([w*1.2,d,h*0.05])centerblock();
}}
module door(w,d,h){
        color( colors[rands(0, n_colors-1, 1)[0]])

    union(){
    resize([w,d,h]) 
    difference(){
              color( colors[rands(0, n_colors-1, 1)[0]])
  centerblock();
        translate([0,0,0]) resize([0.85,0.5,0.92]) centerblock();
        
    }
           color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0,wind*1.5,0]) resize([w*1.2,d*3,h*0.05])centerblock();
           color( colors[rands(0, n_colors-1, 1)[0]])
 translate([0,wind*0.5,h*0.97]) resize([w*1.2,d,h*0.05])centerblock();
}}    

  module wall (w,d,h,order){union(){
      difference(){translate([0,-d,0])
          wallblock(w,h);
          //cube([w,d,h]);
      union(){
      fw=w-vanpadding*2;
      numw=floor(fw/    (winw+spacew));
      step=fw/numw;
          
      for ( i = [vanpadding : step : w-vanpadding] )
        {
        if (order[i/step]==1)
       { 
        translate ([i,wind*2,winz])cutter(winw,wind*2.9,winh);
       } 
        else
        {
        translate ([i,doord*3,doorz-1])cutter(doorw,doord*3.9,doorh+1);
        }
        

     }
     } }
     
     
         fw=w-vanpadding*2;
        numw=floor(fw/    (winw+spacew));
        step=fw/numw;
           for ( i = [vanpadding : step : w-vanpadding] )
{
     if (order[i/step]==1)
            { 
            translate ([i,wind*0.5,winz])window(winw,wind,winh);
                } 
        else
            {
            translate ([i,doord*0.5,doorz])door(doorw,doord,doorh);

            }

}
     }}
     //rotate([-5,0,0])roofstone();,
//House generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
