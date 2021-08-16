$fn = 15;

   * %translate([-2, -2.9, 12])
    scale(0.7)rotate([0,0,0])
    import(file = "horse3.stl"); 
v=[
[0,0,12,[12.9,11.3,5]],
[0,0,20,[10.9,7.3,3]],
[-2,0,25,[8.9,6.3,3]],
[-6,0,30,[6,5.5,3]],
[-6.5,0,35,[6,6.5,3]],
[-7,0,40,[5,5.5,3]],
[-5,0,45,[5,5,2]],
 
 [0,0,44,[4,6.5,2]],
[2,0,43,[3.5,5.5,1]],
[5,0,40,[2.5,3,1]], 
[9,0,34,[4.5,4,2]],
 [9,0,32.5,[4,4,2]],
 [10.5,0,30.9,[2,3.5,1]],
 [11.3,0,30,[1,2.5,0.5]]
]; 

v2=[
 
[-5,0,45,[5,5,2]],
 
 [-2,0,39,[6,6.45,7]],
[3,0,38,[2,4.5,7]],
[5,0,36,[2,4,7]], 
 
 [9,0,32.5,[4,4,3]],
 [10.5,0,30.9,[2,3.5,1]]
];
v3=[
 
[-5,0,45,[5,5,2]],
  
 [-3,0,42,[7,6.0,2]],
 [-3,0,39,[7,6.8,3]],
 [-2.8,0,35,[5,6.5,3]],
[-2,0,34.9,[5,5.8,3]],
[3,0,34,[2,3.0,3]],
 
[5.9,0,31,[2,3.1,2]], 
[7.9,0,29,[3,3.4,1]],
 [9,0,28.1,[2,2,1]]
];

ShowControl(v) ;
ShowControl(v2) ;
ShowControl(v3) ;




module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
   if (len(v[0][0]) != undef) {
      ShowSplControl(v);
   } else
      for (i = [1: len(v) - 1]) {
         // vg  translate(t(v[i])) sphere(v[i][3]);
         blendline(
            (t(v[i])), (t(v[i - 1])), (v[i][3]), (v[i - 1][3]));
      }
}
module blendline(v1, v2, s1 = 1, s2 = 1) {
   d = 1 / 2;
   for (i = [0 + d: d: 1]) {
      hull() {
         translate(lerp(v1, v2, i)) scale(lerp(s1, s2, i)) sphere(1);
         translate(lerp(v1, v2, i - d)) scale(lerp(s1, s2, (i - d))) sphere(1);
      }
   }
}

function t(v) = [v[0], v[1], v[2]];

function lerp(start, end, bias) = (end * bias + start * (1 - bias));

function SC3(a) =
let (b = clamp(a))(b * b * (3 - 2 * b));

function clamp(a, b = 0, c = 10) = min(max(a, b), c);

function gauss(i, n = 0) = n > 0 ?
   let (x = gauss(i, n - 1)) x + (x - SC3(x)) : let (x = i) x + (x - SC3(x));
 