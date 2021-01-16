function midpoint(start,end,bias = 0.5) = start + (end  - start )* bias;
function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];

v1=rndV()*100;
v2=-v1;
translate(v1)sphere(3);
translate(v2)sphere(3);
for (i=[0:0.01:1]){
v3=midpoint(v1,v2 ,i);
    
translate(v3)sphere(3);
    
    
    }
