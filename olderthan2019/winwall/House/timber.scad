TimbL=120;//[50:200]
TimbW=10;//[5:40]
rotate([rands(-50, 50, 1)[0],rands(-50, 50, 1)[0],rands(0, 90, 1)[0]]) translate([0,0,-TimbL*0.5])rotate([-90])

resize([TimbW*0.7,TimbL,TimbW]) timber();


module timber(){

color( [0.54,0.25,0.07]) 
    difference(){
     color( [0.54,0.25,0.07]) 
        rotate([90,0,0])rotate([0,0,45])        cylinder(1,$fn=floor(rands(4,8,1)[0]));
for(i=[1:rands(3,5,1)[0]]){
//translate([-rands(-.8,.8,1)[0],0,0])scale([1,rands(1,5,1)[0],1])rotate([0,0,45])cube([0.1,0.1,2],center=true);

translate([-rands(-.8,.8,1)[0],-1,0])scale([5,rands(1,5,1)[0],5])rotate([0,0,45])cube([0.1,0.1,2],center=true);}}

}