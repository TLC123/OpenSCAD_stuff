b=[for (a=[ -90:3:90])
    [sign(sin(a)) *pow(abs(sin(a)),1.8)*(sign(sin(a)) <0?1.47:1.46),
cos(a)-(1-(pow((90-max(0,a))/90,3) +max(0,a)/90))*0.2

]];
c=[for (a=[ -90:3:110])
    [sign(sin(a)) <0?-pow(abs(sin(a)),1.8)*1.47 :(a/90)*2.46 ,
(sign(sin(a)) <0?cos(a):1)+(1-(pow((90-max(0,a))/90,3) +max(0,a)/90))*0.85

],[5.34,0]];

 

 color([0.3,0.3,0.3] )scale([1,1,0.3])rotate([90,0,0])rotate_extrude($fn=80)
 rotate(-90) polygon(b);


 #color("yellow",.5)scale([0.99,0.9,0.3])rotate([90,0,0])rotate_extrude($fn=80)
 rotate(-90) polygon(c);
 
 