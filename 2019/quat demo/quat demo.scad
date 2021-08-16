include <maths.scad>

v=[1,0,1]/norm([1,0,1]);
r=$t*360;
r1= quat_to_mat4(quat(v,r));
q2 = quat_to_mat4(quat([1,0,0],0));
echo (r1);
echo (q2);
combo =  mat4_mult_mat4(r1, q2);
w=combo[3];
i=combo.x;
j=combo.y;
k=combo.z;

color("red"  )rotate(360/8*0)ax(i);
color("green"  )rotate(360/8*1)ax(j);
color("blue"  )rotate(360/8*2)ax(k);
color("yellow"  )rotate(360/8*3)ax(w);

function stereo(p)=[p.x/(1-p.z),p.y/(1-p.z)];
module ax(n)
{
for (r=[0:360/8:360])
{
x= sin(r+n*360);
z=cos(r+n*360)+1;
//translate([x,0,z])sphere(0.05);
translate(stereo([x,0,z]))sphere(0.05);

}
}