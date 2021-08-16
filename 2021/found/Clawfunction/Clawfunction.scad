r=15;
steps=159;
//for(i=[1/steps:1/steps:1-1/steps ]){
//
//t1=claw(i,r);
//m1=(t1[0]+t1[1])/2;
//t2=claw(i+steps,r);
//m2=(t2[0]+t2[1])/2;
//
//hull(){translate(m1){sphere(norm(t1[0]-t1[1])/3,$fn=10);}
//translate(m2){ sphere(norm(t2[0]-t2[1])/3,$fn=10);}}
//echo(norm(t1[0]-t1[1]))
//hull(){translate(t1[0]){sphere(1,$fn=10);}
//translate(t1[1]){sphere(1,$fn=10);}}
//}

  polygon(Claw_Path(r,steps));
function Claw_Path(r)=
concat( [for(i=[1/steps:1/steps:1-1/steps]) 
[-(((sign(sin(i*360))*
  cos(i*360)+1 *sign(sin(i*360))))*r)*2+2*r,-sin(i*360)*r]],
[for(i=[1-1/steps:-1/steps:1/steps]) [-cos(i*180)*r*2*2+2*r,sin(i*180)*r*2]]  );

 function  claw(i,r)=let(
t1= [-sin(i*360)*r,-(((sign(sin(i*360))*
      cos(i*360) +0.99*sign(sin(i*360))))*r)+2*r,0],
t2= [sin(i*180)*r*2,-cos(i*180)*r*2+2*r,0] )[t1,t2];