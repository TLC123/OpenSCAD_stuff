/* IK solves the knee position of a two segment leg between 
point a and b of a specifyed length, bending preferably towards provided sky_vector   
If b is further than the leg is long it does its best to reach for b*/


a=[0,0,15]; b=[-50,50,0]; length=140;
c= IK(a,b,length );
line(a,c);
line(c,b);
translate(b)sphere(3);
translate(c)sphere(3);

function IK(start,end,length,sky_vector=[0,0,1],bias=0.5)=(len3(start-end))>length?
let(new_end=(start+un(end-start)*length) ,e=echo(new_end,len3(new_end),length))
IK(start,new_end,length,sky_vector,bias):
lerp(start,end,bias)+
(
un( flipxy(end-start,sky_vector))*un(sky_vector).y*IK2(length,(end-start))+
un( flipxz(end-start,sky_vector))*un(sky_vector).z*IK2(length,(end-start))+
un( end-start)                   *un(sky_vector).x*IK2(length,(end-start)))
;
function IK2(l,v)=sqrt(pow(l/2,2)-pow(min(len3(v),l)/2,2));
function flipxz(v,sky_vector=[0,0,1])=un(cross(v,flipxy(v,sky_vector)))*len3(v);
function flipxy(v,sky_vector=[0,0,1])=un(cross(sky_vector,v))*len3(v);

/*Dependencies*/
function len3(v) =len(v)>1?
sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)])):len(v)==1?v[0]:v; 
function addl(l,c=0)= len(l)-1 >c?l[c]+addl(l,c+1):l[c];
function un(v)=v/max(len3(v),1e-64);
function lerp(start,end,bias=0.5)=(end*bias+start*(1-bias));
/* End of dependencies*/

module line(p1, p2 ,width=0.5) 
{
    hull() {
        translate(p1) sphere(width);
        translate(p2) sphere(width);
    }
}

