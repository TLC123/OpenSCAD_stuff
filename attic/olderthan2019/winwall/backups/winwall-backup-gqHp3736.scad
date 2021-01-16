housex=1400;
housey=400;
housez=260;

winh=140;
winw=100;
wind=20;
winz=72;
doorh=160+72;
doorw=120;
doord=20;
doorz=0;
vanh=220;
vanpadding=150;
spacew=120;
stoneh=0.030;
stonew=0.050;
stoned=0.040;



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


module wallblock( length, height)
{
    color( colors[rands(0, n_colors-1, 1)[0]])
	 
     union() {
    intersection() {
    
    translate([-stonew/2,0,0]) cube([length+stonew,stoned,height ]) ;
   
    union() {
        translate([0,-stoned/2,0])cube([length,stoned,height ]) ;
		// Wall
		for( i = [1:height/stoneh]) {
			for ( j = [1:length/stonew] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
                        translate([j*stonew-(i%2)*10,0+rands(-5, 5, 1)[0],i*stoneh+rands(-stoneh*0.3, stoneh*0.3, 1)[0]])
				resize([stonew,stoned,stoneh*1.1]) stone();
                		translate([j*stonew-(i%2)*10,stoned/2+rands(-5, 5, 1)[0],i*stoneh])
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

module centerblock(){      color( colors[rands(0, n_colors-1, 1)[0]])

    translate ([0,-0.5,0.5])cube(1,center=true);}
    
module cutter(w,d,h){resize([w,d,h])centerblock();}
    
    
module window(w,d,h){   
    color( colors[rands(0, n_colors-1, 1)[0]])

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
    color( colors[rands(0, n_colors-1, 1)[0]])
    union(){
    resize([w,d,h]) 
    difference(){
        centerblock();
        translate([0,0,0]) resize([0.85,0.5,0.92]) centerblock();
        
    }
    translate([0,wind*1.5,0]) resize([w*1.2,d*3,h*0.05])centerblock();
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
      
     w=1;
     d=2;
     
     
//      translate ([0,0,0])wall(housex,wind,housez,[1,1,1,1,1,1,1]);
  //    translate ([0,0,housez *1.1])wall(housey,wind,housez,[2,1,2,1,1,1,1]);
    //  translate ([0,0,housez*2.2])wall(housex,wind,housez,[2,1,1,1,1,1,1]);
      //translate ([0,0,housez*3.3 ])wall(housey,wind,housez,[1,1,1,1,1,1,1]);
     
     union(){
     wall(housex,wind,housez,[1,1,1,1,1,1,1]);
      translate ([housex,0,0])rotate([0,0,-90])wall(housey,wind,housez,[2,1,2,1,1,1,1]);
     translate ([housex,-housey,0])rotate([0,0,-180])wall(housex,wind,housez,[2,1,1,1,1,1,1]);
     translate ([0,-housey,0])rotate([0,0,-270])wall(housey,wind,housez,[1,1,1,1,1,1,1]);}
     
     translate([0,0,housez]) union(){
     wall(housex,wind,housez,[1,1,1,1,1,1,1]);
      translate ([housex,0,0])rotate([0,0,-90])wall(housey,wind,housez,[1,1,1,1,1,1,1]);
     translate ([housex,-housey,0])rotate([0,0,-180])wall(housex,wind,housez,[1,1,1,1,1,1,1]);
     translate ([0,-housey,0])rotate([0,0,-270])wall(housey,wind,housez,[1,1,1,1,1,1,1]);}
  //window(6,5,6);
    //cutter(6,2,6);