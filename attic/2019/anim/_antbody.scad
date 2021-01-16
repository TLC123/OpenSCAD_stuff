include<polytools.scad>
bod();
mirror([0,1,0])bod();

translate(lerp(v3(body[8]),v3(body[9]) ,0.9) )rotate ([60,0,-60])scale(0.5)leg();
translate(lerp(v3(body[6]),v3(body[5]) ,0.5) )rotate ([0,0,-50])leg();
translate(lerp(v3(body[6]),v3(body[5]) ,0.75)  )rotate ([10,0,0])leg();
translate(v3(body[5]) )rotate ([10,0,50])leg();
mirror([0,1,0]){
translate(lerp(v3(body[8]),v3(body[9]) ,0.9) )rotate ([60,0,-60])scale(0.5)leg();

translate(lerp(v3(body[6]),v3(body[5]) ,0.5) )rotate ([0,0,-50])leg();
translate(lerp(v3(body[6]),v3(body[5]) ,0.75)  )rotate ([10,0,0])leg();
translate(v3(body[5]) )rotate ([10,0,50])leg();
}
 body = [
[-5.00,0,0.00,1]
,[-4.00,0,1.00,2]
,[-2.00,0,2.00,3]
,[0.00,0,2.00,3]
,[3.00,0,2.00,1]
,[4.00,0,1.00,1]
,[7.00,0,4.00,3]
,[9.00,0,5.00,3]
,[12.00,0,4.00,1]
,[14.00,0,4.00,3]
,[15.00,1,2.00,2]
,[15.00,0.5,0.00,1]
];
 
leg=[[0,0.00,0.00,0.5]
,[0,2.00,-2.00,0.75]
,[0,7.00,0.00,1]
,[0,7.00,-6.00,0.75]
,[0,9.00,-9.00,0.75]
,[0,10.00,-9.50,0.5] ];
ant =[ 
[0,2.00,-0.00,0.75]
,[0,7.00,-1.00,0.7]
,[0,10.00,-4.00,0.75]
,[0,9.00,-8.00,0.75]
,[0,8.00,-10,0.5] ];
ant1=tr(lerp(v4(body[8]),v4(body[9]) ,0.9) ,rz(-60,rx(60,sc(0.7,ant))));
leg1=tr(lerp(v4(body[6]),v4(body[5]) ,0.5) ,rz(-50,rx(0,sc(1,leg))));
leg2=tr(lerp(v4(body[6]),v4(body[5]) ,0.75) ,rz(0,rx(10,sc(1,leg))));
leg3=tr(lerp(v4(body[5]),v4(body[3]) ,0.25) ,rz(50,rx(10,scx(1.3,leg))));
 


color("red"){
polyline(ant1);
polyline(leg1);
polyline(leg2);
polyline(leg3);
}
echo (body);
echo (ant1);
echo (leg1);
echo (leg2);
echo (leg3);

function tr(b,a)=[for(p=a)p+b];
function sc(b,a)=[for(p=a)p*b];
function scx(b,a)=[for(p=a)[p.x*b*1.5,p.y*b,p.z,p[3]]];
function rx(b,a)=[for(p=a)[
p.x, (p.y*cos(b)-p.z*sin(b))
,(p.z*cos(b)+p.y*sin(b))
,p[3]]];
 

function rz(b,a)=[for(p=a)[
 (p.x*cos(b)-p.y*sin(b))
,(p.y*cos(b)+p.x*sin(b))
,p.z
,p[3]]];
function v3(p1)=[p1.x,p1.y,p1.z];
function v4(p1)=[p1.x,p1.y,p1.z,0];

module bod()  polyline(body);
 
module leg ()  polyline(leg);

 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[ i+1 ]);
} // polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
p1p=v3(p1);
p2p=v3(p2);
width1=p1[3];
width2=p2[3];
    hull() {
        translate(p1p) sphere(width1);
        translate(p2p) sphere(width2);
    }
}