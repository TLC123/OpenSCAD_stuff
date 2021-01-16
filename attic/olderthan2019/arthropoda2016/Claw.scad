r=5;
for(i=[1:360/21.4:359]){
hull(){
 translate([0,2*r,0])translate([-sin(i)*r,-(((sign(sin(i))*cos(i)+0.99*sign(sin(i))))*(r)),0]){sphere(1,$fn10);
//text(str(i));
}
translate([0,2*r,0])translate([sin(i/2)*r*2,-cos(i/2)*r*2,0]){sphere(1,$fn10);
//text(str(i));
}

}}
