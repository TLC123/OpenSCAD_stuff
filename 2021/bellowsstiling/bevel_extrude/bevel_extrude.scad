bevel_extrude(h=2,r=.3,detail=1) text("#",size=20,$fn=1,halign="center");


module bevel_extrude(h ,r ,detail=3)
{
   difference(){
    linear_extrude(h,convexity=6)children();
    
     l=concat([[0,0]   ,[0,h-r]       ],
    [for(i=[90:-90/detail:0]) [r,h-r]+[-sin(i)*r,cos(i)*r]]
    ,[[r,h+r+.1]],[[0,h+r+.1]]
    );
   union()  for(i=[0:max(0,len(l)-2)]){
        p1=l[i];
        p2=l[i+1]+[0,0.0001];
        p3=[ 0,l[i+1].y+0.0001];
        p4=[ 0,l[i].y];
    minkowski(){
     color(rands(0,1,3))hull()rotate_extrude($fn=12,convexity=6)polygon([p1,p2,p3,p4]);
     mirror([0,0,1]) linear_extrude(0.00001)   negative2d () children();
    }
 }
    
    }}
module negative2d (){
    difference(){
    
        offset(delta=30,$fn=1)hull()children();    
        children();
    }
    }