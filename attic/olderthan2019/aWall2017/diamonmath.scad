for(i=[0:1/20:1])
{
j=1-i;

n1=un([i,0.5,j]);
n2=un([0,i,j]);
n3=un([i,0,j]);
n4=un([i,j,0]);



//line([0,0,0],n1*10);
//line([0,0,0],n2*10);
//line([0,0,0],n3*10);
//line([0,0,0],n4*10);

np1= [1+n1.x-n1.y-n1.z,1+n1.y-n1.x-n1.z,1+n1.z-n1.y-n1.x]*dot(n3, un([1,1,1]));
 np2= [1+n2.x-n2.y-n2.z,1+n2.y-n2.x-n2.z,1+n2.z-n2.y-n2.x]*0.5;
np3= ( 1.0-dot(n3, un([1,1,1])))*n3;
np4= (1.570735-dot(n4, un([1,1,1])))*n4;
line([0,0,0],np1*10);
line([0,0,0],np2*10);
//line([0,0,0],np3*10);
//line([0,0,0],np4*10);
}
color("Red")line([10,0,0],[0,10,0]);
color("Red")line([10,0,0],[0,0,10]);
color("Red")line([0,0,10],[0,10,0]);
color("Red")line([10*1.414214,0,0],[0,10*1.414214,0]);
color("Red")line([10*1.414214,0,0],[0,0,10*1.414214]);
color("Red")line([0,0,10*1.414214],[0,10*1.414214,0]);


module line(p1=[0,0,0,1],p2=[0,0,10,1])
{hull(){
translate([p1.x,p1.y,p1.z])sphere(0.1);
translate([p2[0],p2[1],p2[2]]) sphere(0.1);
}
}

function len3(v) =len(v)>1?sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function addl(l,c=0)=c<len(l)-1?l[c]+addl(l,c+1):l[c];
 function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
function un(v)=v/max(len3(v),0.000001)*1;
 