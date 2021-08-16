$center=[0,0,0];
$lbound=[-0,-0,-0];
$ubound=[0,0,0];

box(2,a=[0,0,0])
box(1,a=[1,-1,0]) 
box(0.5,a=[1,1,1])
box(0.5,a=[1,0,0])
;

module box(s,a)
{



translate($center)cube(s,center=true);
$center= $center+a*-s*2;
 children();


}