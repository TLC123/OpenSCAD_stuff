turns=4+rnd(-2,2);
radius = 50+rnd(-40,10);
xpnt=rnd(-2,2);
start_angle=rnd(360);
function L_Spiral (a,radius = 50,heigth,turns =  4,xpnt=0.685,start_angle=45)






= let( fx = xpnt<0?
pow(max(0,1-a),1/abs(min(-1,xpnt-1) )): pow(max(0,1-a),max(1,xpnt+1))   ) 
[(radius * fx ) * cos(start_angle+ a* turns*360*sign(turns)),
 (radius * fx ) * sin(start_angle+ a* turns*360*sign(turns)),a*heigth];

for(j=[0:1/160:1]){color(rands(0,1,3))hull(){
 translate(L_Spiral (j, radius,0,  turns, xpnt, start_angle ))sphere();
 translate(L_Spiral (j+1/160, radius,0, turns, xpnt, start_angle ))sphere();
}}
 





function r(a,xpnt)=let( fx = xpnt<0?
pow(max(0,1-a),1/abs(min(-1,xpnt-1) )): pow(max(0,1-a),max(1,xpnt+1))   )
fx;

p=[rnd(-60,60),rnd(-60,60)];
//translate(p) sphere(2);

function d(p,radius = 50,heigth,turns =  4,xpnt=0.685,start_angle=45)=
let(
a0 =((1+atan2(p.y,p.x)/360-start_angle/360)%1),
d=min([ for (i=[0:turns])

  abs(norm(p)- r(a0/turns+(i/turns),xpnt)*radius) 
]))
d;

translate(p)circle(d(p, radius,0, turns, xpnt, start_angle ));
echo(d(p, radius,0, turns, xpnt, start_angle ));
function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
 function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
