seed=rands(0,1000,1)[0];
planeCrop(  30,[0,1,2],[0,0,20] ) 
union() {
    for (t = [0: 5]) {
        r = rands(0, 360, 3,t+seed);
       c = rands(0, 1, 3);
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
  translate(origin)
     un_look_at( normal )
         crop(maxh)    
             look_at(normal)
               translate(-origin)
                    color() {
                        children();
                    }
               }
               
module planeCrop(maxh = 100,normal,origin) {
  translate(origin)
     un_look_at( normal )
         crop(maxh)    
             look_at(normal)
               translate(-origin)
                    color() {
                        children();
                    }
               }



module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
module un_look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(-rotations[0],rotations[1]) children();
}

function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));
