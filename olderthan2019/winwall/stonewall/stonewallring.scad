
colors = ["Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray",
"DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"];
n_colors = 5;

module stone2(){ 
        rotate([rands(0, 7.60, 1)[0],rands(0, 7.60, 1)[0],rands(0, 7.60, 1)[0]])    
 intersection(){
        
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])    
    resize([rands(8, 10, 1)[0],rands(8, 10, 1)[0],rands(8, 10, 1)[0]])
    cube(1,center=true); 
    
    resize([rands(5, 8, 1)[0],rands(5, 8, 1)[0],rands(5, 8, 1)[0]])
    cube(1,center=true); 
}
    }


module ring(r,s,p,e){
    for(i=[s:p:e]){
    
    rotate ([0,i,0] )translate([0,0,r])stone2();
    
    }
    }
    module valve()
  {  for(i=[10:5:70]){
        translate([0,i,0])ring(40,-90,7,90);
    }
}