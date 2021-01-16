sphcube( );
module sphcube(bias=0.75,res=5,radius=0.125){

rstep=1/round(res);

for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([i,j,0.5]);
p2=([i+rstep,j,0.5]);
p3=([i+rstep,j+rstep,0.5]);
p4=([i,j+rstep,0.5]);
lp1= (lerp(p1,un(p1),bias));
lp2= (lerp(p2,un(p2),bias));
lp3= (lerp(p3,un(p3),bias));
lp4= (lerp(p4,un(p4),bias));
hull(){
translate(lp1-un(lp1)*radius)sphere(radius,$fn=20);
translate(lp2-un(lp2)*radius)sphere(radius,$fn=20);
translate(lp3-un(lp3)*radius)sphere(radius,$fn=20);
translate(lp4-un(lp4)*radius)sphere(radius,$fn=20);
translate([0,0,0])sphere(radius,$fn=20);
}
}}
for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([i,j,-0.5]);
p2=([i+rstep,j,-0.5]);
p3=([i+rstep,j+rstep,-0.5]);
p4=([i,j+rstep,-0.5]);
lp1= (lerp(p1,un(p1),bias));
lp2= (lerp(p2,un(p2),bias));
lp3= (lerp(p3,un(p3),bias));
lp4= (lerp(p4,un(p4),bias));
hull(){
translate(lp1-un(lp1)*radius)sphere(radius,$fn=20);
translate(lp2-un(lp2)*radius)sphere(radius,$fn=20);
translate(lp3-un(lp3)*radius)sphere(radius,$fn=20);
translate(lp4-un(lp4)*radius)sphere(radius,$fn=20);
translate([0,0,0])sphere(radius,$fn=20);
}
}}
for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([i,0.5,j]);
p2=([i+rstep,0.5,j]);
p3=([i+rstep,0.5,j+rstep]);
p4=([i,0.5,j+rstep]);
lp1= (lerp(p1,un(p1),bias));
lp2= (lerp(p2,un(p2),bias));
lp3= (lerp(p3,un(p3),bias));
lp4= (lerp(p4,un(p4),bias));
hull(){
translate(lp1-un(lp1)*radius)sphere(radius,$fn=20);
translate(lp2-un(lp2)*radius)sphere(radius,$fn=20);
translate(lp3-un(lp3)*radius)sphere(radius,$fn=20);
translate(lp4-un(lp4)*radius)sphere(radius,$fn=20);
translate([0,0,0])sphere(radius,$fn=20);
}
}}
for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([i,-0.5,j]);
p2=([i+rstep,-0.5,j]);
p3=([i+rstep,-0.5,j+rstep]);
p4=([i,-0.5,j+rstep]);
lp1= (lerp(p1,un(p1),bias));
lp2= (lerp(p2,un(p2),bias));
lp3= (lerp(p3,un(p3),bias));
lp4= (lerp(p4,un(p4),bias));
hull(){
translate(lp1-un(lp1)*radius)sphere(radius,$fn=20);
translate(lp2-un(lp2)*radius)sphere(radius,$fn=20);
translate(lp3-un(lp3)*radius)sphere(radius,$fn=20);
translate(lp4-un(lp4)*radius)sphere(radius,$fn=20);
translate([0,0,0])sphere(radius,$fn=20);
}
}}
for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([0.5,i,j]);
p2=([0.5,i+rstep,j]);
p3=([0.5,i+rstep,j+rstep]);
p4=([0.5,i,j+rstep]);
lp1= (lerp(p1,un(p1),bias));
lp2= (lerp(p2,un(p2),bias));
lp3= (lerp(p3,un(p3),bias));
lp4= (lerp(p4,un(p4),bias));
hull(){
translate(lp1-un(lp1)*radius)sphere(radius,$fn=20);
translate(lp2-un(lp2)*radius)sphere(radius,$fn=20);
translate(lp3-un(lp3)*radius)sphere(radius,$fn=20);
translate(lp4-un(lp4)*radius)sphere(radius,$fn=20);
translate([0,0,0])sphere(radius,$fn=20);
}
}}
for(i=[-0.5:rstep:0.5-rstep/2]){
for(j=[-0.5:rstep:0.5-rstep/2]){
p1=([-0.5,i,j]);
p2=([-0.5,i+rstep,j]);
p3=([-0.5,i+rstep,j+rstep]);
p4=([-0.5,i,j+rstep]);
lp1= (lerp(p1,un(p1),bias));
lp2= (lerp(p2,un(p2),bias));
lp3= (lerp(p3,un(p3),bias));
lp4= (lerp(p4,un(p4),bias));
hull(){
translate(lp1-un(lp1)*radius)sphere(radius,$fn=20);
translate(lp2-un(lp2)*radius)sphere(radius,$fn=20);
translate(lp3-un(lp3)*radius)sphere(radius,$fn=20);
translate(lp4-un(lp4)*radius)sphere(radius,$fn=20);
translate([0,0,0])sphere(radius,$fn=20);
}
}}






}
function len3(v)=len(v)==2?sqrt(pow(v[0],2)+pow(v[1],2)):sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function un(v)=v/max(len3(v),0.000001)*1;
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function rnd( a=0,b=1)= (rands(min(a,b),max(a,b),1)[0]);
