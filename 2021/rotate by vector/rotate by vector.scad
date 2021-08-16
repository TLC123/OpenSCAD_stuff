p1=[0,0];
p2=rands(-10,10,2);
//p2=[0,1];
p3=rands(-10,10,2);


v=un(p2-p1);

rot=[[v.x,v.y],[-v.y,v.x]];

p4=p3*rot;

hull(){
translate(p1)circle(.1);

translate(p2)circle(.1);
}

translate(p3)circle(.5);

translate(p4)circle(1);


function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function smooth(a) = let (b = clamp(a))(b * b * (3 - 2 * b));
function gauss(x) = x + (x - smooth(x));
