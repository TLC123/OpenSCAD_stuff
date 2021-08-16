use <BOSL2/std.scad>
include <BOSL2/std.scad>
 a=difference(circle(10), translate([1,0,0],circle(6)));
 for(c=a,d=c){echo(d);}
oo(a);
 module oo(a,n=1){
     
     
     b=offset(a ,-.1);
  if( is_region(b))
      {
            region( difference(a,b) );
              oo(b,n-1);
          }
 else{ 
//   if (is_region(a))  translate ([0,0,0.01]) region( a);
}
     
     }
