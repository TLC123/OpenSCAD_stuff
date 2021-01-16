step=8;
intersect() {
import("bunny.stl", convexity=20);


for (k=[-52.501:step*2:50]){
 translate ([0,0,k])
for (j=[-52.501:step*2:50]){
 translate ([0,j,0])
for (i=[-52.501:step*2:50]){
 translate ([i,0,50])   cube([step,step,step],center=true);}
 }}}