low=0;
hi=1;
for(i=[-low:1/160:hi])translate([i+0,0])square([1/160,lerp(0,1,i)]);// base slope
for(i=[-low:1/160:hi])translate([i+0,2])square([1/160,(arc1(i))]);// circular arc over
for(i=[-low:1/160:hi])translate([i+0,4])square([1/160,(arc2(i))]);// circular arc under
exponent=rnd(-10,10);
for(i=[-low:1/160:hi])translate([i+0,6])square([1/160,((power(i,exponent)))]);
for(i=[-low:1/160:hi])translate([i+0,8])square([1/160, powerInOut(i) ]);

for(i=[-low:1/160:hi])translate([i+2,0])square([1/160,smax(i,step((i),2/3,0.1))]);//full step
for(i=[-low:1/160:hi])translate([i+2,2])square([1/160,(step((i),2/3,0.3,0.7))]);// clamped step
v1=rnd(); v2=rnd();
for(i=[-low:1/160:hi])translate([i+2,4])square([1/160,((comp(i,v1,v2)))]);
for(i=[-low:1/160:hi])translate([i+2,6])square([1/160,(ramp((i),1/3,2/3,0.1))]);
for(i=[-low:1/160:hi])translate([i+2,8])square([1/160,((stepramp(i)))]);
for(i=[-1:1/160:1.0])translate([bisignmap(i) +2,10])square([1/160,map(infmap(i*12))]);
    
for(i=[-low:1/160:hi])translate([i+4,0])square([1/160,((powerInOutInv(i)))]);
for(i=[-low:1/160:hi])translate([i+4,2])square([1/160,(smooth(i))]);
for(i=[-low:1/160:hi])translate([i+4,4])square([1/160,(gauss(i))]);
for(i=[-low:1/160:hi])translate([i+4,6])square([1/160,((expkpow(i)))]);
     
for(i=[-low:1/160:hi])translate([i+6,0])square([1/160, triginvsinw(i)]);
for(i=[-low:1/160:hi])translate([i+6,2+min(0,trigsinw(i))])square([1/160,abs(trigsinw(i))]);
for(i=[-low:1/160:hi])translate([i+6,4+min(0,trigcosw(i))])square([1/160,abs(trigcosw(i))]);
for(i=[-low:1/160:hi])translate([i+6,6])square([1/160,(triginvcosw(i))]);
for(i=[-low:1/160:hi])translate([i+6,8])square([1/160,((bez2(gauss(i),[0,2,0.5,0,1,1])))]);

#for(i=[-low:1/160:hi])translate([i+8,0])square([1/160,(mstep(i,5))]);
#for(i=[-low:1/160:hi])translate([i+8,2])square([1/160,(arcs1((i),3))]);
#for(i=[-low:1/160:hi])translate([i+8,4])square([1/160,(arcs2((i),3))]);
#for(i=[-low:1/160:hi])translate([i+8,6])square([1/160,(smooths(smooth(i),3))]);
#for(i=[-low:1/160:hi])translate([i+8,8])square([1/160,(mods((i),5))]);


