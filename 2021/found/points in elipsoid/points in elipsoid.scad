function random_points_inside_ellipsoid(rx,ry,rz,n)=[for(i=[1:n])ellipsoid_point(rx,ry,rz)];

function ellipsoid_point(rx,ry,rz)=let (r=[rx,ry,rz],p=[rands(-rx,rx,1)[0],rands(-ry,ry,1)[0],rands(-rz,rz,1)[0] ] ,
d= ((
sq2(p.x)/sq2(r.x)+
sq2(p.y)/sq2(r.y)+
sq2(p.z)/sq2(r.z)) - 1) * min(r.x,r.y,r.z)  )  (d)>0?ellipsoid_point(rx,ry,rz):p;
function sq2(v)=pow(v,2);

p=random_points_inside_ellipsoid(50,50,100,1000);
for(t=p)translate(t)sphere(4);
echo(p);