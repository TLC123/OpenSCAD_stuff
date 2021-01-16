S=4;

mx=4;
m= [for(i=[1:mx])r(mx) ] ;
    function r(n)=un([for(n=[1:n])rands(-9,9,1)[0]]);

    
a=[rands(-10,10,1),rands(-10,10,1),rands(-10,10,1),rands(-10,10,1)];

function eliminate(m,a)=
    let(

m0=m,/*[
[2, 2, 3, 4], 
[1, 4, 6, 8], 
[1, 6, 3, 12], 
[1, 8, 9, 2]];*/
 p1= [
[1,                  0, 0, 0], 
[-m0[1][0]/m0[0][0], 1, 0, 0], 
[-m0[2][0]/m0[0][0], 0, 1, 0], 
[-m0[3][0]/m0[0][0], 0, 0, 1] 
 
] ,
                                                  
 m1=saneRound(p1*m0),
 a1=saneRound(p1*a),
 
p2= [
[1,                  0, 0, 0], 
[0,                  1, 0, 0], 
[0, -m1[2][1]/m1[1][1], 1, 0], 
[0, -m1[3][1]/m1[1][1], 0, 1] 
 
] ,
 m2=saneRound(p2* (m1)),
 a2=saneRound(p2*a),
 p3= [
[1, 0, 0, 0], 
[0, 1, 0, 0], 
[0, 0, 1, 0], 
[0, 0, -(m2[3][2]/m2[2][2]), 1] ],

m3=saneRound(p3* (m2)),
 a3=saneRound(p3*a)
 )
 [m3,a3]
 ;
 
 res=eliminate(m,a);
 tres=transpose(res[0]);
 
 res2=eliminate(tres,a);
echo("\n");
prettym (m,a);
echo("\n");
prettym (res[0],res[1]);
echo("\n");
prettym (res2[0],res2[1]);
echo("\n");
mtd=matdiv(res2[0]);
prettym(id4(),mtd*res2[1] );
 echo();
 
 
 function matdiv(m)=[for(i=[0:len(m[0])-1])[for(j=[0:len(m)-1])m[i][j]!=0?1/m[i][j]:0]];
 function transpose(m)=[for(i=[0:len(m[0])-1])[for(j=[0:len(m)-1])m[j][i]]];
function saneRound(m)=[for(v=m)[for(i=v) abs(i)<1e-14?round(i):i]];// within precition zero
  
function decround(i,r=10e-3)=(i/r)*r;
function id4()=[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]];
module prettym(m,a=""){
         
    for(n=[0:len(m)-1] ) echo(str("[\t",list2str([for(ch=m[n])str(decround(ch),",\t")]),"]\t", str( "[",decround(a[n][0]),"]"))) ;}
    
        function list2str(l,c=0)=c<len(l)-1?str(l[c],list2str(l,c+1)) :l[c];
    
    
     function un(v) = v / max(norm(v), 0.000001) * 1; // div by zero safe unit normal

 