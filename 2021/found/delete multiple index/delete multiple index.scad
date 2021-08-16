//pub

List=[[1,2,3],3,4,5,6,7,8,90,1 ]; Selection=[0,3,4,5]; 

echo(" List :",List);
echo(" Indices of elements to remove :",Selection);
/*Indexes and indices are both accepted and widely used plurals of the noun index. */
echo(" List after removal :",split_keepers(List,Selection));
echo(" List of removed elements :", split_removed(List,Selection));

 
function split_keepers(List,Selection)=
        [for(i=[0:max(0,len(List)-1)]) if(search(i,Selection)==[])List[i]];
function split_removed(List,Selection)=
        [for(i=[0:max(0,len(List)-1)]) if(search(i,Selection)!=[])List[i]];

