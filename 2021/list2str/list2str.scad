strg=["foo","bar","tar\t","foo","bar","tar","foo","bar","tar"];
echo(list2str(strg) );


function list2str(l,c=0)=c<len(l)-1?str(l[c],list2str(l,c+1)) :l[c];