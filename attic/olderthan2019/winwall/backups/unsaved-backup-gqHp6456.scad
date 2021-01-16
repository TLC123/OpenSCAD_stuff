p0=[0,0,0];
p1=[1,0,0];
p2=[1,1,0];
p3=[0,1,0];

quad(p0,p1,p2,p3);
module quad(p0,p1,p2,p3,e=0.2,s=0.8){
    c=(p0+p1+p2+p3)/4;
    n=un(p2n(p0,p1,p3)+p2n(p3,p1,p2));
    if (e>0.001 ){
        ep0=lerp(c+n*e,(p0+n*e), s);
        ep1=lerp(c+n*e,(p1+n*e),s);
        ep2=lerp(c+n*e,(p2+n*e),s);
        ep3=lerp(c+n*e,(p3+n*e),s);
       quad (p0,p1,ep1,ep0,e*0.5,s);
       quad (p1,p2,ep2,ep1,e*0.5,s);
       quad (p2,p3,ep3,ep2,e*0.5,s);
       quad (p3,p0,ep0,ep3,e*0.5,s);
       quad (ep0,ep1,ep2,ep3,e*0.7,s);
        }
    else
    {polyhedron([p0,p1,p3,p2],[[0,1,2],[2,1,3]]);}
    
    }




function lerp(start,end,bias ) = (end * bias + start * (1 - bias));
function p2n(pa,pb,pc)=let(u=pa-pb,v=pa-pc)un([u[1]*v[2] - u[2]*v[1], u[2]*v[0] - u[0]*v[2], u[0]*v[1] - u[1]*v[0]]);
    
function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
function un(v) = v / max(len3(v),0.000001) * 1;
