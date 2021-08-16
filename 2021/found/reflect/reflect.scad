function reflect (d,n)=d- 2*(d*n)*n;

p1= rands(0,50,3);
p3=reflect(-p1,[0,0,1]);
line(p1);
line(p3);

echo(p1);



module line(p1,p2=[0,0,0]){
hull(){
translate(p1)sphere(1);
translate(p2)sphere(1);
}}