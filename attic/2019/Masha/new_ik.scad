hsternum=[0,0,0];
hshouldertarget=[10,cos($t*360*3)*1,cos($t*360*5)*2];
hshoulder=reachfor(hsternum,hshouldertarget,3);
hhandtarget=[12-sin($t*360*0.5)*10,6+cos($t*360*2)*5,2+cos((0.75+0.125+$t)*360*4)*7];
hhand=reachfor(hshoulder,hhandtarget,10);
hbendnorm=p2n(hsternum, hhand, hshoulder+[0,0,1]);
helbow=lerp(hshoulder,hhand,0.5)+hbendnorm*IK(10.1, (hhand-hshoulder));

polyline([hsternum,hshoulder,helbow,hhand]);

sternum=[0,0,0];
shouldertarget=[-10,cos($t*360*3)*2,cos($t*360*5)*2];
shoulder=reachfor(sternum,shouldertarget,3);
handtarget=[-12+sin($t*360*0.5)*10,6+cos($t*360*2)*5,2+cos($t*360*4)*7];
hand=reachfor(shoulder,handtarget,10);
bendnorm=p2n(sternum, shoulder+[0,0,1], hand);
elbow=lerp(shoulder,hand,0.5)+bendnorm*IK(10.1, (hand-shoulder));

polyline([sternum,shoulder,elbow,hand]);

function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] *
 v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]
]);

function rndR()=[rands(0,360,1)[0],rands(0,360,1)[1],rands(0,360,1)[0]];
function rndV()=[rands(-1,1,1)[0],rands(-1,1,1)[0],rands(-1,1,1)[0]];

function lerp(start, end, bias) = (end * bias + start * (1 - bias));


function midpointjust(start,end) = start + (end  - start )/2;

 

function limit(limit,v) = v / norm(v) * min(norm(v),limit);

function limhilo(lolimit,hilimit,v) = v / norm(v) * min(max(norm(v),lolimit),hilimit);

function IK(l,v) = sqrt(pow(l / 2,2) - pow(min(norm(v),l) / 2,2));

function flip3(v) = [-v[2],-v[1],v[0]];

function vec4(vec3,i) = [vec3[0],vec3[1],vec3[2],i];
  
function crosst(p1,p2)=[p1[1]*p2[2]-p1[2]*p2[1],p1[2]*p2[0]-p1[0]*p2[2],p1[0]*p2[1]-p1[1]*p2[0]];

function un(v) = v / norm(v);

function mmul(v1,v2) = [v1[0] * v2[0],v1[1] * v2[1],v1[2] * v2[2]];

function rndc()= rands(0,1,3) ;

function reachfor(p1,p2,l)=let(pn=p2-p1) limit(l,pn)+p1;

function beckham(start,end,length,lookat = [0,1,0],bias = 0.5) = midpoint(start,end,bias) + (un(flipxy(end - start)) * un(lookat)[1] * IK(length,(end - start)) + un(flipxz(end - start)) * un(lookat)[2] * IK(length,(end - start)) + un(end - start) * un(lookat)[0] * IK(length,(end - start)));

function pele(start,end,lookat = [0,0,4]) = midpoint(t(start),t(end)) + un(flipxy(t(end) - t(start))) * lookat[1] + un(flipxz(t(end) - t(start))) * lookat[2] + un(t(end) - t(start)) * lookat[0];

function ground(v,h=2)=[v[0],v[1],max(h,v[2])];


function wrap(x,x_max=1,x_min=0) = (((x - x_min) % (x_max - x_min)) + (x_max - x_min)) % (x_max - x_min) + x_min; // wraps numbers inside boundaries

 module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p)  )]);
} // polyline plotter
module line(p1, p2 ,width=0.5) 
{ // single line plotter
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}