// Design by: Michael A Fuselier
// TV Mount Adapter
// l=length(x), w=width(y),h=height(z), 
H=8; W=46; L=330.2;


module diamond () {
    square([125.,125]);
}
;

module plate () {

    
hull() {

// main rectangle
translate([.5*W,0,0])
    square([L,W,H]);

// close rounded end of rectangle
translate([.5*W,.5*W,0])
    circle (  d=W);

// far rounded end of rectangle
translate([L+.5*W,.5*W,0])
    circle (  d=W);
}
;

 ;}
;

module holes()
{union () {
// large hole for TV screw   
translate([.5*W,.5*W,0])
    circle (  d=7.5);

// large hole for TV screw   
translate([L+.5*W,.5*W,0])
    circle (  d=7.5);
    
// small hole for TV mount   
translate([(92.075)+.5*W,.5*W,0])
    circle (  d=7.5);    
    
// small hole for TV mount   
// translate([(109.5375)+.5*W,.5*W,0])
//    circle (  d=7.5);   

// small hole for TV mount   
// translate([(217.4875)+.5*W,.5*W,0])
//    circle (  d=7.5);    
    
// small hole for TV mount   
   translate([(234.95)+.5*W,.5*W,0])
      circle (  d=7.5); 
     
}}
linear_extrude(H)
difference() {
union(){
translate ([22+(.5*L),-(.20*L),0]) 
rotate(45, [0,0,1]) diamond();

translate ([0,0,0]) plate () ;
translate ([W+(.5*L),-(.5*L),0]) 
    rotate (90) plate () ; }

translate ([0,0,0]) holes () ;
translate ([W+(.5*L),-(.5*L),0]) 
    rotate (90) holes () ;
}