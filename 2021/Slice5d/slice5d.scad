file="slice_000.off";
slice=.25;
minkowski(){
    cube(0.01);
intersection(){
    
    in();
 color("blue")   hull()translate([0,0,-slice])in();
    
    
    }
}
    
    
   module in(){
              import( file ,convexity=30);
       }