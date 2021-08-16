//Use Noise(x,y,z,seed);
/*for (x=[0:1:15]){for (y=[0:0.1:15]){
i=Noise(x*10,y*10,1,10);
translate ([x*10,y*10,0])scale([1,1,15])sphere(i);
echo (i);}}*/

function Noise(x=1,y=1,z=1,seed=1)=let(SML=octavebalance())(Sweetnoise(x*1,y*1,z*1,seed)*SML[0]+Sweetnoise(x/2,y/2,z/2,seed)*SML[1]+Sweetnoise(x/4,y/4,z/4,seed)*SML[2]);
function lim31(l,v)=v/len3(v)*l;
function octavebalance()=lim31(1,[40,150,280]);
function len3(v)=sqrt(pow(v[0],2)+pow(v[1],2)+pow(v[2],2));
function Sweetnoise(x,y,z,seed=69840)=tril(SC3(x-floor(x)),(SC3(y-floor(y))),(SC3(z-floor(z))),Coldnoise((x),(y),(z),seed),Coldnoise((x+1),(y),(z),seed),Coldnoise((x),(y+1),(z),seed),Coldnoise((x),(y),(z+1),seed),Coldnoise((x+1),(y),(z+1),seed),Coldnoise((x),(y+1),(z+1),seed),Coldnoise((x+1),(y+1),(z),seed),Coldnoise((x+1),(y+1),(z+1),seed));
function tril(x,y,z,V000,V100,V010,V001,V101,V011,V110,V111)=	
/*V111*(1-x)*(1-y)*(1-z)+V011*x*(1-y)*(1-z)+V101*(1-x)*y*(1-z)+V110*(1-x)*(1-y)*z+V010*x*(1-y)*z+V100*(1-x)*y*z+V001*x*y*(1-z)+V000*x*y*z
*/
V000*(1-x)*(1-y)*(1-z)+V100*x*(1-y)*(1-z)+V010*(1-x)*y*(1-z)+V001*(1-x)*(1-y)*z+V101*x*(1-y)*z+V011*(1-x)*y*z+V110*x*y*(1-z)+V111*x*y*z;
function Coldnoise(x,y,z,seed=69940)=
((3754853343/((abs((floor(x+40))))+1))%1+(3628273133/((abs((floor(y+44))))+1))%1+(3500450271/((abs((floor(z+46))))+1))%1+(3367900313/(abs(seed)+1))/1)%1;
function SC3(a)=(a*a*(3-2*a));