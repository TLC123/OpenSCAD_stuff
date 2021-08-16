root=[0,0,0];
 
node1=[for(i=[0:3])[rnd(i,i*-10),rnd(i,i*-10),rnd(i,i*10)]];
node2=[for(i=[0:3])[rnd(i,i*10),rnd(i,i*10),rnd(i,i*10)]];
    node3=[for(i=[0:3]) [rnd(i,i*10),rnd(i,i*10),rnd(i,i*10)]];
graph=[root,  node3 ,node1, node2,];

plotgraph(graph);

 module plotgraph(g)
{ 
    root=g[0];
for (i=[1:len(g)-1])
    {
        if(is_node(g[i])){ line(g[i-1],g[i],1);}
        else plotgraph( g[i] );
        }
    
    }
    
    
    
function is_node(v)= is_list(v) && len(v)==3 &&(is_num(v[0])&&is_num(v[1])&&is_num(v[2])) ;






function v3(p) = [p.x,p.y,p.z]; // vec3 formatter
function rev(v) = [for (i = [len(v) - 1: -1: 0]) v[i]];
function avrg(l) = len(l) > 1 ? addl(l) / (len(l)) : l;
function avrgp(l) = len(l) > 1 ? addlp(l) / (len(l)) : l;
function addlp(v,i=0,r=[0,0,0]) = i<len(v) ? addlp(v,i+1,r+v[i]) : r;
function lerp(start,end,bias) = (end * bias + start * (1 - bias));
function un(v)=assert (is_list(v)) v/max(norm(v),1e-64) ;
function rndc(a = 1,b = 0,s = [])=[rnd(a,b,s),rnd(a,b,s),rnd(a,b,s)];
function rnd(a = 1,b = 0,s = []) =
s == []?(rands(min(a,b),max(a,b),1)[0]) :(rands(min(a,b),max(a,b),1,s)[0]);


module polyline(p) {for(i=[0:max(0,len(p)-2)])line(p[i],p[wrap(i+1,len(p) )]);}

module polyline_open(p) {
     if (len(p)-1>1)
     for(i=[0:max(0,len(p)-2)])line(p[i],p[   i+1]);
} // polyline plotter

module line(p1,p2 ,width=2) 
{ // single line plotter
hull() {
translate(p1) sphere(width);
translate(p2) sphere(width);
}
}









function un(v)=v/max(norm(v),1e-16);// div by zero safe unit normal
function rnd(a = 1, b = 0, s = []) = 
  s == [] ? 
   (rands(min(a, b), max(   a, b), 1)[0]) 
  : 
   (rands(min(a, b), max(a, b), 1, s)[0])
  ; // nice rands wrapper