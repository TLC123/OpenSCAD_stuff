constrain=[[0, 0, 0], [0, 0, 10], [50, 0, 50], [50, 10, 50]];
lenght=100;
links=25;
chain=concat(
[constrain[0]],[constrain[1]],[for(i=[0:max(1,links-4)])(constrain[1]+constrain[2])/2],[constrain[2]],[constrain[3]]);
function smooth(vi,t)=
let(v=t>0?smooth(vi,t-1):vi)
let(e=len(v)-1,sm=[ 

for (i=[1:max(1,e-1)])(v[i]+v[clamp(i-1,0,e)]+v[clamp(i+1,0,e)])/3

])
concat([v[0]],sm,[v[len(v)-1]]);



function clamp(a, b = 0, c = 1) = min(max(a, b), c);
function un (v)=v/max(norm(v),1e-32);// div by zero safe


module ShowControl(v) { // translate(t(v[0])) sphere(v[0][3]);
 
    for (i = [1: len(v) - 1]) {
      // vg  translate(t(v[i])) sphere(v[i][3]);
      hull() {
        translate( v[i]) sphere(0.5);
        translate( v[i - 1]) sphere(0.5);
      }
    }
}


ShowControl(constrain);
ShowControl(smooth(chain,1220));
 echo(smooth(chain));