 



My_poly_line=make_points(16);
LengthOfIt=(len3v(My_poly_line));
Far_Along=rnd(1);
My_Point_Exactly=v2t(My_poly_line,LengthOfIt*Far_Along);
echo( str(round(Far_Along*100),"% "),My_Point_Exactly);
polyline(My_poly_line);
translate(My_Point_Exactly)color("gold")sphere(3);
translate(My_poly_line[0])color("red")sphere(2);
translate(My_poly_line[len(My_poly_line)-1])color("blue")sphere(2);

module line(p1, p2 ,width=0.1) { hull() {        
translate(p1) sphere(width);
translate(p2) sphere(width);    }}

module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}

function un(v)=v/max(1e-15,norm(v));
function len3v(v,acc=0,p=0)=p+1>len(v)-1?
        acc: len3v(v,acc+norm(v[p]-v[p+1]),p+1)  ;
function v2t(v,stop,p=0)=p+1>len(v)-1|| norm(v[p]-v[p+1])>stop?  
 v[p]+un(v[p+1]-v[p])*stop:v2t(v,stop-norm(v[p]-v[p+1]),p+1);
function make_points(j=10,l1=[-30,-30,-30],l2=[30,30,30])= 
     ([for(i=[1:j])[
rnd(l1.x,l2.x)/10+i*10,
rnd(l1.y,l2.y),
rnd(l1.z,l2.z)]]);
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; 

module line(p1, p2 ,width=0.1) { hull() {        
translate(p1) sphere(width);
translate(p2) sphere(width);    }}

module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);}
 
