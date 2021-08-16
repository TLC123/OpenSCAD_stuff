function random_points_inside_cone(r,h,n)=[for(i=[1:n])cone_point(r,h)];

function cone_point(r,h)=let (p=[rands(-r,r,1)[0],rands(-r,r,1)[0],rands(0,h,1)[0] ],d=sqrt(pow(p.x,2) + pow(p.y,2) ) )  d > r-r*(p.z/h)?cone_point(r,h):p;


p=random_points_inside_cone(50,150,2000);
for(t=p)translate(t)rotate(rands(0,360,3))cube(5,center=true);
echo(p);