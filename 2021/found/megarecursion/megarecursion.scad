

echo(call("hey"));
 function call(v,c=9999999999)=
c>999?call(   call(v,999),c-999) // splits recursion in more shallow calls
: c>0?call(v,c-1):v;