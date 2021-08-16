sdf=function(p)  sdSegment( p, [0,0],  [2,1] );
cartf=function(p)  sin(p*36)*2;
  
rotate($vpr)sdfPlot(sdf);
rotate($vpr)cartesianPlot(cartf);

function dot(a,b)=a*b;
function clamp(v,a=0,b=1)=min(max(v,min(a,b)),max(1,b));
function  sdSegment( p, a,   b )=
let(
      pa = p-a, ba = b-a,
      h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 ))
      norm( pa - ba*h );
 

module sdfPlot(f,res=500){
    page=sin($vpf)*$vpd;
    hpage=page/2;
    vpage=hpage/(3/5);
    tick=page/res;
    for(x=[$vpt.x-vpage:tick:$vpt.x+vpage],y=[$vpt.y-hpage:tick:$vpt.y+hpage])
        {
            v=abs(f([x,y]));
                 if (v<tick){translate([x,y])color("black",1-(v/tick))square(tick,center=true);}
        }
    
    
    
    }

module cartesianPlot(f,res=500){
    page=sin($vpf)*$vpd;
    hpage=page/2;
    vpage=hpage/(3/5);
    tick=page/res;
    for(x=[$vpt.x-vpage:tick:$vpt.x+vpage] )
        {
            y= (f(x ));
                  {translate([x,y])color("black" )square(tick,center=true);}
        }
    
    
    
    }