string1="hksdjfhkkkkdsfkljhriirenfcnlknd";
echo(RLEencode(string1));
string2="hhksdjfhkkkkdsfkljhriirenfcnlknd";
echo(RLEencode(string2));
string3=[0,1,1,2,2,2,2,1,1,0,-1,-1,-2,-2,-2,-2,-1,-1,0,1,1,2,2,2,2,1,1,0,-1,-1];
de=(RLEencode(string3));
  echo(string3);
echo(de);
echo(RLEdecode(de));

function RLEencode(s,o,run=0,n=1)=
n==len(s)+1?o:
let(
newrun=s[n]==s[n-1]?run+1:0,
newo=s[n]==s[n-1]?o:concat(  o!=undef?o:[],[[run+1,s[ n-1]]])
)
RLEencode(s,newo,newrun,n+1)
;

function RLEdecode(s,o=[],run=1,n=-1)=
n==len(s)?o:
 let(next=[s[n][1]])
run ==1?

RLEdecode(s,concat(   o,next!=undef&&n>-1?next:[]),s[n+1][0],n+1)
:
RLEdecode(s,concat(   o,next!=undef?next:[] ),run-1,n);