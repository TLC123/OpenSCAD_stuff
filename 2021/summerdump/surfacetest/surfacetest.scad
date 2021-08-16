scale([1,1,1+rnd()])intersection(){
scale([1,1,0.05*rnd(2)])s();
rotate(120*2)scale([1,1+rnd(),0.05*rnd(2)])s();
rotate(120)scale([1+rnd(),1,0.05*rnd(2)])s();
    
      hull(){
         $fn=6;
        cylinder(10,25,15); 
         
     
       linear_extrude(1.25) difference() {
offset(3,$fn=12)offset(-3)        circle(25);
    }
    }

}         
$fn=6;
       linear_extrude(1.5) difference() {
        circle(26);
        circle(24);
    }

module s(){
    intersection(){
    rotate(rnd(360))surface("surf.png",true,,10);
    $fn=6;
        cylinder(200,25,20);
        }  
        
    
        }
        
        function un(v) = v / max(norm(v), 1e-64) * 1;
        function clamp(a,b=0,c=1) =  min(max(a,min(b,c)),max(b,c));
        function lerp(start,end,bias) = (end * bias + start * (1 - bias));
        function rnd(a=0,b=1)=min(a,b)+(rands(0,1,1)[0])*(max(a,b)-min(a,b));
        