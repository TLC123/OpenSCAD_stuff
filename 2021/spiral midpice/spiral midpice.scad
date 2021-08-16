r0=rnd(1,5);
r1=rnd(1,5);
fr=[rnd(-20,0),-rnd(-10,10)];
to=[rnd(-0,20),-rnd(-10,10)];
for(i=[0:1/30:1])
    
{
 
    translate(f(i,fr,to,r0,r1,1))sphere(.5);
    translate(f(i,fr,to,r0,r1,2))sphere(.5);
    p=f(i,fr,to,r0,r1);
    color("red")translate(p)sphere(.5);
    
    }
    
    
    
    
 function s(   p,   a,  b )=
let(
     pa = p-a,
     ba = b-a,
     h = clamp(  (pa*ba)/(ba*ba), 0.0, 1.0 ),
    d=norm( pa - ba*h ))
    [d,h];
 
function f(i,fr,to,r0,r1,sel=0) =
    let(
          v=to-fr,
        va=atan2(v.y,v.x)-90,
        a0=lerp(-90,90, (i))-va,
        a1=lerp(-90,90, (i))+va,
        p0=fr+[sin(a0),cos(a0)]*r0,
        p1=to+[sin(a1),-cos(a1)]*r1,
        p=lerp(p0,p1,lerp( smooth(i),i,.5)),
    out=[p,p0,p1]
    )
    out[sel];
    
     function SDFarc(p,fr,to,r0,r1)=
     let(
    
    h=s(p,fr,to).y,
    step=1/16,
    d=min([
    norm(p-f(h,fr,to,r0,r1)),
    for(i=[0:step:1-step])
        s(p,f(i,fr,to,r0,r1),f(i-step,fr,to,r0,r1)).x
    ]))
    d;
    
    
    
        p=[rnd(-10,10),rnd(-10,10)];
d=SDFarc(p,fr,to,r0,r1);
    
    color("blue",0.5)translate(p)circle(d,$fs=1);
 
 function un(v) = v / max(norm(v), 1e-64) * 1;
 function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
 function lerp(start,end,bias) = (end * bias + start * (1 - bias));
 function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
 function smooth(a) = let (b = clamp(a))(b * b * (3 - 2 * b));
 function gauss(x) = x + (x - smooth(x));
 