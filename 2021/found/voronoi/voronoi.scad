v=[for (m=[0:29])rands(0,100,2)];
vc=[for (m=[0:29])un(rands(0,1,3))];
for(i=[0:100])for(j=[0:100]){
vlm=[for (m=[0:29])round(norm(v[m]-[i,j]))];
vl=min(vlm);
hit=search(vl,vlm,0);
 
c=len(hit)>1?[1,1,1]:vc[hit[0]]/max(1,vl/3);
echo(hit);
 translate([i,j])color(c)cube(1);
}
function un(v)=v/max(norm(v),1e-16);