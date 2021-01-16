p0=[-1,-1,1];
p1=[1,1,1];
p2=[1,-1,-1];
p3=[-1,1,-1];
tet(p0,p1,p2,p3);

module tet(p0,p1,p2,p3,c=2)
{
line(p0,p1);
line(p0,p2);
line(p0,p3);
line(p1,p3);
line(p2,p1);
line(p2,p3);
p01=(p0+p1)/2;
p02=(p0+p2)/2;
p03=(p0+p3)/2;
p13=(p1+p3)/2;
p32=(p3+p1)/2;
p21=(p2+p1)/2;
tet(p0,p01,p02,p03,c-1);


}

















module line(p1,p2)
{hull(){
translate(p1)sphere(0.1);
translate(p2)sphere(0.1);
}}