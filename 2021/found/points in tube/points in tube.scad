function random_points_inside_cylinder(r,r2,h,n)=[for(i=[1:n])cylinder_point(r,r2,h)];

function cylinder_point(r,r2,h)=let (p=[rands(-r,r,1)[0],rands(-r,r,1)[0],rands(0,h,1)[0] ],d=(pow(p.x,2) + pow(p.y,2) )) d > pow(r,2)||d < pow(r2,2)?cylinder_point(r,r2,h):p;


p=random_points_inside_cylinder(50,30,100,1000);
for(t=p)translate(t)scale(6)sphere(1);
echo(p);