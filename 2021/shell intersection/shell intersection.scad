r=2;
$fs=r/4;
unionR(r,true)
{
      color("blue")translate([2,-5,0]) difference(){
            cube (10);
          color("blue")  translate([-5,-5,5]) cube(10); }
    sphere(7);
     }



module unionR(r,draft=false)
{
     union(){
        children();
        }
        difference(){
    intersection_for(i=[0:$children-1])
        {
            shell(r*.5,0,draft ) children(i);
        }
                
  color("red") minkowski(convexity=30){
    intersection_for(i=[0:$children-1])
        {
            shell(r ,r -0.001,draft) children(i);
        }
                    if (draft) sphere(r,$fn=5); else sphere(r);        }
      }
} 
 
module  shell(s1,s2=0,draft=true)
{
     difference(){
        minkowski(){
            children();
    if (draft) sphere(s1,$fn=6); else sphere(s1);
          }
    children();
    if (s2==0) children();
        else
                 minkowski(){
            children();
    if (draft) sphere(s2,$fn=6); else sphere(s2);
          }
           }
     }