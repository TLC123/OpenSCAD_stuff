//float flower(vec3 p, float r) {
//  float q = length(p);
//  p -= vec3(sin(p.x * 15.1), sin(p.y * 25.1), sin(p.z * 15.0)) * 0.01; //some space warping
//  vec3 n = normalize(p);
//  q = length(p); // distance before flowerwarp
//
//  float rho = atan(length(vec2(n.x, n.z)), n.y) * 20.0 + q * 15.01; 
//vertical part of  cartesian to polar with some q warp
//  float theta = atan(n.x, n.z) * 6.0 + p.y * 3.0 + rho * 1.50;
 //horizontal part plus some warp by z(bend up) and by rho(twist)
//  return length(p) - (r + sin(theta) * 0.3 * (1.3 - abs(dot(n, vec3(0, 1, 0))))
 //the 1-abs(dot()) is limiting the warp effect at poles
//    + sin(rho - iGlobalTime * 2.0) * 0.3 * (1.3 - abs(dot(n, vec3(0, 1, 0))))); 
// 1.3-abs(dot()means putting some back in 
//}
polysphere();
module polysphere(){
istep=1/90;jstep=1/45;
for (i=[0:istep:1]){for (j=[-0.5:jstep:0.5]){
p1=basevec(i,j)*30;
p2=basevec(i+istep,j)*30;
p3=basevec(i+istep,j+jstep)*30;
p4=basevec(i,j+jstep)*30;
polyhedron([p1,p2,p3,p4],[[0,1,2],[2,3,0]]);
  }}}
function basevec(i,j)=[sin(i*360)*cos(j*180),cos(i*360)*cos(j*180),sin(j*180)];