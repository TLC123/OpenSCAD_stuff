for(i=[-0:1/160:1])translate([i,0])square([1/160,
    lerp(i,(elasticOut( (i)
 ) ),1)

]);
    function lerp(start, end, bias) = (end * bias + start * (1 - bias));

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
   
function arc2 (x,n=0) =let(a= n>0? arc2(x,(n-1)):x) clamp( 1-sqrt(1-(a)*(a)));
    function clamp(a, b = 0, c = 1) = min(max(a, b), c);
  
  function elasticOut(t )=
    1-(1-pow(t,0.5))* (cos( pow((t*4+1),2.85)*360*0.01*1.8) )   ;
        
        
        function gauss(x) =       x + (x - smooth(x));
        
    function smooth (a) =let (b = clamp(a))(b * b * (3 - 2 * b));