module grow(i)
{ union(){
    r=rands(-10,10,1)[0];
    hull(){sphere(d=2*i,h=0.1,$fn=8);
    rotate([r,10,i]) translate([0,0,max(15,50/i)])sphere(d=2*(i-1),h=0.1,$fn=8);}
    if(i>=1){
    rotate([r,10,i]) translate([0,0,max(15,50/i)])grow(i-1);
    if(rands(0,1.1,1)[0]>=1){
    rotate([r,10,i-90]) translate([0,0,max(15,50/i)])grow(i-2);
    }
        }
    
    }
}
module
hill()
{ 
    children(0);
   //translate(                [0,0,-2])hull() children(0);
    
    
    }

    grow(20);

minkowski(){
    sphere(5);
   
    scale([1,1,0.2]) union(){
rotate([30,180,0])grow(15);
//rotate([60,180,60])grow(10);
rotate([30,180,120])grow(15);
//rotate([60,180,180])grow(10);
rotate([30,180,240])grow(12);
//rotate([60,180,300])grow(10);
}
} 