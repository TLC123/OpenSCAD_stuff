 fn =50;
 step = 1 / fn;
 for (i = [step: step: 1]) {
     MyElipse(i,step);
 
   
 }
 module MyElipse(i,step) {
   // "i" start out as zero and go to one. multiply "i" with each end value to get linear changing values.
   relative=((cos(i*90)/10+0.9));
// transformations in what ever order you need
  translate([0, 0, sin(i*90)/10 ]) 
   
   rotate([0, 0, 0])
   linear_extrude((sin(i*90)-sin((i-step)*90))*1, convexity = 10)    // Just extrude the thinnest slice

// more transformations in what ever order you need
  offset(r=-cos(i*90-90)*0.1)
difference(){   
circle(r = 1, $fn = fn *2 );  
   translate([0.5,0,0])circle(r = 1, $fn = fn *2 ); 
 }}