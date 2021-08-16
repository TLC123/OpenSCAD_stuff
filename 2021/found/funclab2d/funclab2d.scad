linear_extrude(0.01)
for(j=[-2:1/8:2])
for(i=[0:1/80:4])translate([fx5(i,0.7)  *abs(j) , (0.1/max(0.001,abs(j)))*i*sign(j)])square(0.05);


//function multimix (v,m)=v*un(m);
function multimix (v,m)=let(um=pun(m)) ([for(i=[0:len(v)-1])v[i]*um[i]]);
function amp(fx,f0,f1)=(fx-f0)/(f1-f0);
function bounce(v)=0.5-abs( -v+0.5) ;
function reflectf(v)=0.5-abs( v-0.5) ;
function reflectl(v)=0.5+abs( v-0.5) ;

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
function step(v,bias,start=0, end=1) = v>=bias?end:start;

function comp(i,c=0.5,s=0.75)=i<c? ramp(i,0,c,0,s) :ramp(i,c,1,s,1) ;

function expand(i,c1,c2,s)=i<c? ramp(i,0,c,0,s) :ramp(i,c,1,s,1) ;

function mstep(v,steps=3) = (floor(v*steps)/steps );
function mods(v,steps=3) = ( (v*steps)%1);
function arcs1(v,steps=3) = arc1(mods(v,steps),1)/steps+mstep(v,steps);
function arcs2(v,steps=3) = arc2(mods(v,steps),1)/steps+mstep(v,steps);
function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));

 ;

function ramp(v,bi1=1/3,bi2=2/3,start=1/3, end=2/3) = 
let(b1=min(bi1,bi2),b2=max(bi1,bi2))
v<=b1?start:v<=b2?lerp(start,end,(v-b1)/(b2-b1))    :end;
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for (i = [0: len(v) - 2]) lerp(v[i] , v[i + 1] , t)
]): lerp(v[0] , v[1] ,t);

function stepramp(v,bi1=1/5,bi2=4/5,start=1/4, end=3/4) = 
let(b1=min(bi1,bi2),b2=max(bi1,bi2))
v<=b1?ramp(v,0,b1,0,start):v<=b2?lerp(start,end,(v-b1)/(b2-b1))    :ramp(v,b2,1,end,1);
function minmax(i,v1,v2,bias=0.5) =  i>=bias?max(v1,v2):min(v1,v2);
 


function maskmix(v1,v2,c ) =  lerp(v1,v2,c);


function mix(start, end, bias) = (end * bias + start * (1 - bias));
 

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

//
//function un(v)=v/max(norm(v),1e-16);
//function pun(v)=v/max(sumv(v),1e-16);
//function sumv(l)=  len(l) > 0 ? [ for(li=l) 1 ] * l : undef;
// function f(x) = 1-abs(1/(1+x));
// function fx(x) =( fx10(  (x)));
// function fx1(x) = 1-((1-x)*(1-x));
 function fx2(x,n) = n<0?pow(x,1/abs(min(-1,n-1) )):pow(x,max(1,n+1))   ;
// function fx3(x) = 1-((x)*(x));
 function fx4(x) =  clamp(pow(x-0.5,3)*4+0.5);
 function ifx4(x) =       ((x+ x-fx4(x))-0.5)*0.9+0.5 ;
//
  function fx5(x,k=8) =(k*x)*exp(1.0-(k*x));
 function fx6(x,k=5,n=4) =1- (exp( -k*pow(x,n) ));
// function fx7(x,k=0.3 ) = pow( 4.0*x*(1.0-x), k );
// function fx8(x,k=0.3 ) = 1+(sqrt(log (x))/2);
// function fx9(x,k=0.3 ) = lerp(lerp(0,1,1-x- ((7/x  )%(x/7)) ),lerp(0,1, x- ((4/x  )%(x/7)) ),x) ;
// function fx10(x,k=4 ) = lerp(clamp( (x-0.5)*k ),clamp( (x-0.5)*k+1 ), x);
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);
}

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}