PI = acos(-1.);
function easeInSine(x) = 1. - cos((x * PI) / 2.);
function easeInSineVec2(uv) = uv.y - easeInSine(uv.x);
function easeOutSine(x) = sin((x * PI) / 2.);
function easeOutSineVec2(uv) = uv.y - easeOutSine(uv.x);
function easeInOutSine(x) = -(cos(PI * x) - 1.) / 2.;
function easeInOutSineVec2(uv) = uv.y - easeInOutSine(uv.x);
function easeInCubic(x) = x * x * x;
function easeInCubicVec2(uv) = uv.y - easeInCubic(uv.x);
function easeOutCubic(x) = 1. - pow(1. - x, 3.);
function easeOutCubicVec2(uv) = uv.y - easeOutCubic(uv.x);
function easeInOutCubic(x) = x < .5 ? 4. * x * x * x : 1. - pow(-2. * x + 2., 3.) / 2.;
function easeInOutCubicVec2(uv) = uv.y - easeInOutCubic(uv.x);
function easeInQuint(x) = x * x * x * x * x;
function easeInQuintVec2(uv) = uv.y - easeInQuint(uv.x);
function easeOutQuint(x) = 1. - pow(1. - x, 5.);
function easeOutQuintVec2(uv) = uv.y - easeOutQuint(uv.x);
function easeInOutQuint(x) = x < .5 ? 16. * x * x * x * x * x : 1. - pow(-2. * x + 2., 5.) / 2.;
function easeInOutQuintVec2(uv) = uv.y - easeInOutQuint(uv.x);
function easeInCirc(x) = 1. - sqrt(abs(1. - pow(x, 2.)));
function easeInCircVec2(uv) = uv.y - easeInCirc(uv.x);
function easeOutCirc(x) = sqrt(abs(1. - pow(x - 1., 2.)));
function easeOutCircVec2(uv) = uv.y - easeOutCirc(uv.x);
function easeInOutCirc(x) = x < .5 ? (1. - sqrt(1. - pow(2. * x, 2.))) / 2. : (sqrt(1. - pow(-2. * x + 2., 2.)) + 1.) / 2.;
function easeInOutCircVec2(uv) = uv.y - easeInOutCirc(uv.x);
function easeInElastic(x) =
let (c4 = (2. * PI) / 3.)
x == 0. ? 0. : x == 1. ? 1. : -pow(2., 10. * x - 10.) * sin((x * 10. - 10.75) * c4);
function easeInElasticVec2(uv) = uv.y - easeInElastic(uv.x);
function easeOutElastic(x) =
let (c4 = (2. * PI) / 3.)
x == 0. ? 0. : x == 1. ? 1. : pow(2., -10. * x) * sin((x * 10. - .75) * c4) + 1.;
function easeOutElasticVec2(uv) = uv.y - easeOutElastic(uv.x);
function easeInOutElastic(x) =
let (c5 = (2. * PI) / 4.5)
x == 0. ? 0. : x == 1. ? 1. : x < .5 ? -(pow(2., 20. * x - 10.) * sin((20. * x - 11.125) * c5)) / 2. : (pow(2., -20. * x + 10.) * sin((20. * x - 11.125) * c5)) / 2. + 1.;
function easeInOutElasticVec2(uv) = uv.y - easeInOutElastic(uv.x);
function easeInQuad(x) = x * x;
function easeInQuadVec2(uv) = uv.y - easeInQuad(uv.x);
function easeOutQuad(x) = 1. - (1. - x) * (1. - x);
function easeOutQuadVec2(uv) = uv.y - easeOutQuad(uv.x);
function easeInOutQuad(x) = x < .5 ? 2. * x * x : 1. - pow(-2. * x + 2., 2.) / 2.;
function easeInOutQuadVec2(uv) = uv.y - easeInOutQuad(uv.x);
function easeInQuart(x) = x * x * x * x;
function easeInQuartVec2(uv) = uv.y - easeInQuart(uv.x);
function easeOutQuart(x) = 1. - pow(1. - x, 4.);
function easeOutQuartVec2(uv) = uv.y - easeOutQuart(uv.x);
function easeInOutQuart(x) = x < .5 ? 8. * x * x * x * x : 1. - pow(-2. * x + 2., 4.) / 2.;
function easeInOutQuartVec2(uv) = uv.y - easeInOutQuart(uv.x);
function easeInExpo(x) = x == 0. ? 0. : pow(2., 10. * x - 10.);
function easeInExpoVec2(uv) = uv.y - easeInExpo(uv.x);
function easeOutExpo(x) = x == 1. ? 1. : 1. - pow(2., -10. * x);
function easeOutExpoVec2(uv) = uv.y - easeOutExpo(uv.x);
function easeInOutExpo(x) = x == 0. ? 0. : x == 1. ? 1. : x < .5 ? pow(2., 20. * x - 10.) / 2. : (2. - pow(2., -20. * x + 10.)) / 2.;
function easeInOutExpoVec2(uv) = uv.y - easeInOutExpo(uv.x);
function easeInBack(x) =
let (c1 = 1.70158)
let (c3 = c1 + 1.)
c3 * x * x * x - c1 * x * x;
function easeInBackVec2(uv) = uv.y - easeInBack(uv.x);
function easeOutBack(x) =
let (c1 = 1.70158)
let (c3 = c1 + 1.)
1. + c3 * pow(x - 1., 3.) + c1 * pow(x - 1., 2.);
function easeOutBackVec2(uv) = uv.y - easeOutBack(uv.x);
function easeInOutBack(x) =
let (c1 = 1.70158)
let (c2 = c1 * 1.525)
x < .5 ? (pow(2. * x, 2.) * ((c2 + 1.) * 2. * x - c2)) / 2. : (pow(2. * x - 2., 2.) * ((c2 + 1.) * (x * 2. - 2.) + c2) + 2.) / 2.;
function easeInOutBackVec2(uv) = uv.y - easeInOutBack(uv.x);
function easeOutBounce(x) =
let (n1 = 7.5625)
let (d1 = 2.75)
(x < 1. / d1) ? n1 * x * x: (x < 2. / d1) ? 
    let (x = x - 1.5 / d1) n1 * (x) * x + 0.75 : (x < 2.5 / d1) ?
    let (x = x - 2.25 / d1) n1 * (x) * x + 0.9375 : let (x = x - 2.625 / d1) n1 * (x) * x + 0.984375;
