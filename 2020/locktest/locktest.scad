difference(){body();
cut();}

module m(r){
    offset(r/2,$fn=4){
        children();
        }
    }

module body(){ translate([-20,0,0])color("red")difference(){
    cube([60,40,29.99],center=true);
rotate([0,45,0])    cube([15,50,15],center=true);


}
}
module cut(r){
    
    diff(r);
    mirror([0,0,1])diff(r);
    }



module diff(m){
for (r=[0:10:90])
{
    hull (){rotate(r) brat1(m);rotate(r+10)brat1(m);}
hull (){rotate(r)brat2(m);rotate(r+10)brat2(m);}
hull (){rotate(r)brat3(m);rotate(r+10)brat3(m);}
}

}
module hasp(){
mirror([0,0,1]){
brat1();
brat2();
brat3();
}
    
brat1();
brat2();
brat3();
    }



module brat1(m=0){translate([-5,0,0]){
 
translate([5,0,0])
rotate(-80)hull(){
translate([5,0,0])linear_extrude(5)m(m)circle(2);
translate([15,0,0])linear_extrude(15)m(m)circle(2);
translate([25,0,0])linear_extrude(15)m(m)circle(4.5);
translate([28,0,0])linear_extrude(8)m(m)circle(5);
}
}}

module brat2(m=0){translate([-5,0,0]){

translate([5,0,10])linear_extrude(5)m(m)circle(6);


}}


module brat3(m=0){translate([-5,0,0]){
    hull(){linear_extrude(3)m(m)circle(10);
translate([5,0,10])linear_extrude(0.0011)m(m)circle(6);
}

}}
