
colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;

module Wall( length, height)
{
	union() {
		// Wall
		for( i = [0:length]) {
			for ( j = [0:height] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([-40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
				cube([30, 40, 20]);
                
			}
		}
		
		// Top stones
		for (j = [0:length/2]) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([-40/2+rands(-5, 5, 1)[0],2*j*40,(height+1)*20])
				cube([30, 40, 20]);
            import("rock.stl", convexity=3);
		}
	
		// Base stones
		difference() {
			scale([1,1,0.5])
			union(){
				for( i = [0:80]) {
					color( colors[rands(0, n_colors-1, 1)[0]])
					translate([rands(-15, 15, 1)[0], rands(25, length*40+10, 1)[0],rands(0, 15, 1)[0]])
					sphere( r = rands(20, 40, 1)[0], center = true, $fn=20);
				}
			}
			
			translate([-120/2,-40, -40])
			cube([120, 80+40*length+20, 40]);
		}
	}
}


resize([28,28,28])Wall(10, 10);


//translate([0, 10*40+50, 0])
//rotate([0,0,-30])
//Wall(10, 10);