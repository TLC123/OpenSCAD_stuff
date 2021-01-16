a=[each[0:99]];
 b=[0,1,2, [0:10],  ,[1,23]];
echo (b,select(a,b));
  function select(vector,indices) = [ for (i =  indices,index=i) vector[index] ];
    
function is_list_undef(a)= is_list(a) ?max([for(i=a)is_list_undef(i)]):is_undef(a);
    search