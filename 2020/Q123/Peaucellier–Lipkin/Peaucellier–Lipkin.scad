translate([-30,0,90]){ translate([0,50,0])rotate([-90,0,0])chip();
 translate([0,-50,0])rotate([-90,0,0])chip();
 translate([10,0,40])rotate([-90,0,0])chip();
    
    translate([0,0,-10]){  
        translate([75,50,0])rotate([-0,90,0])chip();
 translate([75,-50,0])rotate([-0,90,0])chip();
 translate([85,0,40])rotate([-0,90,0])chip();}
    }

translate([100,0,50])rotate([0,90,0]) translate([0,60,0])rotate([-90,0,0])chip();
translate([100,0,50])rotate([0,90,0])  translate([0,-60,0])rotate([-90,0,0])chip();
translate([-20,0,50])rotate([0,90,0]) translate([0,60,0])rotate([-90,0,0])chip();
translate([-20,0,50])rotate([0,90,0])  translate([0,-60,0])rotate([-90,0,0])chip();

module chip(){
    
    
b1=60;
b2=20;
l=b1+b2;
p=[75,10];
lsh=norm(p);
lsh1=lsh*(3/4);
h=sqrt(b1*b1-lsh1*lsh1);
pm=p*(3/4);
pc1= pm+
     [-p.y,p.x]/lsh*h
     ;
     pc2= pm+
     [p.y,-p.x]/lsh*h
     ;
     
 ic=[20,0];

   pi=pm-(p-pm);     
     
 bar( [0,0],     pc1);
translate([0,0,2]) bar(       pc1,p);
  translate([0,0,1])bar( [0,0],     pc2);
  translate([0,0,0]) bar(       pc2,p);

 
 
 
 translate([0,0,3])bar(pi,ic);
   translate([0,0,1])bar(pc1,pi);
   translate([0,0,2])bar(pi,pc2);
 
 }
 
 
 
module bar(p1,p2){
    linear_extrude(1)
    difference(){
    hull(){
     translate(p1)circle(2);
    translate(p2)circle(2);
    }
       translate(p1)  circle(1);
    translate(p2)circle(1);
    
}
    }
    
    
    function link(p1,p2,b1,b2)=
 let( l=b1+b2)
let(p=p2-p1 )
let(lsh=norm(p))
let(lsh1=lsh*(1/3))
let(h=sqrt(abs(b2*b2-lsh1*lsh1)))
let(pm=p*(1/3))
let( pc1=  p1+pm+
     ([p.y,-p.x]/lsh)*h
)
pc1;    
    
    