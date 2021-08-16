n=-[1,0,1];
t=[85,0,0]+n*-50;
mirror(n)
translate(t)

 planeExtrude(  240,n,t,[1,.5],0 ) 
 
 translate([0,0,35])rotate_extrude()
 { difference(){
    offset(4) difference(){
     circle (100);
     translate([0,10])scale([1.1,.9])circle (100);
              
        }    mirror([0,1])  square([200,200]); }}


   

module crop(maxh = 100) {
    intersection() {
        color() {
            children();
        }
        linear_extrude(1000)
        hull()
        projection() {
            children();
        }
    }
}
module getslice(maxh = 10,scale,angle) {
     
        mirror([0,0,1])linear_extrude(maxh,scale=scale,twist=angle)
        
        projection(cut=true) {
            children();
         
    }
}
 module planeCrop(maxh = 100,normal,origin) {
  translate(origin)
     look_at( -normal )
         crop(maxh)    
             look_at(normal)
               translate(-origin)
                    color() {
                        children();
                    }
               }
               
module planeCrop(maxh = 100,normal,origin) {
  translate(origin)
     look_at( -normal )
         crop(maxh)    
             look_at(normal)
               translate(-origin)
                    color() {
                        children();
                    }
               }

module planeExtrude(maxh = 100,normal,origin,scale=1,angle=0) {
   
 {
  translate(-origin){
     look_at( -normal ){
    
         getslice(maxh,scale,angle)
             look_at(normal)
               translate(origin)
                    color() {
                        children();
                    }
                            
         crop(maxh)
             look_at(normal)
               translate(origin)
                    color() {
                        children();
                    }
               }}
               
               
           translate(-origin){  
               look_at( normal ) {
               translate([0,0,maxh])  
               scale(scale) rotate(angle)  crop(maxh)
             look_at(-normal)
               translate(origin)
                    color() {
                        children();
                    }}}
               
                }    }

module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));
