
colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;
module stone(){intersection(){
    cube(1.01, center = true);
    sphere(1, center = true);
    }}

module Wall( length, height)
{ rotate([0,90,0])
    				color( colors[rands(0, n_colors-1, 1)[0]])

	scale([0.14,0.14,0.14]) 
    intersection(){
               translate([-10,0,0]) cube([30,40*length-1,20*height-1]);

    
    union() {
        cube([28,40*length,20*height]);
		// Wall
		for( i = [0:height]) {
			for ( j = [0:length] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([1+rands(0, 2, 1)[0],j*40-(i%2)*20,i*20])
				rotate([rands(-2,2, 1)[0],rands(-2, 2, 1)[0],rands(-1, 2, 1)[0]])
                resize([28, 38, 18]) stone();
			}
		}
		
		
	
		
	}}
}



Wall(20, 15);
 

//translate([0, 10*40+50, 0])
//rotate([0,0,-30])
//Wall(5, 10);