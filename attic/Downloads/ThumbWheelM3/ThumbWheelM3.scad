//src=http://www.thingiverse.com/thing:225188


$fn=80;
// radius of thumbwheel
rw=15;
// hight of thumbwheeel
hw=3;

//size of nut
rm4_ac=5.5/2/cos(360/12);
// height of the nut
hm4=2.4;
// hole for the screw to go through without toughing
rm4free=4/2;
// hight of nut trapp 90% of nut height
h1=hm4*.9;
// outer radius of nut trapp
r1=rm4_ac+1.5;

//height of scale
hs=.6;
//width of scale
ws=.4;
// number of major ticks
nm=5;
// small number for overlapp
e=0.01;
e2=1;
echo(hw+h1);

grip=37;
grip_gap=0.4;
grip_depth=0.4;

module ThumbWheelM3(){
	//color("lime")
	difference(){
		union(){
			cylinder(hw,rw,rw,$fn=nm*30);
			translate([0,0,hw-e-e2])cylinder(h1+e,r1+2,r1);
		}
		translate([0,0,-1])cylinder(hw+h1+2,rm4free,rm4free,$fn=24);
		translate([0,0,hw-e2])cylinder(hm4,rm4_ac,rm4_ac,$fn=6);
        
 
        for (i=[0:grip]) {
            rotate([0,0,360/grip*i]) translate([rw+0.5-grip_depth,0,hw/2]) rotate([45,0,0]) cube([1,grip_gap,hw*2],center=true); 
            rotate([0,0,360/grip*i]) translate([rw+0.5-grip_depth,0,hw/2]) rotate([-45,0,0]) cube([1,grip_gap,hw*2],center=true); 
        }
	}
	color("black"){
	for(i=[0:nm-1])
		rotate(360/nm*i)
			translate([r1,-ws/2,hw])cube([(rw-r1)-1,ws,hs]);
	for(i=[0:nm*2-1])
		rotate(360/nm/2*i)
			translate([r1+1+((rw-r1)-2)/2+1,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
	for(i=[0:nm*10-1])
		rotate(360/nm/10*i)
			translate([r1+1+((rw-r1)-2)/4*3+0.5,-ws/2,hw])cube([((rw-r1)-2)/4,ws,hs]);
    
    	for(i=[0:nm-1])
		rotate(360/nm*(i+0.5)) {
           translate([r1+1+((rw-r1)-2)/2+0.5,-1.6,hw]) rotate([0,0,90]) linear_extrude(height = hs) text(text = str(i+1),, size=4);
        }
	}
}

ThumbWheelM3();
