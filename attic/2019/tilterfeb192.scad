include<DC19/DCmath.scad>
t=$t;
//t=0.45;

R=(max(-1,min(1,sin( t*360)*1.5))*25)+25;
translate([0,0,750])rotate([0,R])
{
translate([0,0,-50])cube([1200,800,800],center=true);


}
%translate([0,0,100])cube([1200,800,400],center=true);
%translate([0,400,750])rotate(90,[1,0,0])cylinder(19,730,730,$fn=39);


L1=200;
L2=300;
L3=100;





piv4=[50,-400,-30];
piv3=[-300,-400,-30];

r5=-((max(-1,min(1,sin( t*360)*1.5))*22)-25);
piv5=piv3+[sin(r5),0,cos(r5)]*L1;
n1=let(n=un(piv5-piv4))[n.z,0,-n.x];
lz=L3/(L3+L2);
l1=sqrt( abs(pow((L3) ,2)- pow(norm(piv5-piv4) *(lz),2)))  ;
piv8=lerp( piv4,piv5, lz )+ n1*l1;


echo(  piv8,n1,l1   );


$fn=6;
color("Red")linkop(){
//color("Red")translate(piv1) sphere(30 );
color("Red")translate(piv4) sphere(30);
color("Red")translate(piv8) sphere(30);
color("Red")translate(piv5) sphere(30);
color("Red")translate(piv3) sphere(30);
 }

 

function rotate(p,r)= [p.x*cos(r)-p.z*sin(r),p.y,p.x*sin(r)+p.z*cos(r)]  ;

module linkop()
{
    
     for ( i= [0:1:$children-2])
    
   hull(){
      children(i);
     children(i+1);
   }  
    }