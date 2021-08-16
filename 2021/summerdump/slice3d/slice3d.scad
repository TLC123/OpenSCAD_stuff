sliceh=1;
kr=rands(0,36,3);
slice3d()
rotate(kr)cube(5,true);


module slice3d(n=0){
    %children();
    if (n>0)
    {
           intersection(){
            
            
           translate([0,0,-sliceh])
               hull()slice3d(n-1) children();
           slice3d(n-1)  children();
            }
        }
    else
        intersection(){
            
            
           translate([0,0,-sliceh])hull() children();
            children();
            }
    
    }