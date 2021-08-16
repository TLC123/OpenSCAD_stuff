echo(clamplist([10,20,03,40,21,1,0,0.6,-2]));
function clamplist(v,b=0,c=1) = 
len(v) == undef ? min(max(v,min(b,c)),max(b,c)): 
len(v) == 0 ? [] : 
[for (i = v) clamplist(i,b,c)];
