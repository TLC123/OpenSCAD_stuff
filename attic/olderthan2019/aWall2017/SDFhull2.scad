

for(i=[-1.5:0.04:0])
translate([0,0, abs(i*10) ])color([min(abs(i),1),min((abs(i)+0.5)*0.75,1), min(abs(i),1)])
difference(){
offset(r=i*30,$fn=60)dof();
*offset( (i-0.04)*30,$fn=60)dof();
}


for(i=[0:0.04:2])
translate([0,0,-abs(i*10)])color([(abs(i)+0.5)*0.75, abs(i),(i)]*0.5)
render()
difference(){
offset(i*30,$fn=60)dof();
offset((i-0.04)*30,$fn=60)dof();
}









module dof(){
scale(6){
minkowski(){
circle(0.6);
intersection(){ 
 square(4.8,center=true); 
 rotate(45)square(5.1,center=true);
}}

}


}

