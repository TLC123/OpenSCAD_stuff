//Generates a path in the shape of a rectangle
function figureL7(x=40,y=20,step=52)=
let(total=(x+x+y+y),steps_x=round(step/total*x),steps_y=round(step/total*y))
concat(
[for(t=[0:steps_x-1])[(-x/2+(x/steps_x)*t),y/2]],
[for(t=[0:steps_y-1])[x/2,y/2-((y/steps_y)*t)]],
[for(t=[0:steps_x-1])[x/2-((x/steps_x)*t),-y/2]],
[for(t=[0:steps_y-1])[-x/2,-y/2+(y/steps_y)*t]]);

function close(p)=concat(p,[p[0]]);
modulepolyline(p){for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}
moduleline(p1,p2,width=0.5){union(){
    translate(p1)sphere(width);
    translate(p2)sphere(width);}}


polyline(close(figureL7()));
 