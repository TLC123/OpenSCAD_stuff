b=1;
a= [
[[1,-5,4],[10,-10,1],[-1,-2,1],[4,9,1]]
,[[0, 0, 0], [-5, 1, 2], [0, 2, 0], [1, 1,0], [2, 2, 0], [2, 1, 0.5], [2, 0, 0], [1, 1, 0]]
];

echo(isequalformat(a,b));

function isequalformat (a,b,level=" ")=
let(er=echo(str(level,a," = ",b,"->",a==b," ",(a!=undef&&b!=undef)?len(a)==len(b): false)))
len(a)==undef?
 (a!=undef&&b!=undef)?len(a)==len(b): false:
let(c=[for(i=[0:emax(len(b)-1,len(a)-1)])
isequalformat(a[i],b[i], str(level," ")) ] )alltrue(c);

function alltrue(a)=let( b=[for(i=a)true] )a==b;
function emax(a,b)=max(a==undef?0:a,b==undef?0:b);
