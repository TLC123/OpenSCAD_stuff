$fn=36;
w=170;
epsilon=0.00001;


 r=.0;

//union(){




difference(){
union(){union(){
hull(){
translate([0,20,2])cylinder(7,1.5,1.5);
translate([0,20,2])cylinder(9,1 ,1 );
}translate([-0,20,-1])cylinder(25,.051 ,.051 );}


  mirrorcopy([1,0])

intersection()
{
    
    
    
    step=1/10;
 rotate([90,0,0])  linear_extrude(50-r,center=true){ for(i=[-2.15:step:6.75-step]){
    ii=i+step;
    hull(){
        translate([65-i*10, ( smooth(1-i))*4,0])circle(2,$fn=12);
        translate([65-ii*10, ( smooth(1-ii))*4,0])circle(2,$fn=12);
    }
}}
    
    
    
    

//    minkowski()
    {
//    sphere(r,$fn=12);

linear_extrude(54-r,center=true){ offset(-r)
//    offset(-4)offset(4)
    union(){
    
    translate([w/2-5,0,0])circle(5);




step=1/10;
 translate([w/2-10,0]) square([6,6],true);
for(i=[-1.15:step:4-step]){
    ii=i+step;
    hull(){
        translate([55-i*15,smooth(smooth(i))*20,0])circle(3,$fn=12);
        translate([55-ii*15,smooth(smooth(ii))*20,0])circle(3,$fn=12);
    }
}
 }
 }
 }

}
 }
 
 linear_extrude(30,center=true)mirrorcopy([1,0])  {
translate([170/2-5,0,0])circle(2,$fn=36);

}
hull(){
translate([-0,20,-1])cylinder(1,1.5,1.5);
translate([-0,20,-1])cylinder(2,1 ,1 );
}
translate([-0,20,-1])cylinder(25,.1 ,.1 );

 }

module mirrorcopy(m)
{
    children();
    mirror(m)
    children();
    
    }

function un(v) = v / max(norm(v), 1e-64) * 1;
function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function rnd(a = 1, b = 0) = (rands(min(a, b), max(a, b), 1)[0]);
function smooth(a) = let (b = clamp(a))(b * b * (3 - 2 * b));
function gauss(x) = x + (x - smooth(x));
    
    
    
    module bevel_extrude(h ,r ,detail=4)
{
   difference(){
   linear_extrude(h,convexity=6)children();
    
     l=concat([[0,0]   ,[0,h-r]       ],
     [for(i=[90:-90/detail:0]) [r,h-r]+[-sin(i)*r,cos(i)*r]]
    ,[[r,h+r+.1]],[[0,h+r+.1]]
    );
 echo(l);
     union()  for(i=[0:max(0,len(l)-2)]){
        p1=l[i]+[epsilon,0];
        p2=l[i+1]+[epsilon,epsilon] ;
        p3=[ epsilon,l[i+1].y+0.0001];
        p4=[ epsilon,l[i].y];
        echo(p1,p2,p3,p4);
     minkowski(){
     color(rands(0,1,3))hull()rotate_extrude($fn=12,convexity=6)polygon([p1,p2,p3,p4]);
     color("red")mirror([0,0,1]) linear_extrude(epsilon)  union() negative2d () children();
    }
 }
    
    }}
module negative2d (){
    difference(){
    
        offset(delta=30,$fn=1)hull()children();    
        children();
    }
    }
