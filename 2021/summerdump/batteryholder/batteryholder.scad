gods=5;
lift=30;
battery=[170,170];
frame=[49,95];

difference(){

linear_extrude(lift,center=true,convexity=10)holder(); 
    //battery stripe
linear_extrude(lift-gods*2.2,center=true,convexity=10)
difference()
{
offset(-gods*.5 )
 hull() profile();

 offset(-gods*1.5 )
    
 hull() profile();

}
    
    
//battery stripe
linear_extrude(lift-gods*2,center=true,convexity=10)
difference()
{
offset(gods*2.5)
        translate([0,battery.y/2+gods])square(battery,true);

 offset(gods*1.5)
    
        translate([0,battery.y/2+gods])square(battery,true);

}

//innerbottom stripe
linear_extrude(lift-gods*2,center=true,convexity=10)
difference()
{
offset(gods*4.5)    
    translate([0,-frame.y/2])square(frame,true);
 offset(gods*3.5 )
      translate([0,-frame.y/2])square(frame,true);

}
//outerbottom stripe
linear_extrude(lift-gods*2,center=true,convexity=10)
difference()
{
offset(gods*7.5)    
    translate([0,-frame.y/2])square(frame,true);
 offset(gods*6.5 )
      translate([0,-frame.y/2])square(frame,true);

}
}
module profile(){
    translate([0,battery.y/2+gods])square(battery,true);
    
    translate([0,-frame.y/2])square(frame,true);
    
    }
    
    
    
    module holder(){
        
        

          difference(){
 offset(gods*.25) offset(-gods*1 ) offset(gods*.75)
     difference(){
   
    union(){
        // huvud kroppen
         hull()scale([1,1.025])offset(gods)profile();
    //nedre öron
      translate([0,-frame.y/3])  square([gods*6+(battery.x+frame.x)/2,gods*6],true);
   
   //övrree öron     
              translate([0,battery.y*.75])  square([gods*6+(battery.x+gods),gods*6],true);
        
        //mellan öron     
              translate([0,battery.y*.15])  square([gods*6+(battery.x+gods),gods*6],true);
                
        //top öron     
              translate([0,battery.y+gods*2 ]) rotate(90) square([gods*6 ,gods*6],true);
        }
    profile();
        

}
// nedre snitt
  translate([0,-frame.y/3])  square([ battery.x ,gods *0.5],true); 
// diagonala snitt
translate([battery.x*.25,0]) rotate(-35) square([ battery.x ,gods *0.5],true);
mirror([1,0,0])
translate([battery.x*.25,0]) rotate(-35) square([ battery.x ,gods *0.5],true);

//övre snitt
              translate([0,battery.y*.75])  square([gods*6+(battery.x+gods),gods*.5],true);
//mellan snitt
              translate([0,battery.y*.15])  square([gods*6+(battery.x+gods),gods*.5],true);
      //top öron snitt    
              translate([0,battery.y+gods*2 ]) rotate(90) square([gods*7 ,gods*.5],true);

        }
        }