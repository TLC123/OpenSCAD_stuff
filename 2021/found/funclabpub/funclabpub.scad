*linear_extrude(0.001)
for(i=[-0:1/160:1])translate([i,0])square([1/160,(lerp(0,1, (i)))]);
    function lerp(start, end, bias) = (end * bias + start * (1 - bias));
linear_extrude(0.001)
for(i=[-0:1/160:1])translate([i,0])square([1/160,(lerp(0,1, (i)))]);
    function lerp(start, end, bias) = (end * bias + start * (1 - bias));

for(i=[-0:1/160:1])translate([i,0])square([1/160, (step( (i),2/3,0.1))]);
    function step(v,bias,start=0, end=1) = v>=bias?end:start;

for(i=[-0:1/160:1])translate([i,0])square([1/160, (mstep( i,5))]);
    function mstep(v,steps=3) = (floor(v*steps)/steps );

for(i=[-0:1/160:1])translate([i,0])square([1/160, (mods(  (i),5))]);
    function mods(v,steps=3) = ( (v*steps)%1);

for(i=[-0:1/160:1])translate([i,0])square([1/160, (smooth( (i),2/3,0.1))]);
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160, (step( (i),2/3,0.3,0.7))]);
    function step(v,bias,start=0, end=1) = v>=bias?end:start;


for(i=[-0:1/160:1])translate([i,0])square([1/160,  (arc1(  (i)))]);
    function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
    function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));
    function arcs1(v,steps=3) = arc1(mods(v,steps),1)/steps+mstep(v,steps);
    function arcs2(v,steps=3) = arc2(mods(v,steps),1)/steps+mstep(v,steps);
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160, (arc2(  (i)))]);
    function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
    function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));
    function arcs1(v,steps=3) = arc1(mods(v,steps),1)/steps+mstep(v,steps);
    function arcs2(v,steps=3) = arc2(mods(v,steps),1)/steps+mstep(v,steps);
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);


for(i=[-0:1/160:1])translate([i,0])square([1/160, (ramp( (i),1/3,2/3,0.1)) ]);
    function ramp(v,bi1=1/3,bi2=2/3,start=1/3, end=2/3) = 
        let(b1=min(bi1,bi2),b2=max(bi1,bi2))
        v<=b1?start:v<=b2?lerp(start,end,(v-b1)/(b2-b1))    :end;
    
for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (  stepramp(i) )) ]);
    function stepramp(v,bi1=1/5,bi2=4/5,start=1/4, end=3/4) = 
        let(b1=min(bi1,bi2),b2=max(bi1,bi2))
        v<=b1?ramp(v,0,b1,0,start):v<=b2?lerp(start,end,(v-b1)/(b2-b1))    :ramp(v,b2,1,end,1);

 //for(i=[-0:1/160:1])translate([i,0])square([1/160,   (gauss(  (i))) ]);
    function gauss(x) =       x + (x - smooth(x));
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160, (mods(  (i),5))]);
    function mods(v,steps=3) = ( (v*steps)%1);

for(i=[-0:1/160:1])translate([i,0])square([1/160, (arcs1(  (i),3))]);
    function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
    function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));
    function arcs1(v,steps=3) = arc1(mods(v,steps),1)/steps+mstep(v,steps);
    function arcs2(v,steps=3) = arc2(mods(v,steps),1)/steps+mstep(v,steps);
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);
    function mstep(v,steps=3) = (floor(v*steps)/steps );
    function mods(v,steps=3) = ( (v*steps)%1);


for(i=[-0:1/160:1])translate([i,0])square([1/160,   (arcs2(  (i),3)) ]);
    function arc1 (x,n=0) = let(a= n>0? arc1(x,(n-1)):x) clamp(sqrt(1-(1-a)*(1-a)));
    function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));
    function arcs1(v,steps=3) = arc1(mods(v,steps),1)/steps+mstep(v,steps);
    function arcs2(v,steps=3) = arc2(mods(v,steps),1)/steps+mstep(v,steps);
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);
    function mstep(v,steps=3) = (floor(v*steps)/steps );
    function mods(v,steps=3) = ( (v*steps)%1);




 


for(i=[-0:1/160:1])translate([i,  min(0,isinw(i))])square([1/160,   abs(isinw(  (i))) ]);
    function cosw(i)=cos(i*360)/2 -0.5+i;
    function icosw(i)=-cos(i*360)/2+0.5+i;
    function isinw(i)=gauss(i)-sin(i*360)/2;
    function sinw(i)=sin(i*360)/2+smooth(i);
    function gauss(x) =       x + (x - smooth(x));
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160,    (sinw(  (i))) ]);
    function cosw(i)=cos(i*360)/2 -0.5+i;
    function icosw(i)=-cos(i*360)/2+0.5+i;
    function isinw(i)=gauss(i)-sin(i*360)/2;
    function sinw(i)=sin(i*360)/2+smooth(i);
    function gauss(x) =       x + (x - smooth(x));
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i ,  min(0,cosw(i))])square([1/160,   abs(cosw(  (i))) ]);
    function cosw(i)=cos(i*360)/2 -0.5+i;
    function icosw(i)=-cos(i*360)/2+0.5+i;
    function sinw(i)=gauss(i)-sin(i*360)/2;
    function isinw(i)=sin(i*360)/2+smooth(i);
    function gauss(x) =       x + (x - smooth(x));
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160,    (icosw(  (i))) ]);
    function cosw(i)=cos(i*360)/2 -0.5+i;
    function icosw(i)=-cos(i*360)/2+0.5+i;
    function sinw(i)=gauss(i)-sin(i*360)/2;
    function isinw(i)=sin(i*360)/2+smooth(i);
    function gauss(x) =       x + (x - smooth(x));
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);


