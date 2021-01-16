$fn=16;

subclip(){
for( a=[0:30:360])
    
rotate(a) translate([10,0,0]) sphere(11);
}


module subclip(){
    if ($childen>0)
    
    difference(){
         children(0);
         children(1:max(1,$children-1));
        }
    subclip()children(1:max(1,$children-1));;
        
    }