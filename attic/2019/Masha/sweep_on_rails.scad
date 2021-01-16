$detail=0.125;


 v1=[[10,5,0],[5,10,0]];
 v2=[[-10,5,0],[-5,10,0]];
 v4=[[10,0,5],[0,0,5], [0,0,5],[0,10,5]];
 v5=[[-10,0,5],[0,0,5], [0,0,5],[0,10,5]];
  v3=[[0,0,-5], [0,0,0],[0,0,5]];
       railOn2rails( v1  ,v4   ,v3 ,4);
          railOn2rails( v2  ,v5   ,v3 ,4);

//  module sweep2railsAdaptive(rail1,rail2, u0=0,u1=1)
//  {
//   um=lerp(u0,u1,0.5);
//    rail1p0=        smooth_animate_open(u0,rail1);
//    rail1p1=        smooth_animate_open(u1,rail1);
//    rail1lm=lerp(rail1p0,rail1p1,0.5);
//    rail1um =smooth_animate_open(um,rail1);
//    rail1err= norm(v3(rail1lm-rail1um));
//    rail2p0=        smooth_animate_open(u0,rail2);
//    rail2p1=        smooth_animate_open(u1,rail2);
//    rail2lm=lerp(rail2p0,rail2p1,0.5);
//    rail2um =smooth_animate_open(um,rail2);
//          rail2err=norm(v3(rail2lm-rail2um));
//      if(rail1err>$detail|| rail2err>$detail)
//          {sweep2rails(rail1,rail2, u0,lerp(u0,u1,0.5));
//              sweep2rails(rail1,rail2, lerp(u0,u1,0.5),u1);
//              } 
//else 
//          {
//              p0=smooth_animate_open(u0,rail1);
//              p1=smooth_animate_open(u1,rail1);
//              p2=smooth_animate_open(u1,rail2);
//              p3=smooth_animate_open(u0,rail2);
//              
//   color(p0[4]) polyhedron ([v3(p0),v3(p1),v3(p2),v3(p3)],[[0,1,3],[1,2,3]]);
//    }
//
//      }
    module railOn2rails(rail1,rail2, rail3, steps)
  {
      steps=len(rail3)*2;
      step=1/steps;
  for (u=[0:step:1  ],v=[0:step:1 ]){  
      
      
      
       
pi0=smooth_animate_open(v,rail3) 
-lerp(smooth_animate_open(0,rail3),smooth_animate_open(1,rail3),v)
+lerp(smooth_animate_open(u,rail1),smooth_animate_open(u,rail2),v);

pi1=smooth_animate_open(v+step,rail3) 
-lerp(smooth_animate_open(0,rail3),smooth_animate_open(1,rail3),v+step)
+lerp(smooth_animate_open(u,rail1),smooth_animate_open(u,rail2),v+step);

pi2=smooth_animate_open(v+step,rail3) 
-lerp(smooth_animate_open(0,rail3),smooth_animate_open(1,rail3),v+step)
+lerp(smooth_animate_open(u+step,rail1),smooth_animate_open(u+step,rail2),v+step);

pi3=smooth_animate_open(v,rail3) 
-lerp(smooth_animate_open(0,rail3),smooth_animate_open(1,rail3),v)
+lerp(smooth_animate_open(u+step,rail1),smooth_animate_open(u+step,rail2),v);
  
       
            
         
//    color(clamp( pi0[4] ,0,1))   translate(v3(pi0)) sphere(0.3);

                 
 color(clamp( pi0[4] ,0,1)) polyhedron ([v3(pi0),v3(pi1),v3(pi2),v3(pi3)],[[0,1,3],[1,2,3]]);
    } 

      }


    module sweep2rails(rail1,rail2, steps=60)
  {
      step=1/steps;
  for(u=[0:step:1  ]){  
            p0=smooth_animate_open(u,rail1);
            p1=smooth_animate_open(u+step,rail1);
            p2=smooth_animate_open(u+step,rail2);
            p3=smooth_animate_open(u,rail2);
              for(v=[0:step:1 ])
              {
            pi0=lerp(p0,p3, (v));
            pi1=lerp(p0,p3, (v+step)); 
            pi2=lerp(p1,p2, (v+step));             
            pi3=lerp(p1,p2, (v));
                 
   color(pi0[4]) polyhedron ([v3(pi0),v3(pi1),v3(pi2),v3(pi3)],[[0,1,3],[1,2,3]]);
    }}

      }
  
      
      
      
      
  function pointOn2rails(u,v,path1,path2)=
   lerp (smooth_animate_open(u,path1),smooth_animate_open(u,path2),v)
  
  ;
  
  
  
function wrapi(x,tak) =  ((x  % tak) + tak) % tak; // wraps index 0 - x 
 
function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;

//function smooth_animate_closed(t,v)=let(
//ll=len(v),        i=round(ll*t),       T= ((ll*t+0.5)%1) , 
//  
// p0=    lerp(v[ wrapi(i-1,ll)], v[wrapi(i,ll)],0.5),
//p1=    v[wrapi(i,len(v))], 
//p2=    lerp( v[wrapi(i,ll)],v[ wrapi(i+1,ll)],0.5) , 
// 
//
//lerp(lerp( p0,p1,T),lerp(p1,p2,T),(T)) ;


function smooth_animate_open(t,v,sharp=0)=let(
ll=len(v) -1,        
  i=round(ll*t),    
  T= ((ll*t+0.5)%1) , 
  p1=    v[ i ], 
  
  
p00=     lerp(v[   i-1], p1,0.5),
p0=     lerp(v[   i-1], p1,0.5),
p2=    lerp( p1,v[  (i+1)],0.5),
p22=    lerp( p1,v[  (i+1)],0.5) ) 

i==0?lerp(p1-(p2-p1),p2,(T)):
i==ll?lerp(p0,p1-(p0-p1),(T)):

lerp(lerp( p0,p1,T),lerp(p1,p2,T),(T)) ;

// bez2(T,[p00,p0,p1,p2,p22]);

function bez2(t, v) = (len(v) > 2) ? bez2(t, [   for (i = [0: len(v) - 2])lerp(v[i],v[i+1],t)]): lerp(v[0] , v[1] ,t);

function v3(v) = [v[0], max(0,v[1]), max(0,v[2])];





 module polyline_closed(p) {for(i=[0:max(0,len(p)-1)])line(p[i],p[ wrap(i+1,len(p))]);
} // polyline plotter
 module polyline_open(p) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1]);
} // polyline plotter


module line(p1, p2 ,width=0.1) 
{ // single line plotter
 color(p1[4])   hull() {
        translate(v3(p1))scale(p1[3]) sphere(1);
        translate(v3(p2))scale(p2[3]) sphere(1);
    }
}
function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal

function wrap(x,x_max=1,x_min=0) =

 (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers 

 function addTo (p,a)= [for (i=p)i+a];
    function smin (a) =
let (b = clamp(a))(b * b * (3 - 2 * b));
 
function clamp(a, b = 0, c = 1) =is_list(a)? [for (i=a)clamp(i,b,c)] : min(max(a, b), c);

function gauss(x) =  
     x + (x - smooth(x));

function v3(v) = [v[0], max(0,v[1]), max(0,v[2])];

function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 
function rndc(a=1,b=0)=[rnd(a,b),rnd(a,b),rnd(a,b)];
function roundlist(v,r = 0.01) = len(v) == undef ? v - (v % r) : len(v) == 0 ? [] : [
  for (i = [0: len(v) - 1]) roundlist(v[i],r)];