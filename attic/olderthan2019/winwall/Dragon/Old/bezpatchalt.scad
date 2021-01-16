////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
controlpoints=5;//[1:20]
thickest=15;//[5:50]
detail = 40; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v1 = concat([[0,0,0,1]],[  for(i = [1: controlpoints])[0, i*10, rands(-50, 50, 1)[0], 1]],[[0,100,0,1]]);
v2 = concat([[100,0,0,1]],[for(i = [1: controlpoints])[100+rands(0, 50, 1)[0],i*10, rands(-50, 50, 1)[0],  1]],[[100,100,0,1]]);
v3 = concat([[0,0,0,1]],[  for(i = [1: controlpoints])[i*10,  0,rands(-50, 50, 1)[0], 1]],[[100,0,0,1]]);
v4 = concat([[0,100,0,1]],[for(i = [1: controlpoints])[i*10, 100,rands(-50, 50, 1)[0],  1]],[[100,100,0,1]]);
echo(v4);
module yourmodule(i){
   
        
    }  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
//main call
bline(v1,v2,v3,v4,detail);
// Bline module
module bline(v1,v2,v3,v4,d) {
    detail=0.999/d;
draw(bez2(0, v1),bez2(1, v1));
draw(bez2(0, v2),bez2(1, v2));   
    for(j = [0: detail: 1]) {
     
        
      for(i = [0: detail: 1]) {
           p1=t(bez2(i, v1));
        p2=t(bez2(i, v2));
color("red")draw(p1,p2,0.1);
          psj=0.2;
          addp=midpoint(p1,p2,0.5);
midv1=midpoint(bez2(0, v1),bez2(0, v2));
midv2=midpoint(bez2(1, v1),bez2(1, v2));
subp=midpoint(midv1,midv2,0.5);
p3=bez2(j,v3) ;
p4= bez2(j,v4) ;
p3s=bez2(0.5,v3) ;
p4s= bez2(0.5,v4) ;          
midp=p3*i+p4*(1-i); 
midps=p3s*i+p4s*(1-i);           
draw(p3,p3);
draw(p4,p4);
draw(midp,midp);
        color("green")  draw(midps,midps,3);
color("red")draw(addp,addp,3);          
color("red")draw(p1,p1,1);
          color("red")draw(p2,p2,1);
color("darkred")draw(subp,subp,3);
          color("darkred")draw(midv1,midv2,1);
    }}
  }
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];
function midpoint(start,end,bias=0.5) =start+(end*bias-start*(1-bias)); 

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
module draw(s,f,h=1){hull(){   translate(t(s))  sphere(h); translate(t(f))  sphere(h);}   }