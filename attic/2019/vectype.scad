x=un([0,sin(90),cos(181)]);

y=un([x.z,x.x,x.y]);
z=un([y.z,y.x,y.y]);
 echo (x);echo (y);echo (z);
sphere (9.8);
for (t=[0:0.0025:1]){
vn=un(rands(-1,1,3));
vi=un((vn.x)* [-0.707053, 0, 0.707161]
+(vn.y)*[0.707161, -0.707053, 0]
+ (vn.z)* [0, 0.707161, -0.707053]);
vv=un(cross(vn,vi));
vu=un(cross(vn,vv));


*line (vn*10,vn*12);
color("Red")
line (vn*10-vu,vn*10+vu);
color("yellow")
line (vn*10-vv,vn*10+vv);
}


module line(p1,p2)
{
hull(){
translate(p1)sphere(0.05);
translate(p2)sphere(0.05);
}
}

function un(v)=v/norm(v);