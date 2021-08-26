include<unionRoundMask.scad>


color("green")
render()
unionRoundMask(r=3,detail=10,q=12,showMask=false)
{
    rotate([40,50,30])
    linear_extrude(40 )square([10,10]);
    linear_extrude(40 )circle(10);
    
    }