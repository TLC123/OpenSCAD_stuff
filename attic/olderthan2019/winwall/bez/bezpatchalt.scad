////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
controlpoints=3;//[1:20]
thickest=15;//[5:50]
detail = 10; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v1 = [[0,0,0,1],[0,50,0,1],[0,100,0,1]];

v2 = [[100,0,0,1],  [100,50,0,1],[100,100,0,1]];
v3 = [v1[0],[50,150,50,1],v2[0]];

v4 = [v1[2],[50,250,50,1],v2[2]];
  
  
  %color("gray",0.3){
  poly(v1[0],v1[1],v1[2]);
  poly(v2[0],v2[1],v2[2]);
  poly(v3[0],v3[1],v3[2]);
  poly(v4[0],v4[1],v4[2]);
  }
  
  
  
  
  
  
  
  
//main call
bpatch(vsharp(vsharp(vsharp(vsharp(v1)))),vsharp(v2),vsharp(v3),vsharp(v4),detail);
// Bline module
module bpatch(v1,v2,v3,v4,d) {
    detail=0.999/d;
    *for(o = [detail: detail: 1])
        {
            poly(bez2(o-detail, v1),bez2(o, v1),bez4(o,1-detail,v1,v2,v3,v4));
                poly(bez4(o,1-detail,v1,v2,v3,v4),bez2(o-detail, v1),bez4(o-detail,1-detail,v1,v2,v3,v4)); 
            
            poly(bez2(o-detail, v2),bez2(o, v2),bez4(o,detail,v1,v2,v3,v4)); 
poly(bez4(o,detail,v1,v2,v3,v4),bez2(o-detail, v2),bez4(o-detail,detail,v1,v2,v3,v4));
                poly(bez2(o-detail, v3),bez2(o, v3),bez4(1-detail,o,v1,v2,v3,v4)); 
            
        poly(bez4(1-detail,o,v1,v2,v3,v4),bez2(o-detail, v3),bez4(1-detail,o-detail,v1,v2,v3,v4)); 
        
         poly(bez2(o-detail, v4),bez2(o, v4),bez4(detail,o,v1,v2,v3,v4));    
        poly(bez4(detail,o,v1,v2,v3,v4),bez2(o-detail, v4),bez4(detail,o-detail,v1,v2,v3,v4));    
        }
        
    for(i = [detail: detail: 1]) {
      
      for(j = [detail: detail: 1]) {
    /* 

p2=(bez2(i, v2)); 
p3=(bez2(j, v3)); 
p4=(bez2(j, v4)); 
                */
    //     p= ((bez2(j, v3))*i+(bez2(j, v4))*(1-i))*0.5+((bez2(i, v1))*j+(bez2(i, v2))*(1-j))*0.5; 
      //    draw(p,p);
        //  echo(p);
          //draw(bez4(i,j,v1,v2,v3,v4),bez4(i,j,v1,v2,v3,v4))
          poly(bez4(i,j,v1,v2,v3,v4),bez4(i,j-detail,v1,v2,v3,v4),bez4(i-detail,j,v1,v2,v3,v4),1);
          poly(bez4(i,j-detail,v1,v2,v3,v4),bez4(i-detail,j-detail,v1,v2,v3,v4),bez4(i-detail,j,v1,v2,v3,v4),1);

    }}
  }
function  bez4(i,j,v1,v2,v3,v4)=((bez2(j, v3))*i+(bez2(j, v4))*(1-i))*0.5+((bez2(i, v1))*j+(bez2(i, v2))*(1-j))*0.5; 
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
module draw(s,f,h){hull(){translate(t(s))sphere(h); translate(t(f)) sphere(h);} }
module poly(p1,p2,p3,h){hull(){translate(t(p1))sphere(h);translate(t(p2))  sphere(h);translate(t(p3))sphere(h);}}

function vsharp(v)=[for(i=[0:0.5:len(v)-1])v[floor(i)]];
