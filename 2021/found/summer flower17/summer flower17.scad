t=0.43;
kstep= 360/120;
istep=1/6;
jstep=1/12;

v1 =[ [30, 0, 196.6025], [80, 0, 90.6025], [100, 0, 30.6737], [87.8148, 0, -20.7912], [76.9131, 0, -44.3145], [25.4528, 0, -69.4522] ];
vs1=bez2spl(v1,t);
 L1 = len3spl(vs1);


v2 =[[10, 0, 79.6165], [20, 0, 69.6165],   [68.4703, 0, 24.5538], [40, 0, -45], [0, 0, -50]];
vs2=bez2spl(v2,t);
 L2 = len3spl(vs2);


v3 = [[25.9813, 0, 10.2836], [34.4414, 0, -12.8976], [25.2382, 0, -22.8155], [10, 0, -29.1089] ];
vs3=bez2spl(v3,t);
 L3 = len3spl(vs3);
v0=[[0,0,5],[5,0,0],[0,0,-5]];

 
//
// polyline(v1);
//
// polyline(v2);
//
 polyline([for(i=[0:1/20:1]) spl2(i*L1, vs1)]);
 polyline([for(i=[0:1/20:1]) spl2(i*L2, vs2)]);
 polyline([for(i=[0:1/20:1]) spl2(i*L3, vs3)]);

for(k=[0:kstep:360]){

for(i=[0.06:istep:1])
{
vx= ([bez2(i, v0),  (spl2(i*L3, vs3)) , (spl2(i*L2, vs2)) ,
 (spl2(i*L1, vs1)) 


 ] );
vsx=bez2spl(vx,t); Lx = len3spl(vsx);

 for(j=[0:jstep:1]){
p1=spl2(j*Lx*(sin(i*3600+k*5 )*0.25+0.45), vsx);
p2=spl2((j+jstep)*Lx*(sin(i*3600+k*5 )*0.25+0.45), vsx);
p3=spl2(j*Lx*(sin(i*3600+(k+kstep)*5 )*0.25+0.45), vsx);
p4=spl2((j+jstep)*Lx*(sin(i*3600+(k+kstep)*5 )*0.25+0.45), vsx);
hull(){

scale([3,3,1])translate( [sin(k)*p1.x,cos(k)*p1.x,p1.z]) sphere(1,$fn=1);
scale([3,3,1])translate( [sin(k+kstep)*p3.x,cos(k+kstep)*p3.x,p3.z]) sphere(1,$fn=1);
scale([3,3,1])translate( [sin(k)*p2.x,cos(k)*p2.x,p2.z]) sphere(1,$fn=1);
scale([3,3,1])translate( [sin(k+kstep)*p4.x,cos(k+kstep)*p4.x,p4.z]) sphere(1,$fn=1);
// polyline(vx);
}}
}}
 
function spl2(stop, v, p = 0) =let (L = len3bz(v[p])) p + 1 > len(v) - 1 || stop < L ? bez2(stop / L, v[p]) : spl2(stop - L, v, p + 1);















//
//function t(v) = [v[0], v[1], v[2]];
function bez2spl(v, t = 0.3) =
let (L = len(v) - 1)[
  for (i = [0: L - 1]) let (isatend=i==L-1?0:1,isatstart=i==0?0:1,prev = max(0, i - 1), next = min(L, i + 1), nnext = min(L, i + 2))
  let (M = norm(v[next] - v[i]),
 N0 = un(v[i] - v[prev]),
 N1 = un(v[next] - v[i]), 
N2 = un(v[nnext] - v[next]), 
N01 = un(N0 + N1) * M * t*isatstart, 
N12 = un(N1 + N2) * M * t*isatend )
[v[i], v[i] + N01, v[next] - N12, v[next]]];

 function un(v) = v / max(norm(v), 0.000001) * 1;
//function bez2(t, v) = (len(v) > 2) ? bez2(t, [
//  for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)
//]): v[0] * (1 - t) + v[1] * (t);
//function bez2(t, v) = (len(v) > 2) ? bez2(t, [
//  for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)
//]): v[0] * (1 - t) + v[1] * (t);
function len3bz(v, precision = 0.211, t = 0, acc = 0) = t > 1 ? acc : len3bz(v, precision, t + precision, acc + norm(bez2(t, v) - bez2(t + precision, v)));

function len3spl(v, precision  = 0.211, acc = 0, p = 0) = p + 1 > len(v) ? acc : len3spl(v, precision, acc + len3bz(v[p], precision), p + 1);
function bez2(t, v) = (len(v) > 2) ? bez2(t, [   for (i = [0: len(v) - 2]) v[i] * (1 - t) + v[i + 1] * (t)]): v[0] * (1 - t) + v[1] * (t);










module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[i+1]);
}

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}