////////////////////
//Dead Tree generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike

////////////////////
// preview[view:south west, tilt:top diagonal]
part=0;//[0,1,2,3,4,5,6,7,8,9]
mycolor=[0.3,0.15,0.09];
module grow(i,j,b)
{ union(){
    r=rands(-5,15+j,1)[0];
     rv=rands(-5-j,5+j,1)[0];
    goon=rands(0.9,15/j,1)[0];
    t=min(max(15,75/i),25);
    
    if(goon<1&&b>1&&j<2){ 
        difference(){
        color(mycolor)hull(){
            sphere(d=2*i,h=0.1,$fn=12);
rotate([r,rv,i]) translate([0,0,t])rotate([15,0,0])cylinder(d=2*(i-1),h=0.1,$fn=12);}
        
      color("tan")  
rotate([r,rv,i]) translate([0,0,t])rotate([15,0,0])cylinder(d=1.7*(i-1),h=5,$fn=12);}}
        
        else{
            color(mycolor)
            hull(){sphere(d=2*i,$fn=12);
        rotate([r,rv,i]) translate([0,0,t])
                sphere(d=2*(i-1),$fn=12);
             
                }
        
        
    if(i>1 ){
    
    if(rands(0,2+j/15,1)[0]>=1){
    rotate([r,20+rv,i-180]) translate([0,0,0])grow(i-1,0,b+1);
    rotate([r,rv,i]) translate([0,0,t])grow(i-1,0,b+1);    
    }else
    {rotate([r,rv,i]) translate([0,0,t])grow(i-1,j+1,b);}
        }
        }
    
    }
}
module root(i)
{color(mycolor) union(){
    r=rands(-15,15,1)[0];
    rv=rands(-0.11,1,1)[0];
    t=max(10,25/i);
    hull(){sphere(d=2*i,h=0.1,$fn=12);
    rotate([rv,r,0]) translate([0,0,t])sphere(d=2*(i-1),h=0.1,$fn=12);}
    if(i>=1){
    rotate([rv,r,0]) translate([0,0,t])root(i-1);
    if(rands(0,1.08,1)[0]>=1){
    rotate([rv,r+45,0]) translate([0,0,t])root(i-2);
    }
        }
    
    }
}
module stone(){ color("DimGray")
    intersection(){
        rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 10, 1)[0],1.4,1.4])
    //import("rock.stl", convexity=3);
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])cube(1.5,center=true ); 
 
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 10, 1)[0],1.5,1.5])
    //import("rock.stl", convexity=3);
    rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])cube(1.5,center=true ); 
         rotate([rands(0, 360, 1)[0],rands(0, 360, 1)[0],rands(0, 360, 1)[0]])resize([rands(5, 10, 1)[0],1.4,1.4])
    //import("rock.stl", convexity=3);
    rotate([rands(0, 90, 1)[0],rands(0, 90, 1)[0],rands(0, 90, 1)[0]])cube(1.5,center=true ); 
    }}

*cube([1,1,28]);
scale(0.3)union(){
    
   
  intersection(){ 
   
     color("tan")   cylinder(r=200,h=300);
 translate([0,0,8])  grow(20,0,0);
  }

translate([0,0,-0.001])color("DimGray")cylinder(r=100.001,h=5.001);
translate([0,0,5])color("DimGray")cylinder(r=100.001,r2=95,h=5);
  
   intersection(){ 
       
       color("tan")   cylinder(r=94,h=100);

       translate([0,0,16])union(){  
           for(i=[0:8]){
           color("DimGray") rotate([0,0,i*40+rands(-0,36,10)[part]]) translate([30+rands(0,20,1)[0],0,-8])resize([40,50,15]) stone();  }
           
rotate([80,180,0+rands(-15,15,10)[0]])root(15);
           rotate([80,180,rands(-360,360,10)[part]])root(15);
//rotate([60,180,60])grow(10);
rotate([80,180,120+rands(-15,15,1)[0]])root(15);
//rotate([60,180,180])grow(10);
rotate([80,180,240+rands(-15,15,1)[0]])root(12);
//rotate([60,180,300])grow(10);
}}
 }