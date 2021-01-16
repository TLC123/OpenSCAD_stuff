lazy=newDelay([1,1,1],[0,0,2]);
lazy2=newDelay([2,1,1],[2,0,2]);
echo(lazy);
echo(lazy2);
crazy=funconcat(lazy,funconcat(lazy,funconcat(lazy,funconcat(lazy,lazy2))));
echo(1,crazy);
echo(3,eval(crazy));

function newDelay(all,bll)= function(cll) norm(all-bll);
function eval(lazy)=is_function(lazy)?eval(lazy()):lazy;

function funconcat(a,b)=function(c) (a* b);