translate([0,0,0])gate();
translate([-70,0,0])gate();
translate([70,0,0])gate();
translate([0,0,0])gate();



module gate() {
rotate([-90,0,0]){
color("yellow")linear_extrude(1,center=true)panel();
color("LemonChiffon")linear_extrude(2,center=true) offset(delta=-0.25)panel();
color("Khaki")linear_extrude(2.7,center=true) offset(delta=-1)panel();
}}


module panel(){cros(){
 port();
translate([0,0])bar(8);

translate([7,0])bar(5);
translate([12,0])bar(4);
translate([17,0])bar(6);
translate([20,0])bar();

translate([-7,0])bar(5);
translate([-12,0])bar(4);
translate([-17,0])bar(6);
translate([-20,0])bar();

translate([0,1])stripe(8);
translate([0,7.5])stripe(5);
translate([0,12])stripe(4);
translate([0,16])stripe(4);
translate([0,23])stripe(8);
translate([0,30])stripe();
translate([0,35])stripe();
translate([0,40])stripe();
//translate([0,45])stripe();
 }}

module cros()
{ 
union(){difference(){
children([0]);
 offset(delta=-3){children([0]);}
 }

difference(){ 
offset(0)scale([0.65,0.85])children([0]);
 offset(delta=-2)scale([0.65,0.85])children([0]);
}}

 difference(){
 offset(delta=-3){children([0]);}
for(i=[1:9],j=[10:$children -1])
 offset(delta=-0.75)intersection ()
{children([i]);children([j]);
}
 offset(delta=-2)scale([0.65,0.85])children([0]);
}


}






module bar(x=4)
{
translate([0,24])square([x,60],center=true);
}

module stripe(y=5)
{
translate([0,5])square([60,y],center=true);
}
module port(){



square(25);
mirror()square(25);

translate([10,30])scale([0.9,1.2])circle(15);

translate([-10,30])scale([0.9,1.2])circle(15);
}