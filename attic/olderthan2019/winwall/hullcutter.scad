


cut(1,0.1)
import("bunny.stl", convexity=20);

module cut(s,stop){
    r=s-0.1;
   if(r>stop){ cut(r,stop)
    intersection()
{
color("Red")   children(0);

scale(r)hull(){
    children(0);
}}}else{children(0);}
    
    
    
    }