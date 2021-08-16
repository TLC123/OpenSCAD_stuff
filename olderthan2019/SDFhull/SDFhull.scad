

for(i=[-1:0.04:0])
translate([0,0, abs(i*10) ])color([abs(i),(abs(i)+0.5)*0.75, (i)])
difference(){
offset(i*30,$fn=60)dof();
offset((i-0.04)*30,$fn=60)dof();
}


for(i=[0:0.04:2])
translate([0,0,-abs(i*10)])color([(abs(i)+0.5)*0.75, abs(i),(i)])
render()
difference(){
offset(i*30,$fn=60)dof();
offset((i-0.04)*30,$fn=60)dof();
}









module dof(){
scale(6){
difference(){
offset(-3,$fn=50)union(){square(10);
circle(7);}
translate([-3,0,0])circle(1);
translate([2,4,0])circle(1);}
translate([5,0,0])circle(1);}
}

