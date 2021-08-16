 constructionPlane(normal=[2,.6,1.1],origin=[0,0,0]){ circle(10); translate([12,15])rotate(60)square(12,true);}


module constructionPlane(normal=[0,0,1],origin=[0,0,0]){
    look_at(normal ,origin ){  children();
    if($preview) {
        %color("gray",.2)linear_extrude(1e-3)square($vpd*.165,true);
        %color("red")linear_extrude(1e-2)square($vpd*[0.16,0.001]);
        %color("green")linear_extrude(1e-2)square($vpd*[0.001,0.16]);}        
        %color("blue")cylinder($vpd*.1,$vpd*0.001,$vpd*0.001);
        }
        }

module look_at(lookpoint,origin=[0,0,0],rotatefrom=[0,0,1]){
rotations=look_at(lookpoint,origin ,rotatefrom);
rotate(rotations[0],rotations[1]) children();
}
function look_at(p,o=[0,0,0],up=[0,0,1])=let(a=up,b=p-o,c=cross(a,b) ,d=angle(a,b))[d,c];

function angle (a,b)=atan2(sqrt((cross(a, b)*cross(a, b))), (a* b));
