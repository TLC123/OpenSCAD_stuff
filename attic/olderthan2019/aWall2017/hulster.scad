

hullster();
 


module hullster()
{$fan=40;
for(i=[0:1/8:1]){
ii=1-i;
hull(){
translate([10*ii,0,0])scale(ii) sphere(3);
translate([0,10*i,0])scale(i) sphere(3);
translate([-10*i,0,0])scale(i) sphere(1 );
}
}
}