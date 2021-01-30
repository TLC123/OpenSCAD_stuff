seed=rands(0,100,100 ) ;
n=[0.01,0,1];//rands(-1,1,3,seed[0]);
o=rands(-10,10,3,seed[1]);
echo(n,o);
planeCrop(  60,n,o ) 
translate([0,0,10])union() {
    for (t = [0: 5]) {
        r = rands(0, 360, 3 ,seed[t]);
       c = rands(0, 1, 3,seed[t]);
     color(c)   rotate(r) cube(20);
    }
}


module crop(maxh = 100) {
    intersection() {
        color() {
            children();
        }
        linear_extrude(maxh)
        hull()
        projection() {
            children();
        }
    }
}
 module planeCrop(maxh = 100,normal,origin) {
     if(normal=[0,0,1])
         {
           translate(origin)
              crop(maxh)    
                 translate(-origin)
                    color() {
                        children();
                    }
             }
     else {
     
  translate(origin)
     look_at( [0,0,1],[0,0,0],-normal )
         crop(maxh)    
             look_at(-normal)
               translate(-origin)
                    color() {
                        children();
                    }
               }
           }


module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));
