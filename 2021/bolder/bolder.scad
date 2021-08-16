color("gray") render()
    
    
minkowski(){    difference(){
 
    simple();
 
        
    for([0:1]){  
        rotate(rands(-360,360,3))
        translate(rands(-.1,.1,3))
        translate([2.125 ,0,0])scale(4)scale([.5,.75,1])
        
            minkowski(){
                simple();
                 scale(.1)simple();
            } 
    }

}
     scale(.51)simple();
}   

module simple()
{
    
    hull(){
    for([0:2]){    scale(rands(0.75,1.125,3))
        translate(rands(-.1,.1,3))
        rotate(rands(-360,360,3))
        scale(rands(0.75,1.25,3))sphere(.7,$fn=8);
    }
        }
    }
