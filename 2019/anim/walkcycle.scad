v1=[[10,0,0,0.1], [-23,3,0,0.1],[-1,15,0,0.1],[10,0,0,0.1] ];
 


path1=[for(t=[0:0.1:1])bez2(t, v1)];
 polyline(path1) ;


pt1=[[14,0,0,0.1], [-28,-2,0,0.1],[4,10,0,0.1],[14,0,0,0.1] ];

path2=[for(t=[0:0.1:1])bez2(t, pt1)];
 polyline(path2) ;
 tv=($t+0.5)%1;
th=($t)%1;
x1=lerp(th,pow(th,4),1.05-th);

x2=lerp(tv,pow(tv,4),1.05-tv);
f1= bez2(x2, v1);
 


f2=bez2(x1, v1);
 
//translate (v3(f2))sphere(1);

t1=bez2(x2, pt1);
 
//translate (v3(t1))sphere(1);

t2=bez2(x1, pt1);
 
//translate (v3(t2))sphere(1);
 polyline([[3+f1.x*0.25,10+f1.y*0.5,0,0.21],f1,t1]) ;
 polyline([[3+f2.x*0.25,10+f2.y*0.5,0,0.21],f2,t2]) ;


function bez2(t, v) = 
(len(v) > 2) ? 
bez2(t,
[  for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)]
): 
v[0] * (1 - t) + v[1] * (t);


function v3(v) = [v[0], max(0,v[1]), max(0,v[2])];

function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;



 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p)  )]);
} // polyline plotter
module line(p1, p2 ,width=0.1) 
{ // single line plotter
    hull() {
        translate(v3(p1)) sphere(p1[3]);
        translate(v3(p2)) sphere(p2[3]);
    }
}
function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries



//function v3(v)=[v.x,v.y,v.z];