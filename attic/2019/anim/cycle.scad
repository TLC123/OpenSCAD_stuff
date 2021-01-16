//v1=[for([0:15])[rnd(100),rnd(100),rnd(100)] ];
v1= [[76, 86, 69, 2, [0, 0, 0]], [80, 11, 4, 4, [0, 0, 0]], [39, 75, 53, 3, [0, 0, 0]], [49, 87, 68, 2, [0, 0, 0]], [78, 2, 85, 2, [0, 0, 0]], [58, 8, 27, 3, [0, 0, 0]], [42, 41, 73, 2, [0, 0, 0]], [31, 45, 57, 3, [0, 0, 0]] ];
 path1=[for(t=[0:1/100:1]) (smooth_animate(t, v1) )];
color("Red")  polyline(v1) ;
  echo(roundlist(v1,1));
n=smooth_animate($t, v1);
//n=elastic_animate($t, v1);




p=v3(n-[0,0,0,0]);
z=n[3];
c=n[4];
 translate(p)color("Red")scale(1)cube(14,center=true);
 
 function easeOutElastic(  ti,   b=0,   c=1,   d=2) = let(
      t=ti/d,
      ts = t * t,
      tc = ts*t
)
     b+c*(
 33*tc*ts 
 + -106*ts*ts 
 + 126*tc 
 + -67*ts 
 + 15*t
);
 
  function elasticOut(t )=
 1- (1-pow(t,0.6))* (cos( pow((t*4+1),2.65)*360*0.01*1.1) )   ;
 
function wrapi(x,tak) =  ((x  % tak) + tak) % tak; // wraps index 0 - x 
 
function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;

function smooth_animate(t,v)=let(
ll=len(v),        i=round(ll*t),       T=easeOutElastic((ll*t+0.5)%1) , 
p0=    lerp(v[ wrapi(i-1,ll)], v[wrapi(i,ll)],0.5),
p1=    v[wrapi(i,len(v))], 
p2=    lerp( v[wrapi(i,ll)],v[ wrapi(i+1,ll)],0.5) ) 
lerp(lerp( p0,p1,T),lerp(p1,p2,T),(T)) ;

function elastic_animate(t,v)=let(
ll=len(v),        i=round(ll*t),       T=((ll*t+0.5  )%1) , 
p0=     v[ wrapi(i-1,ll)] ,
 p2=     v[ wrapi(i,ll)]  ) 
 lerp( p0, p2,easeOutElastic(T )) ;

function v3(v) = [v[0], max(0,v[1]), max(0,v[2])];





 module polyline(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[ wrap(i+1,len(p))]);
} // polyline plotter
module line(p1, p2 ,width=0.1) 
{ // single line plotter
 color(p1[4])   hull() {
        translate(v3(p1)) sphere(p1[3]);
        translate(v3(p2)) sphere(p2[3]);
    }
}
function wrap(x,x_max=1,x_min=0) =

 (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers 

 

function v3(v) = [v[0], max(0,v[1]), max(0,v[2])];

function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function roundlist(v,r = 0.01) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i],r)];