$fn=16;
// but it doesnt work because  for only leaves one children
subclip(){
for( a=[0:10:360])
    
rotate(a) translate([10,0,sin(a*3)]) sphere(11);
}


module subclip(){
    if ($children>2)
    
    difference(){
         children(0);
       for([1:max(1,$children-1)])  children(i);
        }
     children( );;
        
    }