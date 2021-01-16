linear_extrude(1)difference(){
    square ([50,100],center=true);
    
 translate([6+2.3,0]*2)hull(){   
translate([0,(26.6-2.3)/2])    circle(2.3/2,$fn=12);
translate([0,-(26.6-2.3)/2])     circle(2.3/2,$fn=12);
}

 translate([6+2.3,0]*1)hull(){   
translate([0,(26.6-2.3)/2])    circle(2.3/2,$fn=12);
translate([0,-(26.6-2.3)/2])     circle(2.3/2,$fn=12);
}

 translate([6+2.3,0]*0)hull(){   
translate([0,(26.6-2.3)/2])    circle(2.3/2,$fn=12);
translate([0,-(26.6-2.3)/2])     circle(2.3/2,$fn=12);
}

 translate([6+2.3,0]*-1)hull(){   
translate([0,(26.6-2.3)/2])    circle(2.3/2,$fn=12);
translate([0,-(26.6-2.3)/2])     circle(2.3/2,$fn=12);
}

 translate([6+2.3,0]*-2)hull(){   
translate([0,(26.6-2.3)/2])    circle(2.3/2,$fn=12);
translate([0,-(26.6-2.3)/2])     circle(2.3/2,$fn=12);
}

 translate([6+2.3,0]*1)hull(){   
translate(-[0,(26.6)/2+7.5+8.7/2])    circle(8.7/2,$fn=36);
 
}
 translate([6+2.3,0]*-1)hull(){   
translate(-[0,(26.6)/2+15.5+3.4/2])    circle(3.4/2,$fn=24);
 
}

translate([6+2.3,0]*-0.4)hull(){   
translate(-[0,(26.6)/2+8.1+5.6/2])    circle(5.6/2,$fn=24);
 
}
}