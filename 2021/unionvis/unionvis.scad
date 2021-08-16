include<"polytools.scad">

%union(){
cube(1);
cube (1, center=true);
}
 %intersection(){
cube(1);
cube (1, center=true);
}


polyline([[.5,0,.5],[0,0,.5],]);


