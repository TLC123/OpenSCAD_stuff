 linear_extrude(10)
 projection(cut = true) 
translate ([0,0,70])
surface(file = "ukmap.png", center = true, invert = true);
