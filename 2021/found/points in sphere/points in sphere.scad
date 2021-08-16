function random_points_inside_sphere(r,n)=[for(i=[1:n])sphere_point(r)];

function sphere_point(r)=let (p=rands(-r,r,3)) (pow(p.x,2) + pow(p.y,2) + pow(p.z,2) > pow(r,2))?sphere_point(r):p;


p=random_points_inside_sphere(50,1000);
for(t=p)translate(t)sphere(4);
echo(p);