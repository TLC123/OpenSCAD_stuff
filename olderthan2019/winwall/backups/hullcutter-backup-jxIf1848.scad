


cut(1,1-$t)
import("bunny.stl", convexity=20);

module cut(s,stop){
    r=s-0.01;
   if(r>stop){ cut(r,stop)
    intersection()
{
color("Red")   children(0);

scale(r)hull(){
    children(0);
}}}else{children(0);}
    
    
    
    }