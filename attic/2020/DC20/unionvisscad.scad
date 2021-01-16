 

% union(){
cube(1);
// cube (1,center=true  );
translate([.5,.5])cube (1  );
    }
 %intersection(){
cube(1);
// cube (1,center=true  );
////translate([.5,.5])cube (1  );
}


//color("red")polyline([[.5,0,.5],[0,0,.5],[0,.5,.5],[0,.5,0],[0.5,.5,0],[0.5,0,0],[0.5,0,0.5],],.01);
//color("lightgreen",.5)polyline([[.55,0,.55],[0,0,.55],[0,.55,.55],[0,.55,0],[0.55,.55,0],[0.55,0,0],[0.55,0,0.55],],.005);
//color("lightblue",.5)polyline([[.5,-.05,.5],[-.05,-.05,.5],[-.05,.5,.5],[-.05,.5,-.05],[0.5,.5,-.05],[0.5,-.05,-.05],[0.5,-.05,0.5],],.005);
{ color("red")polyline([[1,0.5,0],[1,.5,1] ],.01);
 color("red")polyline([[.5,1,0],[.5,1,1] ],.01);}
 
 color("lightgreen",.5){ 
     polyline([[1,0.45,0],[1,.45,1] ],.01);
 polyline([[.5,1.05,0],[.5,1.05,1] ],.01);}
 
color("lightblue",.5) {
    polyline([[1.05,0.5,0],[1.05,.5,1] ],.01);

polyline([[.5-.05,1,0],[.5-.05,1,1] ],.01);}

 module polyline(p,w) {for(i=[0:max(0,len(p)-2)])line(p[i],p[(i+1)%len(p)  ],w);
} // polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}