$fn=30;
difference(){
intersection(convexity=40)
{
 

rotate([90,0,0]) linear_extrude(2.4,center=true,convexity=40)difference(){

 {polygon([[0,0],[4.7,0],[4.7,1.12-.44],[3.94,1.12-.44],[3.94,1.12],[1.12,1.12],[1.12,1.9],[0,1.9]]);
translate([2.5,.56])circle(0.25);
}}

linear_extrude(1.9)polygon([[0,1.2],[1.12,1.2],[1.12,0.7],[  3.4874,0.7],[4.7,0],[  3.4874,-0.7], [1.12,-0.7],[1.12,-1.2],[0,-1.2]]);

}



translate([.8,0,2])cube(1,center=true);
translate([0.1999,0,0.9999])cube([0.4,01.4,2],center=true);

}