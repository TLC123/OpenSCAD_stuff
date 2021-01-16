union()
{
    linear_extrude(2)
offset(-5)offset(10)offset(-5){
   translate([-0,-10,0]) square([65,100]);

translate([-12,45,0])
square([90,50]);
}
translate([0,26,0])rotate([0,90,0]){cube([15,15,2]);
    
translate([13.5,0,.5])rotate([0,45,0]){cube([15,15,1]);
}
}


translate([0,0,0])rotate([0,90,0]){cube([20,25,2]);
    
translate([18.75,00.57])rotate([0,45,0]){cube([20,25,1]);
}
}

translate([63,,0])rotate([0,90,0]){cube([15,55,2]);
    
translate([13.95,0,.95])rotate([0,45,0]){cube([5,55,1]);
}
}
}