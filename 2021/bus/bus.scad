lenght=12+1/4;
hwidth=(3+1/4)*.5;
clearance=-.5;
ph=-.80;

bottom=[[0,0],[lenght,0],[lenght-.5,1+1/4],[lenght-1,hwidth],[1+1/8+1/2,hwidth],[1/2,1+1/4]];
$fn=12;

intersection(){
  linear_extrude(2+1/2-clearance) { mirror([0,1]) 

polygon(bottom); polygon(bottom);}
minkowski(){
    sphere(abs(ph),$fn=24);

intersection(){
    

translate([0,0,clearance])linear_extrude(2+1/2-clearance)
{
      offset(ph)offset(1.6) offset(-1.6){
mirror([0,1]) 

polygon(bottom);
polygon(bottom);
}}

top=[[0,clearance*5],[lenght,clearance*5] , [lenght,1+1/2],
[lenght-1,1+1/2+5/8]
, [1+1/8,1+1/2+5/8]
, [0,1+1/2 ] 
];

 rotate([90,0,clearance])linear_extrude(3+1/4,center=true)
{
   offset(ph) offset(1) offset(-1)
    {  polygon(top);

    
    
    } }
    
    
    front=[[ hwidth,clearance*4],[  hwidth,1+1/2],[  1+1/4,1+1/2+3/8],[  0,1+1/2+5/8],[  -(1+1/4),(1+1/2+3/8)],[  -hwidth,1+1/2],[ -hwidth,clearance*4 ]];
    
     rotate([0, 90, 0])rotate([0, 0,  90])linear_extrude( lenght )
{
   offset(ph) offset(.5) offset(-.5)
    {   polygon(front);
    }
    
    
    }
     }
}}