//clock holder reddit
$fs=1;
step=25;
ang=30;
hang=60;
height=61;
width=38;
thick=6;
translate(-[-hang,-19,-30.5-thick*.5]){

for(i=[0:1/step:1-1/step]){hull(){for(ii=[i:1/step:i+(1/step)*1.5]){
rotate([0,ii*-180,0])translate([0,0,-height/2])rotate([0,90,0])
    rotate(smooth(ii)*-ang)bar();}}}
    
rotate([0,-90,0]){hulldull([0,0,hang]){translate([-height/2,0,0])bar();}
hulldull([0,0,hang]){translate([height/2,0,0])rotate(-ang)bar();}}

}

module hulldull(p){hull(){children();translate(p)children();}}
module bar(){linear_extrude(.0001)offset(thick*.5)square([0.0001,width-thick],true);}

function clamp(a,b=0,c=1)=min(max(a,min(b,c)),max(b,c));
function smooth(a)=let(b=clamp(a))(b*b*(3-2*b));