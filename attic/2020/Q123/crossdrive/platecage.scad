$fn = 36*3;
function base_face (r, d, mod) = [for(angle = [0: 360/$fn/2: 360-360/$fn/2]) [
    cos(angle)*(r + abs(angle%mod-mod/2)/mod*2*d - d/2),
    sin(angle)*(r + abs(angle%mod-mod/2)/mod*2*d - d/2)
  ]];

module gear_base(diam=20, number=10) {
 offset(-diam*.01)offset(diam*.02)offset(-diam*.01) render()
    polygon(base_face(diam/2, diam/number*1.5, 360/number));
}
module splineP(d){
    square(d*.5,center=true);
    }



module gear(diam=20, number=10, h = 5, orient = 1) {
  render()intersection(){
 difference()
  {     linear_extrude(height = h/2, twist =0* (orient)*90*h/diam)
    gear_base(diam, number);
     {     linear_extrude(height = h/2,slices=1)
 splineP(diam);
  } 
    
//  translate([0, 0, h/2])
//    rotate(-sign(orient) * 90*h/diam)
//      render()
//        linear_extrude(height = h/2, twist = -(orient) * 90*h/diam)
//          gear_base(diam, number);
}

p=0.9;
hull(){
translate([0,0,p])cylinder(h*.5-2*p,diam*.5+p,diam*.5+p);
cylinder(h*.5,diam*.5-p,diam*.5-p);
}
}

}

! scale([.5,.5,1]){ 
    
linear_extrude (3)offset(0)offset(-0)
    
    difference(){ 
        
//        circle( 32,$fn=24);
   gear_base(64,38);
     circle( 7.5,$fn=24);
     splineP(20.4);   
        for(a=[0:60:360])
    rotate([0,0,a])
translate([20,00,-5]){
     circle( 1.6*2 );
        }
        
        
    }
          % translate([32+10,0])rotate(15) gear(20, 12, 20,.3); 
}
 
 halfpack();
 rotate([180,0,0])rotate([0,0,60])halfpack();
 scale(.5) gear(20, 12, 20, -.3); 
scale(.5)rotate([90,0,0])linear_extrude(30)difference(){
offset(1,$fn=1)offset(-1)     square(10,center=true);
rotate([0,0,45])offset(1,$fn=1)offset(-1)square(6,center=true);
}



module halfpack() {
translate([0,0,5])union(){
rotate(90)
 *gear(20, 12, 20,.3);
    cylinder(50,1.6*2,1.6*2,center=true);



for(a=[0:120:360])
    rotate([0,0,a])
translate([20,00,-5]){
 *translate([0,00,15])rotate([180,0,0])gear(20, 12, 20, -.3);
    cylinder(50,1.6*2,1.6*2,center=true);

}
}

}