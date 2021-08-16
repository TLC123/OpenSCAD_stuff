rotate_extrude()
{hull()   {
     intersection (){
    square([41,465]);
    translate([0,454])circle(6);
     }
    intersection (){
    square([41,459]);
        
    union(){    
    square([41,330]);
    translate([-135,352])circle(175,$fn=54);
        
        
        }}}}
 
        
   rotate([90,0,0])   linear_extrude(5,center=true)   polygon([[43,5],[50,10],[85,20],[85,60],[43,170]]); 
        
   rotate([90,0,0])   linear_extrude(5,center=true)   polygon([[43,335],[73,345],[73,365],[10,450], ]);   
        
   rotate([90,0,180])   linear_extrude(5,center=true)   polygon([[43,5],[50,10],[85,20],[85,60],[43,170]]); 
        
   rotate([90,0,180])   linear_extrude(5,center=true)   polygon([[43,335],[73,345],[73,365],[10,450], ]);