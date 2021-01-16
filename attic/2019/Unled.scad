p1=[0,0];
p2=[200,00];

r1=-360*2;
r2=360*2;
for (j=[0:0.005:1]){
    i=gauss(gauss(j));
    t=lerp(p1,p2,smooth(smooth(smooth(smooth(smooth(smooth((i))))))));
    r=lerp(r1,r2,i);
    m= gauss(gauss(gauss(sin(   (i) *360*0.5 ))))*bulge(i)*bulge(i)*bulge(i)*70;
    s = [sin(r)*m,cos(r)*m];
    translate(t+s) sphere();
    translate(t) color("red")sphere();
    
    }
    
    
function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function un(v) = v / max(len3(v), 0.000001) * 1; // div by zero safe unit normal
 
function rnd(a = 1, b = 0, s = []) = s == [] ? (rands(min(a, b), max(
 a, b), 1)[0]) : (rands(min(a, b), max(a, b), 1, s)[0]);
    
    function bulge(x)=1-pow(1-x*2,2);
    
    function smooth (a) =
let (b = clamp(a))(b * b * (3 - 2 * b));
function smooths(v,steps) =smooth( smooth(mods(v,steps) ))/steps+mstep(v,steps);

function sinw(i)=gauss(i)-sin(i*360)/2;
function isinw(i)=sin(i*360)/2+smooth(i);

function cosw(i)=cos(i*360)/2 -0.5+i;
function icosw(i)=-cos(i*360)/2+0.5+i;

function clamp(a, b = 0, c = 1) = min(max(a, b), c);

function gauss(x) =  
     x + (x - smooth(x));