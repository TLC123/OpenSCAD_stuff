module pallbotten(){square ([100,144]);
translate([100+227.5 ,0])square ([145,144]);
translate([100+227.5*2+145,0])square ([100,144]);
translate([0,22+78])square ([800,44]);}






exact=[for (a=[11:-1:0],b=[a:-1:0],c=[b:-1:0] ,d=[c:-1:0])let(
sum=((1+a)*sign(a)+
(1+b)*sign(b)+
(1+c)*sign(c)+ 
(1+d)*sign(d) 
))
if(sum==12 ) ([if(a>0)a,if(b>0)b,if(c>0)c,if(d>0)d ])];
echo (len(exact),exact);

 