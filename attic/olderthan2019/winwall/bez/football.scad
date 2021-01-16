function midpoint(start,end,bias=0.5) =start+(end*bias-start*(1-bias)); 
function len3(v)=sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function un( v) = v / len3(v);
function mmul(v1,v2)=[v1[0]*v2[0],v1[1]*v2[1],v1[2]*v2[2]];

function IK (l,v)=sqrt(pow(l/2,2)-pow(len3(v)/2,2));
module draw(s,f,h){hull(){   translate(s)  sphere(h); translate(f)  sphere(h/2);}    }
sky=[1,0.001,0];
lookat=[0,0,1];
function flipxz(v)=un(cross(v,flipxy(v,sky)))*len3(v);// X flip blå
function flipxy(v)=un(cross(sky,v))*len3(v);// X flip GUL



a=[0,0,0];
b=[rands(-15,15,1)[0],0,-5];
//b=[5,5,10];
c=b/len3(b)*min(len3(b),14);

color("blue")translate(a)sphere();
translate(b)sphere();
color("blue")translate(pele(a,c,[0,0,0]))sphere();
end=c;
start=a;
echo(beckham(a,c,[0,5,0]));
echo(midpoint(start,end));
echo(
mmul(un(flipxy(end-start)),lookat)+
mmul(un(flipxz(end-start)),lookat)+
mmul(un(end-start),lookat));

//color("yellow")draw(midpoint(a,c),pele(a,c,[0,0,-5]));
//color("yellow")draw(a,pele(a,c,[0,0,-5]));
//color("yellow")draw(c,pele(a,c,[0,0,-5]));

color("yellow")draw(a,(beckham(a,c,15,lookat)));
color("yellow")draw(c,(beckham(a,c,15,lookat)));

circle(3);

function beckham(start,end,length=len3(b-a)*1.1,lookat=[0,1,0])=midpoint(start,end)+
un(flipxy(end-start))*un(lookat)[1]*IK(length,end-start)+
un(flipxz(end-start))*un(lookat)[2]*IK(length,end-start)+
un(end-start)*        un(lookat)[0]*IK(length,end-start) ;

function pele(start,end,lookat=[0,0,4])=midpoint(start,end)+
un(flipxy(end-start))*lookat[1]+
un(flipxz(end-start))*lookat[2]+
un(end-start)*lookat[0] ;