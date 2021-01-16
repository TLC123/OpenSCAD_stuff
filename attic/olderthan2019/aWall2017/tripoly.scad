a=[for (i=[0:35:360])[sin(i)*10+cos(i*2)*2,cos(i)*15+cos(i*3)]];
 tria=fp_triangulate(a);
b=[for (i=[0:30:360-30])let(j=i-30)[[0,0],[sin(i)*10+cos(i*5)*2,cos(i)*15+cos(i*3)],[sin(j)*10+cos(j*5)*2,cos(j)*15+cos(j*3)]]];
 tria=fp_triangulate(a);

for(i=[0:len(tria)-1]){
polygon(tria[i]);
//echo(tria[i]);
}

f=fp_removevertex(b,[0,0]);


 for(i=[0:len(b)-1]){
translate([30,0])polygon(b[i]);
echo(b[i]);
}
translate([-30,0])polygon(a);
 for(i=[0:len(a)-1]){

echo(a[i]);
}
echo();
 for(i=[0:len(f)-1]){
translate([60,0])polygon(f[i]);
echo(f[i]);
} 

function fp_removevertex(faces,vertex)=let(
d= fp_tricylceb(faces,vertex),
c= fp_segorder(d),
e=fp_segcollapse(c),
f=fp_triangulate(e))
f;
function fp_tricylceb(b,p)=[for(i=[0:len(b)-1])fp_tricycle (b[i],p)];

function fp_triangulate(a)=len(a)>3?let(b=concat([for(i=[2:len(a)-1])a[i]],[a[0]] )
) concat([[a[0],a[1],a[2]]],fp_triangulate(b)):[[a[0],a[1],a[2]]];

function fp_tricycle(f,p)=fp_is_equal(f[0],p)?[f[1],f[2]]:let(f1=[f[1],f[2],f[0]])fp_is_equal(f1[0],p)?[f1[1],f1[2]]:let(f2=[f1[1],f1[2],f1[0]])fp_is_equal(f2[0],p)?[f2[1],f2[2]]:f;

 function fp_is_equal(a, b, d=1e-16) = (a==b) || (abs(a-b)<d) || (norm(a-b)<d);
    function flatten(l) = [ for (li = l, lij = li) lij ];


 function fp_segorder(n,acc=0,c=0)=c<=len(n)-1?let(newacc= (acc==0)?[n[0]]:let(lookfor= acc[0][0]) concat([for(i=[0:len(n)-1])if(fp_is_equal(lookfor,n[i][1])==true)n[i]],acc ))fp_segorder(n,newacc,c+1):acc;

function fp_segcollapse(n)=
[for(i=[0:len(n)-1])n[i][0]];