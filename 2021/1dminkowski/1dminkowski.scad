
l=[for (rands(0,0,6))rands(-10,10,3)];
echo(l);

minkowski(){
for(i=[0:1/20:1])
    hull(){
    translate(bez(i,l))sphere(.01);
    translate(bez(i+1/20,l))sphere(.01);
    }

union(){
    scale([10,1,1])sphere(.1);
    scale([1,10,1])sphere(.1);
    scale([1,1,10])sphere(.1);
    }
}


function bez(i,v)=len(v)>2?bez(i,[for(n=[0:len(v)-2])lerp(v[n],v[n+1],i)]):lerp(v[0],v[1],i);



function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function smooth(a) = let (b = clamp(a))(b * b * (3 - 2 * b));
function gauss(x) = x + (x - smooth(x));
