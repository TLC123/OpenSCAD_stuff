a=[for (i=[0:35:360])[sin(i)*10+cos(i*5)*2,cos(i)*15+cos(i*3)]];
 tria=fp_triangulate(a);
for(i=[0:len(tria)-1]){
polygon(tria[i]);
echo(tria[i]);
}
function fp_triangulate(a)=
len(a)>3?
let(
b=concat([for(i=[2:len(a)-1])a[i]],[a[0]] )
) 
concat([[a[0],a[1],a[2]]],fp_triangulate(b))
:
[[a[0],a[1],a[2]]]
;