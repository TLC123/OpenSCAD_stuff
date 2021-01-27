 constructionPlane([1,0,1])linear_extrude(5) circle(10);


module constructionPlane(normal=[0,0,1],origin=[0,0,0]){
    look_at(normal ,origin ){  children();
    if($preview){%linear_extrude(10e-16)square($vpd*.5,true);}        
    
        }
        }

module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));
