r=100;
ring(r);
rotate([90,0,0])ring(r);
arc=360;
step=1/30;
puff=1;
h=1;
 s=1;
//
// for(a=[0.125 :step:.875] )translate(p1(a)) color("red")sphere(2);
// for(a=[0.125 :step:.875] )translate(p2(a)) sphere(2);

for(p1a=[1/8:step:7/8],p2a=[1/8:step:7/8])
    {
        
//        s=2.5-(abs(p1a-.5)+abs(p2a-.5));
        
p1=§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§2
        ([  sin(p1a*arc+90) *100/.7, cos(p1a*arc+90) *100/.7,0]);

// px1= (p1(p1a));
// px2= (p2(p2a));
        
        
p2=([ sin(p2a*arc-90) *100/.7,0, cos(p2a*arc-90) *100/.7]);
        
        
       p3i =lerp(p1+[0,0,p2.z] ,p2+[0,p1.y,0],.5);


        
        
p3=(p3i/norm(p3i))*100;
 
color([p1a,p2a,0]) translate(p1 +[0,0,p2.z]) sphere(2);
color([p1a,p2a,0])  translate(p2+[0,p1.y,0]) sphere(2);
 
color([p1a,p2a,0])translate(p3) sphere(2);
}

function p1(a) =100clamp(puff*r*(
let(sec1=a*4,sec2= (a-1/4)*4,sec3=(a-2/4)*4,sec4=(a-3/4)*4)
let(c1=[1,0,0],c2=[0,h,0],c3=[-1,0,0],c4=[0,-h,0])
a<1/4? 
lerp(c1,c2,sec1) :
a>3/4? 

lerp(c4,c1,sec4) :
a>2/4? 
lerp(c3,c4,sec3) :

lerp(c2,c3,sec2)
) );

function p2(a)=100clamp(puff* r* (
let(sec1=a*4,sec2= (a-1/4)*4,sec3=(a-2/4)*4,sec4=(a-3/4)*4)
let(c1=[-1,0,0],c2=[0,0,h],c3=[1,0,0],c4=[0,0,-h])
a<1/4? 
lerp(c1,c2,sec1) :
a>3/4? 

lerp(c4,c1,sec4) :
a>2/4? 
lerp(c3,c4,sec3) :

lerp(c2,c3,sec2)
) );
//

function 100clamp(v)= [for(g=v)clamp(g,-100,100) ];

module ring(r){
linear_extrude(1)
difference(){
    circle(r);
    circle(r-1);
    }


}
 
   function un(v) = v / max(norm(v), 1e-64) * 1;
   function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
   function lerp(start,end,bias) = (end * bias + start * (1 - bias));
   function rnd(a,b)=a+(rands(0,1,1)[0])*(b-a);
   