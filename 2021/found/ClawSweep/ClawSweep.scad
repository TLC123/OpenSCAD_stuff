scale([2,1,1])translate([-100,0,0])for(a=[10:10:130])
{
hull(){
rotate([0,a,0])translate([100,0,0]) scale([1,1,0.0125]) sphere((max(1,130-a))/2);
rotate([0,a-10,0])translate([100,0,0]) scale([1,1,0.0125]) sphere((max(1,130-(a-10)))/2);
}
}
scale([2,1 ,1]) scale([1,1,0.75]) rotate_extrude()translate([65,-10,0]) circle(10);