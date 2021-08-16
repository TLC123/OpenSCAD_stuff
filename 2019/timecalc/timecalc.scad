t1=round(rands(0,24,1)[0])+round(rands(0,59,1)[0])/100;
t2=round(rands(0,24,1)[0])+round(rands(0,59,1)[0])/100;
rast=0.0;
t1=0.42;
t2=58.42;
m1=floor(t1)*60+(t1%1)*100 +(floor(rast)*60+(rast%1)*100 );
m2=t2<t1?floor(t2+24)*60+(t2%1)*100:floor(t2)*60+(t2%1)*100;
t=floor((m2-m1)/60)+((m2-m1)%60)/100;
echo(t1,m1);
echo(t2,m2);

echo(m2-m1,t);