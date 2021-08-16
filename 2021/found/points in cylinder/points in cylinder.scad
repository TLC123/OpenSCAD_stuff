function random_points_inside_cylinder(r,h,n)=[for(i=[1:n])cylinder_point(r,h)];

function cylinder_point(r,h)=let (p=[rands(-r,r,1)[0],rands(-r,r,1)[0],rands(0,h,1)[0] ],d=(pow(p.x,2) + pow(p.y,2) )) d > pow(r,2)?cylinder_point(r,h):p;


p=random_points_inside_cylinder(50,100,1000);
for(t=p)translate(t)sphere(4);
echo(p);