function easeOutBounceVec2(uv) = uv.y - easeOutBounce(uv.x);
function easeInBounce(x) = 1. - easeOutBounce(1. - x);
function easeInBounceVec2(uv) = uv.y - easeInBounce(uv.x);
function easeInOutBounce(x) = x < .5 ? (1. - easeOutBounce(1. - 2. * x)) / 2. : (1. + easeOutBounce(2. * x - 1.)) / 2.;
function easeInOutBounceVec2(uv) = uv.y - easeInOutBounce(uv.x);


//function multimix(v,m)=v*un(m);
function amp(signal,pivot,level)=(signal-pivot)/(level-pivot);
function arc1(x,i=0)=let(a=i>0?arc1(x,i-1):x)clamp(sqrt(1-(1-a)*(1-a)));
function arc2(x,i=0)=let(a=i>0?arc2(x,i-1):x)clamp(1-sqrt(1-(a)*(a)));
function arcs1(v,steps=3)=arc1(mods(v,steps),1)/steps+mstep(v,steps);
function arcs2(v,steps=3)=arc2(mods(v,steps),1)/steps+mstep(v,steps);
function bez2(t,v)=(len(v)>2)?bez2(t,[for(i=[0:len(v)-2])lerp(v[i],v[i+1],t)]):lerp(v[0],v[1],t);
function bisignmap(i)=(i+1)/2;// map bilateral -1:1 to 0:1
function bounce(v)=0.5-abs(-v+0.5); // fold
function clamp(a,b=0,c=1)=min(max(a,b),c);
function comp(i,c=0.5,s=0.75)=i<c?ramp(i,0,c,0,s):ramp(i,c,1,s,1); // comressor
function expand(i,c1,c2,s)=i<c1?ramp(i,0,c1,0,s):ramp(i,c1,1,s,1);// expander
function expkpow(x,k=5,n=4) =1- (exp( -k*pow(x,n) ));
function gauss(x)=x+(x-smooth(x));
function infmap(i)=max(0,1-(1/(abs(i)+1)))*sign(i);
function lerp(start,end,bias)=(end*bias+start*(1-bias));
function map(value,istart=-1,istop=1,ostart=0,ostop=1)=ostart+(ostop-ostart)*((value-istart)/(istop-istart));;
function maskmix(v1,v2,c)=lerp(v1,v2,c);
function minmax(i,v1,v2,bias=0.5)=i>=bias?max(v1,v2):min(v1,v2);
function mix(start,end,bias)=(end*bias+start*(1-bias));
function mods(v,steps=3)=((v*steps)%1);
function mstep(v,steps=3)=(floor(v*steps)/steps);
function multimix(v,m)=let(um=pun(m))([for(i=[0:len(v)-1])v[i]*um[i]]);
function power(x,n)=n<0?pow(x,1/abs(min(-1,n-1))):pow(x,max(1,n+1));
function powerInOut(x,exponent=3)=(.5+((pow((x-.5)*2,exponent))))/2;
function powerInOutInv(x)=((x+x-powerInOut(x))-0.5)*0.9+0.5;
function ramp(v,bi1=1/3,bi2=2/3,start=1/3,end=2/3)=let(b1=min(bi1,bi2),b2=max(bi1,bi2))v<=b1?start:v<=b2?lerp(start,end,(v-b1)/(b2-b1)):end;
function reflectf(v)=0.5-abs(v-0.5);
function reflectl(v)=0.5+abs(v-0.5);
function smooth(a)=let(b=clamp(a))(b*b*(3-2*b));
function smooths(v,steps)=smooth(smooth(mods(v,steps)))/steps+mstep(v,steps);
function step(v,bias,start=0,end=1)=v>=bias?end:start;
function stepramp(v,bi1=1/5,bi2=4/5,start=1/4,end=3/4)=let(b1=min(bi1,bi2),b2=max(bi1,bi2))v<=b1?ramp(v,0,b1,0,start):v<=b2?lerp(start,end,(v-b1)/(b2-b1)):ramp(v,b2,1,end,1);
function trigcosw(i)=cos(i*360)/2-0.5+i;
function triginvcosw(i)=-cos(i*360)/2+0.5+i;
function triginvsinw(i)=sin(i*360)/2+smooth(i);
function trigsinw(i)=gauss(i)-sin(i*360)/2;
 


function smin(a,b,k=.1)=let(h=clamp(0.5+0.5*(b-a)/k,0.0,1.0))lerp(b,a,h)-k*h*(1.0-h);
function smax(a,b,k=.1)=let()-smin(-a,-b,k);


function rnd(a = 1, b = 0, s = []) = 
s == [] ? 
 (rands(min(a, b), max( a, b), 1)[0]) 
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