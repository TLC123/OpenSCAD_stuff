function minAngleDist(a,b)= 
 
      (2*((b - a) % 360)) % 360 - ((b - a) % 360);
 
function lerp_angle(a,b,bias) =
     a +   ((2*((b - a) % 360)) % 360 - ((b - a) % 360))*bias;


A=($t*3800)%360;
B=(A*7)%360;
echo(A,lerp_angle(A,B,0.5),B);
color("Red")rotate(A)cube([100,1,1]);
color("Blue")rotate(B)cube([100,1,1]);
color("Green")rotate(lerp_angle(A,B,0.5))cube([100,1,1]);
