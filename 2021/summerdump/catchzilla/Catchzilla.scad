*%translate([10,-0])rotate(80)render()import("D:/Downloads/godzilla_scan.stl");
color("gray")translate([0,-80,70])cylinder(150,20,20);
s=rands(1,1,1,1);
duck=-[0,-15,-10,0];
color("lightgray")for(j=[0:3])
{
    i=j/3;
translate([28,-28])foot();
mirror([1,0,0]) translate([28,-28])foot();
leg();
mirror([1,0,0])leg();
tail=[[0,80,12,1],[0,60,8,5],[0,40,10,7],
[0,20,10,10],[0,-10,30,16],[0,-20,50,14],
[0,-25,70,18],[0,-30,90,16]+duck,,[3*i,-35,100,12]+duck,
[3*i,-40,125,8]+duck,[5*i,-50,129,6]+duck,[2*i,-64,129,3]+duck,[0,-64,129,3]+duck,]+[for([0:12])rands(-2,2,4)]; 
polyline(tail);

mirror([1,0,0])polyline(tail);


jaw=[[3,-40,125,6]+duck,[8,-40,115,6]+duck,[7,-47,112,5]+duck,[5,-59,112,2]+duck,[0,-60,110,2]+duck]+[for([0:4])rands(-1,1,4)] ;
 polyline( jaw);
 mirror([1,0,0])polyline(jaw);


leg=[[20,-28,10,10],[21,-40,30,9],[16,-28,45,12],[0,-20,55,2]]+[for([0:3])rands(-1,1,4)];
polyline( leg); mirror([1,0,0])polyline(leg);



arms=[[10,-18,90,14],[18,-24,90,10],[35,-45,88,7],[45,-55,85,6],[46,-83,100,3],[40,-94,100,2]]+[for([0:5])rands(-1,1,4)];
polyline( arms); mirror([1,0,0])polyline(arms);

}
module foot()   {
    
 rotate(rands(-3,3,3))   rotate(-90+12)translate([-5,-5,0])cube([25,5,3 ]);
rotate(rands(-3,3,3))     rotate(-90+-10)translate([-5,-5,0])cube([25,5,3 ]);
 rotate(rands(-3,3,3))    rotate(-90+30)translate([-5,-5,0])cube([25,5,3 ]);
    
    }
    module leg() {
        translate([5,0,0]){
        
        hull(){
    $fn=2;
  translate([18,-28,3]) rotate(rands(-3,3,3))  sphere(4);
translate([13,-38,30])  rotate(rands(-3,3,3))   sphere(8);    
    
    }
    
    hull(){
    $fn=2;
   translate([18,-28,3]) rotate(rands(-3,3,3)) sphere(1);
  translate([13,-28,15])  rotate(rands(-3,3,3)) sphere(8);    
  translate([13,-38,30])      rotate(rands(-3,3,3)) sphere(8);    

    }
    hull(){
    $fn=2;

       translate([13,-38,30]) rotate(rands(-3,3,3)) sphere(9);    
       translate([7,-28,45]) rotate(rands(-3,3,3)) sphere(13);    

    }}
    }
    
     module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[ i+1]);
} // polyline plotter

module line(p1, p2 ,width=0.5) 
{ // single line plotter
    seed=p1.x+p1.y+p1.z;
     $fn=4;    hull() {
        translate([p1.x,p1.y,p1.z]) rotate(rands(-30,30,3,seed))  sphere(p1[3]);
        translate([p2.x,p2.y,p2.z]) rotate(rands(-30,30,3,seed)) sphere(p2[3]);
    }
}