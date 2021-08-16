 
function dot(a,b)=a*b;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));

function sdPolygon( v,  p )= //Polygon - exact   (https://www.shadertoy.com/view/wdBXRW)
    let(
     dlist=[for(   j=[0: len(v)-1] ) 
        let( i=(j+1)%(len(v)),
        e = v[j] - v[i],
        w =    p - v[i],
        b = w - e*clamp( dot(w,e)/dot(e,e), 0.0, 1.0 ))
         dot(b,b) ],
    slist= [for(   j=[0: len(v)-1] ) 
        let( i=(j+1)%(len(v)),
        e = v[j] - v[i],
        w =    p - v[i],       
        c =[ p.y >= v[i].y , p.y < v[j].y  ,  e.x * w.y > e.y * w.x] )
         (c[0]&&c[1]&&c[2]) ||  (!c[0]&&!c[1]&&!c[2]) ? -1:1 ],
    d=min(dlist),
    s= [for(i=slist)1]*[for(i=slist)min(0,i)]%2==0?1:-1)
s*sqrt(d);



function  opExtrusion(  p,     primitive /*function*/,   h )=
    let(
      d = primitive(p.xy),
      w = vec2( d, abs(p.z) - h ))
      min(max(w.x,w.y),0.0) + length(max(w,0.0));
 
 function opRevolution(   p,     primitive  /*function*/,   o )=
    let(
      q = [ norm(p.xz) - o, p.y ])
      primitive(q)
;