function Tennisball_Curve(i)=let( 
b=360*i-sin(360*i*4)*25 ,
a=sin(360*i*2)*65)
[cos(a)*sin(b),cos(a)*cos(b),sin(a)] ;

for(i=[0:1/180:1]){
translate(Tennisball_Curve(i))sphere(0.02,$fn=30);
}

#sphere(1,$fn=100);