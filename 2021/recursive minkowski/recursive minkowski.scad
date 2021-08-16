to(2)
translate([10,0])circle(1);
translate([-10,0])circle(1);


module to(n){
    
    if(n>0)
    { minkowski(){
        
       rotate(10) children();
        scale(.5) to(n-1)children();
        
        }
        
        }
    else
        {
            children();
            }
    }