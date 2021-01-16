w=[[0,0],[10,6]];
levels(w,3,5);
module levels(w,n,m)
{
for(i=[0:n-1])
  level([w[0]+[0,w[1].y*(i/n)],[w[1].x,w[1].y/n]],m);



}

module level(w,n)
{
for(i=[0:n-1])

color(rands(0,1,3))translate(w[0]+ [w[1].x*(i/n),0])square([w[1].x/n,w[1].y]);



}