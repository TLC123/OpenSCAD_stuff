 branch(n=4);


module branch(n=4)
{
 if(n/1){
     R=(3/n)*40;
     for(i=[0:3]){
    rotate(rands(-R,R,3))translate([0,0,sqrt(n)*5])
      {sphere(sqrt(n));
      branch(n-1);
     
 }}}
 
 
    }