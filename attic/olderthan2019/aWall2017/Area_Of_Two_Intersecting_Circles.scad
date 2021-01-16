function Area_Of_Two_Intersecting_Circles(P1, P2,P1r,P2r) =
let(p1 = P1r * P1r,p2 = P2r * P2r )
(PI*p1+PI*p2)-
(
let(d = max(1e-32,norm(P2 -  P1)))
(d >= P1r + P2r) ?0:
d < abs(P2r - P1r)?PI * min(p1, p2):    
let( x = (p1 - p2 + d * d) / (2 * d),
z = x * x,  y = sqrt(p1 - z)) 
p1 * asin(y / P1r)/57.2958 + p2 * 
     asin(y / P2r)/57.2958 - y * 
     (x + sqrt(z + p2 - p1))             );
////////////////////////////////////////////////
p1=rands(0,40,2);
p2=rands(0,40,2);
r1=rands(1,20,1)[0];
r2=rands(1,20,1)[0];

echo(str(" Area 1 : ",PI*r1*r1," "));
echo(str(" Area 2 : ",PI*r2*r2," "));
echo(str(" Area ∑ : ",PI*r1*r1+PI*r2*r2)  );
echo(str(" Area  I : ",Area_Of_Two_Intersecting_Circles(p1,p2,r1,r2)));

linear_extrude(1) union(){
translate(p1)circle(r1,$fn=50);
translate(p2)circle(r2,$fn=50);
}
if(  norm(p2 -  p1)< r1 + r2 )color("red")linear_extrude(1.01)
intersection(){
translate(p1)circle(r1,$fn=50);
translate(p2)circle(r2,$fn=50);
}
