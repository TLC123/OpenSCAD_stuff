z=0.5;
for(x=[-2:0.01:2]){
    for(y=[-0:1:0]){
  // color([z,z,z]) translate([x*10,y*10,0])scale([1,1,1])cylinder(Coldnoise (x,y,z)*    10+10,0.5,0.5,$fn=4);
        
      color([z,z,z]) translate([x*10,y*10,0])scale([1,1,1])cylinder( SC3 (x%1) ,0.5,0.5,$fn=4);
    }}  
  
  
  
    function Coldnoise (x,y,z,seed=211448)= ((19990303/(abs(x%10)+1))+(19990303/(abs(y%10)+1) )+(19990303/(abs(z%10)+1) )+(19990303/(abs(seed)+1) ))%1 ;
       
    function Sweetnoise (x,y,z,seed=211448)=tril(SC3 (abs(x%1)),SC3 (abs(y%1)),SC3 (abs(z%1)),
    Coldnoise (floor(x),floor(y),floor(z),seed)
    Coldnoise (floor(x+1),floor(y),floor(z),seed)
    Coldnoise (floor(x),floor(y+1),floor(z),seed)
    Coldnoise (floor(x),floor(y),floor(z+1),seed)
    Coldnoise (floor(x+1),floor(y),floor(z+1),seed)
    Coldnoise (floor(x),floor(y+1),floor(z+1),seed)
    Coldnoise (floor(x+1),floor(y+1),floor(z),seed)
    Coldnoise (floor(x+1),floor(y+1),floor(z+1));seed);
    
   function SC3 (a)=       (a * a * (3 - 2 * a));
function tril(x,y,z,V00,V100,V010,V001,V101,V011,V110,V111) =	
V000* (1 - x)* (1 - y)* (1 - z) +
V100* x *(1 - y) *(1 - z) + 
V010* (1 - x) *y *(1 - z) + 
V001* (1 - x) *(1 - y)* z +
V101* x *(1 - y)* z + 
V011* (1 - x)* y *z + 
V110* x *y* (1 - z) + 
V111* x *y *z;