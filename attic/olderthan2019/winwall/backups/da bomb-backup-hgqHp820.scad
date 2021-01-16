for(r=[40:-10:0]){
    start=360/r;
for (i=[rands(0,start,1)[0]:360/r:360]){
    
      color("red",0.5)rotate([0,0,i])translate([0,r,0]) cube([10,10,30]);
    
      rotate([0,0,i])translate([0,r,0]) rotate([-90+(60-r*2),-0,0])cube([10,10,30]);
    }}
    