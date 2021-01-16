
fn=10;
v=[[-3,0,2,1],[0,0,-1,3],[0,0,4,4],[0,0,3,4],[4,0,0,2],[8,0,-4,1],[8,0,10,0],[12,0,7,1],[15,0,-3,0]];
v2=[[-3,0,0,0],[2,5,3,5],[0,0,1,1],[10,5,-5,1],[6,1,8,1],[9,1,5,1],[11,0,-2,0]];
v3=[[-3,0,0,0],[2,-5,3,5],[0,0,1,1],[10,-5,-5,1],[6,-1,8,1],[9,-1,5,1],[11,0,-2,0]];

bline(v,0.06);
bline(v2,0.06);
bline(v3,0.06);

 // Bline module
module bline(v,detail) {
     translate([bez2(0  , v)[0],bez2(0  , v)[1],bez2(0  , v)[2]])rotate(bez2euler (0,v))           //yourmodule(0,v)
    ;
    for(i = [detail: detail: 1]) {
      
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           //yourmodule(i,v)
        ;
           
        
      hull() {
        translate(t(bez2(i, v))) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
          sphere(r = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]) sphere(r = bez2(i - detail, v)[3], $fn = fn);
      }
    }
  }
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
//unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
