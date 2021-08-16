module grow(i)
{ union(){
    
    hull(){sphere(d=i,h=0.1,$fn=20);
    rotate([1,10,i]) translate([0,0,i])sphere(d=i-1,h=0.1,$fn=20);}
    if(i>=1){
    rotate([1,10,i]) translate([0,0,i])grow(i-1);
    if(rands(0,2,1)[0]>=1){
    rotate([1,10,i]) translate([0,0,i])grow(i-1);
    }
        }
    
    }
}
    grow(30);