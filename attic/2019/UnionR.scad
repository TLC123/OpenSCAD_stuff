 $fn=4;
$fn1=12;
$fn2=12;

R=[rands(-360,360,3),rands(-360,360,3),rands(-360,360,3),rands(-360,360,3),rands(-360,360,3),rands(-360,360,3),rands(-360,360,3)];

unionR(2 ){
//translate(-[1,1,1])
    rotate(R[0]) {
    // hull()
    {
   *  translate([1,1,1])    rotate(R[1])cube(4, center=true);
     translate(-[1,1,1])   rotate(R[2])cube(4,  center=true);}}
//translate([1,1,1])
     rotate(R[3]) {
    //    hull()
    {
    translate([1,1,1])     rotate(R[4])cube(4, center=true);
  *  translate(-[1,1,1])    rotate(R[5])cube(4, center=true);}
}}


module outset(r=0.5,fn){
 
minkowski(){
sphere(r,$fn=fn);
children(); 
}
}

module unionR(r)
{
  difference(){ 
   union(){
        children();
        
       { intersection(){
     difference() { outset(r/2,$fn1)children(0); children(0);}
     difference(){ outset(r/2,$fn1)children(1) ;children(1) ;}
    } 
    }} 
 
    
    outset(r*.5,$fn2){ intersection(){
    difference(){ outset(r ,$fn1)children(0);outset(r/2,$fn1)children(0);}
    difference(){ outset(r ,$fn1)children(1);outset(r/2,$fn1)children(1);}
    }  }
    
    
    }    }