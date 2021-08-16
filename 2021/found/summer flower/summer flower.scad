R=0.25;
for(j=[0.4:1/60:0.8]){
p=concat([
for(i=[0:1/100:1])
 layer(i,j)],[
for(i=[1:-1/100:0])
layer(i,j+1/200)]);

intersection(){
rotate([0,0,rands(0,10,1)[0]+j*60*(2*360/5.5)])
{scale([1,0.5,1])translate([51*R,0,0])sphere(50*R);}
 rotate_extrude( convexity=10)offset(-0.2,$fn=10)offset(0.2)scale([2,0.5])polygon(p);}
}

function layer(i,j)=[sin(j*180-sin(i*90)*180*(1-i))*i*100*0.5,cos(j*180-sin(i*90)*180*(1-i))*i*100];