function random_points_inside_cuboid(p1,p2,n)=[for(i=[1:n])cuboid_point(p1,p2)];

function cuboid_point(p1,p2)= [rands(-p1.x,p2.x,1)[0],rands(-p1.y,p2.y,1)[0],rands(-p1.z,p2.z,1)[0]] ;
function sq2(v)=pow(v,2);
p1=[0,0,0];
p2=[100,100,100];
p=random_points_inside_cuboid(p1,p2,1000);
for(t=p)translate(t)sphere(4);
echo(p);