$fn=40;
w=1;
profile=[[-55,-1,w*1.5],[-52,0,w],[-1,-1,w*1.5],[0,1,w],


[0,2+1+20,w], [-4,2+1+20,w],

[-4,2+2+26,w],
[3,2+2+35,w],
[5,2+2+37,w*2],
[3,2+2+35,w],
[-4,2+2+26,w],

[-29,15,w],[-37,20,w],[-39,22,w*1.5],];

  rotate([0,-90,0])union(){
rotate([0,-90,0])linear_extrude(40,center=true, convexity=50) polyline(profile);

intersection(){
 translate([0,5,49.5])cube([40,100,100],center=true);


 union(){
intersection(){
    
   rotate([15,0,0])translate([0,39,0])
    
    
 rotate_extrude() {
    iclip1=[ [40.7,-10.5,w],[41,0,w],[40,1,w],[40,10,w],[40.5,11,w*1.5],[40,12,w],[40,22,w],[40,80,w*0.5]];
    polyline(iclip1);
    
    }


  hull(){
    scale([1,2])translate([0,0,43]) rotate([90,0,0])cylinder(50,25,25,center=true);
   scale([1,2])translate([0,0,3]) rotate([90,0,0])cylinder(50,25,25,center=true);
}
} 

//lower lip
translate([0,-1]) intersection(){
    
   rotate([15,0,0])translate([0,38+0.4,0]) 
    

 rotate_extrude() {
    iclip=[ [32.7,-10.5,w],[35.7,-1,w],[36.4,1,w*0.5],[36.4,20.6,w*0.5],[26,32,w*0.5]];
    polyline(iclip);
    
    }

 scale([1.2,3])translate([0,0,10]) rotate([90,0,0])cylinder(50,20,20,center=true);

                        } 

}
}}
module polyline(a){
    
    for (i=[0:len(a)-2])
        
    hull() {
    translate([a[i].x,a[i].y]) circle (a[i].z  );
    translate([a[i+1 ].x ,a[i+1].y])circle(a[i+1].z );
    
    }
    }