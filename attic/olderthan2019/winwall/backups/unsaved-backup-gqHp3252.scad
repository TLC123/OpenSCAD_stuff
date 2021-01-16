difference(){cube([2,1,1],center=true);
color("Red")translate([rands(-3,3,1)[0],0,-0.5])resize([8,1,0.02])surface(file = "techtex.png", center = true, convexity = 5);
}