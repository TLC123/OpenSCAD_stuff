module obj(x){
    if(x>0){
    difference(){
    color([rands(0,1,1)[0],rands(0,1,1)[0],rands(0,1,1)[0]]) obj(x-1);
    minkowski(){
    obj(x-1);
    translate ([0,0,-(100+x)])cylinder(100,50,0);
    }
    }
}
else{
    union(){
    translate([-10,0,0])rotate([1,25,0])cube (10);
    translate([10,0,0]) sphere(5);
    }
}
    }


obj(10);