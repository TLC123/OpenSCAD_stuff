 K=concat(
koch([-100,-100],[-100,100] ),koch([-100,-100],[100,-100]),
koch([100,100],[100,-100] ),koch([100,100],[-100,100]));
color("gold")polygon(K);
echo(K);
function koch(p0=[0,0],p4=[100,0],i=6)=i>0?let(
v=(p4-p0),p1=p0+v*1/3,p3=p0+v*2/3,
c=(p4+p0)/2,h=(1/2) * sqrt(3) * norm(v)/3,
perpendicular=[-v.y,v.x],p2=c+(perpendicular/norm(perpendicular)*h))
concat(koch(p0,p1,i-1),koch(p1,p2,i-1),koch(p2,p3,i-1),koch(p3,p4,i-1)):[p0,p4];