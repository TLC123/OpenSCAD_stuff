w=100;
h=800;

for(i=[0,500,2000,2100,3700,3800,5200,5300,8000,8100,12000])
translate([0,i,0]){
mirror([1,0,0])rotate([90,0,0])linear_extrude(25)konsol();
rotate([90,0,0])linear_extrude(25)konsol();
}

module konsol(){
  difference(){   offset(50) offset(-50)konsolprofil();
   offset(25) offset(-125)konsolprofil();
}
    }
module konsolprofil(){
   polygon([[1300,h*.5],[ w*.5,-h*.25],[ w*.5,h*.5]]);
    }



color ("lightgray")difference(){


difference(){
hull(){
translate([0,0,h*.25])rotate([-90,0,0])linear_extrude(12000,convexity=30) {
offset(25)offset(-25)square([w,h*.5],true);
}
translate([0,2000,0])rotate([-90,0,0])linear_extrude(3000,convexity=30) {
offset(25)offset(-25)square([w,h],true);
}}

rotate([-90,0,0])linear_extrude(12001,convexity=30) {
offset(12.5)offset(-25-12.5)square([w,h],true);
}


}


translate([0,0,150]) rotate([0,90,0])linear_extrude(w+50,center=true,convexity=30)
{
  for(i=[700:700:12000-700]) scale([max(.5,(1.5-abs(i-4000)/6000)),1]){
   translate([-100,i]) offset(20)offset(-70) rotate(-90)polygon([[0,0],[-350,350],[350,350],]);
   mirror([1,0])translate([-250,i+350]) offset(20)offset(-70) rotate(-90)polygon([[0,0],[-350,350],[350,350],]);
    }
    


}
}

color("gray"){

translate([0,3000,-200])rotate([0,90,0])translate([0,0,1100-700]){
cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
    
    translate([0,4500,-200])rotate([0,90,0])translate([0,0,1100-700]){
cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
    
    mirror([1,0,0]){
    translate([0,3000,-200])rotate([0,90,0])translate([0,0,1100-700]){
cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
    
    translate([0,4500,-200])rotate([0,90,0])translate([0,0,1100-700]){
cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
}

translate([0,6000,0]){
    
    translate([0,3000,-200])rotate([0,90,0])translate([0,0,1100-700]){
//cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
    
    translate([0,4500,-200])rotate([0,90,0])translate([0,0,1100-700]){
//cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
    
    mirror([1,0,0]){
    translate([0,3000,-200])rotate([0,90,0])translate([0,0,1100-700]){
//cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
    
    translate([0,4500,-200])rotate([0,90,0])translate([0,0,1100-700]){
//cylinder(300,500,500);
translate([0,0,400])cylinder(300,500,500);
    }
}
    
    }
}
      translate([0,3000,-0])       axle();
      translate([0,4500,-0])       axle();     
    translate([0,9000,-0])       axle();
    translate([0,10500,-0])       axle();
mirror([1,0,0]){
            translate([0,3000,-0])       axle();
      translate([0,4500,-0])       axle();     
    translate([0,9000,-0])       axle();
    translate([0,10500,-0])       axle();
}
            
            
            
            
    module axle(){
   translate([100,000,-200]) rotate([0,90,0]) {
     cylinder(1050,50,50);
      hull()
    {
       translate([-200,0,0])  linear_extrude(50)offset(100)square([100,400],true);
       translate([0,0,200]) linear_extrude(50)offset(100)square([100,200],true);
        
    }
        hull()
    {
       translate([-200,0,0])  linear_extrude(50)offset(100)square([400,50],true);
       translate([0,0,200]) linear_extrude(50)offset(100)square([150,50],true);
        
    }
     
        }}