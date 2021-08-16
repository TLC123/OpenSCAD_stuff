Seed=1;//[0:1000]
s=1.2;//[0.8:0.01:1.5]
color("Grey")translate([1.5,0,0])scale([1,1,0.5])boulder(Seed);
color("DarkGrey")translate([-1.5,0,0])scale([1,1,0.5])cutstone(Seed);

intersection(){
color("Grey")translate([0,0,0])scale([s,s,s*0.5])boulder(Seed);
color("DarkGrey")translate([0,0,0])scale([1,1,0.5])cutstone(Seed);
}


//////////////// stones ////////////////
module boulder(bseed){
loops=6;n=10;l=n*5;ri=rands(0,360,l,bseed);t=rands(-180,180,l,bseed+1);
for(loop=[0:loops]){v21=rands(0,l-1,n*3+1,bseed+loop);
v1=[for(i=[0:l])[sin(ri[i])*cos(t[i]),cos(ri[i])*cos(t[i]),sin(t[i])]];
v2=[for(j=[0:n])[v21[j],v21[j+n],v21[j+n+n]]];
color("Gray")scale(0.6)hull()polyhedron(v1,v2);}}
module cutstone(bseed){
loops=1;l=200;n=100;
for(loop=[0:loops]){l1=rands(-0.5,0.5,l*3+3,bseed+loop);
v21=rands(0,l-1,n*3+1,bseed+loop);
v1=[for(i=[0:l])[l1[i],l1[i+l],l1[i+l+1]]];v2=[for(j=[0:n])[v21[j],v21[j+n],v21[j+n+n]]];
color("Gray")hull()polyhedron(v1,v2);}}