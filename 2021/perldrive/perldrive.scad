$fn=32;
scale (5){
intersection(){
    
    
    cube([16,16,1.6],true);
    
    
    union()


{
or=5.4;
no=floor((or*2*PI)/4);

 for(r=[0:(360/no):360])
    {
rotate(r)translate([or,0,0])perl(1.1,1,$fn=16);
}

ir=2.22;
ni=floor((ir*2*PI)/2);

 translate([0,.5,])for(r=[0:(360/ni):360])
{
rotate(r)translate([ir+.1,0,0])perl(1.1,1,$fn=16);
}
}}

*intersection(){
    
    
    cube([16,16,1.6],true);
    
    
    union(){

ring();
mirror([ 0,0,1])ring();
 ring2(6.8); 
 ring2(1.2); 
 }

 }


}
module perl(h,r,$fn){
    cylinder(h,r,0);
    mirror([0,0,1])cylinder(h,r,0 );
    
    
    }
    
    
    module ring( ror=4) {
         
rno=floor((ror*2*PI)/2);
st=(360/rno*0.1);
translate([0,0,.55])for(r=[0:st:360]){
    hull(){
            rotate(r)translate([ror,0,-.0])sphere(.5);
            rotate(r+st)translate([ror,0,-.0])sphere(.5); 
           rotate(r)translate([ror,0,-.55])sphere(.4);
            rotate(r+st)translate([ror,0,-.55])sphere(.4);

        rotate(r)translate([1+ror+sin(r*7)*.5,0,sin(r*7)*.25])sphere(.1);
        rotate(r+st)translate([1+ror+sin((r+st)*7)*.5,0,sin((r+st)*7)*.25])sphere(.1);   
        
        rotate(r)translate([1+ror+sin(r*7)*.5,0,1])sphere(.1);
        rotate(r+st)translate([1+ror+sin((r+st)*7)*.5,0,1])sphere(.1);
 
    
        rotate(r)translate([-1+ror+-sin(r*7)*.25,0,sin(r*7)*.45])sphere(.1);
        rotate(r+st)translate([-1+ror+-sin((r+st)*7)*.25,0,sin((r+st)*7)*.45])sphere(.1);
          rotate(r)translate([-1+ror+-sin(r*7)*.25,0,1])sphere(.1);
        rotate(r+st)translate([-1+ror+-sin((r+st)*7)*.25,0,1])sphere(.1);
    }
}
    }
    module ring2(r)
    {
              difference(){
        rotate_extrude(convexity=5)
        {
      
          translate([r,-1])  square(1.5,center=true);
             
            }
            
            or=r;
no=floor((or*2*PI)/4);

  for(r=[0:(360/no):360])
    {
rotate(r)translate([or,0,0])cylinder(2,.2,.2,center=true,$fn=16);
}
            }
        }