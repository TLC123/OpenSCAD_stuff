My_Spiral=spiral(-15,-180,100);
polyline(My_Spiral);
echo(My_Spiral);
function spiral(turns=1,degree=0,radius,steps=290)= let(t=turns*360+degree)
[for(i=[0:1/steps:1])let(T=lerp(0,t, i),R=lerp(0,radius,f3(i)),x=sin(T)*R,y=cos(T)*R) [x,y] ];




function lerp(start, end, bias) = (end * bias + start * (1 - bias));
 

function smooth_curve(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function gauss(x) =  
     x + (x - smooth_curve(x));
 
 function f(x) = 1-abs(1/(1+x));
 function f2(i) = sqrt(log (i))/2;
 function f3(x) =1-sqrt(2*x);

module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}