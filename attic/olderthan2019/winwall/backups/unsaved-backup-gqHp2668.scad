for(y=[1:0.1:10]){
for(x=[1:0.1:10]){
    /*
    z=(
    (abs(round(x)-x)-0.25)
    +(abs(round(x*PI)-x*PI)-0.25)
    +(abs(round(x*sqrt(PI))-x*sqrt(PI))-0.25)
    )/2;*/
     z=(    
    //sin(x*4649)/(4*sin(x*180)+7)
   //+sin(x*4001)/(4*cos(x*360)+7)
   //+sin(x*1987)/(4*sin(x*180)+7) 
   +sin(x*1013)/(1*cos(y*360)+2)
   +sin(x*521)/(1*sin(y*180)+3)
   +sin(x*241)/(4*cos(y*360)+7)
   +sin(x*127)/(6*sin(y*180)+11)
   +sin(x*241)/(4*cos(y*360)+7)
   +sin(x*127)/(3*sin(y*180)+5)
   +sin(x*67)/(2*cos(y*360)+3)
   +sin(x*53)/(2*cos(y*101)+3)
    
    
        //sin(y*4649)/(4*sin(y*180)+7)
   //+sin(y*4001)/(4*cos(y*360)+7)
   //+sin(y*1987)/(4*sin(y*180)+7) 
   +sin(x*y*1013)/(1*cos(x*360)+2)
   +sin(x*y*521)/(1*sin(x*180)+3)
   +sin(x*y*241)/(4*cos(x*360)+7)
   +sin(y*127)/(6*sin(x*180)+11)
   +sin(y*241)/(4*cos(x*360)+7)
   +sin(y*127)/(3*sin(x*180)+5)
   +sin(y*67)/(2*cos(x*360)+3)
   +sin(y*53)/(2*cos(x*101)+3)
    )/18;
       
    translate([x*10,y*10,0])scale([1,1,z])cylinder(10,0.5,0.5,$fn=8);
    }}