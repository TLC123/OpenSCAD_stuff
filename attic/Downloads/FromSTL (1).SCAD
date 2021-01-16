//http://jsfiddle.net/aaL8xfs5/ 
 dense=0.5;
 My_poly=stl(); 
 
 n=[for(i=[0:len(My_poly[1])-1])face_normal(My_poly[0][My_poly[1][i][0]],My_poly[0][My_poly[1][i][1]],My_poly[0][My_poly[1][i][2]])];
 c=[for(i=[0:len(My_poly[1])-1])addl([My_poly[0][My_poly[1][i][0]],My_poly[0][My_poly[1][i][1]],My_poly[0][My_poly[1][i][2]]])/3];
 r=[for(i=[0:len(My_poly[1])-1])look_at(n[i]) ];
 a=[for(i=[0:len(My_poly[1])-1])polyarea(My_poly[0][My_poly[1][i][0]],My_poly[0][My_poly[1][i][1]],My_poly[0][My_poly[1][i][2]])];
 maxa=max(a);
 
 difference ( ){
 polyhedron(My_poly[0],My_poly[1]);
 for(i=[0:len(My_poly[1])-1]){ if(rands(0,maxa*dense,1)[0]<a[i]) translate(c[i])rotate(r[i][0],r[i][1]) cylinder(1,1,1,center=true,$fn=10);}
 }
 
 function face_normal(point_a,point_b,point_c)=
 let(u=point_a-point_b,v=point_a-point_c)
 un([u[1]*v[2]-u[2]*v[1],u[2]*v[0]-u[0]*v[2],u[0]*v[1]-u[1]*v[0]]);
 
 function un(v)=v/max(len3(v),1e-64);
 function len3(v) =len(v)>1?
 sqrt(addl([for(i=[0:len(v)-1])pow(v[i], 2)]))
 :len(v)==1?v[0]:v; 
 function addl(l,c=0)= len(l)-1 >c?l[c]+addl(l,c+1):l[c];
 function look_at(p,o=[0,0,0],up=[0,0,1])=
 let(
 a=up,
 b=p-o,
 c=cross(a,b) ,
 d=angle(a,b))
 [d,c];
 
 function angle (a,b)=
 atan2(
 sqrt((cross(a, b)*cross(a, b))), 
 (a* b)
 );
 function polyarea(p1, p2, p3) = heron(len3(p1 - p2), len3(p2 - p3), len3(p2 - p1));
 
 function heron(a, b, c) =
 let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));
 