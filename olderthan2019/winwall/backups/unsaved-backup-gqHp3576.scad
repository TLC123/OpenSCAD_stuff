step=3;
intersection(){
import("bunny.stl", convexity=20);

translate([0,0,40])intersection(){
for (i=[-52.501:step*2:50]){
    translate ([0,0,i])cube ([100,100,step],center=true)
    ;}
    
    for (i=[-52.501:step*2:50]){
    translate ([0,i,0])cube ([100,step,100],center=true)
    ;}
    
    for (i=[-52.501:step*2:50]){
    translate ([i,0,0])cube ([step,100,100],center=true)
    ;}}}