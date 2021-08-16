circle=[rnd(100),rnd(100.150),rnd(1,45)];
point=[rnd(100),rnd(100)];
line=[[rnd(100),rnd(100)],[rnd(100),rnd(100)]];
line2=[[rnd(100),rnd(10)],[rnd(10),rnd(100)]];
translate([circle.x,circle.y])circle(circle[2]);
//translate(point)sphere(2);
circlep=[circle.x,circle.y];
//translate((circlep+ (line[0]+line[1])/2+(line2[0]+line2[1])/2)/3)sphere(2);
n1=un(line[0]-line[1]);
hull(){translate(line[0])circle(1);
translate(line[1])circle(1);
}
hull(){
translate(line[0]+n1*100)circle(0.2);
translate(line[1]-n1*100)circle(0.2);
}
n2=un(line2[0]-line2[1]);
hull(){translate(line2[0])circle(1);
translate(line2[1])circle(1);
}
hull(){
translate(line2[0]+n2*100)circle(0.2);
translate(line2[1]-n2*100)circle(0.2);
}
//d=cpl(circle,point,line );
d=cll(circle,line,line2  );

if(d[3]<1){color("red")translate(d[0])circle(d[1],$fn=60);
   echo("internal",d);} 
    else{ color("red")translate(d[0])circle(1,$fn=60);echo("Found no internal solution in time");}

 for(i=[0:10:360]){
cme=[sin(i)*1000,cos(i)*1000];
d1=cll(circle,line,line2  ,cme);
if(norm(d1[0]-d[0])>1){
echo(d1);
if(d1[3]<1){color([rnd(),rnd(),rnd()])translate(d1[0])circle(d1[1],$fn=60);} 
    else{ color("blue")translate(d1[0])circle(1,$fn=60);echo("Found no solution in time");}
}

}

//function cpl(circle,point,line,ifind=undef,maxi=0)=
//let(
//circlep=[circle[0],circle[1]],
//find=ifind==undef?(point+circlep+(line[0]+line[1])/2)/3:ifind,
//dtc=distancetocircle(circle,find),
//dtp=distancetopoint(point,find),
//dtl=distancetoline(line,find),
//sum=abs(dtc-dtp)+abs(dtp-dtl)+abs(dtl-dtc),
//avrg=(dtc+dtp+dtl)/3
//)sum<0.00000001||maxi>500?[find,avrg,maxi,sum]:
//let(
//circlep=[circle[0],circle[1]],
//circlen=(circlep-find)/dtc,
//pointn=(point-find)/dtp,
//linen1=(line[0]-line[1])/dtl,
//linen=[-linen1.y,linen1.x],
//newfind= ( (find+circlen*(dtc-avrg) *0.5) +(find+pointn*(dtp-avrg)*0.5) +(find+linen*(dtl-avrg)*0.5 )   )/3
//)
//
//cpl(circle,point,line,newfind ,maxi+1)
//
// ;

function cll(circle,line,line2,ifind=undef,maxi=0)=
let(
circlep=[circle.x,circle.y],
find=ifind==undef? ( circlep*0.4+ (line[0]+line[1])/2*0.3+(line2[0]+line2[1])/2*0.3)
:ifind,
dtc=distancetocircle(circle,find),
//dtp=distancetopoint(point,find),
dtl=distancetoline(line,find),
dtl2=distancetoline(line2,find),
sum=abs(dtc-dtl2)+abs(dtl2-dtl)+abs(dtl-dtc),
avrg=(dtc+dtl2+dtl)/3
)sum<1e-8||maxi>5000?[find,avrg,maxi,sum]:
let(
circlep=[circle[0],circle[1]],
circlen=(circlep-find)/dtc,
//pointn=(point-find)/dtp,
linen=un([distancetoline(line,find+[-1,0])-dtl,distancetoline(line,find+[0,-1])-dtl ]),
linen2=un([distancetoline(line2,find+[-1,0])-dtl2,distancetoline(line2,find+[0,-1])-dtl2 ]),
 
newfind= ( (find+circlen*max(0,(dtc-avrg)) *0.5)   +(find+linen*(dtl-avrg)*0.5  )   +(find+linen2*(dtl2-avrg)*0.5  )   )/3
)

cll(circle,line,line2,newfind ,maxi+1)

 ;




function distancetopoint(point,find)=norm(point-find);
function distancetocircle(circle,find)=norm([circle.x,circle.y]-find)-circle[2];
function distancetoline(line,p)=let(
a=line[0],b=line[1],pa = p - a, ba = b - a,h =  ( (pa*ba)/ (ba*ba)))
norm( pa - ba*h ) ;
function un(v)=v/max(1e-15,norm(v));


 function rnd(a = 1, b = 0, s = []) =
s == [] ?
  (rands(min(a, b), max(
    a, b), 1)[0]) :
  (rands(min(a, b), max(a, b), 1, s)[0]);