for(i=[-0:1/160:1])translate([i,0])square([1/160,   (smooths(  smooth(i),3 )) ]);
    function smooths(v,steps) =smooth( smooth(mods(v,steps) ))/steps+mstep(v,steps);
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);



v3=rnd(-10,10);
for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (   power(i,v3) )) ]);
     function power(x,n) = n<0?pow(x,1/abs(min(-1,n-1) )):pow(x,max(1,n+1))   ;



for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (   fx4(i) )) ]);
    function fx4(x) =  clamp(pow(x-0.5,3)*4+0.5);
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (   ifx4(i) )) ]);
     function ifx4(x) =       ((x+ x-fx4(x))-0.5)*0.9+0.5 ;


for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (   fx6(i) )) ]);
     function fx6(x,k=5,n=4) =1- (exp( -k*pow(x,n) ));




for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (   bez2(gauss(i),[0,2,0.5,0,1,1]) )) ]);
    function bez2(t, v) = (len(v) > 2) ? bez2(t, [
          for (i = [0: len(v) - 2]) lerp(v[i] , v[i + 1] , t)
        ]): lerp(v[0] , v[1] ,t);

    function lerp(start, end, bias) = (end * bias + start * (1 - bias));

for(i=[-1:1/160:1])translate([bisignmap(i),0])square([1/160,  map(infmap(i*12) )   ]);
    function bisignmap(i)=(i+1)/2;
    function infmap(i)=max(0,1-(1/(abs(i)+1)))*sign(i);
    function  map(  value,istart=-1, istop=1, ostart=0, ostop=1) =
    ostart + (ostop - ostart) * ((value - istart) / (istop - istart));

v1=rnd();v2=rnd();
for(i=[-0:1/160:1])translate([i,0])square([1/160,  ((  comp(i,v1,v2)))]);
    function comp(i,c=0.5,s=0.75)=i<c? ramp(i,0,c,0,s) :ramp(i,c,1,s,1) ;
    function ramp(v,bi1=1/3,bi2=2/3,start=1/3, end=2/3) = 
        let(b1=min(bi1,bi2),b2=max(bi1,bi2))
        v<=b1?start:v<=b2?lerp(start,end,(v-b1)/(b2-b1))    :end;
      




for(i=[-0:1/160:1])translate([i,0])square([1/160,     clamp(fx4(i),0.2,0.8)]);
    function fx4(x) =  clamp(pow(x-0.5,3)*4+0.5);
    function ifx4(x) =       ((x+ x-fx4(x))-0.5)*0.9+0.5 ;
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);

for(i=[-0:1/160:1])translate([i,0])square([1/160,   ( (  max(smooth(i),gauss(i))))]);
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);




//function multimix (v,m)=v*un(m);
function multimix (v,m)=let(um=pun(m)) ([for(i=[0:len(v)-1])v[i]*um[i]]);
function amp(fx,f0,f1)=(fx-f0)/(f1-f0);
function bounce(v)=0.5-abs( -v+0.5) ;
function reflectf(v)=0.5-abs( v-0.5) ;
function reflectl(v)=0.5+abs( v-0.5) ;




function expand(i,c1,c2,s)=i<c? ramp(i,0,c,0,s) :ramp(i,c,1,s,1) ;
 



function minmax(i,v1,v2,bias=0.5) =  i>=bias?max(v1,v2):min(v1,v2);
 


function maskmix(v1,v2,c ) =  lerp(v1,v2,c);


function mix(start, end, bias) = (end * bias + start * (1 - bias));
 






function clamp(a, b = 0, c = 1) = min(max(a, b), c);




;


function un(v)=v/max(norm(v),1e-16);
function pun(v)=v/max(sumv(v),1e-16);
function sumv(l)=  len(l) > 0 ? [ for(li=l) 1 ] * l : undef;

 function f(x) = 1-abs(1/(1+x));
 function fx(x) =( fx10(  (x)));
 function fx1(x) = 1-((1-x)*(1-x));
 function fx3(x) = 1-((x)*(x));


 function fx5(x,k=8) =k*x*x*exp(1-k*x*x);
 function fx7(x,k=0.3 ) = pow( 4.0*x*(1.0-x), k );
 function fx8(x,k=0.3 ) = 1+(sqrt(log (x))/2);
 function fx9(x,k=0.3 ) = lerp(lerp(0,1,1-x- ((7/x  )%(x/7)) ),lerp(0,1, x- ((4/x  )%(x/7)) ),x) ;
 function fx10(x,k=4 ) = lerp(clamp( (x-0.5)*k ),clamp( (x-0.5)*k+1 ), x);
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