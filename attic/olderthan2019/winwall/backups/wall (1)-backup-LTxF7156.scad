
colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;

module Wall( length, height)
{
	union() {
        
         color( colors[rands(0, n_colors-1, 1)[0]]) translate([-75,00,0])cube([65, 40*length, height*20]);
		// Wall
		for( i = [1:height]) {
			for ( j = [0:length] ) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([-40/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
                
                resize(newsize=[40,55,40]) rotate([rands(-150, 150, 1)[0], rands(-150, 150, 1)[0], rands(-150, 150, 1)[0]]) resize(newsize=[40,40,40])  import("rock.stl", convexity=3);
				
                
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([-120/2+rands(-5, 5, 1)[0],j*40-(i%2)*10,i*20])
                
                resize(newsize=[60,60,40]) rotate([rands(-150, 150, 1)[0], rands(-150, 150, 1)[0], rands(-150, 150, 1)[0]]) resize(newsize=[40,40,40])  import("rock.stl", convexity=3);
                
			}
		}
		
        
		// Top stones
		for (j = [0:length/2]) {
				color( colors[rands(0, n_colors-1, 1)[0]])
				translate([-80/2+rands(-5, 5, 1)[0],2*j*40,(height+1)*20])
            
				 resize(newsize=[40,40,15]) rotate([rands(-150, 150, 1)[0], rands(-150, 150, 1)[0], rands(-150, 150, 1)[0]]) resize(newsize=[40,40,40])  import("rock.stl", convexity=3);
            
		}
	
		// Base stones
		difference() {
			scale([1,1,1.5])
			union(){
				for( i = [0:80]) {
					color( colors[rands(0, n_colors-1, 1)[0]])
					translate([rands(-105,15, 1)[0], rands(0, length*40+10, 1)[0],rands(0, 15, 1)[0]])
					 resize(newsize=[40,60,40]) rotate([rands(-150, 150, 1)[0], rands(-150, 150, 1)[0], rands(-150, 150, 1)[0]]) resize(newsize=[40,40,40])  import("rock.stl", convexity=3);
				}
			}
			
			translate([-240/2,-40, -40])
			cube([240, 80+40*length+20, 40]);
		}
	}
}


 resize(newsize=[28,28,28]) Wall(20, 5);


//translate([0, 10*40+50, 0])
//rotate([0,0,-30])
//Wall(10, 10);